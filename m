Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770FEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF22206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="QIvFDyOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF22206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbeIRWnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:43:03 -0400
Received: from vern.gendns.com ([206.190.152.46]:51313 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730140AbeIRWnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FZaLJFqELgHmbFLyzRwtlf7BQZspCL+RovxK1SpYuwo=; b=QIvFDyOXobeZG0tJ7OSa+5juAd
        nvQQFWON6vLUkdm8IPnqXBBByB2iRIwW9oXENJCbxcsm609jyiQj32tbf/j2buRfKQ0lCD3LKS4kp
        +0JQc1GlIvdeQ76Jk8r6E/Fg0tSyvWfkXRIv8UUxmagyWvvLSJNBXJi1NE5CYlqw5V/NVPvZnOBqd
        22eYXLKyo9pFeDk+9Lro8YVaPAyt+7haJXJ4GFmESzsRoVmZlSb5chXYxvvJ4okGk1/ByEEa4giJt
        HkdCFE6nbwtUOVO6BMsHaUc8EdwYzOm8tYbJKhGlUuFxbMnGAqfAzo1XEvB7NVO4VF+lOZTfa7m5Z
        6UCx+fww==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:37876 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1g2JVA-0074xZ-Go; Tue, 18 Sep 2018 13:09:28 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-spi@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] spi: SPI_CS_WORD followup
Date:   Tue, 18 Sep 2018 12:08:47 -0500
Message-Id: <20180918170850.2749-1-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a followup to the series "spi: introduce SPI_CS_WORD mode flag" [1] to
address some review comments.

- The first two patches handle the case for GPIO CS
- The last patch is the IIO patch from the previous series with an expanded
  commit message.


[1]: https://lore.kernel.org/lkml/20180913003920.30600-1-david@lechnology.com/

David Lechner (3):
  spi: always use software fallback for SPI_CS_WORD when using cs_gio
  spi: spi-davinci: Don't error when SPI_CS_WORD and cs_gpio
  iio: adc: ti-ads7950: use SPI_CS_WORD to reduce CPU usage

 drivers/iio/adc/ti-ads7950.c | 53 +++++++++++++++++++++---------------
 drivers/spi/spi-davinci.c    |  3 --
 drivers/spi/spi.c            |  6 ++--
 3 files changed, 35 insertions(+), 27 deletions(-)

-- 
2.17.1

