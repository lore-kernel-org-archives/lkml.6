Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E376CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0D520892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0D520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbeKHBsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:48:20 -0500
Received: from foss.arm.com ([217.140.101.70]:53780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727546AbeKHBsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:48:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35F1580D;
        Wed,  7 Nov 2018 08:17:18 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A8E03F5BD;
        Wed,  7 Nov 2018 08:17:15 -0800 (PST)
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Fix crash on early domain free
To:     Joerg Roedel <joro@8bytes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181107131850.11584-1-geert+renesas@glider.be>
 <e4dcd8b2-768e-b11d-b6de-337b7e942050@arm.com>
 <20181107153418.cge2dj5zmztahxrf@8bytes.org>
 <CAMuHMdWPkMtnGrxrtFGmyJ5NEvSSCiMUVXXBWX+NS-J4tQXLAw@mail.gmail.com>
 <20181107160341.pfpukoqhyhapfzpn@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f8259910-3e07-497b-9f18-6bcb47430cff@arm.com>
Date:   Wed, 7 Nov 2018 16:17:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107160341.pfpukoqhyhapfzpn@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-07 4:03 pm, Joerg Roedel wrote:
> On Wed, Nov 07, 2018 at 04:50:40PM +0100, Geert Uytterhoeven wrote:
>> It only got triggered by the combination of commits 6c2fb2ea76361da9
>> ("of/device: Set bus DMA mask as appropriate") and b4ebe6063204da58
>> ("dma-direct: implement complete bus_dma_mask handling"), which is being
>> fixed by "of/device: Really only set bus DMA mask when
>> appropriate" (https://patchwork.kernel.org/patch/10670177/).
> 
> Okay, but the bug is triggered since 6c2fb2ea76361da9, so I took this
> one for the fixes-tag.

FWIW it looks like it *has* always been possible to hit this crash by 
allocating a domain and freeing it again without attaching any devices, 
it's just highly improbable for any sane code to do that explicitly, so 
the real latent triggers are failure paths in external callers (which in 
this case are themselves only being reached thanks to my bug elsewhere).

Robin.
