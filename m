Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv0hEEv9dzAmchP79zMn5LvpFDAn7PoZwcirK8Hpa9mAi39KsSTLHWoxChfhtQzF0nXwLHx
ARC-Seal: i=1; a=rsa-sha256; t=1519411311; cv=none;
        d=google.com; s=arc-20160816;
        b=E1KwYyJYmaf0ho58E1lQe+Df08qdLequg21PxbHT6SKglFUNmpV9kmRMLr4wJjXD1b
         ubmaypQOLqMgU7dBD0B0C8n1Mipi8V/BcX8T4f1jEopt00bgXG9C2C8E3esq4rsyGx2c
         K4GJr4QAwGpFHmFmxnDaJ6Q8bmvcgWcTGYlsv2NyYWnY4+7gi8KME6A3IxXGRgnZ9Hgo
         5/iG+PN3bgmlkvtBGhGVfpr4DK53megOSDScKirrCOYreOuF2mnABttwIzXhHRGU7VPH
         YSjpHb9UZEWRJHnu1lhcHa+wyhc3K1oSu88ISyVNrc7G5RpR6TRxTMbj/6G+zDrgRcpd
         YVpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZGu9zD2o+42UjfRjjjbpSxOggDXRSQaKLLy1aqJiIBA=;
        b=usjY3lBOhG2HdiXcQbtmu9A5psc0XcJFphkQPZQ4yfxERWifAVdbEPr7IbcRLWRHdb
         bWdzThmA+/DC6ifUBW+Aha62WnC9h4ZEpa9QLw9k6Dmw792SjAHO4asK2bsFvugEwS/g
         /caCUDSwZ+llVw5VinAYUa6ZYRDXBGMWL9kTFN44ChSjf82xjDb8sG/z6cyLbKAe21mg
         EbDz8yZNH/Ual933QPbRMny/SlXGmG0UQMIEkrGLg6LTCFvBR2FTDfwBMerH8mh3T396
         +0pFgJFygtIB0qvAbXeieXl71EF1oa0zF3TclekIaO8vBl8axrxg4aEPJYIia/j6YI0/
         PWXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 157/193] ASoC: Intel: Kconfig: fix build when ACPI is not enabled
Date: Fri, 23 Feb 2018 19:26:30 +0100
Message-Id: <20180223170350.512304837@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218235665026382?=
X-GMAIL-MSGID: =?utf-8?q?1593218235665026382?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinod Koul <vinod.koul@intel.com>

commit 3493d4a86457c7de9f1e602b4267c9b0f9ec1c9f upstream.

Randy reported following error when ACPI is not enabled:

warning: (SND_SOC_INTEL_BYTCR_RT5640_MACH && SND_SOC_INTEL_BYTCR_RT5651_MACH
&& SND_SOC_INTEL_CHT_BSW_RT5672_MACH && SND_SOC_INTEL_CHT_BSW_RT5645_MACH &&
SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH) selects SND_SST_IPC_ACPI
+which has unmet direct dependencies (SOUND && !M68K && !UML && SND &&
SND_SOC && ACPI)

causing these build errors:

In file included from ../sound/soc/intel/atom/sst/sst_acpi.c:40:0:
../include/acpi/acpi_bus.h:65:20: error: conflicting types for
'acpi_evaluate_dsm'
 union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const u8 *uuid,
In file included from ../sound/soc/intel/atom/sst/sst_acpi.c:31:0:
../include/linux/acpi.h:676:34: note: previous definition of
'acpi_evaluate_dsm' was here
 static inline union acpi_object *acpi_evaluate_dsm(acpi_handle handle,

CONFIG_SND_SST_IPC_ACPI was already dependent upon ACPI, but that was not
solving it. So move the depends up to machine drivers and remove from
CONFIG_SND_SST_IPC_ACPI.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
[arnd: rebased to PATCH kernel]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/Kconfig |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -24,7 +24,6 @@ config SND_SST_IPC_PCI
 config SND_SST_IPC_ACPI
 	tristate
 	select SND_SST_IPC
-	depends on ACPI
 
 config SND_SOC_INTEL_SST
 	tristate
@@ -91,7 +90,7 @@ config SND_SOC_INTEL_BROADWELL_MACH
 
 config SND_SOC_INTEL_BYTCR_RT5640_MACH
 	tristate "ASoC Audio DSP Support for MID BYT Platform"
-	depends on X86 && I2C
+	depends on X86 && I2C && ACPI
 	select SND_SOC_RT5640
 	select SND_SST_MFLD_PLATFORM
 	select SND_SST_IPC_ACPI
@@ -103,7 +102,7 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
 
 config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
         tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5672 codec"
-        depends on X86_INTEL_LPSS && I2C
+        depends on X86_INTEL_LPSS && I2C && ACPI
         select SND_SOC_RT5670
         select SND_SST_MFLD_PLATFORM
         select SND_SST_IPC_ACPI
@@ -115,7 +114,7 @@ config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
 
 config SND_SOC_INTEL_CHT_BSW_RT5645_MACH
 	tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5645/5650 codec"
-	depends on X86_INTEL_LPSS && I2C
+	depends on X86_INTEL_LPSS && I2C && ACPI
 	select SND_SOC_RT5645
 	select SND_SST_MFLD_PLATFORM
 	select SND_SST_IPC_ACPI
