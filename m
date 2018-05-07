Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AB8JxZok5oh1JpRCqt/9tvSuYptLAUprgvqBKCJ6yUojB8yvBdHbIIkgKCQMLJddqwnFUjR982Y0
ARC-Seal: i=1; a=rsa-sha256; t=1525668788; cv=none;
        d=google.com; s=arc-20160816;
        b=N4Bj/aQNP83Q8PCeuiCZK6E7Z+S5v+0I69fsDQPvt59MAn3Odo5PoAjj456jGgJ6wV
         aRmw5aokUH5oJ7M5D8LxbDClFX+pABTyUh/t1N37uaFB1EQJeG5nzyFfv+2aCfopkoVI
         LAHy8X/tUL9M4AkudGzi03YZuhje699ERSyCOnIg/YMl7PLere7cFl61QSp/qCryXZ6s
         1D3IwfZennzekIYGIzuXkNTxoIAu2Hsxz4stw0ekor4C17RO96L089UEn9Y7Z03pcndB
         JGb4IE3Ud/Q5k/AxGJk0bMlwNmThfj/oW5q+gEgui/BYxnC5bO1GnCJ0ha8sYEHPYS4F
         2mUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=FV5T0gn8Q18nfQz+oY5/07aRwLQzjefGdcy2MRhjQbk=;
        b=ENrGuiu5lBOjzywM/QaidaxfzSZluu7EPpjy5pD1UKf51Fd7LJLVB+sJF6MZ58yk9x
         m8qd8+LChhD3J9jNyS48gNpItfRcN9B9Iy8QijN/8B3V34LOblB970y52HqUX6lkp1rH
         RCdUe2eGbPVR6OWeVQc43ZxSMiBYUpdXluXJVMPZ/t2w+tnRP9XjAUbniPUClcFvJVNe
         i7xImWYUnV+seEG4z7OZnaTUESB2zQ6opzRsGnWyhKxTLgcvidb6rfR6jutsE3J/pyR5
         U4f6fW9QD0tfPyBk+JCmMicmhESolEiCB/55ZhaqEqb+9M5BTOLTdI6u9tE7Zegl9yMo
         bYjA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 193.47.165.129 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
From: Vadim Pasternak <vadimp@mellanox.com>
To: dvhart@infradead.org, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH v2 4/7] platform: mellanox: add new ODM system types to mlx-platform
Date: Mon,  7 May 2018 06:48:52 +0000
Message-Id: <1525675735-125547-2-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1525675735-125547-1-git-send-email-vadimp@mellanox.com>
References: <1525675735-125547-1-git-send-email-vadimp@mellanox.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599779675377048711?=
X-GMAIL-MSGID: =?utf-8?q?1599779675377048711?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add new ODM system types, matched according to DMI_BOARD_NAME. The
supported ODM Ids are: VMOD0001, VMOD0002, VMOD0003, VMOD0004, VMOD0005.
Patch does not introduce new systems, but allows to ODM companies to set
DMI_BOARD_VENDOR and DMI_PRODUCT_NAME on their own. It assumes that ODM
company can't change DMI_BOARD_NAME.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
v1->v2:
 Comments pointed out by Darren:
 - Modify commit message;
---
 drivers/platform/x86/mlx-platform.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index 7a0bd24..912f844 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -844,6 +844,36 @@ static const struct dmi_system_id mlxplat_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "SN34"),
 		},
 	},
+	{
+		.callback = mlxplat_dmi_default_matched,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "VMOD0001"),
+		},
+	},
+	{
+		.callback = mlxplat_dmi_msn21xx_matched,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "VMOD0002"),
+		},
+	},
+	{
+		.callback = mlxplat_dmi_msn274x_matched,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "VMOD0003"),
+		},
+	},
+	{
+		.callback = mlxplat_dmi_msn201x_matched,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "VMOD0004"),
+		},
+	},
+	{
+		.callback = mlxplat_dmi_qmb7xx_matched,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "VMOD0005"),
+		},
+	},
 	{ }
 };
 
-- 
2.1.4
