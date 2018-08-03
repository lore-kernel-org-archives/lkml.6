Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C6CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B022173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="WqX3eEft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B022173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbeHCKno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:43:44 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:59871 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729814AbeHCKnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:43:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id D52CE1458F223;
        Fri,  3 Aug 2018 16:51:58 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Zsbo5tmmzRi8; Fri,  3 Aug 2018 16:51:58 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 5BE191458F232;
        Fri,  3 Aug 2018 16:51:58 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 5BE191458F232
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533286318;
        bh=/vSghkdXHCtCWyJiGHzKBOpilBPrTP8B2cX+1iQ/N2c=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=WqX3eEfth8KVm3aJ9wykuK3mYh8PD+jBucFL4R2K/G6VwT6rtXtOFqdsvSwcMdE6t
         /pIXHw92ICBD9CUEW3f7KV2s+VKasCsQEpBBjkUwt2xe8Jt3+CG8p64dgPJhLR8WT+
         VTTufMT2SNwCa8C4kuQjQ2cd4okoV9ccDzznA+E8=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xa-kM69glU3n; Fri,  3 Aug 2018 16:51:58 +0800 (CST)
Received: from hsj-Precision-5520 (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 148F81458F223;
        Fri,  3 Aug 2018 16:51:57 +0800 (CST)
Date:   Fri, 3 Aug 2018 16:48:14 +0800
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
Message-ID: <20180803084814.GA30216@hsj-Precision-5520>
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
> 	return 0;
> }
> 
> after:
> _remove()
> {
> ...
> 	/* Free resources, disable HW, etc */
> 	/*
> 	 * The dma device is still registered and a channel can be
> 	 * requested
> 	 */
> 
> 	dma_async_device_register()
> 	return 0;
> }
> 
> It might be theoretical, but conversion to managed device resources is
> not straight forward in some cases. 
Yes. 

okay, let me think again..

@Vinod, please just ignore this patch set.

Thanks
Huang Shijie
