Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D576C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB7B21534
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 08:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB7B21534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbeHTMNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:13:36 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:8569 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeHTMNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:13:35 -0400
X-IronPort-AV: E=Sophos;i="5.53,264,1531810800"; 
   d="scan'208";a="18003594"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Aug 2018 01:58:49 -0700
Received: from ibiza.rfo.atmel.com (10.10.76.4) by chn-sv-exch04.mchp-main.com
 (10.10.76.105) with Microsoft SMTP Server id 14.3.352.0; Mon, 20 Aug 2018
 01:58:44 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <ulf.hansson@linaro.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <dgilbert@interlog.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 0/2] atmel-mci and maybe android-goldfish broken on 4.18
Date:   Mon, 20 Aug 2018 10:54:43 +0200
Message-ID: <20180820085445.14632-1-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dougas Gilbert noticed that atmel-mci was broken with the 4.18 release.
He found the culprit commit which is 5b4277814e3fd
("[PATCH 2/7] mmc: atmel-mci: use sg_copy_{from,to}_buffer"). The from/to
logic was inverted: sg_copy_to_buffer copies from an SG list to a linear
buffer so it can't replace a memcpy where the destination is the virtual
address of an SG buffer.

This patch was part of "make more host drivers highmem safe v2". It seems
there is the same logical error within the android-goldfish driver but I
couldn't check it on real hardware.

Ludovic Desroches (2):
  mmc: atmel-mci: fix bad logic of sg_copy_{from,to}_buffer conversion
  mmc: android-goldfish: fix bad logic of sg_copy_{from,to}_buffer
    conversion

 drivers/mmc/host/android-goldfish.c |  4 ++--
 drivers/mmc/host/atmel-mci.c        | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.12.2

