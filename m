Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308DBC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C579D2064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C579D2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeGZPia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:38:30 -0400
Received: from nautica.notk.org ([91.121.71.147]:45680 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730352AbeGZPia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:38:30 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 0FB13C009; Thu, 26 Jul 2018 16:21:24 +0200 (CEST)
Date:   Thu, 26 Jul 2018 16:21:09 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        David Miller <davem@davemloft.net>,
        v9fs-developer@lists.sourceforge.net,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] 9p: fix NULL pointer dereferences
Message-ID: <20180726142109.GA4235@nautica>
References: <20180726081049.10527-1-tomasbortoli@gmail.com>
 <20180726081727.GA6699@nautica>
 <CACT4Y+ark+0EYSZaOX-qDKpOkyfLgSO9CkidZzx=xkUuhpr65A@mail.gmail.com>
 <20180726094849.GA18334@nautica>
 <abbeafa2-9008-5749-aee5-b4a115d71af7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abbeafa2-9008-5749-aee5-b4a115d71af7@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Thu, Jul 26, 2018:
>> But I think trans=fd allows NULL addr today, no?
> 
> How ?

Just using the mount syscall with a NULL dev_name? I haven't checked
this syzcaller reproducer but it's probably what it does.

p9_fd_create doesn't use 'addr' at all so it's safe to create a 9p mount
for trans=fd with no device name, as Dmitry pointed out


> > On the other hand, virtio, rdma and xen all have the same problem, so
> > Thomas, please fix them instead :)
> 
> So just by patching v9fs_mount ?

If we want to preserve the current behaviour for trans=fd (and I don't
see why not) we just have to patch all the transports that use the
device, that is all .create functions but p9_fd_create()

Basically exactly what you did, just for a few more functions - I
apparently was a little bit too optimistic thinking we could share
this check.

-- 
Dominique
