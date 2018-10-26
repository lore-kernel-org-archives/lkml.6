Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C868ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA4B2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA4B2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeJ0Fc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:32:56 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:41336 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeJ0Fc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:32:56 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-71-107-nat.elisa-mobile.fi [85.76.71.107])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 94EC5300CF;
        Fri, 26 Oct 2018 23:54:23 +0300 (EEST)
Date:   Fri, 26 Oct 2018 23:54:23 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [REGRESSION] OCTEON MMC driver failure with v4.19
Message-ID: <20181026205423.GD3792@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

OCTEON (MIPS64) MMC driver probe fails with v4.19, because with

commit 6c2fb2ea76361da9b420a8e23a2a19e7842cbdda
Author: Robin Murphy <robin.murphy@arm.com>
Date:   Mon Jul 23 23:16:09 2018 +0100

    of/device: Set bus DMA mask as appropriate

we now get a default 32-bit bus DMA mask, and the device itself has
64-bit mask, so it gets rejected.

With the current mainline, the driver is again working (probably
because of b4ebe6063204 ("dma-direct: implement complete bus_dma_mask
handling")). But I think this is just because I happen to have < 4 GB RAM,
and it probably could still fail on bigger systems..?

A.
