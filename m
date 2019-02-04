Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B65BC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53E520815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549264054;
	bh=J9Ejc/QFwbp/ybBWJfdCPhEWwplBj5pf/5I8F9u7q6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sm6vEhLJ1gau3mtz3/NXVp/Fa27y36MlM5IuFQToKYteWH/q4ligqztaCZEG/v4G5
	 N/Q5dzRC2ZuoHH/1dLlEoxgHDPTQzOeILzwRynQbg7Ms1jMwZ+77Nz83kAlXupV0vy
	 kRxemIljtBSoI9FuFvjvhDP0aPV5wXA+K9FKXfyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfBDHHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 02:07:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfBDHHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 02:07:32 -0500
Received: from localhost (unknown [171.76.74.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4C5620815;
        Mon,  4 Feb 2019 07:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549264051;
        bh=J9Ejc/QFwbp/ybBWJfdCPhEWwplBj5pf/5I8F9u7q6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UovMSkAkZCSWSKtZH054M8vafCIy5t2bz7CalDgQfYFvXpe6X2QYlVWR9TmelHwlE
         gh5fJWwCXluo0PwY2ezWU0NJTs8AfCGRHgOvVt/b4CKgcIZpUhcfolSSqEJAX2xga+
         T3PB2tH5aPcAUti7z/ILwW7r7BGk/kuknX+x4hoE=
Date:   Mon, 4 Feb 2019 12:36:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Leonid Iziumtsev <leonid.iziumtsev@gmail.com>
Cc:     dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, m.grzeschik@pengutronix.de
Subject: Re: [PATCH] dmaengine: imx-dma: fix wrong callback invoke
Message-ID: <20190204070603.GH4296@vkoul-mobl>
References: <20190115171523.702-1-leonid.iziumtsev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115171523.702-1-leonid.iziumtsev@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-01-19, 17:15, Leonid Iziumtsev wrote:
> Once the "ld_queue" list is not empty, next descriptor will migrate
> into "ld_active" list. The "desc" variable will be overwritten
> during that transition. And later the dmaengine_desc_get_callback_invoke()
> will use it as an argument. As result we invoke wrong callback.
> 
> That behaviour was in place since:
> commit fcaaba6c7136 ("dmaengine: imx-dma: fix callback path in tasklet").
> But after commit 4cd13c21b207 ("softirq: Let ksoftirqd do its job")
> things got worse, since possible delay between tasklet_schedule()
> from DMA irq handler and actual tasklet function execution got bigger.
> And that gave more time for new DMA request to be submitted and
> to be put into "ld_queue" list.
> 
> It has been noticed that DMA issue is causing problems for "mxc-mmc"
> driver. While stressing the system with heavy network traffic and
> writing/reading to/from sd card simultaneously the timeout may happen:
> 
> 10013000.sdhci: mxcmci_watchdog: read time out (status = 0x30004900)
> 
> That often lead to file system corruption.

Applied and tagged to stable, thanks
-- 
~Vinod
