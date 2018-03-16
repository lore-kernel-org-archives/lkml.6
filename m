Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELupOE/c7Ep6ycqHCybLt42esOg9jufYrE6ao9Tlk0YeeJO59seoo1MEReyptaRrfLJT8znR
ARC-Seal: i=1; a=rsa-sha256; t=1521214945; cv=none;
        d=google.com; s=arc-20160816;
        b=kDeAJ1d80KgY9DuDtZwlTu7vy2HC6r6+WE8OiLxwDQLYpMrQeRWJvmwnQL4Q7EQc7z
         buiGUj6Hj20eEPgN/RjXGz1p/8hBuDoCu3S61Ddqnc2C81f+zwQ5TlEYCVuNfwFKT4bq
         76YE6dAdgGivO1KGro6QuIrSFeU/IPzs7IZuX+BqWyJxwegPLo1i17H9lGntxHZQD7W/
         0la5pINstqhKFdRO1P4GJpAI+rRSLy2BvjUh4ExFupoMAUUaqBdmeyPe6rXojWgSJM9X
         SdTcs2jPEpyID+joKu2rFc7sUmsL9FDG6Kb6vNRgP4olco1sOsZMGDpFOf1I21papTm3
         2tPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gU8XLm1vhQP/Znc12zBbqZV0zSbg60ZLxTZUrbOO964=;
        b=wiqzBWQcQCVkOrgftCC55WHLzcXa65hBmmO0XHQHvdhZaZWCskrHd9KU/fz4Wn4QXb
         Zn+AeFZXtqqORnOoPW02w6VTqQjRG6WlqwpbrMU9NUMzkGeyKdHtbff7n/HaXC2LY1br
         dQ3UTxDMrkafQ1gff+ZPTkiCj5jqluRjc30OwJ1p9vUn9dNWVWEoCkex1HY3RhcS1nU5
         Trec+FbntCLmM4U8YSiMYfhNqOg0d7V8OVpHbNS4RuiXpjYSQYBTjbG7S4HsBnrt7c+7
         UmHfcuJbOhCBQD1JdxWn4hGkV3CHxySehsJ7ZYPSpC87dXA4YZFAFNzU08jSeA0xo2ek
         qBPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 072/128] drm/etnaviv: make THERMAL selectable
Date: Fri, 16 Mar 2018 16:23:33 +0100
Message-Id: <20180316152340.296279092@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109111628663271?=
X-GMAIL-MSGID: =?utf-8?q?1595109483438463514?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philipp Zabel <p.zabel@pengutronix.de>


[ Upstream commit 49b82c389d2a40eaef1355aaa35868b367aec9d1 ]

The etnaviv driver causes a link failure if it is built-in but THERMAL
is built as a module:

  drivers/gpu/drm/etnaviv/etnaviv_gpu.o: In function `etnaviv_gpu_bind':
  etnaviv_gpu.c:(.text+0x4c4): undefined reference to `thermal_of_cooling_device_register'
  etnaviv_gpu.c:(.text+0x600): undefined reference to `thermal_cooling_device_unregister'
  drivers/gpu/drm/etnaviv/etnaviv_gpu.o: In function `etnaviv_gpu_unbind':
  etnaviv_gpu.c:(.text+0x2aac): undefined reference to `thermal_cooling_device_unregister'

Adding a Kconfig dependency on THERMAL || !THERMAL to avoid this causes
a dependency loop on x86_64:

  drivers/gpu/drm/tve200/Kconfig:1:error: recursive dependency detected!
  For a resolution refer to Documentation/kbuild/kconfig-language.txt
  subsection "Kconfig recursive dependency limitations"
  drivers/gpu/drm/tve200/Kconfig:1:       symbol DRM_TVE200 depends on CMA
  For a resolution refer to Documentation/kbuild/kconfig-language.txt
  subsection "Kconfig recursive dependency limitations"
  mm/Kconfig:489: symbol CMA is selected by DRM_ETNAVIV
  For a resolution refer to Documentation/kbuild/kconfig-language.txt
  subsection "Kconfig recursive dependency limitations"
  drivers/gpu/drm/etnaviv/Kconfig:2:      symbol DRM_ETNAVIV depends on THERMAL
  For a resolution refer to Documentation/kbuild/kconfig-language.txt
  subsection "Kconfig recursive dependency limitations"
  drivers/thermal/Kconfig:5:      symbol THERMAL is selected by ACPI_VIDEO
  For a resolution refer to Documentation/kbuild/kconfig-language.txt
  subsection "Kconfig recursive dependency limitations"
  drivers/acpi/Kconfig:189:       symbol ACPI_VIDEO is selected by BACKLIGHT_CLASS_DEVICE
  For a resolution refer to Documentation/kbuild/kconfig-language.txt
  subsection "Kconfig recursive dependency limitations"
  drivers/video/backlight/Kconfig:158:    symbol BACKLIGHT_CLASS_DEVICE is selected by DRM_PARADE_PS8622
  For a resolution refer to Documentation/kbuild/kconfig-language.txt
  subsection "Kconfig recursive dependency limitations"
  drivers/gpu/drm/bridge/Kconfig:62:      symbol DRM_PARADE_PS8622 depends on DRM_BRIDGE
  For a resolution refer to Documentation/kbuild/kconfig-language.txt
  subsection "Kconfig recursive dependency limitations"
  drivers/gpu/drm/bridge/Kconfig:1:       symbol DRM_BRIDGE is selected by DRM_TVE200

To work around this, add a new option DRM_ETNAVIV_THERMAL to optionally
enable thermal throttling support and make DRM_ETNAVIV select THERMAL
at the same time.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/etnaviv/Kconfig       |    9 +++++++++
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c |    8 +++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/etnaviv/Kconfig
+++ b/drivers/gpu/drm/etnaviv/Kconfig
@@ -6,6 +6,7 @@ config DRM_ETNAVIV
 	depends on MMU
 	select SHMEM
 	select SYNC_FILE
+	select THERMAL if DRM_ETNAVIV_THERMAL
 	select TMPFS
 	select WANT_DEV_COREDUMP
 	select CMA if HAVE_DMA_CONTIGUOUS
@@ -13,6 +14,14 @@ config DRM_ETNAVIV
 	help
 	  DRM driver for Vivante GPUs.
 
+config DRM_ETNAVIV_THERMAL
+	bool "enable ETNAVIV thermal throttling"
+	depends on DRM_ETNAVIV
+	default y
+	help
+	  Compile in support for thermal throttling.
+	  Say Y unless you want to risk burning your SoC.
+
 config DRM_ETNAVIV_REGISTER_LOGGING
 	bool "enable ETNAVIV register logging"
 	depends on DRM_ETNAVIV
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1738,7 +1738,7 @@ static int etnaviv_gpu_bind(struct devic
 	struct etnaviv_gpu *gpu = dev_get_drvdata(dev);
 	int ret;
 
-	if (IS_ENABLED(CONFIG_THERMAL)) {
+	if (IS_ENABLED(CONFIG_DRM_ETNAVIV_THERMAL)) {
 		gpu->cooling = thermal_of_cooling_device_register(dev->of_node,
 				(char *)dev_name(dev), gpu, &cooling_ops);
 		if (IS_ERR(gpu->cooling))
@@ -1751,7 +1751,8 @@ static int etnaviv_gpu_bind(struct devic
 	ret = etnaviv_gpu_clk_enable(gpu);
 #endif
 	if (ret < 0) {
-		thermal_cooling_device_unregister(gpu->cooling);
+		if (IS_ENABLED(CONFIG_DRM_ETNAVIV_THERMAL))
+			thermal_cooling_device_unregister(gpu->cooling);
 		return ret;
 	}
 
@@ -1808,7 +1809,8 @@ static void etnaviv_gpu_unbind(struct de
 
 	gpu->drm = NULL;
 
-	thermal_cooling_device_unregister(gpu->cooling);
+	if (IS_ENABLED(CONFIG_DRM_ETNAVIV_THERMAL))
+		thermal_cooling_device_unregister(gpu->cooling);
 	gpu->cooling = NULL;
 }
 
