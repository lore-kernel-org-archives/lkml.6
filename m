Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30C9C71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C5620652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C5620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeJOVvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:51:49 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:30826 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726469AbeJOVvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:51:49 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9FDx0Dt004467;
        Mon, 15 Oct 2018 16:03:40 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2n48sh58y4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 15 Oct 2018 16:03:40 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B2BFA31;
        Mon, 15 Oct 2018 14:03:39 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5545C4E65;
        Mon, 15 Oct 2018 14:03:39 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.44) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 15 Oct
 2018 16:03:39 +0200
Received: from localhost (10.201.23.16) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 15 Oct 2018 16:03:38
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <robh@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>
Subject: [PATCH 0/4] ASoC: stm32: sai: add mclk clock provider
Date:   Mon, 15 Oct 2018 16:03:32 +0200
Message-ID: <1539612216-12602-1-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set allows to use STM32 SAI interface as a master clock provider.
The Cirrus cs42l51 codec patch gives the example of the source code required on codec side,
to use SAI mclk provider.

These patches allow to cover the following use cases:
	- SAI is master or slave and is master clock provider
	- SAI is master or slave and is not master clock provider (another sai provides the mclk clock)

Implementation overview:
- mclk configuration
	SAI is registered in clock framework:
		- either as a mclk provider (optional in DT). SAI generates mclk when requested by DAPM
		- or as a mclk consumer (optional in DT).
	cs42l51 codec is configured as a mclk consumer (optional in DT)

- mclk power
	A DAPM is registered in codec to handle mclk enable/disable (DAPM route is set in soundcard node)

- mclk rate:
	mclk rate is computed at runtime from stream rate and mclk-fs ratio provided in DT
	mclk rate is propagated through sysclk callback to the SAI which is mclk consumer.
	The mclk rate is set exclusively to avoid concurrent rate requests on SAI master.

Regards
Olivier

Olivier Moysan (4):
  ASoC: dt-bindings: add mclk provider support to stm32 sai
  ASoC: dt-bindings: add mclk support to cs42l51
  ASoC: stm32: sai: set sai as mclk clock provider
  ASoC: cs42l51: add mclk support

 .../devicetree/bindings/sound/cs42l51.txt          |  17 ++
 .../devicetree/bindings/sound/st,stm32-sai.txt     |   7 +
 .../devicetree/bindings/trivial-devices.txt        |   1 -
 sound/soc/codecs/cs42l51.c                         |   8 +
 sound/soc/stm/stm32_sai.h                          |   3 +
 sound/soc/stm/stm32_sai_sub.c                      | 275 ++++++++++++++++++---
 6 files changed, 274 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cs42l51.txt

-- 
2.7.4

