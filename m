Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DAD9DC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86510208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="INuYMFJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86510208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755176AbeFNLM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:12:29 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37331 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755011AbeFNLM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:12:26 -0400
Received: by mail-lf0-f65.google.com with SMTP id g21-v6so8805444lfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 04:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OLM64qu0BqGnXUPi7feqWMmjyhhNKd3eVLkEDXss8gg=;
        b=INuYMFJYUkGHh1kcbDzbPPnHV4ZJgmbgb3lyUN7s54D3Re3+y8GzE8Iy2OAPvgkOZM
         jx6HmOR1WcIYSSvhXTY3hz7D1+lrmXNnPb/PcOXF9fJ1a8e0Iznw0lJ9oyTHIm4cH11x
         /NjqV3CluHO2ziuxpNeXLb5Q8e1wF3fHQvYRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OLM64qu0BqGnXUPi7feqWMmjyhhNKd3eVLkEDXss8gg=;
        b=sPob06u4fxydfSB3PBradJs9VXZe2HuMveat5Vw8cmRQdA2svOgkUPczwK8AwOacjd
         /qoTdSovcIl5BUCJ/x+AbkmNY9vhAOHJ5qGHGE9YglWCC12/toiMD8JkVLk0HnoSP63q
         NEvvo3vW4DGXzxSInvBUjBAZdxZQe4Bxiqt/WelxGI3eNoxGCMO5yzxnmimGGclyI0S2
         FpM3rMdipbTxuBmnFhtm6SFam8s/MRF1URW9HIbgcegGQcI669fniEjlSMYLmbqYOhZY
         AyH1MivAFdppDZwOgoQtoHZIIhlRylhahHEn+gGWYA0jiPYfbfElt8rOjb4weJE8nWoB
         cqmQ==
X-Gm-Message-State: APt69E1ymmKyKPlux5bsBPV9tywWWOvfctABnI+KlHFF/WSCmZVqhF5H
        Rke7F/Wr2xlkXSErA/ArWh/DUA==
X-Google-Smtp-Source: ADUXVKJBYfKMdqebQFRfBrBI/R772/Nk4U2UzirtxjzZeY2IEQHctUw7Q52S9ODPS4cU67wvY5N5FQ==
X-Received: by 2002:a19:c452:: with SMTP id u79-v6mr5553433lff.5.1528974745266;
        Thu, 14 Jun 2018 04:12:25 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id j103-v6sm1029550lfi.58.2018.06.14.04.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 04:12:24 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     andy.gross@linaro.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v2 0/7] soc: qcom: Allow COMPILE_TEST of all drivers
Date:   Thu, 14 Jun 2018 13:11:31 +0200
Message-Id: <20180614111138.8923-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit cab673583d96 ("soc: Unconditionally include qcom Makefile"),
we unconditionally include the soc/qcom/Makefile.

This opens up the possibility to compile test the code even when
building for other architectures.

This patch series prepares and enables all but two Kconfigs to be
compile tested even when building for other architectures.


Changes since v1:
Added two new patches, "ASoC: qdsp6: Add depends on OF"
and "soc: qcom: Remove bogus depends on OF".
Patch "soc: qcom: Allow COMPILE_TEST of all drivers"
now adds "depends on ARCH_QCOM || COMPILE_TEST" to the menu entry.


Niklas Cassel (7):
  rpmsg: smd: Add missing include of sizes.h
  soc: qcom: smem: Add missing include of sizes.h
  soc: qcom: smp2p: Add select IRQ_DOMAIN
  soc: qcom: smsm: Add select IRQ_DOMAIN
  ASoC: qdsp6: Add depends on OF
  soc: qcom: Remove bogus depends on OF
  soc: qcom: Allow COMPILE_TEST of all drivers

 drivers/rpmsg/qcom_smd.c |  1 +
 drivers/soc/qcom/Kconfig | 14 +++++---------
 drivers/soc/qcom/smem.c  |  1 +
 sound/soc/qcom/Kconfig   |  2 +-
 4 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.17.1

