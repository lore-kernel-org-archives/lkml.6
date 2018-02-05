Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2271oonb+8WfAw2p7G+OWQ7aez+ANbpIR1Q6YRSHPSmoffY1PKjDAVtSsgjFHWCZKQvfBs2l
ARC-Seal: i=1; a=rsa-sha256; t=1517855170; cv=none;
        d=google.com; s=arc-20160816;
        b=i2sGdyrnYdRIGvq7o46ZT2isjnu+JUOslLeARwhwFGf3phkES9pWcMlLrsiXu9QhsT
         cQJbQrM2s/glq1MJOMxhy/5E2Qygq72k5wsytYaRGQuRbniVQpttGqkn0jbiCMXgtp4q
         BLD2V8hSlcRDcbKTqKNMSMAK90IJw1jfkRowSvAVgmbziabEVam1cqB6/9PThNu+ZosA
         gATItRWI5dvOpKS+0ju9iVARiIcpKyrw4kgq6i1qY53BZGtmDLUs4e96DFjrXfhKZS3R
         1ZFlTHuWt5sFdovuEKNLRdLasylDB4AcLYDMnnb7YPrtnQP0/5W44dLtRz9iqfWn4uJV
         dvZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/q+vbY6vljct3Ij9Z3knpqR88K4gLQ9yCKf7jtRGIyA=;
        b=Lg2QMJceRqY8AFf7Y3g4QYMn8C+dTf93evfcNayhnQV7/qnZTHACXJ+LUYqGCVnJW1
         MX6fD61pc9IASS4VbbpSNFWcX9dTtbob+ZrkphvcYj8VQn5UGMOcSvZ67haVNDl1MHsQ
         ePh9aD4Tgw6XhJdaxelGu/CMt0Lt3OaHJRQRe7SUGadtodKSiVjRQE77oZM+SCfU7UzK
         mBeIyNcSl+UoAx2bjJpI/ZD1/eNA8R0aNePrc/SS5Ee8pOlzzyl6b1kRFqxoZdwHu+j5
         Fpav6KgbvtsS2vYyeJYq4jMZSyiDnhgA85LHgKJBNbzMrhufWUvOC5yJVWsDC9EjQ3IU
         /45g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	karahmed@amazon.de,
	peterz@infradead.org,
	bp@alien8.de
Subject: [PATCH 4.15 50/60] x86/retpoline: Avoid retpolines for built-in __init functions
Date: Mon,  5 Feb 2018 10:23:23 -0800
Message-Id: <20180205182216.300380140@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586398360196413?=
X-GMAIL-MSGID: =?utf-8?q?1591586503630066131?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse dwmw@amazon.co.uk

commit 66f793099a636862a71c59d4a6ba91387b155e0c

There's no point in building init code with retpolines, since it runs before
any potentially hostile userspace does. And before the retpoline is actually
ALTERNATIVEd into place, for much of it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: karahmed@amazon.de
Cc: peterz@infradead.org
Cc: bp@alien8.de
Link: https://lkml.kernel.org/r/1517484441-1420-2-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 include/linux/init.h |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -5,6 +5,13 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 
+/* Built-in __init functions needn't be compiled with retpoline */
+#if defined(RETPOLINE) && !defined(MODULE)
+#define __noretpoline __attribute__((indirect_branch("keep")))
+#else
+#define __noretpoline
+#endif
+
 /* These macros are used to mark some functions or 
  * initialized data (doesn't apply to uninitialized data)
  * as `initialization' functions. The kernel can take this
@@ -40,7 +47,7 @@
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
-#define __init		__section(.init.text) __cold  __latent_entropy
+#define __init		__section(.init.text) __cold  __latent_entropy __noretpoline
 #define __initdata	__section(.init.data)
 #define __initconst	__section(.init.rodata)
 #define __exitdata	__section(.exit.data)
