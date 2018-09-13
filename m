Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39EBC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614D92147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="F+8Hlfch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614D92147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeIMFrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 01:47:00 -0400
Received: from vern.gendns.com ([206.190.152.46]:46143 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbeIMFrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 01:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JZIgClga4XUpBDzlTDNQz8tLfQ5tZB2IY2+IZLtdcew=; b=F+8HlfchBwjBkaOMxzJ6juc49E
        o04//j7LWMvsbWJy/VTVkG7zjdBQt99sGsB/D11f5vOUqcUnfBDFEqpU3b+WLr90RQC2Zo5zpP7ZC
        y0+k8UsLwB+8I0HOwEFTnMaLK7Fjk1xJoUgpk6iwPkYJxWac6DlcPOhWy3vpnR1JPvLK8F0We9Lw0
        +4n1nxBtmJL6MLSo05mV7KsetEbiqOzwvj+1sXrqz+GWtbt+L1FYxY3SSFfxkjG06YbcU4kuYlScc
        KCIr+RoLGiXeEa+5AUJ8I/wHKqgbo9N3bNTdy3GApWpBlJskws5liCzS+DABfG/ikDP5ZXuPpYEYX
        kyJAmunQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:33924 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1g0Ffo-00AGoe-Bk; Wed, 12 Sep 2018 20:39:56 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-spi@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] spi: introduce SPI_CS_WORD mode flag
Date:   Wed, 12 Sep 2018 19:39:16 -0500
Message-Id: <20180913003920.30600-1-david@lechnology.com>
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

This series introduces a new SPI mode flag, SPI_CS_WORD, that indicates that
the chip select line should be toggled after each word sent. This series
includes examples of how this can be implemented for both an SPI controller
and an SPI device.

The motivation here is to take advantage of DMA transfers with an analog/digital
convert chip. This chip requires that the chip select line be toggled after
each word send in order to drive the internal circuitry of the chip.

The way we were accomplishing this was, for example, to read 16 channels, we
would create 16 SPI _transfer_s in one SPI _message_. Although this works, it
uses quite a bit of CPU because we have to do work at the end of each transfer
to get the next transfer ready. When you are polling the chip at 100Hz, this
CPU usage adds up.

The SPI controller being used has DMA support, but only on the _transfer_ level
and not on the _message_ level. So, to take advantage of DMA, we need to read
all of the A/DC channels in a single _transfer_. The SPI controller is capable
automatically toggling the chip select line during a DMA transfer, so we are
adding a new SPI flag in order to take advantage of this.

I have tested both the default software implementation and the spi-davinci
implementation with the A/DC driver in this series.

v2 changes:
- dropped patch "spi: spi-bitbang: change flags from u8 to u16" that has already
  been applied
- new patch "spi: add software implementation for SPI_CS_WORD" that provides
  a default implementation of SPI_CS_WORD for controllers

David Lechner (4):
  spi: add new SPI_CS_WORD flag
  spi: add software implementation for SPI_CS_WORD
  iio: adc: ti-ads7950: use SPI_CS_WORD to reduce CPU usage
  spi: spi-davinci: Add support for SPI_CS_WORD

 drivers/iio/adc/ti-ads7950.c | 53 +++++++++++++++++++++---------------
 drivers/spi/spi-davinci.c    | 11 ++++++--
 drivers/spi/spi.c            | 32 +++++++++++++++++++++-
 include/linux/spi/spi.h      |  2 +-
 4 files changed, 71 insertions(+), 27 deletions(-)

-- 
2.17.1

