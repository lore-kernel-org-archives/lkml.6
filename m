Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227uRtHj8E0+7VjxR8Sm3ovH/9p0DWHNN4JVobqMd8jIAzbubnHFJRKRHHxgO7qGtRtnWHEq
ARC-Seal: i=1; a=rsa-sha256; t=1517591026; cv=none;
        d=google.com; s=arc-20160816;
        b=Lm4Cex+qgVLHLjpmUQ5qIEhcsSygPFTLtw95KkLi5IXy+QI0ytsQxQrfzRdet3VlpD
         LBWhT2G0VoY+fIOPnUrG5/5LXjOEbnEP1S944MNs5k/+u3Cp4meC2Y6UeXzaj6XgeM5J
         72cIH1YgoeqDPHu6SgAH7DYCRxATQ1W7hNMpV/6Ma3saAZoModd3RR00KPqgA4EFZmuu
         0C3rmpotIINRElsASlHnhIsB3ct17VVGKGP+8/N0dvHE/lhOPYK1/dHVmQsiAHTET0Ms
         nbp5jBA7L+Ze/S8b7Pmxz9Jw9mC/tW2idA9hjLGuA5q2EEggOUYJLOkI0EYuFzaS7210
         9Tfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vzVhdlOTeT6twczBJcmuS8DGaUUfsJ2ZJfHpz7YXqYk=;
        b=psGVjjHwaDwqvw2YRw9U1pzXSlgZABHVb4Wdk5WdI24SAVVsD1ip5VBK5xeusaYZ8X
         3hdWF/MIOzwDFDAJCry1PDXSayWfHvuq8oEnWGt/SptsjriIx17eiNSFTb58AgyIdmf6
         1eobA82/Z7z5lTOz0wcAWLcYBASiIi4BhhKUtn9YOVPXB89+awmftRpKzILHZ7mIugdY
         P0ihgwFQIPfbUoTQe+JAqEajZ8P/NbmtWpi2BYm0O3tdVvuN+K7WEumREviDz0MDiJdk
         5AH6UapGUS1zspJJ9/K9x25FQP8dvexnhn2appMOyUrIwwa7RJ/TNQgbAJ+n5OukcbYo
         PsQg==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 27/86] cpufreq: Add Loongson machine dependencies
Date: Fri,  2 Feb 2018 17:57:47 +0100
Message-Id: <20180202140825.105701479@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309426016769835?=
X-GMAIL-MSGID: =?utf-8?q?1591309528464476797?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -273,6 +273,7 @@ endif
 if MIPS
 config LOONGSON2_CPUFREQ
 	tristate "Loongson2 CPUFreq Driver"
+	depends on LEMOTE_MACH2F
 	help
 	  This option adds a CPUFreq driver for loongson processors which
 	  support software configurable cpu frequency.
@@ -285,6 +286,7 @@ config LOONGSON2_CPUFREQ
 
 config LOONGSON1_CPUFREQ
 	tristate "Loongson1 CPUFreq Driver"
+	depends on LOONGSON1_LS1B
 	help
 	  This option adds a CPUFreq driver for loongson1 processors which
 	  support software configurable cpu frequency.
