Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E3CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06A520873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06A520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbeK1H0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:26:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725752AbeK1H0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:26:19 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7FDAE7F6B0;
        Tue, 27 Nov 2018 20:27:15 +0000 (UTC)
Received: from jlaw-desktop.bos.csb (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0725260C45;
        Tue, 27 Nov 2018 20:27:14 +0000 (UTC)
Subject: Re: [RFC PATCH 0/1] support ftrace and -ffunction-sections
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <1542745158-25392-1-git-send-email-joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <a6c4b12d-389e-8919-d37b-50ba73319b8f@redhat.com>
Date:   Tue, 27 Nov 2018 15:27:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1542745158-25392-1-git-send-email-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 27 Nov 2018 20:27:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/2018 03:19 PM, Joe Lawrence wrote:
> Hi Steve,
> 
> I noticed that ftrace does not currently support functions built with
> the -ffunction-sections option as they end up in .text.<function_name>
> ELF sections, never making into the __mcount_loc section.
> 
> I modified the recordmcount scripts to handle such .text. section
> prefixes and this appears to work on x86_64, ppc64le, and s390x -- at
> least for simple modules, including the "Test trace_printk from module"
> ftrace self-test. 
> 
> That said, I did notice 90ad4052e85c ("kbuild: avoid conflict between
> -ffunction-sections and -pg on gcc-4.7") which indicates that the kernel
> still supports versions of gcc which may not play well with ftrace and
> -ffunction-sections.
> 
> With that limitation in mind, can we support ftracing of functions in
> such sections for compiler versions that do support it? (fwiw, gcc
> v4.8.5 seems happy)  And then if so, what additional testing or coding
> would need to be done to be confident that it is safe?  Is matching on
> ".text.*" too inclusive?
> 

Gentle ping...  I took a dive through the rhkl-archives and found a few
older discussions:

  [PATCH] scripts/recordmcount.pl: Support build with -ffunction-sections.
  https://lore.kernel.org/lkml/CAFbHwiRtBaHkpZqTm6VZ=fCJcyu+dsdpo_kxMHy1egce=rTuyA@mail.gmail.com/

and related LWN article:

  The source of the e1000e corruption bug
  https://lwn.net/Articles/304105/

Catching up with those, I assume that this has never been implemented in
the past due to fear of ftrace modifying a potentially freed section
(and bricking NICs in the process :(

Looking through the kernel sources (like Will in 2008) I don't see any
code jumping out at me that frees code other than .init.  However a
quick code inspection is no guarantee.

Assuming the same use-after-free reservation holds true today:

  1: Is there any reasonable way to mark code sections (pages?) as
     in-use to avoid memory freeing mechanisms from releasing them?  The
     logic for .init is mostly arch-specific, so there could be many 
     different ways random arches may try to pull this off.

  2: Would/could it be safer to restrict __mcount_loc detection of
     ".text.*" sections to modules?  The recordmcount.pl script already
     knows about is_module... that information could be provided to
     recordmcount.c as well for consideration.

-- Joe
