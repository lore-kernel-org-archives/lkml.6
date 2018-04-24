Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1524591085; cv=none;
        d=google.com; s=arc-20160816;
        b=FvYlQ4vYdfj2KYtJ8OK/axvGwGdcXRFScbslQu80Q/MbVkgSOUi6U1YxdU5fMfzBNQ
         EKltXUHdj0/saKa0y8Q4RdROX5fLtii6mlhyUybKbjlQdx6hFDiSDSVcJe8YBuMVd+lz
         w2/A9JCjHOGNDc9BXAk2RMXKvNlyhqPUclKj6FFsMUoAqFUULTFpWL2Vr00K9ndJvZ7C
         h206X54lw9uPM/p/qbCuuttnql/Yf7eXW5824joGoce0M63jd1jbbya9QParhjEa03Ly
         lsix01FnoS/fOHTx+T+NTXz5eidredw6n600mHemEAtUNk98hA70i/Z2ubFltcYgaGKF
         v20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=DmMLfO0cO1SinSZx8ehL1IYCX0Qj7xFY2F2c0l2FVF0=;
        b=0KsTcJJC4663GKvjQoXfu+WHb2kN1HXC6rH5SeA02r8RtcwTH+2Jz3vay1G7TofcIt
         SkKCfvRoRxnsQs8MZJgF87tt2eRIidF6QyxvBegMIn3PpLfTJn3+DZ+02rVZN+2BJlgS
         G39JG9hLi/a0xXNeAhcYheEwXktTdPDP5WQCwCr2e8QTSfilDnVc2DbPeThKzY/E9wvL
         btuHwoBsx6ig/HsXf6hrKOfx1Omo0lv753qPn4j+WM8mrXEAdxD7Vh6ZS6D0tzpU4CUo
         Krc6l6LIc4JavcgJDQ8DnNcDyiNujcluCY2bEnDiWKC2x27h/etBFyvMqjpkyBwYSsq/
         8zpg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=p0QhcDyB;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=p0QhcDyB;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AIpwx482lDV95LtPLfBjNTbn9YUydxmUrbwu3RmPDPDU+YJpb5wKn0iofaoQf7cIClF2QLscdsiBsw==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>,
	David Lechner <david@lechnology.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	Frank Rowand <frowand.list@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arend van Spriel <aspriel@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Michal Suchanek <msuchanek@suse.de>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 10/11] of: platform: provide of_early_platform_probe()
Date: Tue, 24 Apr 2018 19:30:50 +0200
Message-Id: <20180424173051.15099-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598649621810653436?=
X-GMAIL-MSGID: =?utf-8?q?1598649621810653436?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Implement a function that must be called from machine code early in
the bo process in order to probe all registered early devices.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/of/platform.c       | 12 ++++++++++++
 include/linux/of_platform.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 4b55e568fe77..525a466b03d1 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -541,6 +541,18 @@ int of_early_platform_populate(struct device_node *root,
 	return rc;
 }
 EXPORT_SYMBOL_GPL(of_early_platform_populate);
+
+/**
+ * of_early_platform_probe() - Probe all registered early platform devices.
+ *
+ * Returns 0 on success, a negative error code on failure.
+ */
+int of_early_platform_probe(void)
+{
+	return early_platform_driver_register_probe_all(
+				EARLY_PLATFORM_DEFAULT_CLASS, INT_MAX, 0);
+}
+EXPORT_SYMBOL_GPL(of_early_platform_probe);
 #endif /* CONFIG_EARLY_PLATFORM_DEVICES */
 
 int of_platform_default_populate(struct device_node *root,
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 2bf1013a3e89..caa08e3bf3b7 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -81,6 +81,7 @@ extern int of_early_platform_populate(struct device_node *root,
 				      const struct of_device_id *matches,
 				      const struct of_dev_auxdata *lookup,
 				      struct device *parent);
+extern int of_early_platform_probe(void);
 #else /* CONFIG_EARLY_PLATFORM_DEVICES */
 static inline int
 of_early_platform_populate(struct device_node *root,
@@ -90,6 +91,7 @@ of_early_platform_populate(struct device_node *root,
 {
 	return -ENOSYS;
 }
+static inline void int of_early_platform_probe(void) {}
 #endif /* CONFIG_EARLY_PLATFORM_DEVICES */
 
 extern int of_platform_default_populate(struct device_node *root,
-- 
2.17.0
