Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AG47ELttzKDjU+d5+Plf4kl9O2S8Il+FFWaHt4Tt/e21hS0RaTwU7aleo3mnNN+tODiwhhr8MwH3
ARC-Seal: i=1; a=rsa-sha256; t=1522137956; cv=none;
        d=google.com; s=arc-20160816;
        b=IeHViyJtX4fxBDEToOV0dZigEP+TuYHlyo5Wgte9QXwDYiF8B2Ek6LMh/z/Im/rrfD
         LXND1WBXjHj0cJMVQ6VNqIjP0fC+fj8sQJ1HT8eQbCRI6jILRdaVgfHr78I9hnkRD7Ol
         yrgr+LMrZBlaWvgUZ6p48h+iHo7Hi4Z//McvBA9jgEzwhj7/A+OIt22wSsmHMuwBlF46
         faJjMNI2tMT9pCBVb5s7YCsfaWSvky0trnm8Wrd+9X1KS3i1x837VqmGgp4bGT913U+I
         tpha5y/Y7VatExgMCsAusuCjP8FewlQ2FA2X6O0zvfja2jzvJ9AM1Y2neB4zUVn5CsZq
         v3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=qFaVWPe1+tbmkzmsCdV/C+aXE6GtDuL5LEaK+UDPn2U=;
        b=Gh0HR6WmWXzmGnjAppz1Ecrk7QwEG6wjqTyWALXvodoMTcXJ+P1W6AFe+x7XyJ87vP
         mCcVIoJ2vmpmbONHiXqlcmIVQF8VxedB1QnSKDQqtiY6pEAKVFle8Jln7ORol5I9uCiN
         2yaZoQv4nCgH3gCmOLSywbJ4f9sV8GlDUcveFLtCK5ipCl3EHCOHIb7D0MokkPQT/hul
         JG1C11lQHJSryCqvcxz+Wsak17Ck32sqhUX4sxz3HfPRKdZxX28Fg4KYHqqE2fVnqZwq
         7gUT0cFJiQRDZvJTae0bipoOzuHVI3/DalPMlQE5PVVeha4iAZYxzSWqoydyki3p4gnx
         Wl/w==
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
Subject: [PATCH v1 4/7] platform: mellanox: add new ODM system types to mlx-platform
Date: Tue, 27 Mar 2018 10:02:04 +0000
Message-Id: <1522144927-56512-5-git-send-email-vadimp@mellanox.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
References: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596077330575695647?=
X-GMAIL-MSGID: =?utf-8?q?1596077330575695647?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Patch adds new ODM systems, matched according to DMI_BOARD_NAME.
The supported ODM Ids are: VMOD0001, VMOD0002, VMOD0003, VMOD0004,
VMOD0005. It doesn't introduce new systems, but allows to
ODM companies to set DMI_BOARD_VENDOR and DMI_PRODUCT_NAME on
their own. It assumes that ODM company can't change DMI_BOARD_NAME.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
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
