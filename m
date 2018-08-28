Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13B1C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9726020671
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9726020671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeH1Qqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:46:44 -0400
Received: from foss.arm.com ([217.140.101.70]:37272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbeH1Qqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:46:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FBC880D;
        Tue, 28 Aug 2018 05:55:07 -0700 (PDT)
Received: from armageddon.cambridge.arm.com (armageddon.emea.arm.com [10.4.13.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94C193F721;
        Tue, 28 Aug 2018 05:55:06 -0700 (PDT)
Date:   Tue, 28 Aug 2018 13:55:03 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kedareswararao Appana <kedare06@gmail.com>
Cc:     will.deacon@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Query on dma_set_mask_and_coherent() Usage
Message-ID: <20180828125503.ws66n2oxrhmuereb@armageddon.cambridge.arm.com>
References: <CANdmM3O_q_dAzVAd5Lk+u_OHqgEkHR2p1ucgEZ5v_tLQ6G+3Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANdmM3O_q_dAzVAd5Lk+u_OHqgEkHR2p1ucgEZ5v_tLQ6G+3Rw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 08:20:36PM +0530, Kedareswararao Appana wrote:
>               On arm64 platform I have booted Linux only with > 32-bit
> Address i.e from 0x800000000 (reg =  <0x8 0x00000000 0x0 0x80000000>)

So you have 2GB of RAM starting at 0x8_0000_0000.

> In my driver, I am using dma_set_mask_and_coherent(&pdev->dev,
> DMA_BIT_MASK(32)); which should fail if I boot Linux
> with the above configuration but the API is returning success.
> 
> I have debugged it further and observed that, in the arm64
> dma-mapping.c swiotlb is zero resulting dma_supported ops always
> returning 1
> 
> https://elixir.bootlin.com/linux/v4.17.8/source/arch/arm64/mm/dma-mapping.c#L321
> 
>  I will be grateful if someone can send me some pointers for fixing this issue

It's an assumption we've made here:

https://elixir.bootlin.com/linux/v4.17.8/source/arch/arm64/mm/init.c#L224

32-bit devices are expected to have a dma_pfn_offset (and the hardware
configured accordingly).

-- 
Catalin
