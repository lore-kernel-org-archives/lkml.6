Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvM9e6Qj3Gx6vsM0ScIKYQlUJTvLV7It1epEZk1q8djP3wkx3k7wQOR//qqEUhXkxJ6q9br
ARC-Seal: i=1; a=rsa-sha256; t=1521483849; cv=none;
        d=google.com; s=arc-20160816;
        b=hbo+4MORrNlFcv2ytQXfw6u2SfZizAEuD5s7uxj2Kdvglpt/OO8TeaJaewADynENqv
         ZRKepwjlI1ajzDUJPat3YN/VmTgFv/Z3byumUKXyEux/xiypcG2ED2EUzp2SUtdYEVjc
         NazuhgLn7QIC2WeyO6VTS2C4iS87+jH60uTY7kEB0PARV+nzfCuF8J/O++e9udBE1j3r
         hN+OGFBg7BDZ7H11JYhixwCOZmPR0fyCKwqshiSvAo297aZnOrq/pByvqDnzCYslPbLC
         JOUus52QuZbxwV/YXhrBSRyV+SOBAiet1/sfOpnQXd8nLjZ01dW48+oGoZ0idusiCcm3
         Yxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3m7jHsj3KfzoX/PNg/GNv3U0g+SnETgzcY7oFeP+r8c=;
        b=DiMMvmUtxYOe9OFQe9qmvPstYAjRftJPinTveWjm1Of1bLbfSuvpwqd33gwzKviaZE
         e2tMpNIPyYBb/0evHk+okhz9+FPljUNBIuBOn5FdVhW5qQ6XDM7Ng4Ig1SbiObC0LX1B
         u8CzkDS6ho/N5uIZ9u030TJKdsctsrOXgZG9MP/3cgYPCJ2vFOpnqJkcLyZN/vBpZqy0
         H2DK4gbQPslsnMZXR9kDkSn+njrtz267MVzCypPegQtDdMv3Yafk0bI51piAknlodrid
         lTgws1wTluZE/3sIEwVVLP6+N15IvNPOmtwsDjfK6Jq9gcQ1fZpTT1AR2sDV6yW7Lf6b
         mxrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 103/241] soc/tegra: Fix link errors with PMC disabled
Date: Mon, 19 Mar 2018 19:06:08 +0100
Message-Id: <20180319180755.465427055@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391448796464438?=
X-GMAIL-MSGID: =?utf-8?q?1595391448796464438?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>


[ Upstream commit bd737038d555468198495230f4233b9ba92e774c ]

With the new Tegra186 PMC driver merged, anything that relies on the previous
PMC driver fails to link when that is disabled:

arch/arm/mach-tegra/pm.o: In function `tegra_pm_set':
pm.c:(.text.tegra_pm_set+0x3c): undefined reference to `tegra_pmc_enter_suspend_mode'
arch/arm/mach-tegra/pm.o: In function `tegra_suspend_enter':
pm.c:(.text.tegra_suspend_enter+0x4): undefined reference to `tegra_pmc_get_suspend_mode'
arch/arm/mach-tegra/pm.o: In function `tegra_init_suspend':
pm.c:(.init.text+0x1c): undefined reference to `tegra_pmc_get_suspend_mode'
pm.c:(.init.text+0x74): undefined reference to `tegra_pmc_set_suspend_mode'

ERROR: tegra_powergate_sequence_power_up [drivers/ata/ahci_tegra.ko] undefined!
ERROR: tegra_powergate_power_off [drivers/ata/ahci_tegra.ko] undefined!

Making the definition depend on the presence of the driver makes it build
again, though that might not be the correct fix.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Fixes: 854014236290 ("soc/tegra: Implement Tegra186 PMC support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/soc/tegra/pmc.h |   29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -26,12 +26,6 @@
 struct clk;
 struct reset_control;
 
-#ifdef CONFIG_PM_SLEEP
-enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void);
-void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode);
-void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode);
-#endif /* CONFIG_PM_SLEEP */
-
 #ifdef CONFIG_SMP
 bool tegra_pmc_cpu_is_powered(unsigned int cpuid);
 int tegra_pmc_cpu_power_on(unsigned int cpuid);
@@ -108,7 +102,7 @@ int tegra_pmc_cpu_remove_clamping(unsign
 #define TEGRA_IO_RAIL_LVDS	57
 #define TEGRA_IO_RAIL_SYS_DDC	58
 
-#ifdef CONFIG_ARCH_TEGRA
+#ifdef CONFIG_SOC_TEGRA_PMC
 int tegra_powergate_is_powered(unsigned int id);
 int tegra_powergate_power_on(unsigned int id);
 int tegra_powergate_power_off(unsigned int id);
@@ -120,6 +114,11 @@ int tegra_powergate_sequence_power_up(un
 
 int tegra_io_rail_power_on(unsigned int id);
 int tegra_io_rail_power_off(unsigned int id);
+
+enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void);
+void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode);
+void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode);
+
 #else
 static inline int tegra_powergate_is_powered(unsigned int id)
 {
@@ -157,6 +156,20 @@ static inline int tegra_io_rail_power_of
 {
 	return -ENOSYS;
 }
-#endif /* CONFIG_ARCH_TEGRA */
+
+static inline enum tegra_suspend_mode tegra_pmc_get_suspend_mode(void)
+{
+	return TEGRA_SUSPEND_NONE;
+}
+
+static inline void tegra_pmc_set_suspend_mode(enum tegra_suspend_mode mode)
+{
+}
+
+static inline void tegra_pmc_enter_suspend_mode(enum tegra_suspend_mode mode)
+{
+}
+
+#endif /* CONFIG_SOC_TEGRA_PMC */
 
 #endif /* __SOC_TEGRA_PMC_H__ */
