Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A27C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF21206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZoPWop6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF21206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeIDOwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:52:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44684 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeIDOwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:52:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so3340098wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Xxn1Md6Q1rw7FvsQmkfDysf/kPe7UQxUJS0wM0f+YJQ=;
        b=ZoPWop6DQzbJKdkLgnXfo6BB04jRWnvzAyTlmzqBdJv79IDYARsL0YRS3Iu/DyAVPV
         QR95TV4YIoKnLUi9N1CRT2aQnPrmfzGnaBlXHd4OFNa5XcRaWh/zTItXh42DqKhtOvZ4
         nUNgJ4rjATk0/cTcHViIg/3XvZIcBIxtokY5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Xxn1Md6Q1rw7FvsQmkfDysf/kPe7UQxUJS0wM0f+YJQ=;
        b=ZD9xJ73/+53sM/uO70+hnII6wZEaR+Js+z0XJvv7dj7bWqWkYjv4G3xU6tfk7baAAe
         1e4D4MKi1IxW2X7MVJ1N6hSESxlyGq3d9BImZj2vKjakODmAgA93fJYsUA87WeSSE7oQ
         HnDPM3bkx3b9RMeTLSU9bjJ44nikePp1ORsITk315T5ELQDxWHHiBuvOTjeXwaE5WAPL
         4ZmDomgXef3irFAIii5VpFGDd5oAReSFaOKz/4L8mUiqzixPMA0wHW1IYz6n4GBQtzWv
         wtiSeFJUG7oUSyVWbuIvOw6C/ZdCJFWlZ3NLprc1ydqQc2YECaQPVTKEvjMxiJ9AMTK8
         cRNA==
X-Gm-Message-State: APzg51Ag8vH7defPZFdG58e4z3YfhhF2gn/3jjk0vcVDT3oXNni8ictm
        GI6h6u4+S7oyiku413ZNEt9eqQ==
X-Google-Smtp-Source: ANB0VdY9PDB5curnWy1uKQghbyz3bq0jF8OMNdYcuKDjUOEm7pgFF900CYP3GE3E3QFhR5OlXRV4lQ==
X-Received: by 2002:adf:9d81:: with SMTP id p1-v6mr21336084wre.12.1536056849836;
        Tue, 04 Sep 2018 03:27:29 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id g129-v6sm16903325wmf.42.2018.09.04.03.27.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 03:27:29 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 00/13] ASoC: Add support to WCD9335 Audio Codec
Date:   Tue,  4 Sep 2018 11:24:47 +0100
Message-Id: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thankyou for reviewing v2 patchset, here is v3 addressing comments from v2.

Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC.
It is integrated in multiple Qualcomm SoCs like: MSM8996, MSM8976,
and MSM8956 chipsets.

WCD9335 had multiple functional blocks, like: Soundwire controller,
interrupt mux, pin controller, Audio codec, MBHC, MAD(Mic activity Detection),
Ultrasonic proximity and pen detection, Battery-voltage monitoring and
Codec processing engine.

Currently this patchset has been only tested with SLIMbus interface due
to hardware avaiablity, but it can be easily made to work with both SLIMbus
and I2C/I2S.    

This patchset adds very basic playback and capture support witout much
fancy features. New features will be added once the basic support is in.
This patchset is tested on top of linux-next on DB820c for both playback
, capture paths and MBHC.

Some parts of the code has been inherited from Qualcomm andriod kernel,
so credits to various authors.

WCD9335 can be interfaced via I2S/I2C or SLIMbus. 

Here is my test branch incase someone want to try this out:
https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=wcd9335

Thanks,
Srini

Changes since v2 (https://lwn.net/Articles/761107/)
 - Updated dt bindings according to Robs Comments.
 - Added MBHC support with new bindings
 - Moved mfd irq in to single file as suggested by Lee Jones.
 - Addressed various minor comments on mfd driver by Lee Jones.
 - Rebased on top of 4.19-rc1
 - renamed clsh as clsh-v2 as its v2 block

Srinivas Kandagatla (13):
  ASoC: dt-bindings: update wcd9335 bindings.
  mfd: wcd9335: add support to wcd9335 core
  mfd: wcd9335: add wcd irq support
  ASoC: wcd9335: add support to wcd9335 codec
  ASoC: wcd9335: add CLASS-H Controller support
  ASoC: wcd9335: add basic controls
  ASoC: wcd9335: add playback dapm widgets
  ASoC: wcd9335: add capture dapm widgets
  ASoC: wcd9335: add audio routings
  ASoC: dt-bindings: Add WCD9335 MBHC specific properties
  ASoC: wcd9335: add mbhc support
  ASoC: apq8096: add slim support
  ASoC: apq8096: add headset JACK support

 .../bindings/sound/qcom,wcd9335.txt           |   30 +-
 drivers/mfd/Kconfig                           |   14 +
 drivers/mfd/Makefile                          |    4 +
 drivers/mfd/wcd9335-core.c                    |  369 ++
 include/linux/mfd/wcd9335/registers.h         |  627 ++
 include/linux/mfd/wcd9335/wcd9335.h           |   65 +
 sound/soc/codecs/Kconfig                      |    5 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wcd-clsh-v2.c                |  577 ++
 sound/soc/codecs/wcd-clsh-v2.h                |   49 +
 sound/soc/codecs/wcd9335.c                    | 5234 +++++++++++++++++
 sound/soc/qcom/apq8096.c                      |  122 +-
 12 files changed, 7092 insertions(+), 6 deletions(-)
 create mode 100644 drivers/mfd/wcd9335-core.c
 create mode 100644 include/linux/mfd/wcd9335/registers.h
 create mode 100644 include/linux/mfd/wcd9335/wcd9335.h
 create mode 100644 sound/soc/codecs/wcd-clsh-v2.c
 create mode 100644 sound/soc/codecs/wcd-clsh-v2.h
 create mode 100644 sound/soc/codecs/wcd9335.c

-- 
2.18.0

