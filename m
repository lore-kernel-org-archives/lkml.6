Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE8AC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB22B2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="UVbmPuMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB22B2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeJQG02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:26:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33584 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeJQG01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:26:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id y140-v6so197727wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 15:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j4BlaYccVKiDFbcjfkHQ51UdZm9mSlGLM01ms5YpxxM=;
        b=UVbmPuMOveLWhMpZEuPCUhj/GZCPIuzZlyNI523vcI9rcE6Dd9+PHy39NLCqlIxXnV
         o+UliHgmnYz6kZtXJxxaAV8RKhQfHceLPuvp22/XxoCI92ycX0VfbMwXYbIQ9/WGCCDS
         j+NMNQblsxKuNiIkKv/LKkIVJBRSekhGENffYQXncvce9ZqmGFbpl/oks0iGfTpZ0ElU
         B8gyXlFpHmF9GaeFr3ZZNEG5ahEX4sdE0A+ief0okZS743dWSxprAYYW4cCbBG5BPwNP
         7PyYauQBAN34sDLrFByU1FO55Wt/saIA6Pv+BksDJzLnSFYmHWAsupO9lKPyxrZwlPhm
         lADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j4BlaYccVKiDFbcjfkHQ51UdZm9mSlGLM01ms5YpxxM=;
        b=VOAf28mquRuUFm0aRS3WH83jFM9hpsmbBUGGKXl3cjpE+1dCe/ae9oe6AstJRqexyg
         3JL/CICuE9zw4iXq3fiKudabWvaoJZ8KP7FRN1TEg+VB8VnCxKRMnlYmYN5fk4R8HXTS
         AfZavB7f0cfXeOTB+yoq0utuRCGtP215iyfE8MDr3oQtRMrGXGw/ymEhd/vU0y8sQgVI
         RtlB6JHEH4bKIbNCjmytfOyLpl9r3FbQ1TjsBjzV4/dy9UzNg+Cp1V1YlKvvP5n/9f43
         N3PJzRffTNmLqw623GICvFR4cGL8kB2hMKcA/svFXsnFRopbWnJ0Simm3F9FJ1OabStV
         UMGA==
X-Gm-Message-State: ABuFfoj+p1LC5REhuwL6EzjJF/5snKPC4EPU+dXLC+Jfbq3F8DQpH8eD
        0VWw0uAzaWbMCIg9dp6cjDfAXg==
X-Google-Smtp-Source: ACcGV62DLWdfQhzXBCOi9WdbvxD2Kk3lW/thFc5PtmS2tEuRyUvYWAxM2HZdGg/de2HESq824jw0yA==
X-Received: by 2002:a1c:e157:: with SMTP id y84-v6mr109021wmg.104.1539729233204;
        Tue, 16 Oct 2018 15:33:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id x8-v6sm35084836wrd.54.2018.10.16.15.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 15:33:52 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        longman@redhat.com, linux@dominikbrodowski.net,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        linux-api@vger.kernel.org, Christian Brauner <christian@brauner.io>
Subject: [PATCH v3 1/2] sysctl: handle overflow in proc_get_long
Date:   Wed, 17 Oct 2018 00:33:21 +0200
Message-Id: <20181016223322.16844-2-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016223322.16844-1-christian@brauner.io>
References: <20181016223322.16844-1-christian@brauner.io>
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
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
v2->v3:
- (Kees) s/#include <../lib/kstrtox.h>/#include "../lib/kstrtox.h"/g
- (Kees) document strtoul_lenient()

v1->v2:
- s/sysctl_cap_erange/sysctl_lenient/g
- consistenly fail on overflow

v0->v1:
- s/sysctl_strtoul_lenient/strtoul_cap_erange/g
- (Al) remove bool overflow return argument from strtoul_cap_erange
- (Al) return ULONG_MAX on ERANGE from strtoul_cap_erange
- (Dominik) fix spelling in commit message
---
 kernel/sysctl.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cc02050fd0c4..102aa7a65687 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -68,6 +68,8 @@
 #include <linux/mount.h>
 #include <linux/pipe_fs_i.h>
 
+#include "../lib/kstrtox.h"
+
 #include <linux/uaccess.h>
 #include <asm/processor.h>
 
@@ -2065,6 +2067,41 @@ static void proc_skip_char(char **buf, size_t *size, const char v)
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
@@ -2108,7 +2145,8 @@ static int proc_get_long(char **buf, size_t *size,
 	if (!isdigit(*p))
 		return -EINVAL;
 
-	*val = simple_strtoul(p, &p, 0);
+	if (strtoul_lenient(p, &p, 0, val))
+		return -EINVAL;
 
 	len = p - tmp;
 
-- 
2.17.1

