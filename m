Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933461AbeBMGXi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 01:23:38 -0500
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:38244
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S933434AbeBMGXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 01:23:35 -0500
X-ASG-Debug-ID: 1518503006-093b7e4b503e450001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: Shunyong Yang <shunyong.yang@hxt-semitech.com>
To: <me@tobin.cc>
CC: <linux-kernel@vger.kernel.org>, <linux@rasmusvillemoes.dk>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: [PATCH] vsprintf: replace space with readable '=' before crng is ready
Date: Tue, 13 Feb 2018 14:20:48 +0800
X-ASG-Orig-Subj: [PATCH] vsprintf: replace space with readable '=' before crng is ready
Message-ID: <1518502848-7694-1-git-send-email-shunyong.yang@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.109]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14)
X-Barracuda-Connect: localhost[10.128.0.14]
X-Barracuda-Start-Time: 1518503006
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5232 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.47864
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before crng is ready, output of "%p" composes of "(ptrval)" and
left padding spaces for alignment as no random address can be
generated. This seems a little strange when default string width
is larger than strlen("(ptrval)").

For example, when irq domain names are built with "%p", the nodes
under /sys/kernel/debug/irq/domains like this on AArch64 system,

[root@y irq]# ls domains/
default                   irqchip@        (ptrval)-2
irqchip@        (ptrval)-4  \_SB_.TCS0.QIC1  \_SB_.TCS0.QIC3
irqchip@        (ptrval)  irqchip@        (ptrval)-3
\_SB_.TCS0.QIC0             \_SB_.TCS0.QIC2

The name "irqchip@        (ptrval)-2" is not so readable in console
output.

This patch replaces space with readable "=" when output needs padding.
Following is the output after applying the patch,

[root@y domains]# ls
default                   irqchip@(====ptrval====)-2
irqchip@(====ptrval====)-4  \_SB_.TCS0.QIC1  \_SB_.TCS0.QIC3
irqchip@(====ptrval====)  irqchip@(====ptrval====)-3  \_SB_.TCS0.QIC0
\_SB_.TCS0.QIC2

There is same problem in some subsystem's dmesg output. Moreover,
someone may call "%p" in a similar case. In addition, the timing of
crng initialization done may vary on different system. So, the change
is made in vsprintf.c.

Link: https://patchwork.kernel.org/patch/10185199/

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
---
 lib/vsprintf.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 77ee6ced11b1..9fdc8376752a 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1700,9 +1700,25 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
 	const int default_width = 2 * sizeof(ptr);
 
 	if (unlikely(!have_filled_random_ptr_key)) {
+		char *ptrval_str = "(ptrval)";
+		char str[default_width + 1];
+		int len = strlen(ptrval_str);
+
+		if (default_width > len) {
+			int pos;
+
+			pos = (default_width - len) / 2;
+			memset(str, '=', default_width);
+			memcpy(str + pos + 1, ptrval_str + 1, len - 2);
+			str[0] = '(';
+			str[default_width - 1] = ')';
+			str[default_width] = 0;
+			ptrval_str = str;
+		}
+
 		spec.field_width = default_width;
 		/* string length must be less than default_width */
-		return string(buf, end, "(ptrval)", spec);
+		return string(buf, end, ptrval_str, spec);
 	}
 
 #ifdef CONFIG_64BIT
-- 
1.8.3.1
