Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2269J5F+NRzr59AXl28OxqnHWcY41GdWvw0s8ThxtViPCkGC4sYKYOfVObwFq70/DpDr/8fa
ARC-Seal: i=1; a=rsa-sha256; t=1517591369; cv=none;
        d=google.com; s=arc-20160816;
        b=c2RvK74ONiwgpwUvRSxgAIXThObcRpFblbamGFxfep6T/i3PVrSQpRhQxsjgx6qpJ3
         PUEU8fUhUuodDZHx9EiX2mNCZMLy+ZxnJN4mCGTdgMUM25Qqdd0Nawock0bJdr0tUC7t
         Dz0o6FklgtrNoxHVU0Ra5qLGDO5CoPKmeUD6UdqrG/+NAUv9NoBiwOV14uBxRrtfor07
         YQeehO5lMwcBhvogGl2JzfQtxLFsqH9+Nyvh7WSB4lTTYbfbHoR1FONEUOZVpKUvkVU0
         U69roFlg/y5ahlZd9RRtHdnLKNp7rs1GaoGksh6dWROcelxfTAUhJYSQCAjQTnaXT8D7
         JXZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GiJh1CofubcDxrrXnI6lyz4fMF46E8olKIh35idsPjM=;
        b=0jO5SWFu7640vXXOmjtMajckYoa1mNniwILSkQI96cBwW7gqHz61krhlBySbpBERL0
         vCcVNz+rH2DzeCrfK8oYIRIVgpLTVc/HCYZFaeUjKfLzsf/KuYHZROs/hc5oVIDXkcf5
         xO8V9sOdeqHOcVP3xd/XIlpc+d6QX9dhZT8MyC9iSGWgx9vCWbNSc8f5bObjjzNeAKa/
         /1NVDFMBDVuSZQarQfNGwiIp2s8eau+kio14bDlbnQ+Pv87F/mjqnsPqqSCS2Kz/Jk7l
         /cLrNQwiZO2ne+qfBVI8+elJNWyAzh6Xz91mpmeyoJj4vBnaN9X8rImv/ziI96gcEOf3
         An+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Hogan <jhogan@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 055/156] cpufreq: Add Loongson machine dependencies
Date: Fri,  2 Feb 2018 17:57:16 +0100
Message-Id: <20180202140842.782504671@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309426016769835?=
X-GMAIL-MSGID: =?utf-8?q?1591309887896906844?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>


[ Upstream commit 0d307935fefa6389eb726c6362351c162c949101 ]

The MIPS loongson cpufreq drivers don't build unless configured for the
correct machine type, due to dependency on machine specific architecture
headers and symbols in machine specific platform code.

More specifically loongson1-cpufreq.c uses RST_CPU_EN and RST_CPU,
neither of which is defined in asm/mach-loongson32/regs-clk.h unless
CONFIG_LOONGSON1_LS1B=y, and loongson2_cpufreq.c references
loongson2_clockmod_table[], which is only defined in
arch/mips/loongson64/lemote-2f/clock.c, i.e. when
CONFIG_LEMOTE_MACH2F=y.

Add these dependencies to Kconfig to avoid randconfig / allyesconfig
build failures (e.g. when based on BMIPS which also has a cpufreq
driver).

Signed-off-by: James Hogan <jhogan@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -275,6 +275,7 @@ config BMIPS_CPUFREQ
 
 config LOONGSON2_CPUFREQ
 	tristate "Loongson2 CPUFreq Driver"
+	depends on LEMOTE_MACH2F
 	help
 	  This option adds a CPUFreq driver for loongson processors which
 	  support software configurable cpu frequency.
@@ -287,6 +288,7 @@ config LOONGSON2_CPUFREQ
 
 config LOONGSON1_CPUFREQ
 	tristate "Loongson1 CPUFreq Driver"
+	depends on LOONGSON1_LS1B
 	help
 	  This option adds a CPUFreq driver for loongson1 processors which
 	  support software configurable cpu frequency.
