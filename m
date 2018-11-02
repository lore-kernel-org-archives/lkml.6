Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C751BC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB922081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB922081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeKCEvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:51:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43208 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbeKCEvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:51:12 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIfL1-0001JK-IW; Fri, 02 Nov 2018 19:42:35 +0000
Date:   Fri, 2 Nov 2018 19:42:35 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        swhiteho@redhat.com, john.johansen@canonical.com,
        alan.christopher.jenkins@gmail.com, ebiederm@redhat.com,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] mount API series
Message-ID: <20181102194235.GA32577@ZenIV.linux.org.uk>
References: <CAHk-=whysoVxJU8+TBw=D3xN00HOOqg-9Chc=i0Pt+Ozm3Z0Tg@mail.gmail.com>
 <20181031053355.GQ32577@ZenIV.linux.org.uk>
 <CAHk-=whAE6gVi18=u4sSWe1m2RWPh19YCkKQmW4Kx+NQX1mg8w@mail.gmail.com>
 <af28fc2c-d207-875e-8070-f64ead878b5a@redhat.com>
 <CAHk-=wjjVRQVZL+QMnb=CyCOY8yzEZ=S1DBCE7=FiiWsQfV_5Q@mail.gmail.com>
 <28156.1541092687@warthog.procyon.org.uk>
 <3549.1541116763@warthog.procyon.org.uk>
 <20181102040701.GX32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102040701.GX32577@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 04:07:01AM +0000, Al Viro wrote:
> On Thu, Nov 01, 2018 at 11:59:23PM +0000, David Howells wrote:
> 
> >  (*) mount-api-core.  These are the internal-only patches that add the
> >      fs_context, the legacy wrapper and the security hooks and make certain
> >      filesystems make use of it.
> 
> FWIW, while rereading that series I'd spotted something very odd in erofs.
> It's orthogonal to everything else, but just to make sure it doesn't get
> lost:
> 	* sbi->dev_name thing in erofs is used only for debugging printks,
> basically.  Just use sb->s_id[] and be done with that.
> 	* dump struct erofs_mount_private - you don't need dev_name in
> your erofs_fill_super().  Just use mount_bdev() in usual fashion.
> 	* what the hell are you doing with ->s_root???  Why would you
> possibly want it hashed and what kind of dcache lookup could find it?
> That d_rehash() looks deeply confused; what are you trying to do there?

... and while we are at it, what happens to
                unsigned int nameoff = le16_to_cpu(de[mid].nameoff);
                unsigned int matched = min(startprfx, endprfx);

                struct qstr dname = QSTR_INIT(data + nameoff,
                        unlikely(mid >= ndirents - 1) ?
                                maxsize - nameoff :
                                le16_to_cpu(de[mid + 1].nameoff) - nameoff);

                /* string comparison without already matched prefix */
                int ret = dirnamecmp(name, &dname, &matched);
if le16_to_cpu(de[...].nameoff) is not monotonically increasing?  I.e.
what's to prevent e.g. (unsigned)-1 ending up in dname.len?

Corrupted fs image shouldn't oops the kernel...
