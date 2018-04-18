Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524065756; cv=none;
        d=google.com; s=arc-20160816;
        b=iH8za94LvsS0B1S5qiVsYchaTClerPXk9jL4ZNHVae7FLbLPXvOxjylCouS1dQKcEt
         WcWRhCCPJngMxNRHb3C9UDluN80uPC3Xo/3qhqRmkvSxvIAIfS0OZR8moeaIAjtTZt0K
         Bm5r8gKNgV3nur65M+rALaR9KavKCHfkB+tT9WG7imAEAMVUmnAqM1xJRhnd6d3P+c4b
         sLVhNxc2M7rx2mNXRR4rkbjXZsTyHYzfpfWh58xgXelVZE3jnHsjTzd45VJs3EXnyMFb
         HOYOEaVVCIuN2d/OEycKWYptzC5+fusTM3Z028RsIZYxbvl5vl0DAOE6vAJ2TZe0Pw8/
         YBRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=9EnCiOeYSIl/GqlIy3NOJ+ihvohwchpbM6dKX1Im4GY=;
        b=Yh2GQlF8QOfqKa9LAQWqN5e+XQCEc/Uyy8z2Lc+WiCoyTmXJCCPUWbNXgfVu/FwxCJ
         2dQTSpLBFHO39KDGQCFkZouFXVlvmGyEP1uxwwoJgsyzMozfMBWtzR+ojUkAEHc4pZKZ
         0C18FjCJYyCu1giE15NpewdlnRX7Xd58Pjm1aMRse6rS7l+HqikhlE4JrTePqmyz6xwB
         m+qKmZ1FzbiygbsdN9Zu4rpTeXZb6FimOz06fZSUldqHSNAd15b0Jm/4T6/vo+8Y514M
         ozC0edVvXncP+FEGeTfzghsmk0YEU0ihIqB9b3VmxMd73zuLMNtX7sAw6xYrSUtQAAQl
         20WA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Hn0c6eLD;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Hn0c6eLD;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4+Hs5NYrV/fE0d2Zn5Y3ZN5CGAmwhl4HHtuVaReOLtz7FQCjtI8Ruc8nBcureHO613jQXFciQ==
From: srinivas.kandagatla@linaro.org
To: andy.gross@linaro.org,
	broonie@kernel.org,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org,
	david.brown@linaro.org,
	mark.rutland@arm.com,
	lgirdwood@gmail.com,
	plai@codeaurora.org,
	bgoswami@codeaurora.org,
	tiwai@suse.com,
	perex@perex.cz,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 00/23] ASoC: qcom: Add support to QDSP based Audio
Date: Wed, 18 Apr 2018 16:31:34 +0100
Message-Id: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598098774806419519?=
X-GMAIL-MSGID: =?utf-8?q?1598098774806419519?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thankyou everyone for providing feedback on v4 patchset.
This patchset aims to provide a basic version of QCOM DSP based
audio support which is available in downstream andriod kernels.
This patchset support audio playback on HDMI-RX, MI2S, SLIMBus and
will add support to other features as we move on.

QDSP has both static and dynamic modules. static modules like AFE
(Audio FrontEnd), ADM (Audio Device Manager), ASM(Audio Stream Manager)
and CORE to provide this audio services.
All these services use APR (Asynchronous Packet Router) protocol
via smd/glink transport to communicate with Application processor.
More details on each module is availble in there respective patch.

This patchset is tested on DB820c, with HDMI audio playback, MI2S on
DB410c on top of mainline, Also tested SLIMBus analog audio using
wcd9355 with an additional patches. Previous version of these
patches are also tested on SDM845 by Rohit.

Here is my test branch incase someone want to try these patches
https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=v4.16-qdsp6-v5

Here is block diagram to give a quick overview of the components


  +---------+          +---------+         +---------+   
  |  q6asm  |          |q6routing|         | q6afe   | 
  |   dais  | <------> |  mixers | <-----> |  dais   |  
  +---------+          +---------+         +---------+   
      ^                     ^                   ^
      |                     |                   |
      |  +------------------+----------------+  |       
      |  |                  |                |  |       
      v  v                  v                v  v       
  +---------+          +---------+         +---------+ 
  |   q6ASM |          |  q6ADM  |         |   q6AFE |  
  +---------+          +---------+         +---------+  
      ^                     ^                   ^          ^
      |                     |                   | CPU Side |
------+---------------------+-------------------+--------
      |                     |                   |
      |                     |APR(smd/glink)     | 
      |                     |                   |
      |  +------------------+----------------+  |
      |  |                  |                |  |
+-----+--+-----------------------------------+--+-------
      |  |                  |                |  | QDSP Side |
      v  v                  v                v  v           v
 +---------+          +---------+         +---------+
 |   ASM   | <------> |   ADM   | <-----> |   AFE   |
 +---------+          +---------+         +---------+
                                               ^
                                               | 
                           +-------------------+
                           |
---------------------------+--------------------------
                           |            Audio I/O |
                           v                      v
    +--------------------------------------------------+
    |                Audio devices                     |
    | CODEC | HDMI-TX | PCM  | SLIMBUS | I2S |MI2S |...|
    |                                                  |
    +--------------------------------------------------+


Changes since v4 (https://lkml.org/lkml/2018/3/9/1207)
 - Updated dt bindings as suggested by Rob H.
 - removed dt patch as db820c requires some more display
	 dt patches to get hdmi audio.
 - remove static flags in q6core as suggested by Rohit.
 - add Rohits tested and reviewed tag
 - fixed few static checker warnings.
 - use NULL topology flag as suggested by Rohit.

Thanks,
srini

Srinivas Kandagatla (23):
  soc: qcom dt-bindings: Add APR bus bindings
  soc: qcom: Add APR bus driver
  ASoC: qdsp6: q6common: Add qdsp6 helper functions
  ASoC: qdsp6: dt-bindings: Add q6afe dt bindings
  ASoC: qdsp6: dt-bindings: Add q6adm dt bindings
  ASoC: qdsp6: dt-bindings: Add q6asm dt bindings
  ASoC: qdsp6: q6afe: Add q6afe driver
  ASoC: qdsp6: qdafe: Add SLIMBus port Support
  ASoC: qdsp6: q6afe: Add support to MI2S ports
  ASoC: qdsp6: q6afe: Add support to MI2S sysclks
  ASoC: qdsp6: q6adm: Add q6adm driver
  ASoC: qdsp6: q6asm: Add q6asm driver
  ASoC: qdsp6: q6asm: Add support to memory map and unmap
  ASoC: qdsp6: q6asm: Add support to audio stream apis
  ASoC: qdsp6: q6core: Add q6core driver
  ASoC: qdsp6: q6routing: Add q6routing driver
  ASoC: qdsp6: q6routing: Add support to all SLIMBus Mixers
  ASoC: qdsp6: q6routing: Add support to MI2S Mixers
  ASoC: qdsp6: q6afe: Add q6afe dai driver
  ASoC: qdsp6: q6asm: Add q6asm dai driver
  ASoC: qdsp6: dt-bindings: Add apq8096 machine bindings
  ASoC: qcom: apq8096: Add db820c machine driver
  MAINTAINERS: Add myself as co-maintainer of qcom audio

 .../devicetree/bindings/soc/qcom/qcom,apr.txt      |   85 ++
 .../devicetree/bindings/sound/qcom,apq8096.txt     |   76 ++
 .../devicetree/bindings/sound/qcom,q6adm.txt       |   33 +
 .../devicetree/bindings/sound/qcom,q6afe.txt       |   88 ++
 .../devicetree/bindings/sound/qcom,q6asm.txt       |   33 +
 MAINTAINERS                                        |    1 +
 drivers/soc/qcom/Kconfig                           |    9 +
 drivers/soc/qcom/Makefile                          |    1 +
 drivers/soc/qcom/apr.c                             |  385 ++++++
 include/dt-bindings/soc/qcom,apr.h                 |   27 +
 include/dt-bindings/sound/qcom,q6afe.h             |   31 +
 include/dt-bindings/sound/qcom,q6asm.h             |   22 +
 include/linux/mod_devicetable.h                    |   11 +
 include/linux/soc/qcom/apr.h                       |  132 ++
 sound/soc/qcom/Kconfig                             |   50 +
 sound/soc/qcom/Makefile                            |    5 +
 sound/soc/qcom/apq8096.c                           |  238 ++++
 sound/soc/qcom/qdsp6/Makefile                      |    8 +
 sound/soc/qcom/qdsp6/q6adm.c                       |  633 ++++++++++
 sound/soc/qcom/qdsp6/q6adm.h                       |   25 +
 sound/soc/qcom/qdsp6/q6afe-dai.c                   |  752 +++++++++++
 sound/soc/qcom/qdsp6/q6afe.c                       | 1068 ++++++++++++++++
 sound/soc/qcom/qdsp6/q6afe.h                       |  193 +++
 sound/soc/qcom/qdsp6/q6asm-dai.c                   |  632 ++++++++++
 sound/soc/qcom/qdsp6/q6asm.c                       | 1310 ++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6asm.h                       |   69 ++
 sound/soc/qcom/qdsp6/q6core.c                      |  380 ++++++
 sound/soc/qcom/qdsp6/q6core.h                      |   15 +
 sound/soc/qcom/qdsp6/q6dsp-common.c                |   66 +
 sound/soc/qcom/qdsp6/q6dsp-common.h                |   24 +
 sound/soc/qcom/qdsp6/q6dsp-errno.h                 |   51 +
 sound/soc/qcom/qdsp6/q6routing.c                   |  982 +++++++++++++++
 sound/soc/qcom/qdsp6/q6routing.h                   |    9 +
 33 files changed, 7444 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,apq8096.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6adm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt
 create mode 100644 drivers/soc/qcom/apr.c
 create mode 100644 include/dt-bindings/soc/qcom,apr.h
 create mode 100644 include/dt-bindings/sound/qcom,q6afe.h
 create mode 100644 include/dt-bindings/sound/qcom,q6asm.h
 create mode 100644 include/linux/soc/qcom/apr.h
 create mode 100644 sound/soc/qcom/apq8096.c
 create mode 100644 sound/soc/qcom/qdsp6/Makefile
 create mode 100644 sound/soc/qcom/qdsp6/q6adm.c
 create mode 100644 sound/soc/qcom/qdsp6/q6adm.h
 create mode 100644 sound/soc/qcom/qdsp6/q6afe-dai.c
 create mode 100644 sound/soc/qcom/qdsp6/q6afe.c
 create mode 100644 sound/soc/qcom/qdsp6/q6afe.h
 create mode 100644 sound/soc/qcom/qdsp6/q6asm-dai.c
 create mode 100644 sound/soc/qcom/qdsp6/q6asm.c
 create mode 100644 sound/soc/qcom/qdsp6/q6asm.h
 create mode 100644 sound/soc/qcom/qdsp6/q6core.c
 create mode 100644 sound/soc/qcom/qdsp6/q6core.h
 create mode 100644 sound/soc/qcom/qdsp6/q6dsp-common.c
 create mode 100644 sound/soc/qcom/qdsp6/q6dsp-common.h
 create mode 100644 sound/soc/qcom/qdsp6/q6dsp-errno.h
 create mode 100644 sound/soc/qcom/qdsp6/q6routing.c
 create mode 100644 sound/soc/qcom/qdsp6/q6routing.h

-- 
2.16.2
