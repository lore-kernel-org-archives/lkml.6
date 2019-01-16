Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FABC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BFE206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="il73TofM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404929AbfAPPd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:33:29 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58148 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387579AbfAPPd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:33:28 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0GFXM0E126353;
        Wed, 16 Jan 2019 09:33:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547652802;
        bh=XvZMs47sXQ2CtbRs+eIegwgslk8eTyoumulywHZ45KU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=il73TofMq3RYero5x3YFK3Ckl2kau5tLbg2/kvnytRDQuIURTwdnfBdpO6C19pM1X
         Z++YzakwJ1l69Kq5bs47GPcbyIwYJhEabyS74PPCZFClf+is6rHcnWQCJd5/H6+1Ci
         ojshfa6ab8xXL6oQnS9+t5zeEAhNNJ4oj4hJOUoM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0GFXMoF060396
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jan 2019 09:33:22 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 16
 Jan 2019 09:33:22 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 16 Jan 2019 09:33:22 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0GFXMSH029704;
        Wed, 16 Jan 2019 09:33:22 -0600
Date:   Wed, 16 Jan 2019 09:33:22 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Paul Elder <paul.elder@ideasonboard.com>
CC:     <laurent.pinchart@ideasonboard.com>,
        <kieran.bingham@ideasonboard.com>, <drinkcat@chromium.org>,
        <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] usb: gadget: musb: fix short isoc packets with
 inventra dma
Message-ID: <20190116153322.GG18026@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com,
        drinkcat@chromium.org, balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190116000145.5816-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190116000145.5816-1-paul.elder@ideasonboard.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 07:01:45PM -0500, Paul Elder wrote:
> Handling short packets (length < max packet size) in the Inventra DMA
> engine in the MUSB driver causes the MUSB DMA controller to hang. An
> example of a problem that is caused by this problem is when streaming
> video out of a UVC gadget, only the first video frame is transferred.
> 
> For short packets (mode-0 or mode-1 DMA), MUSB_TXCSR_TXPKTRDY must be
> set manually by the driver. This was previously done in musb_g_tx
> (musb_gadget.c), but incorrectly (all csr flags were cleared, and only
> MUSB_TXCSR_MODE and MUSB_TXCSR_TXPKTRDY were set). Fixing that problem
> allows some requests to be transferred correctly, but multiple requests
> were often put together in one USB packet, and caused problems if the
> packet size was not a multiple of 4. Instead, set MUSB_TXCSR_TXPKTRDY
> in dma_controller_irq (musbhsdma.c), just like host mode transfers.
> 
> This topic was originally tackled by Nicolas Boichat [0] [1] and is
> discussed further at [2] as part of his GSoC project [3].
> 
> [0] https://groups.google.com/forum/?hl=en#!topic/beagleboard-gsoc/k8Azwfp75CU
> [1] https://gitorious.org/beagleboard-usbsniffer/beagleboard-usbsniffer-kernel/commit/b0be3b6cc195ba732189b04f1d43ec843c3e54c9?p=beagleboard-usbsniffer:beagleboard-usbsniffer-kernel.git;a=patch;h=b0be3b6cc195ba732189b04f1d43ec843c3e54c9
> [2] http://beagleboard-usbsniffer.blogspot.com/2010/07/musb-isochronous-transfers-fixed.html
> [3] http://elinux.org/BeagleBoard/GSoC/USBSniffer
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> ---
> Changes in v3:
> 
> - remove unnecessary chunk for sending short packet
> 
> Changes in v2:
> 
> - no more flushing FIFO
> - greatly simplified short packet if guard in musb_g_tx, and removed
>   unnecessary variables
> - minor indentation and wording changes
>  drivers/usb/musb/musb_gadget.c | 13 +------------
>  drivers/usb/musb/musbhsdma.c   | 21 +++++++++++----------
>  2 files changed, 12 insertions(+), 22 deletions(-)

Applied. Thanks.

Regards,
-Bin.
