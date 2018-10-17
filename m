Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25EEC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8DE214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8DE214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codemonkey.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeJQLoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 07:44:17 -0400
Received: from scorn.kernelslacker.org ([45.56.101.199]:41390 "EHLO
        scorn.kernelslacker.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeJQLoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 07:44:16 -0400
Received: from [2601:196:4600:5b90:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.89)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1gCcr0-000756-OV; Tue, 16 Oct 2018 23:50:38 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id 9DFCD56010A; Tue, 16 Oct 2018 23:50:38 -0400 (EDT)
Date:   Tue, 16 Oct 2018 23:50:38 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Cong Wang <xiyou.wangcong@gmail.com>, Meelis Roos <mroos@linux.ee>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Subject: Re: netconsole warning in 4.19.0-rc7
Message-ID: <20181017035038.czaqown24rnjn2pw@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Cong Wang <xiyou.wangcong@gmail.com>, Meelis Roos <mroos@linux.ee>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
References: <e0611057-1b5b-9990-b9fa-060a9b5eba40@linux.ee>
 <CAM_iQpU0+LVwgMea32KQWf8z6Bp1VTmWOGnWNwNSmV0PZzf_ew@mail.gmail.com>
 <20181017034047.nrhstc3b4wzevnri@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017034047.nrhstc3b4wzevnri@codemonkey.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 11:40:47PM -0400, Dave Jones wrote:

 >  > This is exactly what I mentioned in my review here:
 >  > https://marc.info/?l=linux-netdev&m=153816136624679&w=2
 >  > 
 >  > "But irq is disabled here, so not sure if rcu_read_lock_bh()
 >  > could cause trouble... "
 > 
 > Not sure why this didn't show up for me when I was developing that
 > patch, but I can now reproduce this.  The patch below fixes it for
 > me, but I'm not sure if there are still any side-effects.
 > There's also a missed unlock in the error path.

I took another look at that error path. Turns out this is all we need I
think..


diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index de1d1ba92f2d..f9322d5db899 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -318,6 +318,7 @@ void netpoll_send_skb_on_dev(struct netpoll *np, struct sk_buff *skb,
 	npinfo = rcu_dereference_bh(np->dev->npinfo);
 	if (!npinfo || !netif_running(dev) || !netif_device_present(dev)) {
 		dev_kfree_skb_irq(skb);
+		rcu_read_unlock_bh();
 		return;
 	}
 

