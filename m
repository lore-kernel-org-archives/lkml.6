Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E82C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84082089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="fcgy9oG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfAGW1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:27:17 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32884 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfAGW1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:27:14 -0500
Received: by mail-ed1-f66.google.com with SMTP id p6so2437425eds.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 14:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BVbQCDA56Sh3XsGTeC6uIhOhCtmqKl8viz2OQpUKId0=;
        b=fcgy9oG3Kkz8c27iRWp1bPoGNqP09cnR76rHQhWjLQ6jvMmOxOhMgNGXSoitBlgHi/
         HNPN1+2YZtpWQK6mXzBfU24HgDiwE12LSBlKWp64q65EScp9gVTQbV88fzGWFhQeR/vT
         uK91xhiXl9YXoWkY/+Bk1vDEXi0nS3vLglQyio4XQficoqUDWtZSeXGIN8+pPBqufmUk
         T62agBFR409OeCstqZUUXYSPhB4MGSNWZ6u+9hxia3ZqbzVR2tkCpiYJwi220AimKPvE
         c+4PhImulY/BCML6BZi0rR08xFphsssypziXYqZcl9KhCPr9cGEYoEgunABFySMzHAfN
         pG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BVbQCDA56Sh3XsGTeC6uIhOhCtmqKl8viz2OQpUKId0=;
        b=OTPSRkd4fXwbsTEXBkVz6SY/7CRnunw5RRTHB619XGpytOj7J8/OOcIBozGxsFpwz4
         iwvMXi7uqvz8x+dpmo0gJm8SKu/FkjfCZ8Tkr8gvCP4uM+U2UGfTGWJB2ZPOEH6eMSXK
         zBZNBEsWxJo3+8BqDb7TnrtKn6jJWS0L0K4/WwTkKihbq0B1gF6Gs9/SXxLPGQXFHQGp
         YXYZbsUHx+9BP5lNGMFHDpA8uskfN4z7gJWnUC4dxLX3jg2SioEF/cP91Bp578gOxN31
         7NZ9DiA+vECB2Zkezdn3Lr9AeKL5uEyTA5wiiKtzvGEELioZDT66wnZhUe86o1SDfkcB
         xwcA==
X-Gm-Message-State: AA+aEWY3AkzyePue3axhC1GNBL01rZiYYStmPRx4sHQMAsSx1mjrItog
        paUHEmmlTrt77MkolRU/y9S4+w==
X-Google-Smtp-Source: AFSGD/Xem6uBbEl8RjOS4A4GzyjruT31aL8H0HQocgCjR4cYPaB3XOCzrj1eLNYNr34TY7aZuFWHWg==
X-Received: by 2002:a17:906:b297:: with SMTP id q23-v6mr47933168ejz.147.1546900031850;
        Mon, 07 Jan 2019 14:27:11 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6c0:d6c:9810:663f:f898:8929])
        by smtp.gmail.com with ESMTPSA id e53sm30826227ede.90.2019.01.07.14.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 14:27:11 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org, joe.lawrence@redhat.com,
        longman@redhat.com, linux@dominikbrodowski.net,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        linux-api@vger.kernel.org, Christian Brauner <christian@brauner.io>
Subject: [RESEND PATCH v3 1/2] sysctl: handle overflow in proc_get_long
Date:   Mon,  7 Jan 2019 23:26:59 +0100
Message-Id: <20190107222700.15954-2-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190107222700.15954-1-christian@brauner.io>
References: <20190107222700.15954-1-christian@brauner.io>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

proc_get_long() is a funny function. It uses simple_strtoul() and for a
good reason. proc_get_long() wants to always succeed the parse and return
the maybe incorrect value and the trailing characters to check against a
pre-defined list of acceptable trailing values.
However, simple_strtoul() explicitly ignores overflows which can cause
funny things like the following to happen:

echo 18446744073709551616 > /proc/sys/fs/file-max
cat /proc/sys/fs/file-max
0

(Which will cause your system to silently die behind your back.)

On the other hand kstrtoul() does do overflow detection but does not return
the trailing characters, and also fails the parse when anything other than
'\n' is a trailing character whereas proc_get_long() wants to be more
lenient.

Now, before adding another kstrtoul() function let's simply add a static
parse strtoul_lenient() which:
- fails on overflow with -ERANGE
- returns the trailing characters to the caller

The reason why we should fail on ERANGE is that we already do a partial
fail on overflow right now. Namely, when the TMPBUFLEN is exceeded. So we
already reject values such as 184467440737095516160 (21 chars) but accept
values such as 18446744073709551616 (20 chars) but both are overflows. So
we should just always reject 64bit overflows and not special-case this
based on the number of chars.

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Christian Brauner <christian@brauner.io>
---
/* Changelog */
v3:
- (Kees) s/#include <../lib/kstrtox.h>/#include "../lib/kstrtox.h"/g
- (Kees) document strtoul_lenient()

v2:
- s/sysctl_cap_erange/sysctl_lenient/g
- consistenly fail on overflow

v1:
- s/sysctl_strtoul_lenient/strtoul_cap_erange/g
- (Al) remove bool overflow return argument from strtoul_cap_erange
- (Al) return ULONG_MAX on ERANGE from strtoul_cap_erange
- (Dominik) fix spelling in commit message
---
 kernel/sysctl.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 1825f712e73b..06df9ef138e3 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -67,6 +67,8 @@
 #include <linux/bpf.h>
 #include <linux/mount.h>
 
+#include "../lib/kstrtox.h"
+
 #include <linux/uaccess.h>
 #include <asm/processor.h>
 
@@ -2085,6 +2087,41 @@ static void proc_skip_char(char **buf, size_t *size, const char v)
 	}
 }
 
+/**
+ * strtoul_lenient - parse an ASCII formatted integer from a buffer and only
+ *                   fail on overflow
+ *
+ * @cp: kernel buffer containing the string to parse
+ * @endp: pointer to store the trailing characters
+ * @base: the base to use
+ * @res: where the parsed integer will be stored
+ *
+ * In case of success 0 is returned and @res will contain the parsed integer,
+ * @endp will hold any trailing characters.
+ * This function will fail the parse on overflow. If there wasn't an overflow
+ * the function will defer the decision what characters count as invalid to the
+ * caller.
+ */
+static int strtoul_lenient(const char *cp, char **endp, unsigned int base,
+			   unsigned long *res)
+{
+	unsigned long long result;
+	unsigned int rv;
+
+	cp = _parse_integer_fixup_radix(cp, &base);
+	rv = _parse_integer(cp, base, &result);
+	if ((rv & KSTRTOX_OVERFLOW) || (result != (unsigned long)result))
+		return -ERANGE;
+
+	cp += rv;
+
+	if (endp)
+		*endp = (char *)cp;
+
+	*res = (unsigned long)result;
+	return 0;
+}
+
 #define TMPBUFLEN 22
 /**
  * proc_get_long - reads an ASCII formatted integer from a user buffer
@@ -2128,7 +2165,8 @@ static int proc_get_long(char **buf, size_t *size,
 	if (!isdigit(*p))
 		return -EINVAL;
 
-	*val = simple_strtoul(p, &p, 0);
+	if (strtoul_lenient(p, &p, 0, val))
+		return -EINVAL;
 
 	len = p - tmp;
 
-- 
2.19.1

