Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965432AbeBMRKV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:10:21 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50473 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965207AbeBMRBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:01:16 -0500
X-Google-Smtp-Source: AH8x225uJl3/x+lwDmcpqubkSLpxvB/wgelkyIwriA6SV+0eeL+8yYeuwnrOvZq4aM+R/koifFZuBw==
From: srinivas.kandagatla@linaro.org
To: andy.gross@linaro.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
Cc: david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
        spatakok@qti.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 00/25] ASoC: qcom: Add support to QDSP based Audio
Date: Tue, 13 Feb 2018 16:58:12 +0000
Message-Id: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

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

This patchset is tested on DB820c, with HDMI audio playback, MI2S on DB410c
on top of mainline, Also tested SLIMBus analog audio using wcd9355
with an additional patches.

Here is my test branch incase somone want to try these patches
https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=v4.16-rc1-dsp-audio-v3

Here is block diagram to give a quick overview of the components


  +---------+          +---------+         +---------+   
  |  q6asm  |          |q6routing|         | q6afe   | 
  |  fedai  | <------> |  mixers | <-----> | bedai   |  
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

Changes since v2 (https://lwn.net/Articles/741472/)
- fixed locking issues with ASM and APR.
- Added support to MI2S and SLIMBus ports
- moved dma device to apr.
- added dt bindings for ASM, ADM, AFE.
- Fixed dt bindings for msm8996 sound card.
- added compatible strings to ASM, ADM, AFE modules.
- Cleaned up common code as suggested in review.
- converted sound card driver to proper apr client driver.
- Fixed various issues spotted by Banajit and Kasam.
- Tested on DB410c, DB820c for both analog and digital playbacks.
- Exported q6core functions as suggested by Rohit.
- Fixed various issues with dsp carsh/recover usecase.
- Added multiple ASM streams as requested in review.

Srinivas Kandagatla (25):
  dt-bindings: soc: qcom: Add bindings for APR bus
  soc: qcom: add support to APR bus driver
  ASoC: qcom: qdsp6: Add common qdsp6 helper functions
  dt-bindings: sound: qcom: Add bindings for q6afe
  ASoC: qcom: qdsp6: Add support to Q6AFE
  dt-bindings: sound: qcom: Add bindings for q6adm
  ASoC: qcom: qdsp6: Add support to Q6ADM
  dt-bindings: sound: qcom: Add bindings for q6asm
  ASoC: qcom: qdsp6: Add support to Q6ASM
  ASoC: qcom: q6asm: Add support to memory map and unmap
  ASoC: qcom: q6asm: add support to audio stream apis
  ASoC: qcom: qdsp6: Add support to Q6CORE
  ASoC: qcom: qdsp6: Add support to q6routing driver
  ASoC: qcom: qdsp6: Add support to q6afe dai driver
  ASoC: qcom: qdsp6: Add support to q6asm dai driver
  ASoC: qcom: q6afe: add SLIMBus port Support
  ASoC: qcom: q6afe-dai: add support to slim afe dais
  ASoC: qcom: q6routing: add support to all SLIMBus Mixers
  ASoC: qcom: q6afe: add support to MI2S ports
  ASoC: qcom: q6afe: add support to MI2S sysclks
  ASoC: qcom: q6afe-dai: add support to 4 MI2S ports
  ASoC: qcom: q6routing: add support to MI2S Mixers
  dt-bindings: sound: qcom: Add devicetree bindings for apq8096
  ASoC: qcom: apq8096: Add db820c machine driver
  arm64: dts: msm8996: db820c: Add sound card support

 .../devicetree/bindings/soc/qcom/qcom,apr.txt      |   83 ++
 .../devicetree/bindings/sound/qcom,apq8096.txt     |   89 ++
 .../devicetree/bindings/sound/qcom,q6adm.txt       |   31 +
 .../devicetree/bindings/sound/qcom,q6afe.txt       |   38 +
 .../devicetree/bindings/sound/qcom,q6asm.txt       |   38 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |   44 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   62 ++
 drivers/soc/qcom/Kconfig                           |    9 +
 drivers/soc/qcom/Makefile                          |    1 +
 drivers/soc/qcom/apr.c                             |  381 +++++++
 include/dt-bindings/soc/qcom,apr.h                 |   27 +
 include/dt-bindings/sound/qcom,q6afe.h             |   33 +
 include/dt-bindings/sound/qcom,q6asm.h             |   22 +
 include/linux/mod_devicetable.h                    |   11 +
 include/linux/soc/qcom/apr.h                       |  131 +++
 sound/soc/qcom/Kconfig                             |   42 +
 sound/soc/qcom/Makefile                            |    5 +
 sound/soc/qcom/apq8096.c                           |  173 ++++
 sound/soc/qcom/qdsp6/Makefile                      |    5 +
 sound/soc/qcom/qdsp6/q6adm.c                       |  634 ++++++++++++
 sound/soc/qcom/qdsp6/q6adm.h                       |   29 +
 sound/soc/qcom/qdsp6/q6afe-dai.c                   |  645 ++++++++++++
 sound/soc/qcom/qdsp6/q6afe.c                       |  875 ++++++++++++++++
 sound/soc/qcom/qdsp6/q6afe.h                       |   74 ++
 sound/soc/qcom/qdsp6/q6asm-dai.c                   |  621 ++++++++++++
 sound/soc/qcom/qdsp6/q6asm.c                       | 1063 ++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6asm.h                       |   66 ++
 sound/soc/qcom/qdsp6/q6core.c                      |  235 +++++
 sound/soc/qcom/qdsp6/q6core.h                      |    9 +
 sound/soc/qcom/qdsp6/q6dsp-common.c                |   67 ++
 sound/soc/qcom/qdsp6/q6dsp-common.h                |   24 +
 sound/soc/qcom/qdsp6/q6dsp-errno.h                 |   97 ++
 sound/soc/qcom/qdsp6/q6routing.c                   |  758 ++++++++++++++
 sound/soc/qcom/qdsp6/q6routing.h                   |    9 +
 34 files changed, 6430 insertions(+), 1 deletion(-)
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
2.15.1
