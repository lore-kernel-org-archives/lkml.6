Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2255AtQhPY8gz49XzpuumeUGPeAVSbXeEDvGSPjM9l48SRfOmtha5rbrMNxov5UANKZEWJaa
ARC-Seal: i=1; a=rsa-sha256; t=1517590929; cv=none;
        d=google.com; s=arc-20160816;
        b=Dz+Tc7PdMFuH4e7zxPKQ3fRrBBIOoneL+2cn8kQ1HqXLKwnvFk8fF1JlhPqmhFlSZt
         WQFpEU71kVSG1GB/i7IdMSKC6iKLBbcP1I6CyqLuQkdWmkinmMOdixFqF4SeHg7XSLhI
         /eLyU/5ynQVJsXl35Usafmsm1ZUzRbL5nggGYyXcHL/MHkOQXpYHN+DFhVsAx69iwM+a
         tg/ciMgTw6gkBJyam3T9PEDXQa//KbB5fA9g+2yjdjH7WjQxEIv/mhDwsXz0tnjTMMDO
         ZS6CFupQd1whBlh8EZJPJh7yNis6Q0M8z6eVhAeaZxvKUvvBTyl6oXPZA5hLE7XhaIoG
         x50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GBDVX8OD8v38uOx4q5Plu7TTJSCgtnCJLLsOKcy7gSM=;
        b=f8NU0vuMOiv5yHuhEIQtq5BqH3GpuJ+Tp3uyttFii0YeLoLfe+jYAgVYfN3t8C5G00
         Dv1GPz+FTtPiBCFW1NqF4+obPVHZ/5XMtXT+sAbZTj4V8Gm1fUM1o5uJvY/B27t8lRFi
         6TECHpIXIdhCmCpuPsVF683tz967SEvMSDpnAPF6OIvOI3wGZjY0qSnEJyMT59quAUoI
         Njouf2StNWSLqA4xTWcFFHw/muABzbxY977dyEDgu2ZDQQUuCkIOxkN70sLjmWU/6woq
         P5Cw/RHUEKMRQuOMmU4J4Nyjian0iEEXFzGo2HvETMq9A79cELLjV85dnsVeKucqQB/i
         FlfQ==
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
Subject: [PATCH 4.4 28/67] cpufreq: Add Loongson machine dependencies
Date: Fri,  2 Feb 2018 17:57:57 +0100
Message-Id: <20180202140818.713827052@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309426016769835?=
X-GMAIL-MSGID: =?utf-8?q?1591309426016769835?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -236,6 +236,7 @@ endif
 if MIPS
 config LOONGSON2_CPUFREQ
 	tristate "Loongson2 CPUFreq Driver"
+	depends on LEMOTE_MACH2F
 	help
 	  This option adds a CPUFreq driver for loongson processors which
 	  support software configurable cpu frequency.
@@ -248,6 +249,7 @@ config LOONGSON2_CPUFREQ
 
 config LOONGSON1_CPUFREQ
 	tristate "Loongson1 CPUFreq Driver"
+	depends on LOONGSON1_LS1B
 	help
 	  This option adds a CPUFreq driver for loongson1 processors which
 	  support software configurable cpu frequency.
