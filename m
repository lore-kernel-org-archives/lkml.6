Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE98C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BFA223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLtWpFaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BFA223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388827AbeKPEYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:24:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34855 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388293AbeKPEYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:24:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so5352028wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 10:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=db37Pa5OnJlalbC1Xts7cB6LQKlYl4+3RdSS9c6lNEI=;
        b=bLtWpFaBpk/wPHspDeG0fIh9AbH2ujlh3EP51D444ZgAzlve+vlGjjxEwDxcaTtAkT
         rgCXRY+PxxPmOdX+GoEAIA3qb+GIlb/LYP7WV1Xa2Nx8vf84VK9E1mfPts4YMLEfC/mp
         TN57c/VZ+KENihs+z3dvMsHCpTnfXMO2tHFAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=db37Pa5OnJlalbC1Xts7cB6LQKlYl4+3RdSS9c6lNEI=;
        b=VJhinaoQoTa+RS/rPHxA1cGx80f4Y4hQJShyUyZgbfFUvqea1yz+8W44t2UIry7Dby
         n1xQ1pne8yVcVtSqsEO8akS2Gygz3rlQWR/zuDSoSprZusFs6LBU4ROPdjqIk43yQYmv
         PSP9oxFauVhowlsriPO+Bv6yJ6hDNBFO4URd4TtfUDBfPtVo96Rdq9gf0qot+dY3gUCl
         nhNuAkI1YP2rCKB3qJpp+E2CWqrnPo0cfHuRQL7cpfXWTGD9IKCpwedZbJYpL+N1FmTs
         x5lWjjK6vZgK6Pg48NrubD8Izsh6Unxpm8y5geDs5P+pJuwgOGlCkVNpAOtDL8l1T+r7
         3XqQ==
X-Gm-Message-State: AA+aEWYUuSu3ZDV3QGG8WDYXpL3Hr2dvB+wQ3K57WBojqAMr/oo7eL1R
        gc94DcCcGCgU0eTiMRU6Wh/LgA==
X-Google-Smtp-Source: AFSGD/X9cKTlxIlAHbK3AE971I0x3LU0e0k3zdvI7XGTRV1QKBslBSu0q0Qpu5sHjR4a711oMu5X8Q==
X-Received: by 2002:adf:ecd0:: with SMTP id s16-v6mr1634740wro.208.1542305728442;
        Thu, 15 Nov 2018 10:15:28 -0800 (PST)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id r76-v6sm20934737wmb.21.2018.11.15.10.15.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Nov 2018 10:15:27 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        rohitkr@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com,
        devicetree@vger.kernel.org, srini@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/5] ASoC: qdsp6: add compress offload support
Date:   Thu, 15 Nov 2018 18:13:19 +0000
Message-Id: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support to very basic MP3 playback compress offload
support via QDSP ASM module.

Tested this patchset on DB410c with APQ8016 and DB820c with APQ8096 using
tinycompress library.

Adding other codec support should be trivial w.r.t qdsp6 side, however
there are other dependencies like compress UAPI header changes and
FastRPC which are being worked in parallel. Once ready will post them!

thanks,
srini

Changes since v2 (//lkml.org/lkml/2018/9/26/461):
- Removed some unnecessary empty line adds.
- Added more info to snd_compr_set_runtime_buffer() commit message

Srinivas Kandagatla (5):
  ALSA: soc-compress: add support to snd_compr_set_runtime_buffer()
  ALSA: compress: make use of runtime buffer for copy
  ASoC: q6asm-dai: dt-bindings: Add support to compress dais
  ASoC: qdsp6: q6asm: add support to MP3 format
  ASoC: qdsp6: q6asm-dai: Add support to compress offload

 .../devicetree/bindings/sound/qcom,q6asm.txt  |  27 ++
 include/sound/compress_driver.h               |  19 +
 sound/core/compress_offload.c                 |  18 +-
 sound/soc/qcom/Kconfig                        |   1 +
 sound/soc/qcom/qdsp6/q6asm-dai.c              | 372 +++++++++++++++++-
 sound/soc/qcom/qdsp6/q6asm.c                  |   5 +
 6 files changed, 438 insertions(+), 4 deletions(-)

-- 
2.19.1

