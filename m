Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125C9C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 04:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B981521470
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 04:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B981521470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeJTMxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 08:53:10 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53762 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeJTMxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 08:53:10 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F37331262C5D2;
        Fri, 19 Oct 2018 21:44:04 -0700 (PDT)
Date:   Fri, 19 Oct 2018 21:44:01 -0700 (PDT)
Message-Id: <20181019.214401.2045294780943844999.davem@davemloft.net>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, dzickus@redhat.com
Subject: Re: perf overlapping maps...
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181019.210549.1285253275146712779.davem@davemloft.net>
References: <20181019.210549.1285253275146712779.davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 19 Oct 2018 21:44:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Fri, 19 Oct 2018 21:05:49 -0700 (PDT)

> One solution I've come up with is:
> 
> 1) When synthesizing a fork event, set PERF_RECORD_MISC_COMM_EXEC in
>    header->misc.
> 
> 2) Use this to elide the map groups clone in
>    thread__clone_map_groups().

Looking into code history, I notice:

commit 363b785f3805a2632eb09a8b430842461c21a640
Author: Don Zickus <dzickus@redhat.com>
Date:   Fri Mar 14 10:43:44 2014 -0400

    perf tools: Speed up thread map generation

and the subsequent:

commit 4aa5f4f7bb8bc41cba15bcd0d80c4fb085027d6b
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Fri Feb 27 19:52:10 2015 -0300

    perf tools: Fix FORK after COMM when synthesizing records for pre-existing threads

If Don wanted to have the map cloning to happen for processes without
CLONE_VM, I'm not sure that's right.

For real threads, we just take a reference to the map group from
the parent.

Don, a quick summary.  If we synthesize a fork event, let's say for an
emacs process.  perf will clone the map groups of the parent bash
shell which invoked emacs.  Via:

thread__fork(thread, parent, timestamp)
{
 ...
 thread__clone_map_groups(thread, parent)
 {
   ...
   map_groups__clone(thread, parent->mg)

Which is completely bogus.  It brings all of the bash process maps
into the emacs thread map group.  Then we process the emacs mmap2
events, which overlap the bash process maps already cloned into the
emacs map group.  And this make all kinds of erroneous things happen.

I'm suggesting to elide the map groups clone in this situation where
we are synthesizing the fork.

Thanks.
