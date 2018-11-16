Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44119C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D506208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VNiugxc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D506208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389928AbeKPXxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:53:03 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54018 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389761AbeKPXxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:53:03 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAGDeV4Y080949;
        Fri, 16 Nov 2018 07:40:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542375631;
        bh=D57MtcRMcMYoKwYPIkdseLllmZ26OhyEhcNVjT92Lm4=;
        h=From:To:CC:Subject:Date;
        b=VNiugxc2lC43sgemlzC4FZkLXdyhy8MP5tVjtr5k/GGnfOebMNNtmCOxU7ULO3eIJ
         I5fbX5RyVJpHlvYZLmBPk7Du82cjeZhXqc9fzXEsuN3TyeDjuN6R9IvvACivMFebSI
         oTPUrSK06XwJFeszFjoKuDoYFRnW27pePVwiiMHo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAGDeVtt057396
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Nov 2018 07:40:31 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 16
 Nov 2018 07:40:30 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 16 Nov 2018 07:40:30 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAGDeQwq005228;
        Fri, 16 Nov 2018 07:40:27 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <misael.lopez@ti.com>,
        <jsarha@ti.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] ASoC; davinci-mcasp: Pin handling updates
Date:   Fri, 16 Nov 2018 15:41:37 +0200
Message-ID: <20181116134141.17396-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The series will improve the McASP pin handling:
- To avoid non configured clocks leaking out from McASP
- make sure that the AXR pin (TX) state is correct in all scenarios
- Allow user configurable DISMOD for the tx pin instead of hardwiring it in the
  code to low

The DISMOD configuration is needed when the codec requires the TX line to be
high during inactive slots (mu-law codecs for example).

Regards,
Peter
---
Peter Ujfalusi (4):
  ASoC: davinci-mcasp: Clear TXSTAT register before activating
    serializers
  ASoC: davinci-mcasp: Update PDIR (pin direction) register handling
  bindings: sound: davinci-mcasp: Document dismod optional property
  ASoC: davinci-mcasp: Implement configurable dismod handling

 .../bindings/sound/davinci-mcasp-audio.txt    |   5 +
 include/linux/platform_data/davinci_asp.h     |   1 +
 sound/soc/davinci/davinci-mcasp.c             | 109 +++++++++++++++---
 sound/soc/davinci/davinci-mcasp.h             |  30 ++---
 4 files changed, 112 insertions(+), 33 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

