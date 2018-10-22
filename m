Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B799CECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886C82083C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886C82083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeJVR4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:56:11 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7650 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727519AbeJVR4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:56:11 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="46549071"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Oct 2018 17:38:24 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 3FA714B71107;
        Mon, 22 Oct 2018 17:38:24 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 22 Oct 2018 17:38:28 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <keescook@chromium.org>, <bhe@redhat.com>,
        <msys.mizuma@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v10 2/7] x86/boot: Copy kstrtoull() to compressed period
Date:   Mon, 22 Oct 2018 17:37:15 +0800
Message-ID: <20181022093720.21426-3-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181022093720.21426-1-fanc.fnst@cn.fujitsu.com>
References: <20181022093720.21426-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 3FA714B71107.A6D94
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrtoull() lives in 'uncompressed' period, used to
convert a string to an unsigned long long.
Copy to 'compressed' so that we can use it to
convert the memory address from sting to unsigned
long long in 'compressed' period.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/misc.c | 88 +++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h |  4 ++
 2 files changed, 92 insertions(+)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 8dd1d5ccae58..5b9b24949337 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -426,3 +426,91 @@ void fortify_panic(const char *name)
 {
 	error("detected buffer overflow");
 }
+
+#define KSTRTOX_OVERFLOW        (1U << 31)
+
+static inline char _tolower(const char c)
+{
+	return c | 0x20;
+}
+
+unsigned int
+_parse_integer(const char *s, unsigned int base, unsigned long long *p)
+{
+	unsigned long long res;
+	unsigned int rv;
+
+	res = 0;
+	rv = 0;
+	while (1) {
+		unsigned int c = *s;
+		unsigned int lc = c | 0x20; /* don't tolower() this line */
+		unsigned int val;
+
+		if ('0' <= c && c <= '9')
+			val = c - '0';
+		else if ('a' <= lc && lc <= 'f')
+			val = lc - 'a' + 10;
+		else
+			break;
+
+		if (val >= base)
+			break;
+		/*
+		 * Check for overflow only if we are within range of
+		 * it in the max base we support (16)
+		 */
+		if (unlikely(res & (~0ull << 60))) {
+			if (res > div_u64(ULLONG_MAX - val, base))
+				rv |= KSTRTOX_OVERFLOW;
+		}
+		res = res * base + val;
+		rv++;
+		s++;
+	}
+	*p = res;
+	return rv;
+}
+
+const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
+{
+	if (*base == 0) {
+		if (s[0] == '0') {
+			if (_tolower(s[1]) == 'x' && isxdigit(s[2]))
+				*base = 16;
+			else
+				*base = 8;
+		} else
+			*base = 10;
+	}
+	if (*base == 16 && s[0] == '0' && _tolower(s[1]) == 'x')
+		s += 2;
+	return s;
+}
+
+static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
+{
+	unsigned long long _res;
+	unsigned int rv;
+
+	s = _parse_integer_fixup_radix(s, &base);
+	rv = _parse_integer(s, base, &_res);
+	if (rv & KSTRTOX_OVERFLOW)
+		return -ERANGE;
+	if (rv == 0)
+		return -EINVAL;
+	s += rv;
+	if (*s == '\n')
+		s++;
+	if (*s)
+		return -EINVAL;
+	*res = _res;
+	return 0;
+}
+
+int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
+{
+	if (s[0] == '+')
+		s++;
+	return _kstrtoull(s, base, res);
+}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 008fdc47a29c..40378408d980 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -63,6 +63,10 @@ static inline void debug_puthex(const char *s)
 
 #endif
 
+#if (defined CONFIG_RANDOMIZE_BASE) && (defined CONFIG_RANDOMIZE_BASE)
+int kstrtoull(const char *s, unsigned int base, unsigned long long *res);
+#endif
+
 #if CONFIG_EARLY_PRINTK || CONFIG_RANDOMIZE_BASE
 /* cmdline.c */
 int cmdline_find_option(const char *option, char *buffer, int bufsize);
-- 
2.17.2



