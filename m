Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtSKhtLdSge7JWuULu2NYMcAb2gleJFXYO9+eaR0x7fr5qQYi4Aodw/gPq2FWGWA5oQNu/s
ARC-Seal: i=1; a=rsa-sha256; t=1519411292; cv=none;
        d=google.com; s=arc-20160816;
        b=K//9+UYweEzV6BiIO7B6kLlrwLZ55aHHqX+yBkd2ryM4Eo6l8n4oX01DzKUyFyG4z7
         APgBaI530PNegMX0L2A6M2TUy9PP2SqFeRT79FCufYrfDyKPzmbyLLfPwgYNt6tGo1LK
         z1lhB3H9CzMQArKnckPfIJQctriAYUINUPg1r5QysEpNhfY4QV+clGm6EwTyCPRUhUNA
         uAxKaSm4EakI41gxThA92UHyUrvWyVU6FJS2SnS7hDe4KE4KL1SHFw2ZRY2iScM0p2NS
         gkz8qeQ88SqqmrW10kxcAKksTLXy0QnltW7EdeLga7JN1EiOb2dENHg1DTmfXJowaIAZ
         5y8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CcE5SCXA9A4vEWKys2eCfwjb875D85kE0v9SeeRUNFM=;
        b=aAjGDu91FMZRwQ8rsxmlOZldC0yW/Yy15hMtzWC2TuDR/1hPpo24KMD86MA0SnBBbS
         aKYmExJmr/szpAOpymii0Omz87vFlRTI/BU2Scem62FTH2lUOE4FRn94DVjhDXV+xZU/
         pJlLPp340fr5oTWe73bdfrnuWnPa0HLKe+t2EKAJmiv9q2wqrKkXbu/RnNZ9Bet1G8mO
         cET3ppEh0IV7esWQvt1fJMGdRs9UZH9pFxyay+eCoMggfuYhFUMeCrx0dk4DTO14Idg0
         67TgZCKN45TKBuyyGPRYawxCWkhupt3bYoDKjg8tMsURNi9zcQwj9rUdPev5Zk6edWAj
         Vaew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	karahmed@amazon.de,
	peterz@infradead.org,
	bp@alien8.de,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.4 185/193] x86/retpoline: Avoid retpolines for built-in __init functions
Date: Fri, 23 Feb 2018 19:26:58 +0100
Message-Id: <20180223170355.228144146@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218215568288447?=
X-GMAIL-MSGID: =?utf-8?q?1593218215568288447?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

(cherry picked from commit 66f793099a636862a71c59d4a6ba91387b155e0c)

There's no point in building init code with retpolines, since it runs before
any potentially hostile userspace does. And before the retpoline is actually
ALTERNATIVEd into place, for much of it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: karahmed@amazon.de
Cc: peterz@infradead.org
Cc: bp@alien8.de
Link: https://lkml.kernel.org/r/1517484441-1420-2-git-send-email-dwmw@amazon.co.uk
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[jwang: port to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/init.h |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -4,6 +4,13 @@
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
@@ -39,7 +46,7 @@
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
-#define __init		__section(.init.text) __cold notrace
+#define __init		__section(.init.text) __cold notrace __noretpoline
 #define __initdata	__section(.init.data)
 #define __initconst	__constsection(.init.rodata)
 #define __exitdata	__section(.exit.data)
