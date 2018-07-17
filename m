Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B79CECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E478820877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="JU3jrLIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E478820877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbeGQDvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 23:51:40 -0400
Received: from vern.gendns.com ([206.190.152.46]:35629 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729927AbeGQDvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 23:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PulAATXQ8mMXgfa+KzH9fbndMflhi9c4aziU3Zn+svg=; b=JU3jrLIbVv+ZdNXhH/1+06vcxE
        NARrQrTo+bVNudJ3pBU1EKAbhRhRSGf1POHmyEP+lGg0aa1xDfiywb0dg+F66f8/dxvC3n/sXPrjg
        +z0r4UeUz3Umn2iLHMf6b5J0QRQzhpkI+SDP35hPEdsga7QUVDKlEVcbVfdYmqeHlDUwQCQv8VyUS
        i7eWQdG4BHV9eET2/lr2EoJlb40eWLtI/TSt4Z3SITN36vyEfuhBfwGY8Df8reQ88+PkAKip+ZPUP
        HO0hdfYmTWrgn6zimp1uyzfXMcbn2RErvevcETt3W4KWcHGfwcM/2/5YZpNlD0OvTVGtWT+FIwrFK
        ux1YDd1A==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:53228 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1ffGY4-00CnnZ-Jx; Mon, 16 Jul 2018 23:21:12 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-spi@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] spi: introduce SPI_CS_WORD mode flag
Date:   Mon, 16 Jul 2018 22:20:48 -0500
Message-Id: <20180717032052.12273-1-david@lechnology.com>
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

Dependency: the iio patch applies on top of "iio: adc: ti-ads7950: allow
simultaneous use of buffer and direct mode"[1]

[1]: https://lore.kernel.org/lkml/20180716233550.6449-1-david@lechnology.com/

David Lechner (4):
  spi: spi-bitbang: change flags from u8 to u16
  spi: add new SPI_CS_WORD flag
  spi: spi-davinci: Add support for SPI_CS_WORD
  iio: adc: ti-ads7950: use SPI_CS_WORD to reduce CPU usage

 drivers/iio/adc/ti-ads7950.c    | 53 +++++++++++++++++++--------------
 drivers/spi/spi-davinci.c       | 11 +++++--
 include/linux/spi/spi.h         |  2 +-
 include/linux/spi/spi_bitbang.h |  2 +-
 4 files changed, 41 insertions(+), 27 deletions(-)

-- 
2.17.1

