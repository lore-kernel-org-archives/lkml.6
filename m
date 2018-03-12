Return-Path: <kernel-hardening-return-12408-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvKJqpVGa+l0n5uc+uG3wptWGGh+0sUAgfXcXCL6tZOXHvmrCoKW3GcriQRixDxy7nFL8+W
ARC-Seal: i=1; a=rsa-sha256; t=1520828876; cv=none;
        d=google.com; s=arc-20160816;
        b=cWn+9qjKr431xqO9LM2ToiA6l+VGUiIs7mwJueI6N/hROjwqRIoZxBG+4jDi5lCJy4
         DdXBwjgtMXshimvFjF94MTvFmCnSv7KhG1h5Y3PNOhCx/9sx2erXsAT20V4et84wdtc2
         A9NO9WdvBoflqN6obWdusnDgnq4iYt67FIHU+w5E903Od2C/CPmBP4mGaiAUhVCMVBHB
         DtQn846p/ZGUTsGyb8wk6NmabfrGA/3k2yv11UgN/JsxIcNl43zTXDvm5UG9t1JvRsLa
         Q82ZyeVWnCoQ/A+hcrirIt26YFBR9LOjNHXFnJkNX2RG5PyM/mqzhb4ZX+EHoANVAyUE
         4axw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=VpjFo8u6KOeUvTmN6GDsZxaVQ85RQKupAr0HUwUmvXo=;
        b=H5q6bgoUJJduX6z93Pfa96uSl9YQXoybr3ctwjAqpazIKwKCTQZ11ITQTwX2NiwRKG
         sHHG95mqXG3xz3l8miWzk3s0o4aR/LpJwlePBV+/anlCX/C4IGbNf6hX3AvfwaLiSuaj
         fQCpfhxhHLm38EpVA7kx/YOeX9CR+G0VyzcImY04ZbZQkuD0tEJNOmC0uhXJqO9bk19Z
         LX+0Z66grtX8EhS5Bqgr7j/EMVEEcKj8qzcg3ZyebOrfqMGeBZIko6hGRjCsgpIE+ZDu
         49AZh2g8gMw340F4bvnGT9lriZYTzJKhWR/MnUH7mekmNTtQu8/UN6CDXIdf3D/KISHw
         mKfw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=WJ1t/ou7;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=fKwuEN/e;
       spf=pass (google.com: domain of kernel-hardening-return-12408-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12408-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=WJ1t/ou7;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=fKwuEN/e;
       spf=pass (google.com: domain of kernel-hardening-return-12408-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12408-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:uAGmWiC_t7FHjw5nOAi3dj1l_scN0_no5mP_VXrJJA6MEIqVCCIhFQ>
From: "Tobin C. Harding" <me@tobin.cc>
To: Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Tycho Andersen <tycho@tycho.ws>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH] of: unittest: Remove VLA stack usage
Date: Mon, 12 Mar 2018 15:27:23 +1100
Message-Id: <1520828843-22289-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594704660258031955?=
X-GMAIL-MSGID: =?utf-8?q?1594704660258031955?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The kernel would like to have all stack VLA usage removed[1].  This is a
test function so the execution speed is not critical.  We can allocate
memory for this buffer instead of using a VLA.  If kmalloc() fails just
return.

Allocate buffer with kmalloc().

[1]: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---

Kees is this annoying you, CC'ing you an all my VLA patches?

 drivers/of/unittest.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 1991fe4319f5..38cbc343b7da 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -254,12 +254,18 @@ static void __init of_unittest_check_tree_linkage(void)
 static void __init of_unittest_printf_one(struct device_node *np, const char *fmt,
 					  const char *expected)
 {
-	unsigned char buf[strlen(expected)+10];
+	unsigned char *buf;
+	int buf_size;
 	int size, i;
 
+	buf_size = strlen(expected) + 10;
+	buf = kmalloc(buf_size, GFP_KERNEL);
+	if (!buf)
+		return;
+
 	/* Baseline; check conversion with a large size limit */
-	memset(buf, 0xff, sizeof(buf));
-	size = snprintf(buf, sizeof(buf) - 2, fmt, np);
+	memset(buf, 0xff, buf_size);
+	size = snprintf(buf, buf_size - 2, fmt, np);
 
 	/* use strcmp() instead of strncmp() here to be absolutely sure strings match */
 	unittest((strcmp(buf, expected) == 0) && (buf[size+1] == 0xff),
@@ -270,12 +276,13 @@ static void __init of_unittest_printf_one(struct device_node *np, const char *fm
 	size++;
 	for (i = 0; i < 2; i++, size--) {
 		/* Clear the buffer, and make sure it works correctly still */
-		memset(buf, 0xff, sizeof(buf));
+		memset(buf, 0xff, buf_size);
 		snprintf(buf, size+1, fmt, np);
 		unittest(strncmp(buf, expected, size) == 0 && (buf[size+1] == 0xff),
 			"snprintf failed; size=%i fmt='%s' expected='%s' rslt='%s'\n",
 			size, fmt, expected, buf);
 	}
+	kfree(buf);
 }
 
 static void __init of_unittest_printf(void)
-- 
2.7.4
