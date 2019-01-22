Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B8AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6122085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfAVQi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:38:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:45778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729092AbfAVQi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:38:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5685FB081;
        Tue, 22 Jan 2019 16:38:55 +0000 (UTC)
Date:   Tue, 22 Jan 2019 10:38:52 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Ignaz Forster <iforster@suse.de>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabian Vogt <fvogt@suse.de>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] ima: define ima_post_create_tmpfile() hook and add
 missing call
Message-ID: <20190122163852.nbo7z5hrizfsb344@merlin>
References: <1545158873.4206.86.camel@linux.ibm.com>
 <20190117213421.ggasuc263dpqh46c@merlin>
 <1548072003.3782.24.camel@linux.ibm.com>
 <CAOQ4uxjNhNFfFidjzi-8ywQPi54LdzT=LxwdSaX+H-ERS6Qwog@mail.gmail.com>
 <1548171789.4038.6.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548171789.4038.6.camel@linux.ibm.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:43 22/01, Mimi Zohar wrote:
> On Mon, 2019-01-21 at 14:29 +0200, Amir Goldstein wrote:
> > On Mon, Jan 21, 2019 at 2:00 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >
> > > On Thu, 2019-01-17 at 15:34 -0600, Goldwyn Rodrigues wrote:
> > > > On 13:47 18/12, Mimi Zohar wrote:
> > > > > If tmpfiles can be made persistent, then newly created tmpfiles need to
> > > > > be treated like any other new files in policy.
> > > > >
> > > > > This patch indicates which newly created tmpfiles are in policy, causing
> > > > > the file hash to be calculated on __fput().
> > > >
> > > > Discussed in overlayfs, this would be better if we use this on inode
> > > > and called from vfs_tmpfile() instead of do_tmpfile(). This will cover
> > > > the overlayfs case which uses tmpfiles while performing copy_up().
> > > > The patch is attached.
> > > >
> > > > Here is the updated patch which works for my cases.
> > > > However, it is the the failure case after setting the IMA flags
> > > > I am concerned about, though I don't think that should be as harmful.
> > >
> > > Right.  The new IMA hook allocates memory for storing the flags, which
> > > needs to be cleaned up on failure.  For this reason, the IMA call is
> > > deferred until after the transition from locally freeing memory on
> > > failure to relying on __fput().  In "do_last", the call to IMA is
> > > after "opened"; and in the original version of this patch the call to
> > > IMA is after finish_open().
> > >
> > 
> > Not sure I understand the concern.
> > The integrity context is associated with the inode and will be freed
> > on destroy_inode() no matter which error path is taken.
> > Am I missing something?
> 
> No, as long as destroy_inode() is called, it should be fine.
> 

Excellent. I will resend the patch as v3.

Thanks!

-- 
Goldwyn
