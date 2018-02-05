Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2241D5vZhscZ/Vq678nw2YfYMLSg969//vL344bnbw8Kv/Q0Ll3dL8DoIY1Pk1XYTr5gNJL5
ARC-Seal: i=1; a=rsa-sha256; t=1517855070; cv=none;
        d=google.com; s=arc-20160816;
        b=GxUGXMFfik1ECYlzenUOPFibxpK0egPY0O/z5CP+9xz7DQmbijSRgZxhqv0XmmoNYU
         LLUjnRNqnNpHXvQolhaERfbqu7bj3PIxdAK4fpIfF288kxf4KkEMUZFg2NS+TYyi2UiY
         uIvkXc2pEtgKqnMoQNzGqtCb+ovQ5CfSD2HLPDdvEEAIv8LtdYYehvlnTZEzek/FRF39
         hcBSu7C9XvtUqgamiYySD2CIZ+ieAU54I6WRICFt6wNmnd0OwtQMHVmZ0gWbKoaqLujy
         1yLeWSwwhv12GiHZVSu1rmHhugYqS5w4x2glj5DI3IajogcOejGNN6OA/EWfK9Jb9KO2
         cq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Js9TZI84IPNk+Ew8ZTvxnk+WmSl6+hlvCYeZ3yRxLVQ=;
        b=f5zk9+vfofr9+ZdtnASUMqjf7ReFaRvRF2taqlJyYXzqVuqWqDLU7aibPTSLeddU2G
         hdwI/33ZcsrSHl20FcTqedRJ7Ggedr/SXJDQbKY0WOhVQQxlApxEWhW0xTqLCQqDknrt
         yvIzEZfDYUgoDKYkrRHXU0m14ZMwsNuk9R//X+6lPyh4DBctJ9KeuI83FksHonqGWKJj
         iyeisqViuE7BM2TH4/Vu18Dp0JFynU1X9c3ME/DeX0xPJcQCtDiXC4Bp6G7/rHU0lESn
         OiY4x6/DyyEpunUSjEeo6Fz8sXY7kxh8TLckiiMFx1Qpx8wYA9N1+rudzeXPOekoTtZ8
         vM/A==
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
Subject: [PATCH 4.14 54/64] x86/retpoline: Avoid retpolines for built-in __init functions
Date: Mon,  5 Feb 2018 10:23:13 -0800
Message-Id: <20180205182140.797161571@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586398360196413?=
X-GMAIL-MSGID: =?utf-8?q?1591586398360196413?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
-#define __init		__section(.init.text) __cold __inittrace __latent_entropy
+#define __init		__section(.init.text) __cold __inittrace __latent_entropy __noretpoline
 #define __initdata	__section(.init.data)
 #define __initconst	__section(.init.rodata)
 #define __exitdata	__section(.exit.data)
