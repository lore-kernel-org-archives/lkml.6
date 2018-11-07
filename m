Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AC0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC8720882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YexsQG79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC8720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbeKHIla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:41:30 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43057 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbeKHIla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:41:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id g59-v6so8552933plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 15:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Mz309qsso7vjs42wP2+y36SjOBj9rEq49mSc84PaOXg=;
        b=YexsQG79TB48ipkPC1LF9fXM2jYn1eARSWk8bKu7k7ydtHywSwVyu752yKBSSXhA59
         7sneKYcw0Qm7C70OMU3Dp3L+vCG6mapByCClaco0wwPIBlyHnnbQKRv0T07VxnlAsMSF
         Hci293zjaU61incsqOgXW8Wt6stcPBZjpXXO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mz309qsso7vjs42wP2+y36SjOBj9rEq49mSc84PaOXg=;
        b=G3qyDs+vv51UWOUhC9uGal7p7g52xrNDnSx10EOZH0tvlE2nMpcJ46Q4EbrOet9MAi
         J2knrK/R6fU+BYiRGu+tRt/eXcKacKsS7b+Tzy3YrhXKvdXOc3uyUbXsCYiT1bmS6ow/
         1pUyszQZB6lgz+c4G/zrcof5bKOFzrdfIGqleyuOHlHbgu6KNIkzgbSGIbOkJIkgeg7n
         luasnSUd7YxpoP6WV+W4IugkmeACaeORFD3b2dGoVqFaa0+8ohh6uWw2/8221rDdRNSt
         uitCWHfif7rJZhBRWPguEsnFxT9++9rWemYpI5yy+Zgxj1BNSOeuPjPm6MaaUNfwERMd
         G5WQ==
X-Gm-Message-State: AGRZ1gLg5ZsL+urtFqbgsjp+VQuyYa5eNC32xUCn+NyaFr0qHigCW8Eg
        +DS5HmsVnDHyUAI9bwHovs/JusvxxvY=
X-Google-Smtp-Source: AJdET5fVix7/OK6xuVTYoePvH5KQZ+od25iW493gXScLpnLAiVvI00HYalQr9vHYW1TCpwg0xcmqSg==
X-Received: by 2002:a17:902:2943:: with SMTP id g61-v6mr2284183plb.82.1541632134448;
        Wed, 07 Nov 2018 15:08:54 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id e70-v6sm1802034pfb.113.2018.11.07.15.08.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Nov 2018 15:08:53 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, leo.yan@linaro.org,
        suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] coresight: Fix miscellaneous problems with CLAIM tags
Date:   Wed,  7 Nov 2018 16:08:48 -0700
Message-Id: <1541632132-1252-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set addresses problems observed with the CLAIM tag feature.  The first
patch adds support for CLAIM tags to the ETB10 drivers.  The remaining 3 
patches deal with properly handling the tags on ETF and ETM3x devices.

Regards,
Mathieu

Changes since V1:
* Added Suzuki's review tags to patch 1 and 2.
* Addressed ordering issued in ETM3x enable/disable functions (Leo Yan)
 

Mathieu Poirier (4):
  coresight: etb10: Add support for CLAIM tag
  coresight: etf: Release CLAIM tag after disabling the HW
  coresight: etm3x: Deal with CLAIM tag before and after accessing HW
  coresight: etm3x: Release CLAIM tag when operated from perf

 drivers/hwtracing/coresight/coresight-etb10.c   | 23 +++++++++++++++++------
 drivers/hwtracing/coresight/coresight-etm3x.c   | 17 +++++++++--------
 drivers/hwtracing/coresight/coresight-tmc-etf.c |  2 +-
 3 files changed, 27 insertions(+), 15 deletions(-)

-- 
2.7.4

