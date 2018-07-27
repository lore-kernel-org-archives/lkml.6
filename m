Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B40C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9A7208B3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7xso87f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9A7208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388523AbeG0NmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:42:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43346 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730318AbeG0NmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:42:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id b15-v6so4851511wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 05:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Fypcdp/yNsmis0z3qqUE42HkV0MsDOrXv8XSxx3KYq4=;
        b=P7xso87fmY6y13gdROnzSC1OYLQv7DywcVGy+6zpbdVcRQ82G8zlatdy/+TeL6vrbR
         /kiI0TJrpCaCKzwPCAASl+++RC81X/3PWPeuP5houEC0v8tI7YI2URtgwcTD1PpSyIR/
         TabQlQjbZbTIuSsoWmpsC62sTPhUbbQq7o+Do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Fypcdp/yNsmis0z3qqUE42HkV0MsDOrXv8XSxx3KYq4=;
        b=YDwHs+CuYE5lwzU6z4RxAuPPaUtlUJA9xgKFNlIJ8UVAr6BT1+riAN67yHTlx55z2O
         hKM5iXf6bhSPcSDD9SmJSqX0b9x3V743UkkrLjnQRKrxPqrSrFUtFH44u7rnZOl/MN4T
         DNzEMkNLwVH6pRHy0MQ6YgIuMN7YYmX05lnRGNF7HgtJs5j5sGeVr8MrhIoboKqGnKgX
         T1bZ26VCx/gbZMLIn4mrWp8bYsv9mLXa7BYLxC3QJNNKijIO/aadiUvZwO5c7wyZcwQv
         MdSfx+M3/1mje+hc2N21xF4orbkKCfTYFZImEzwIXh/FKs2Wyt6gjpqbMtf653t7RRsd
         LTuQ==
X-Gm-Message-State: AOUpUlFV5Ex2Eg4oFsmxDPuG3paA+yOFuIRcCrGataEDRYrcGPToFpcT
        0s3xat2xV/Znbu7ZAZnANYou7A==
X-Google-Smtp-Source: AAOMgpf3tyHQTHZ3WNIYqi/FfC9yyOnhq0ocCVHzeMeoTkGF/eWfIT2ldTRnER9SmHx4eeYYuzgXYA==
X-Received: by 2002:adf:9246:: with SMTP id 64-v6mr4754181wrj.109.1532694023321;
        Fri, 27 Jul 2018 05:20:23 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id b126-v6sm6178522wmf.41.2018.07.27.05.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jul 2018 05:20:22 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org
Subject: [PATCH v2 00/10] ASoC: Add support to WCD9335 Audio Codec
Date:   Fri, 27 Jul 2018 13:17:56 +0100
Message-Id: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thankyou for reviewing v1 patchset, here is v2 addressing comments from v1.

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
and capture paths.

This patchset also depends on the SLIMbus Stream apis which is already merged
via char-misc tree for 4.19.

Some parts of the code has been inherited from Qualcomm andriod kernel,
so credits to various authors.

WCD9335 can be interfaced via I2S/I2C or SLIMbus. 

Here is my test branch incase someone want to try this out:
https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=wcd9335

Thanks,
Srini

Changes since v1 (https://lkml.org/lkml/2018/7/23/889)
	- Fixed dt bindings as suggested by Mark B.
	- cleanup CLASS-H code, remove un-used states.
	- Various cleanup suggested by Vinod.

Srinivas Kandagatla (10):
  ASoC: dt-bindings: add dt bindings for wcd9335 audio codec
  mfd: wcd9335: add support to wcd9335 core
  mfd: wcd9335: add wcd irq support
  ASoC: wcd9335: add support to wcd9335 codec
  ASoC: wcd9335: add CLASS-H Controller support
  ASoC: wcd9335: add basic controls
  ASoC: wcd9335: add playback dapm widgets
  ASoC: wcd9335: add capture dapm widgets
  ASoC: wcd9335: add audio routings
  ASoC: apq8096: add support to Analog audio via WCD9335 slim

 .../devicetree/bindings/sound/qcom,wcd9335.txt     |  123 +
 drivers/mfd/Kconfig                                |   18 +
 drivers/mfd/Makefile                               |    4 +
 drivers/mfd/wcd9335-core.c                         |  277 ++
 drivers/mfd/wcd9335-irq.c                          |  172 +
 include/dt-bindings/mfd/wcd9335.h                  |   43 +
 include/linux/mfd/wcd9335/registers.h              |  580 +++
 include/linux/mfd/wcd9335/wcd9335.h                |   45 +
 sound/soc/codecs/Kconfig                           |    5 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/wcd-clsh.c                        |  605 +++
 sound/soc/codecs/wcd-clsh.h                        |   49 +
 sound/soc/codecs/wcd9335.c                         | 4963 ++++++++++++++++++++
 sound/soc/qcom/apq8096.c                           |   68 +
 14 files changed, 6954 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
 create mode 100644 drivers/mfd/wcd9335-core.c
 create mode 100644 drivers/mfd/wcd9335-irq.c
 create mode 100644 include/dt-bindings/mfd/wcd9335.h
 create mode 100644 include/linux/mfd/wcd9335/registers.h
 create mode 100644 include/linux/mfd/wcd9335/wcd9335.h
 create mode 100644 sound/soc/codecs/wcd-clsh.c
 create mode 100644 sound/soc/codecs/wcd-clsh.h
 create mode 100644 sound/soc/codecs/wcd9335.c

-- 
2.16.2

