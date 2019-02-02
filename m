Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC523C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEEE2146E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549103238;
	bh=GS/fdapWnmzoOb1gHr/sWftx5rSEkr7c8Rf7n8mX+ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aK+VeDQNCv72l6O03AuooxYUB5Im2as/sQBdaDXfFZx/w0LGfPnzYdPi6aprXBP5m
	 Eh2+BEG6agGu51GeMsIgZ9/fKK4afTSMlYFwW1XOpE1dqcdlL8W4NndG5D9f2grmIR
	 p/5XZdilsIdZXM2iRi5lDuAVI58BnHQmwxlXfsYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfBBK1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 05:27:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfBBK1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 05:27:11 -0500
Received: from localhost (unknown [125.16.100.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57314217D6;
        Sat,  2 Feb 2019 10:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549103231;
        bh=GS/fdapWnmzoOb1gHr/sWftx5rSEkr7c8Rf7n8mX+ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/B1et1b2uCqjJGTFBrGngFuW8z1AfcmKNWBRFnTSfe9LPkEGZJa+3oKXlE2ou3Jv
         kjUia/oCPMnmL66bduRAm+zmhktVHZzCOFeVocsQ7L8LNYOCg4ZDWzml+Mxf1aMD2E
         VI85NGBcOeo0IX4Qv8utHeJjqPMQYsnZOjy1ccmc=
Date:   Sat, 2 Feb 2019 15:55:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Codrin.Ciubotariu@microchip.com
Cc:     Ludovic.Desroches@microchip.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: at_xdmac: Fix wrongfull report of a
 channel as in use
Message-ID: <20190202102540.GF4296@vkoul-mobl>
References: <20190123163339.17506-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123163339.17506-1-codrin.ciubotariu@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-19, 16:33, Codrin.Ciubotariu@microchip.com wrote:
> From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> 
> atchan->status variable is used to store two different information:
>  - pass channel interrupts status from interrupt handler to tasklet;
>  - channel information like whether it is cyclic or paused;
> 
> This causes a bug when device_terminate_all() is called,
> (AT_XDMAC_CHAN_IS_CYCLIC cleared on atchan->status) and then a late End
> of Block interrupt arrives (AT_XDMAC_CIS_BIS), which sets bit 0 of
> atchan->status. Bit 0 is also used for AT_XDMAC_CHAN_IS_CYCLIC, so when
> a new descriptor for a cyclic transfer is created, the driver reports
> the channel as in use:
> 
> if (test_and_set_bit(AT_XDMAC_CHAN_IS_CYCLIC, &atchan->status)) {
> 	dev_err(chan2dev(chan), "channel currently used\n");
> 	return NULL;
> }
> 
> This patch fixes the bug by adding a different struct member to keep
> the interrupts status separated from the channel status bits.

Applied, thanks

-- 
~Vinod
