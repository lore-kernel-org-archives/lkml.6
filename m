Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999D1C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442F324075
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442F324075
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753715AbeGEV5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:57:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59994 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753439AbeGEV46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:56:58 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EB6CADB7;
        Thu,  5 Jul 2018 21:56:57 +0000 (UTC)
Date:   Thu, 5 Jul 2018 14:56:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH 2/6] ipc: reorganize initialization of kern_ipc_perm.seq
Message-Id: <20180705145656.962e34582646b7a28d221f4a@linux-foundation.org>
In-Reply-To: <7143da44-448b-8beb-7583-1a5516623649@colorfullife.com>
References: <20180705055920.19611-1-manfred@colorfullife.com>
        <20180705055920.19611-3-manfred@colorfullife.com>
        <CACT4Y+YyZT+JRyUcYRD83V13M-k91XUp1qkpBCUCkGfamLgDTg@mail.gmail.com>
        <7143da44-448b-8beb-7583-1a5516623649@colorfullife.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2018 17:12:36 +0200 Manfred Spraul <manfred@colorfullife.com> wrote:

> Hi Dmitry,
> 
> On 07/05/2018 10:36 AM, Dmitry Vyukov wrote:
> > [...]
> > Hi Manfred,
> >
> > The series looks like a significant improvement to me. Thanks!
> >
> > I feel that this code can be further simplified (unless I am missing
> > something here). Please take a look at this version:
> >
> > https://github.com/dvyukov/linux/commit/f77aeaf80f3c4ab524db92184d874b03063fea3a?diff=split
> >
> > This is on top of your patches. It basically does the same as your
> > code, but consolidates all id/seq assignment and dealing with next_id,
> > and deduplicates code re CONFIG_CHECKPOINT_RESTORE. Currently it's a
> > bit tricky to follow e.g. where exactly next_id is consumed and where
> > it needs to be left intact.
> > The only difference is that my code assigns new->id earlier. Not sure
> > if it can lead to anything bad. But if yes, then it seems that
> > currently uninitialized new->id is exposed. If necessary (?) we could
> > reset new->id in the same place where we set new->deleted.
> Everything looks correct for me, it is better than the current code.
> Except that you didn't sign off your last patch.
> 
> As next step: Who can merge the patches towards linux-next?

Me.

But it's unclear which patchset we're talking about.  What's the plan
here?  To combine both efforts?


> The only open point that I see are stress tests of the error codepaths.
> 
> And:
> I don't think that the patches are relevant for linux-stable, correct?

