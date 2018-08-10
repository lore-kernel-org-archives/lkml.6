Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08158C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB77223FA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB77223FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeHJMlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:41:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53410 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbeHJMlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:41:16 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DB5CD720;
        Fri, 10 Aug 2018 10:12:01 +0000 (UTC)
Date:   Fri, 10 Aug 2018 12:11:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Seung-Woo Kim <sw0312.kim@samsung.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 3.18.111
Message-ID: <20180810101158.GA31002@kroah.com>
References: <CGME20180530073304epcas3p4967df82d2d086fd08fd354781df61861@epcas3p4.samsung.com>
 <20180530073211.GA22422@kroah.com>
 <20180703032456epcas1p29c4570ae3f6bb3f8d7c2d475e1ba4658~9vfIpgNT51989519895epcas1p2d@epcas1p2.samsung.com>
 <20180703043655.GA9793@kroah.com>
 <20180703044302epcas1p4ff5961129c010a2df3548cf678b6274c~9wjUy-vFW2959129591epcas1p4p@epcas1p4.samsung.com>
 <CA+55aFz-K8s-Sh86PqxRaXTD5pG=YsVUCxf9ue8XOSaGmg-brw@mail.gmail.com>
 <20180705005205.GC30522@ZenIV.linux.org.uk>
 <20180808100622epcas1p1d4e3d6f858a9de3014f6d79bf284ff2c~I4L612J9p0428204282epcas1p1X@epcas1p1.samsung.com>
 <20180810064258epcas1p3eb68d29dbd60b705d0473b3c645496ff~Jcs48Q55D0165001650epcas1p3e@epcas1p3.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180810064258epcas1p3eb68d29dbd60b705d0473b3c645496ff~Jcs48Q55D0165001650epcas1p3e@epcas1p3.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 03:43:02PM +0900, Seung-Woo Kim wrote:
> On 2018년 08월 08일 19:06, Seung-Woo Kim wrote:
> > On 2018년 07월 05일 09:52, Al Viro wrote:
> >> On Mon, Jul 02, 2018 at 10:01:25PM -0700, Linus Torvalds wrote:
> >>> On Mon, Jul 2, 2018 at 9:43 PM Seung-Woo Kim <sw0312.kim@samsung.com> wrote:
> >>>>
> >>>> I think the commit itself is required. Simple, but not reliable,
> >>>> workaround fix is like below:
> >>>>
> >>>> diff --git a/fs/dcache.c b/fs/dcache.c
> >>>> index a34d401..7c751f2 100644
> >>>> --- a/fs/dcache.c
> >>>> +++ b/fs/dcache.c
> >>>> @@ -1879,6 +1879,8 @@ void d_instantiate_new(struct dentry *entry,
> >>>> struct inode *inode)
> >>>>         BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
> >>>>         BUG_ON(!inode);
> >>>>         lockdep_annotate_inode_mutex_key(inode);
> >>>> +       /* WORKAROUND for calling security_d_instantiate() */
> >>>> +       entry->d_inode = inode;
> >>>>         security_d_instantiate(entry, inode);
> >>>>         spin_lock(&inode->i_lock);
> >>>>         __d_instantiate(entry, inode);
> >>>
> >>> Ugh. That looks horrible even if it might avoid the oops.
> >>>
> >>> I think a much better solution is to back-port commit b296821a7c42
> >>> ("xattr_handler: pass dentry and inode as separate arguments of
> >>> ->get()") to older kernels. Then the inode is passed down all the way,
> >>> and you don't have people try to get it from the (not yet initialized)
> >>> dentry.
> >>>
> >>> But there might be other parts missing too, and I didn't look at how
> >>> easy/painful that backport would be.
> >>>
> >>> Al - comments? This is all because of commit 1e2e547a93a0 ("do
> >>> d_instantiate/unlock_new_inode combinations safely") being marked for
> >>> stable, and various cases of security_d_instantiate() calling down to
> >>> getxattr. Which used to not get the inode at all, so those older
> >>> kernels use d_inode(dentry), which doesn't work in this path since
> >>> dentry->d_inode hasn't been instantiated yet..
> >>
> >> You also want b96809173e94 and ce23e6401334 there...
> > 
> > For above two commits, also b296821a7c42 is required. And after
> > backport, smack still crashed because setxattr. To fix it, 5930122683df
> > and 3767e255b390 are also required.
> > 
> > By the way, does no one have met this kind getxattr crash issue with
> > selinux from 3.18.y?
> > 
> 
> I have checked with selinux, and it is confirmed that there is no crash
> because selinux_d_instantiate() has null check for inode. So, it is only
> security smack issue.

So are the 5 patches you sent ok to apply to the 3.18-stable tree?  Or
do we need to do something else?

thanks,

greg k-h
