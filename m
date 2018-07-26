Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900C5C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2269E20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2269E20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbeGZXee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 19:34:34 -0400
Received: from nautica.notk.org ([91.121.71.147]:55512 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730581AbeGZXee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 19:34:34 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 33ACCC009; Fri, 27 Jul 2018 00:15:42 +0200 (CEST)
Date:   Fri, 27 Jul 2018 00:15:27 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        David Miller <davem@davemloft.net>,
        v9fs-developer@lists.sourceforge.net,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] 9p: fix NULL pointer dereferences
Message-ID: <20180726221527.GA9426@nautica>
References: <20180726081049.10527-1-tomasbortoli@gmail.com>
 <20180726081727.GA6699@nautica>
 <CACT4Y+ark+0EYSZaOX-qDKpOkyfLgSO9CkidZzx=xkUuhpr65A@mail.gmail.com>
 <20180726094849.GA18334@nautica>
 <abbeafa2-9008-5749-aee5-b4a115d71af7@gmail.com>
 <20180726142109.GA4235@nautica>
 <baa7368f-e149-ef3d-cf10-4fcd16dce0e6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <baa7368f-e149-ef3d-cf10-4fcd16dce0e6@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Thu, Jul 26, 2018:
> > If we want to preserve the current behaviour for trans=fd (and I don't
> > see why not) we just have to patch all the transports that use the
> > device, that is all .create functions but p9_fd_create()
> > 
> > Basically exactly what you did, just for a few more functions - I
> > apparently was a little bit too optimistic thinking we could share
> > this check.
> 
> Does v9fs_mount() knows the transport ahead? Because in that case it'd
> be possible to check if addr!=NULL && trans!=fd then return error
> 
> Otherwise, patching all the .create, ok.

9p option parsing is all over the place, split in fs/9p/v9fs,
net/9p/client and net/9p/trans_*... Which is actually somewhat of a
problem because that means we can't warn on unused option as each parser
does not know the full subset of options used, so if someone makes a
typo they're on their own to figure it out :/


If you want to factor it in, v9fs_mount does not know which transport is
used, but p9_client_create does know - although the functions/structs
are all static so you need to check clnt->trans_mod->name with strcmp
and I'm honestly not sure that's better than checking in each function..

But, as usual I'm happy as long as it works, so pick your poison :)

-- 
Dominique Martinet
