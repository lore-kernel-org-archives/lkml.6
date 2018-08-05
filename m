Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB898C4646D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 01:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E77217CE
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 01:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="lhwCT7Hr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E77217CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbeHEDGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 23:06:32 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:4516 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbeHEDGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 23:06:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 9610B120854B6;
        Sun,  5 Aug 2018 09:07:28 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VMBM52OeTlX3; Sun,  5 Aug 2018 09:07:28 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 0C7B61292775C;
        Sun,  5 Aug 2018 09:07:28 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 0C7B61292775C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533431248;
        bh=a/++NVgqsYQSXVipcbCMxOTCNlTa4WcXh3BmmT8Xo6Q=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=lhwCT7HrGFwJljaHwhddxN+6CbZdvKv2YMYY6PGHGwzpdTPoh+R/G+oL3Re28ejNp
         VmTURrFkUk09yyCnE6PNIx+sMXw2aPP/Wppne/9FQKcAlo5UJFVKrruahrN/fA+167
         C+OSO2+8TQQwg0G8aacO0gvX7POkt9KKoNp1ZFbg=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EN-k7p7UF0xX; Sun,  5 Aug 2018 09:07:27 +0800 (CST)
Received: from hsj-ThinkPad-Edge-E431 (unknown [223.167.32.17])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 12326120854B6;
        Sun,  5 Aug 2018 09:07:27 +0800 (CST)
Date:   Sun, 5 Aug 2018 09:03:44 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave.jiang@intel.com,
        radhey.shyam.pandey@xilinx.com, appana.durga.rao@xilinx.com,
        jmkrzyszt@gmail.com, gomonovych@gmail.com, keescook@chromium.org,
        horms+renesas@verge.net.au, geert+renesas@glider.be,
        shawnguo@kernel.org, baoyou.xie@linaro.org,
        michal.simek@xilinx.com, baohua@kernel.org,
        ludovic.desroches@microchip.com, linus.walleij@linaro.org,
        david.brown@linaro.org
Subject: Re: [PATCH 00/46] Use dmaenginem_async_device_register to simplify
 code
Message-ID: <20180805010342.GA10132@hsj-ThinkPad-Edge-E431>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
 <5d8b222c-6798-aebc-43fc-d4dab9b6f43b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d8b222c-6798-aebc-43fc-d4dab9b6f43b@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 11:20:49AM +0300, Peter Ujfalusi wrote:
> Hi,
> 
> On 2018-08-03 10:19, Huang Shijie wrote:
> > All the patches are using dmaenginem_async_device_register to simplify code
> > except the last one:
> >   dmaengine: add COMPILE_TEST for the drivers
> > 
> > I use the last one to do the compiler test.  
> > There are still 20 drivers which do not use the dmaenginem_async_device_register.
> > Let me take a rest, if this patch set is accepted, I will do the rest.
> 
> I think for most of the drivers this series is going to open a race
> which is essentially:
> 
> prior:
> _remove()
> {
> ...
> 	dma_async_device_register()
> 	/* Free resources, disable HW, etc */

If these resources are managed by the devm_* APIs.
We can use the dmaenginem_async_device_register().

The Devres will release all the things in the following order:
       ................................................
 	dma_async_device_unregister()
 	/* Free resources, disable HW, etc */
       ................................................

    
Thanks
Huang Shijie
