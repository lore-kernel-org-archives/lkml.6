Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AC1C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA949244C5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA949244C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967044AbeF1PUE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:20:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53295 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964967AbeF1PUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:20:03 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E7D5C203B4; Thu, 28 Jun 2018 17:20:00 +0200 (CEST)
Received: from localhost (nat.foo.tf [163.172.35.26])
        by mail.bootlin.com (Postfix) with ESMTPSA id BC60D203B4;
        Thu, 28 Jun 2018 17:20:00 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, oferh@marvell.com,
        igall@marvell.com
Subject: [PATCH 00/14] crypto: inside-secure - EIP197d support
Date:   Thu, 28 Jun 2018 17:15:30 +0200
Message-Id: <20180628151544.22134-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series introduces the EIP197d engine support to the Inside Secure
SafeXcel cryptographic engine driver.

In order to support this new engine, the driver has to be reworked in
some ways:
- The firmwares are specific to a given version of an EIP engine: they
  must be stored in a version specific folder.
- The compatibles have to be reworked, to denote the exact version of
  the engine being used. Note that we kept the backward compatibility.
- Not all algorithms are supported by all versions of the EIP engine.

Some improvements were also made to the driver, to fully embrace the
capabilities of this new EIP197d engine, and to improve the existing
support.

Please note the DT patches (13/14 and 14/14) should go through the mvebu
tree.

Thanks!
Antoine

Antoine Tenart (9):
  crypto: inside-secure - move the firmware to a better location
  crypto: inside-secure - use precise compatibles
  Documentation/bindings: crypto: inside-secure: update the compatibles
  crypto: inside-secure - filter out the algorithms by engine
  crypto: inside-secure - add an invalidation flag
  crypto: inside-secure - eip197d support
  Documentation/bindings: crypto: inside-secure: eip197d support
  arm64: dts: marvell: armada-cp110: update the crypto engine compatible
  arm64: dts: marvell: armada-37xx: update the crypto engine compatible

Ofer Heifetz (5):
  crypto: inside-secure - dynamic ring configuration allocation
  crypto: inside-secure - add multiple processing engine support
  crypto: inside-secure - adjust the TRC configuration for EIP197D
  crypto: inside-secure - reset CDR and RDR rings on module removal
  crypto: inside-secure - set tx_max_cmd_queue to 32

 .../crypto/inside-secure-safexcel.txt         |  15 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   2 +-
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi |   2 +-
 drivers/crypto/inside-secure/safexcel.c       | 363 ++++++++++++------
 drivers/crypto/inside-secure/safexcel.h       | 136 ++++---
 .../crypto/inside-secure/safexcel_cipher.c    |  23 +-
 drivers/crypto/inside-secure/safexcel_hash.c  |  18 +-
 drivers/crypto/inside-secure/safexcel_ring.c  |  10 +-
 8 files changed, 370 insertions(+), 199 deletions(-)

-- 
2.17.1

