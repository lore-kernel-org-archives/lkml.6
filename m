Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F82C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 04:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08C121470
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 04:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08C121470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbeJTMOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 08:14:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53420 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeJTMOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 08:14:50 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5111E1262C507;
        Fri, 19 Oct 2018 21:05:51 -0700 (PDT)
Date:   Fri, 19 Oct 2018 21:05:49 -0700 (PDT)
Message-Id: <20181019.210549.1285253275146712779.davem@davemloft.net>
To:     acme@kernel.org
CC:     linux-kernel@vger.kernel.org
Subject: perf overlapping maps...
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 19 Oct 2018 21:05:51 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Symbols aren't exactly right all the time on sparc and even the owner
of a sample is set to "unknown" from time to time so I turned on some
debugging to investigate.

One thing that stands out is that we get overlapping maps all the
time.

So I tried to narrow down how this happens.  Here is one case, we get
a new thread fork event for emacs-gtk before the MMAP events so we go:

thread__fork(thread, parent, timestamp)
{
 ...
 thread__clone_map_groups(thread, parent)
 {
   ...
   map_groups__clone(thread, parent->mg)

Dumping this map_groups__clone() operation I see:

map_groups__clone: parent 0x10000425420 --> 0x10000418fb0
map_groups__clone: new [0000010000000000:0000010000110000] /bin/bash
map_groups__clone: new [0000010000212000:000001000021e000] /bin/bash
map_groups__clone: new [000001000021e000:00000100002a0000] /tmp/perf-1309.map
map_groups__clone: new [fff0000100000000:fff0000100024000] /lib/sparc64-linux-gnu/ld-2.27.so
map_groups__clone: new [fff0000100124000:fff0000100126000] /lib/sparc64-linux-gnu/ld-2.27.so
map_groups__clone: new [fff0000100128000:fff0000100152000] /lib/sparc64-linux-gnu/libtinfo.so.6.1
map_groups__clone: new [fff0000100254000:fff0000100256000] /lib/sparc64-linux-gnu/libtinfo.so.6.1
map_groups__clone: new [fff0000100258000:fff000010025c000] /lib/sparc64-linux-gnu/libdl-2.27.so
map_groups__clone: new [fff000010035c000:fff000010035e000] /lib/sparc64-linux-gnu/libdl-2.27.so
map_groups__clone: new [fff000010046a000:fff000010046c000] [vdso]
map_groups__clone: new [fff000010046c000:fff00001005cc000] /lib/sparc64-linux-gnu/libc-2.27.so
map_groups__clone: new [fff00001006d0000:fff00001006d4000] /lib/sparc64-linux-gnu/libc-2.27.so
map_groups__clone: new [fff00001006d4000:fff00001006d6000] /tmp/perf-1309.map
map_groups__clone: new [fff0000100874000:fff000010087e000] /lib/sparc64-linux-gnu/libnss_files-2.27.so
map_groups__clone: new [fff000010097e000:fff0000100980000] /lib/sparc64-linux-gnu/libnss_files-2.27.so
map_groups__clone: new [fff0000100980000:fff0000100986000] /tmp/perf-1309.map

It's inheriting maps for the parent bash shell that invoked emacs-gtk, which
makes no sense at all.

We proceed to process the MMAP events which have the proper mappings
for emacs-gtk, and eventually we happen to hit a mapping that overlaps
with one of the address ranges of the parent bash shell.

For the stuff that doesn't overlap, we have bogus parent bash shell
process mappings left in the emacs-gtk thread map group.

The above trace is simply from "./perf record 2>x.log", nothing fancy.

What we are doing above can't be right.

Yes, when processing real perf events from the kernel for a fork
event, we should do that inheritance stuff.  But if we are
synthesizing the fork to build threads and maps for already running
processes, we absolutely should not perform the map groups clone.

One solution I've come up with is:

1) When synthesizing a fork event, set PERF_RECORD_MISC_COMM_EXEC in
   header->misc.

2) Use this to elide the map groups clone in
   thread__clone_map_groups().

Comments?
