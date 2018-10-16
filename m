Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C05C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78702145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="MOtSUZc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78702145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJQDqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 23:46:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36534 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbeJQDqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 23:46:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id a8-v6so24488342wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 12:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s8YpQdnL+3bo9wvXanIbhjBIFCVQpatrc2cCheA/URs=;
        b=MOtSUZc3uLRgfbSImnR1NyM6rr2Ux27k3QazZxwu/Fq3qjUBxoZzCmuRvRnlbDRQZw
         FeNsDT2Er89OQhdhk1lTl6OtVGd4LXVTEfnouq4VxMzhC8m//cuJSfrjRvAd3dbeVeG+
         KlfYVuGySfpzMIz/+vTVn7vs7v4O0ttreTXHMKVXPETyMrjOovmjV5jv/kHSnN32QaWa
         EaPxA0eLu618KLMfiuY/qq9yKjIM/zUbLd+f7EbqblAxEzlb9XC9l7BZ9VyaS8FAEBV9
         rZiwMuqTMkzYprbcxZKe3SW+5undiZHlMj5ZHP7mxOhdafxFcipeVkSMDwbuX4wdR69F
         fuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s8YpQdnL+3bo9wvXanIbhjBIFCVQpatrc2cCheA/URs=;
        b=HZwZKazTGs/vA5JmhsiJhsWVnGPl+dcnpzZ7wo74B9sGQydaJFyn/kRcNEU1iddI00
         SxXETLtNjQ02kJRKDNgIqoj0gw+5YxNh1tVo3Gl/C1z9tVKNMocU+LNtbXxDbEJbqh/Z
         LMcbwqaPZlUMVZ619ploXfBPpIoaIfDMG/BGTHXsSOpAVtrX1/OMTKnoyZTHPKZHtL9V
         tR8fc8KTb9X/+OCZFhTbZSw6/OBwlirrPMzBvOhqXXs7ghXddX3kJt7UJw+fk6vy+x75
         Ktgs/ueHZztOtSz6wnEhiQwuD3y9Euj2WT3+ef5HeQbCQ5inh8aYdfCFNxfLUjSr+Q/6
         gjmg==
X-Gm-Message-State: ABuFfohkLACxia3fw+lRs4LD2HbU79OOh2nnDZ1XkS64dXScpXCDIutC
        8KI3gKB+6RhBLzdvokocRWacLQ==
X-Google-Smtp-Source: ACcGV6375P8MLLRRqLmOMFaE7UJt05X88UqHPBq/9fGqlAMHe5BDRrYA/nSNQwvNDjajJjtRSBociw==
X-Received: by 2002:a1c:b9cf:: with SMTP id j198-v6mr17480457wmf.57.1539719644466;
        Tue, 16 Oct 2018 12:54:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id z2-v6sm10958588wrh.8.2018.10.16.12.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 12:54:03 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        longman@redhat.com, linux@dominikbrodowski.net,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        linux-api@vger.kernel.org, Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 1/2] sysctl: handle overflow in proc_get_long
Date:   Tue, 16 Oct 2018 21:53:36 +0200
Message-Id: <20181016195337.2440-2-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016195337.2440-1-christian@brauner.io>
References: <20181016195337.2440-1-christian@brauner.io>
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

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Christian Brauner <christian@brauner.io>
---
v1->v2:
- s/sysctl_cap_erange/sysctl_lenient/g
- consistenly fail on overflow
v0->v1:
- s/sysctl_strtoul_lenient/strtoul_cap_erange/g
- (Al) remove bool overflow return argument from strtoul_cap_erange
- (Al) return ULONG_MAX on ERANGE from strtoul_cap_erange
- (Dominik) fix spelling in commit message
---
 kernel/sysctl.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cc02050fd0c4..7d98e02e5d72 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -67,6 +67,7 @@
 #include <linux/bpf.h>
 #include <linux/mount.h>
 #include <linux/pipe_fs_i.h>
+#include <../lib/kstrtox.h>
 
 #include <linux/uaccess.h>
 #include <asm/processor.h>
@@ -2065,6 +2066,26 @@ static void proc_skip_char(char **buf, size_t *size, const char v)
 	}
 }
 
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
@@ -2108,7 +2129,8 @@ static int proc_get_long(char **buf, size_t *size,
 	if (!isdigit(*p))
 		return -EINVAL;
 
-	*val = simple_strtoul(p, &p, 0);
+	if (strtoul_lenient(p, &p, 0, val))
+		return -EINVAL;
 
 	len = p - tmp;
 
-- 
2.17.1

