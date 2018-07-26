Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9351C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4743D20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4743D20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbeGZLFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:05:09 -0400
Received: from nautica.notk.org ([91.121.71.147]:43694 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728681AbeGZLFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:05:08 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 976FAC009; Thu, 26 Jul 2018 11:49:04 +0200 (CEST)
Date:   Thu, 26 Jul 2018 11:48:49 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Tomas Bortoli <tomasbortoli@gmail.com>,
        David Miller <davem@davemloft.net>,
        v9fs-developer@lists.sourceforge.net,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] 9p: fix NULL pointer dereferences
Message-ID: <20180726094849.GA18334@nautica>
References: <20180726081049.10527-1-tomasbortoli@gmail.com>
 <20180726081727.GA6699@nautica>
 <CACT4Y+ark+0EYSZaOX-qDKpOkyfLgSO9CkidZzx=xkUuhpr65A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+ark+0EYSZaOX-qDKpOkyfLgSO9CkidZzx=xkUuhpr65A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote on Thu, Jul 26, 2018:
> > Let's refuse that at much higher level, like v9fs_mount() in
> > fs/9p/vfs_super.c
> >
> > I can't think of any valid reason for dev_name to be NULL, it's the
> > target IP or virtio handle.
> 
> But I think trans=fd allows NULL addr today, no?

Ah, right, I read the patch too fast and read unix_create as fd_create,
I never realized there was a unix_create variant...

fd legitimately doesn't need a name, you are correct.

I'm really curious if anyone ever uses the unix/fd variants for "real"
stuff though! (not meaning syzbot isn't real, but I have yet to see
anything take advantage of this, even if I could imagine some fun
applications by piping the wmii libixp server socket.. and just crashed
my laptop trying because of the (fixed) trans put bug.. I have yet to
see anyone actually doing this)


On the other hand, virtio, rdma and xen all have the same problem, so
Thomas, please fix them instead :)

-- 
Dominique Martinet
