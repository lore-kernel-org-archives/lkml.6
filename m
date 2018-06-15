Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A57C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332F3208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332F3208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756165AbeFOQxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:53:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40356 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752703AbeFOQxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:53:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fTryI-00065b-52; Fri, 15 Jun 2018 16:53:10 +0000
Date:   Fri, 15 Jun 2018 17:53:10 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     axboe@kernel.dk, fujita.tomonori@lab.ntt.co.jp,
        dgilbert@interlog.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        security@kernel.org
Subject: Re: [PATCH] sg, bsg: mitigate read/write abuse, block uaccess in
 release
Message-ID: <20180615165310.GF30522@ZenIV.linux.org.uk>
References: <20180615152335.208202-1-jannh@google.com>
 <20180615164009.GD30522@ZenIV.linux.org.uk>
 <CAG48ez2Fku77S+FM2w5n8J_utOhO0EW_RFbMib=t5Nmwc9pwfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2Fku77S+FM2w5n8J_utOhO0EW_RFbMib=t5Nmwc9pwfQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 06:44:51PM +0200, Jann Horn wrote:
> On Fri, Jun 15, 2018 at 6:40 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Fri, Jun 15, 2018 at 05:23:35PM +0200, Jann Horn wrote:
> >
> > > I've mostly copypasted ib_safe_file_access() over as
> > > scsi_safe_file_access() because I couldn't find a good common header -
> > > please tell me if you know a better way.
> > > The duplicate pr_err_once() calls are so that each of them fires once;
> > > otherwise, this would probably have to be a macro.
> > >
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > ---
> >
> > WTF do you mean, in ->release()?  That makes no sense whatsoever -
> > what kind of copy_{to,from}_user() would be possible in there?
> 
> bsg_release -> bsg_put_device -> bsg_complete_all_commands ->
> blk_complete_sgv4_hdr_rq -> bsg_scsi_complete_rq -> copy_to_user.
> I don't think that was intentional.
> 
> Basically, the sense buffer is copied to a userspace address supplied
> in the previous ->write() when you ->read() the reply. But when you
> ->release() the file without reading the reply, they have to clean it
> up, and for that, they reuse the same code they use for ->read() - so
> the sense buffer is written to userspace on ->release().

Pardon me, that has only one fix - git rm.  This is too broken for words -
if your reading is correct, the interface is unsalvagable.  I hope you
*are* misreading it, but if not... how did that insanity get through
review at merge time?
