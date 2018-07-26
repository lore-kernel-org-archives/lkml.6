Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1D5C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8D820671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8D820671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbeGZLmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:42:08 -0400
Received: from nautica.notk.org ([91.121.71.147]:49496 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbeGZLmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:42:08 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 5C7E5C009; Thu, 26 Jul 2018 12:25:55 +0200 (CEST)
Date:   Thu, 26 Jul 2018 12:25:40 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Tomas Bortoli <tomasbortoli@gmail.com>,
        David Miller <davem@davemloft.net>,
        v9fs-developer@lists.sourceforge.net,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] 9p: fix NULL pointer dereferences
Message-ID: <20180726102540.GA25114@nautica>
References: <20180726081049.10527-1-tomasbortoli@gmail.com>
 <20180726081727.GA6699@nautica>
 <CACT4Y+ark+0EYSZaOX-qDKpOkyfLgSO9CkidZzx=xkUuhpr65A@mail.gmail.com>
 <20180726094849.GA18334@nautica>
 <CACT4Y+Zk_d_Ea-oM0R4cRsdnXogq4S+MZMLHJiJuYzibUkanfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+Zk_d_Ea-oM0R4cRsdnXogq4S+MZMLHJiJuYzibUkanfA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote on Thu, Jul 26, 2018:
> On Thu, Jul 26, 2018 at 11:48 AM, Dominique Martinet
> <asmadeus@codewreck.org> wrote:
> > I'm really curious if anyone ever uses the unix/fd variants for "real"
> > stuff though! (not meaning syzbot isn't real, but I have yet to see
> > anything take advantage of this, even if I could imagine some fun
> > applications by piping the wmii libixp server socket.. and just crashed
> > my laptop trying because of the (fixed) trans put bug.. I have yet to
> > see anyone actually doing this)
> 
> I don't really know any real-world cases, but 9p over fd it looks like
> a kind of fuse, so perhaps somebody uses it this way.

I guess, who knows...

> Also, fd allows to use something like sctp socket, and if I am not
> mistaken, trans=tcp can't even do ipv6 tcp (?).

Yeah... I have a server that supposedly supports it (nfs-ganesha) so
it's been on my todo list forever, but frankly I don't know many more
people using tcp either...

I'd like to at least get this done for rdma eventually but we're stuck
with ipv4 for Lustre anyway so this hasn't really been a priority, even
if either of the transports are likely a few lines "fix" to make them
support both protocols.

-- 
Dominique Martinet
