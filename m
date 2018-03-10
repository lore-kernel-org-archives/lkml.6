Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520648862; cv=none;
        d=google.com; s=arc-20160816;
        b=Wq97VzcDU6zEsNg9klgky8Hx7g8RevQI3UB5/QRjSRX5vNp/aS3etMbJxoyG7smuhm
         ++7oSqHADkUAutY8iEoDOjxxnflhtpsnzSgYjtJ2pWlPvya7xsqHhZUYrzEicuVPJgIY
         1qFfEH4GidFQNagrPcoI/CCNQ4OLD65ELrvK/strGQe/TmdsFlARpTyhF6lJod5VuZhb
         Z5SBM5HqPTAk/7Ictcpb2iKjF/qUG8EEcGaUPyPhqDa6MBha/bkhNNtdOJdEmsYe5sOy
         LsL4AvpiyvkKQW76SgAm0ML9XKms/6e5ti0L4pA2ihpFkqO5ws2r3diCb3QrT3SILpcY
         7TxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=FmOk4ag6ygCIh3kRQvSOEpIrbzyL/lG42jdfNF0lpJk=;
        b=ULUTM9OlhR1OaS2+zvk5W+FPS/sFEgmCTAhMqWqfA1/UMv9FFO1bfuq0KIjvSfkW6t
         4dg4EV1GTnpidnU13dawJdGvQVhKxxmLUicVP/yDwy4rFEFxA9Q9lEqU2A07fwH1ORS5
         g2mFzU78u+N17OaUME9DCjqvDUyYnhtkhBKhqbGWWItDcEQ6zw9L3/tqgqVgGrKLjYW3
         CC51VaK3EySHtDKVvT5ZEoobWZW5oq0lHkr72HNpkWNln7uVgbNQGrmskyvxK1eEOwe4
         NX80fsz3eWN7dVlBk9UiIuPUMHHRDM4sR11KBZ0k02R8TXwurEk7E/iDUELyslKAv+Mb
         PEgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=T97RTaBv;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=T97RTaBv;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtC+REBEDd9mSbUQaJR7IcFmI3DtxDkbuPeFPrYDfS46BKJEh8i7QaihVkF+vPYwlzuZK3SMg==
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
	srinivas.kandagatla@linaro.org
Subject: [PATCH v4 00/24] ASoC: qcom: Add support to QDSP based Audio
Date: Sat, 10 Mar 2018 02:24:32 +0000
Message-Id: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594515902123048091?=
X-GMAIL-MSGID: =?utf-8?q?1594515902123048091?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thankyou everyone for providing feedback on v3 patchset.
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
https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=v4.16-qdsp6-v4

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


Changes since v3 (https://lkml.org/lkml/2018/2/13/719)

- Cleaned up apr and other dt bindings from comments
	 from various reviewers.
- Updated sndcard and dsp components to use component framework
- Fixed various locking issues spotted by Mark B.
- Removed Error to string lookup functions which can be done later.
- cleaned up the subject headers suggested by Mark B
- cleaned up Kconfig as suggested in review.
- Fixed SPDX licence commenting style, suggested by Mark.
- Made adsp command and response in sync
- moved sound node out of apr bus.
- Added more info into dsp versioning support
- Fixed issues with MI2S SD-line selection, spotted by Rohit.
- Added my self as co-maintainer for qcom audio stuff.
- Fixed q6routing issue spotted by flto and rohit.

Srinivas Kandagatla (24):
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
  arm64: dts: db820c: add sound card dt entry
  MAINTAINERS: Add myself as co-maintainer of qcom audio

 .../devicetree/bindings/soc/qcom/qcom,apr.txt      |   85 ++
 .../devicetree/bindings/sound/qcom,apq8096.txt     |   80 ++
 .../devicetree/bindings/sound/qcom,q6adm.txt       |   34 +
 .../devicetree/bindings/sound/qcom,q6afe.txt       |  107 ++
 .../devicetree/bindings/sound/qcom,q6asm.txt       |   34 +
 MAINTAINERS                                        |    1 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |   34 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   75 +-
 drivers/soc/qcom/Kconfig                           |    9 +
 drivers/soc/qcom/Makefile                          |    1 +
 drivers/soc/qcom/apr.c                             |  379 ++++++
 include/dt-bindings/soc/qcom,apr.h                 |   27 +
 include/dt-bindings/sound/qcom,q6afe.h             |   31 +
 include/dt-bindings/sound/qcom,q6asm.h             |   22 +
 include/linux/mod_devicetable.h                    |   11 +
 include/linux/soc/qcom/apr.h                       |  131 ++
 sound/soc/qcom/Kconfig                             |   50 +
 sound/soc/qcom/Makefile                            |    5 +
 sound/soc/qcom/apq8096.c                           |  235 ++++
 sound/soc/qcom/qdsp6/Makefile                      |    8 +
 sound/soc/qcom/qdsp6/q6adm.c                       |  664 ++++++++++
 sound/soc/qcom/qdsp6/q6adm.h                       |   25 +
 sound/soc/qcom/qdsp6/q6afe-dai.c                   |  746 +++++++++++
 sound/soc/qcom/qdsp6/q6afe.c                       | 1067 ++++++++++++++++
 sound/soc/qcom/qdsp6/q6afe.h                       |  193 +++
 sound/soc/qcom/qdsp6/q6asm-dai.c                   |  632 ++++++++++
 sound/soc/qcom/qdsp6/q6asm.c                       | 1310 ++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6asm.h                       |   69 ++
 sound/soc/qcom/qdsp6/q6core.c                      |  381 ++++++
 sound/soc/qcom/qdsp6/q6core.h                      |   15 +
 sound/soc/qcom/qdsp6/q6dsp-common.c                |   66 +
 sound/soc/qcom/qdsp6/q6dsp-common.h                |   24 +
 sound/soc/qcom/qdsp6/q6dsp-errno.h                 |   51 +
 sound/soc/qcom/qdsp6/q6routing.c                   |  982 +++++++++++++++
 sound/soc/qcom/qdsp6/q6routing.h                   |    9 +
 35 files changed, 7592 insertions(+), 1 deletion(-)
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
