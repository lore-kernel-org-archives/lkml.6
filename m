Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C6BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 02:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4312D20851
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 02:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4312D20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbeK1NJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 08:09:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:34432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbeK1NJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 08:09:39 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 470172082F;
        Wed, 28 Nov 2018 02:09:45 +0000 (UTC)
Date:   Tue, 27 Nov 2018 21:09:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [RFC PATCH 0/1] support ftrace and -ffunction-sections
Message-ID: <20181127210942.4067ad46@vmware.local.home>
In-Reply-To: <a6c4b12d-389e-8919-d37b-50ba73319b8f@redhat.com>
References: <1542745158-25392-1-git-send-email-joe.lawrence@redhat.com>
        <a6c4b12d-389e-8919-d37b-50ba73319b8f@redhat.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018 15:27:14 -0500
Joe Lawrence <joe.lawrence@redhat.com> wrote:

> Gentle ping...  I took a dive through the rhkl-archives and found a few
> older discussions:

Thanks for the reminder, my INBOX is totally out of control with
Plumbers followed by Turkey Day.

> 
>   [PATCH] scripts/recordmcount.pl: Support build with -ffunction-sections.
>   https://lore.kernel.org/lkml/CAFbHwiRtBaHkpZqTm6VZ=fCJcyu+dsdpo_kxMHy1egce=rTuyA@mail.gmail.com/
> 
> and related LWN article:
> 
>   The source of the e1000e corruption bug
>   https://lwn.net/Articles/304105/
> 
> Catching up with those, I assume that this has never been implemented in
> the past due to fear of ftrace modifying a potentially freed section
> (and bricking NICs in the process :(

Actually, we have a lot more safe guards against that today.

> 
> Looking through the kernel sources (like Will in 2008) I don't see any
> code jumping out at me that frees code other than .init.  However a
> quick code inspection is no guarantee.
> 
> Assuming the same use-after-free reservation holds true today:
> 
>   1: Is there any reasonable way to mark code sections (pages?) as
>      in-use to avoid memory freeing mechanisms from releasing them?  The
>      logic for .init is mostly arch-specific, so there could be many 
>      different ways random arches may try to pull this off.
> 
>   2: Would/could it be safer to restrict __mcount_loc detection of
>      ".text.*" sections to modules?  The recordmcount.pl script already
>      knows about is_module... that information could be provided to
>      recordmcount.c as well for consideration.

I'm fine with just applying your patch. Today, for x86, there's a gcc
option that adds the __mcount_loc automatically without doing any
whitelisting (it doesn't run recordmcount.*). It just adds anything that
is traced, thus it has to work for all possible cases now.

-- Steve

