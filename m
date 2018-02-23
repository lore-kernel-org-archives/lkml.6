Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225wFmT+YS4pdwg1H3FWqgMuq9GEDsVb/JVycSAbuoGGpC+d3CgYy/9AaBE+nBeoqRUUMtWq
ARC-Seal: i=1; a=rsa-sha256; t=1519411015; cv=none;
        d=google.com; s=arc-20160816;
        b=FXYBB6NFQKh6NXYNs2zWi4Yu3SOrwscgP7E63sjndTaFh+aqb3Y6BvOzK7KbjeMCn4
         IkU//vMWPq/RYAN1aqxJPNyARWA7Odti+dlWQefB1DfdyYg8O2p9IDvtUPVHwZ9JgxX2
         ab0Mwc6cqTLrw71s4GX10/LRsaDsanNKVjN8bV7sbXSiPSrEiQrBJNZy0HevB+c7ixMr
         Ox57t2PyW7rOOy92Qw+SXkslFOL60gJG7A1DNDpiHVXfoGs9JHByS9yJwWsKNtNzQBnq
         y8zgtIo2abjkVljvIYo/qXOMDV+gm1fLM9WtNVx//xqei7esjH5aVSrH8o6pstRGBQNj
         MsSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aB+CBlQ7B7TTGF11/6jWFv/QOne/wVBGVS0uBEz7IYk=;
        b=nZHw7ySN5/PqQx0JlSvDJKZQTceB2/V5UHeKKEf2WH28v4oLtLTx7oYEa5JME8xjbz
         0fXigYDyM+74BIsACNexY59Lp52vlbeOc9vcRYqRMl3cQ3A899ZtFctK7cTrL8HYyHIc
         1NuQA/HU5HI03eqMyGqysPDpuzGS4H0Dzbnzkh2AS1cSrcu9x8CsGf0XzliRWTI/ezQn
         M8/QBks04RbGErKWccWKt3cZtWsHAA33hx80Di1xQvi3SPZw7ANvYPc+Kfg8++7FwMo4
         KjA8XSVl65I2Vwuycq9cWk3lb8fiK61ZcpWZIi1bc0Uk3mvveMD6KBhxOl+OM7/UXNi2
         teQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 4.4 074/193] thermal: fix INTEL_SOC_DTS_IOSF_CORE dependencies
Date: Fri, 23 Feb 2018 19:25:07 +0100
Message-Id: <20180223170337.622999123@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217924198706610?=
X-GMAIL-MSGID: =?utf-8?q?1593217924198706610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 68fd77cf8a4b045594231f07e5fc92e1a34c0a9e upstream.

We get a Kconfig warning when selecting this without also enabling
CONFIG_PCI:

warning: (X86_INTEL_LPSS && INTEL_SOC_DTS_IOSF_CORE
&& SND_SST_IPC_ACPI && MMC_SDHCI_ACPI && PUNIT_ATOM_DEBUG)
selects IOSF_MBI which has unmet direct dependencies (PCI)

This adds a new depedency.

Fixes: 3a2419f865a6 ("Thermal: Intel SoC: DTS thermal use common APIs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thermal/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -299,7 +299,7 @@ config X86_PKG_TEMP_THERMAL
 
 config INTEL_SOC_DTS_IOSF_CORE
 	tristate
-	depends on X86
+	depends on X86 && PCI
 	select IOSF_MBI
 	help
 	  This is becoming a common feature for Intel SoCs to expose the additional
@@ -309,7 +309,7 @@ config INTEL_SOC_DTS_IOSF_CORE
 
 config INTEL_SOC_DTS_THERMAL
 	tristate "Intel SoCs DTS thermal driver"
-	depends on X86
+	depends on X86 && PCI
 	select INTEL_SOC_DTS_IOSF_CORE
 	select THERMAL_WRITABLE_TRIPS
 	help
