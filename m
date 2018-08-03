Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2DBC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D008216F3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="hWhJNaG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D008216F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbeHCJy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:54:29 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:50596 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbeHCJy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:54:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 76F001399B2E1;
        Fri,  3 Aug 2018 16:02:59 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lJXFOg1a1iDe; Fri,  3 Aug 2018 16:02:59 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 1BA841399B2F8;
        Fri,  3 Aug 2018 16:02:59 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 1BA841399B2F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533283379;
        bh=zaK+kj3Rv/f+QqL104DMQN4NEbaF4nBe0AaOq4Q2rEE=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=hWhJNaG+9Ciw3DtNBtUYy06BMFfMkwK5CDUszcougGwY3cc4C30YeYiFvvaySBfC5
         +lqvHi7r1BZ+ADt7qDKcCAFwvxyXkXn+k2wa6dcQGY2F6T/9CMd09FCBGeUFKu2JaE
         JX2lhOSMqm94DEo3bZeFnB162lCDRHpUZpPHZfx8=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2e5-GhF9Vuyf; Fri,  3 Aug 2018 16:02:59 +0800 (CST)
Received: from hsj-Precision-5520 (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 5CCB81399B2E1;
        Fri,  3 Aug 2018 16:02:58 +0800 (CST)
Date:   Fri, 3 Aug 2018 15:59:16 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave.jiang@intel.com,
        radhey.shyam.pandey@xilinx.com, appana.durga.rao@xilinx.com,
        jmkrzyszt@gmail.com, gomonovych@gmail.com, peter.ujfalusi@ti.com,
        keescook@chromium.org, horms+renesas@verge.net.au,
        geert+renesas@glider.be, shawnguo@kernel.org,
        baoyou.xie@linaro.org, michal.simek@xilinx.com, baohua@kernel.org,
        ludovic.desroches@microchip.com, linus.walleij@linaro.org,
        david.brown@linaro.org
Subject: Re: [PATCH 00/46] Use dmaenginem_async_device_register to simplify
 code
Message-ID: <20180803075915.GC29473@hsj-Precision-5520>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
 <2ca11b6e-3afc-d55f-6df7-88a8a4a88873@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ca11b6e-3afc-d55f-6df7-88a8a4a88873@metafoo.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 09:51:43AM +0200, Lars-Peter Clausen wrote:
> On 08/03/2018 09:19 AM, Huang Shijie wrote:
> > All the patches are using dmaenginem_async_device_register to simplify code
> > except the last one:
> >   dmaengine: add COMPILE_TEST for the drivers
> > 
> > I use the last one to do the compiler test.  
> > There are still 20 drivers which do not use the dmaenginem_async_device_register.
> > Let me take a rest, if this patch set is accepted, I will do the rest.
> 
> Lots of race conditions in this series. The DMA device needs to be removed
> before any of the resources it uses are disabled/released.
> 
> As a rule of thumb you can only convert something to a managed
> allocation/reregistration if it is the last action in remove.
Yes. Agree.

I am collecting the DMA maintainers opinions now..
If the managed unregistration is not the last action, we can drop the patch.

Thanks
Huang Shijie

