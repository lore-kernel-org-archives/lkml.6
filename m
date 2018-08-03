Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53937C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E20E2172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E20E2172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbeHCJrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:47:00 -0400
Received: from www381.your-server.de ([78.46.137.84]:60790 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeHCJrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:47:00 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <lars@metafoo.de>)
        id 1flUsD-0005M3-10; Fri, 03 Aug 2018 09:51:45 +0200
Received: from [2003:93:4e47:0:8200:bff:fe9b:6612]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1flUsC-000A3R-Rr; Fri, 03 Aug 2018 09:51:44 +0200
Subject: Re: [PATCH 00/46] Use dmaenginem_async_device_register to simplify
 code
To:     Huang Shijie <sjhuang@iluvatar.ai>, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.jiang@intel.com, radhey.shyam.pandey@xilinx.com,
        appana.durga.rao@xilinx.com, jmkrzyszt@gmail.com,
        gomonovych@gmail.com, peter.ujfalusi@ti.com, keescook@chromium.org,
        horms+renesas@verge.net.au, geert+renesas@glider.be,
        shawnguo@kernel.org, baoyou.xie@linaro.org,
        michal.simek@xilinx.com, baohua@kernel.org,
        ludovic.desroches@microchip.com, linus.walleij@linaro.org,
        david.brown@linaro.org
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2ca11b6e-3afc-d55f-6df7-88a8a4a88873@metafoo.de>
Date:   Fri, 3 Aug 2018 09:51:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.0/24807/Fri Aug  3 02:50:20 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 09:19 AM, Huang Shijie wrote:
> All the patches are using dmaenginem_async_device_register to simplify code
> except the last one:
>   dmaengine: add COMPILE_TEST for the drivers
> 
> I use the last one to do the compiler test.  
> There are still 20 drivers which do not use the dmaenginem_async_device_register.
> Let me take a rest, if this patch set is accepted, I will do the rest.

Lots of race conditions in this series. The DMA device needs to be removed
before any of the resources it uses are disabled/released.

As a rule of thumb you can only convert something to a managed
allocation/reregistration if it is the last action in remove.
