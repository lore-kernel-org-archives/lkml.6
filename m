Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC71DC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E00208FC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="OZbOhb7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E00208FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388754AbeHGJ3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:29:13 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57189 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387881AbeHGJ3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:29:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 8C91814265792;
        Tue,  7 Aug 2018 15:19:47 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cT4cHYg00AQC; Tue,  7 Aug 2018 15:19:47 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 23ADE1070E19D;
        Tue,  7 Aug 2018 15:19:47 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 23ADE1070E19D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533626387;
        bh=3H6OCRqbWjm8hTKGZ4uPKBglbLk/TXQ3GZlfodJ4rEQ=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=OZbOhb7fgwLD9oZDJqW5Oe/xLX9epJwYzqnY1MLpPYXfgOo5TdOJVziOvBFH+mS5I
         l4uuamuODDv56LaqQpKre1DLZFAQNSK7JE4370OV1HDvy+PuTIHpOcjocRAIsCRYZc
         RRmwF5kanBJkYPd1K6qCVUgW4djFHGX23rIc8jF0=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sbxf3yT6VNAy; Tue,  7 Aug 2018 15:19:47 +0800 (CST)
Received: from hsj-Precision-5520 (unknown [192.168.128.73])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 93CB413477342;
        Tue,  7 Aug 2018 15:19:46 +0800 (CST)
Date:   Tue, 7 Aug 2018 15:16:05 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.jiang@intel.com, radhey.shyam.pandey@xilinx.com,
        appana.durga.rao@xilinx.com, jmkrzyszt@gmail.com,
        gomonovych@gmail.com, keescook@chromium.org,
        horms+renesas@verge.net.au, geert+renesas@glider.be,
        shawnguo@kernel.org, michal.simek@xilinx.com, baohua@kernel.org,
        ludovic.desroches@microchip.com, linus.walleij@linaro.org,
        david.brown@linaro.org
Subject: Re: [PATCH 09/46] dmaengine: cppi41: use
 dmaenginem_async_device_register to simplify the code
Message-ID: <20180807071604.GA5576@hsj-Precision-5520>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
 <20180803072016.21544-10-sjhuang@iluvatar.ai>
 <43458794-d124-13df-c944-e473dc8ee1c2@ti.com>
 <20180806032847.GA4452@hsj-Precision-5520>
 <0f35be3f-24c0-f7e4-66c8-e9b7e5c01590@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f35be3f-24c0-f7e4-66c8-e9b7e5c01590@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 10:01:47AM +0300, Peter Ujfalusi wrote:
> Hi,
> 
> On 2018-08-06 06:28, Huang Shijie wrote:
> It might be only me, but I like to keep the resource teardown in a
> reverse order of their creation. If everything is devm then it is granted.
Yes.

If everything is devm then it is granted..

> 
> In case of cppi4 it looks safe after reading in to the DMAengine core,
> module core and platform core code.
> 
> But does the removed three lines worth over the clarity of how the
> module removal is proceeding?
Please keep the driver as it is if you like the traditional way. :)

The DMA driver's maintainer has the right to decide whether
to use the dmaenginem_async_device_register or not.

Thanks
Huang Shijie
