Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZokH8UYFguXVdCXvbhcpx2ImFR3x5tXdbQ0Mwgjd8EWXUTiVz0qzTM9Ep0Juqv9j4glGDH5
ARC-Seal: i=1; a=rsa-sha256; t=1525767207; cv=none;
        d=google.com; s=arc-20160816;
        b=0ifzYE5jsbUsQfn/tjQ3HZ+UX80p9xWuHyvgbLzaum+2G/oeKVMotQcRSi42VAxR03
         rD4h99FJr07DMhVY8Rw4xabujuqEu9EnzNZgpXbKTNrX+ewG8Xcw7zv3S5aa3pk2ZGBk
         gpuw18n/U2ljpvq/Lmp82J5vY6dm5+fhPPGwduhvKQK+pWr2pShilC+tKc1m5pTECNeG
         0QY8Lprq9O07C57X4CAM9/IICpZy/COL2TDczWOvdEV9PShMzikihhF0TpCOlFV1sF+D
         Nxfo3Ft+AunPImVTLMnyoeZK4Z0ZiUhPZ9JQhrJTchdpAHdA3IvId/+u3zqw0nIxbFBP
         NhPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Ebt4dAiRImJQcu75x66puHhcngTNjVDa6RkEypMoYTY=;
        b=0kfhPbOAnX4A6xJYaz7ebuee94dxqwIGCfQGOJ+B1TuijTlXJl1c8gg33iHmO4jO+5
         OXNC3QygD9OOmAJpaddmG+pxZeCjgpK0/kPV8TEV8cCDDByXNRmQoFnz+HDgSSbC5/J4
         nqmCQhQuivU2iyjzcS5/5eEpWJKeZb+yjlDFJBfM/kS4/n593kSmFTr5Z1xKpPX5cSeD
         Y9t9F5Ak4jtfxHrXU7dChXWoW6kuqDdYCnema4c8Mthwh4IGs+qnjEjPTREcbZTRP6BR
         IzE5VD3DZX83zpXjhwc4P2OoLkKM9OiEM3tM6GtgCPoBdr5FImV+KAu2fMHDG6snkOmA
         pzHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=izWFNxQn;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=izWFNxQn;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	len.brown@intel.com,
	rjw@rjwysocki.net,
	diego.viola@gmail.com,
	rui.zhang@intel.com
Subject: [PATCH 4.16 46/52] x86/tsc: Always unregister clocksource_tsc_early
Date: Tue,  8 May 2018 10:10:44 +0200
Message-Id: <20180508073934.620885008@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882875312485536?=
X-GMAIL-MSGID: =?utf-8?q?1599882875312485536?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit e9088adda13cd23249d4b0abb97ff8a81bf5573a upstream.

Don't leave the tsc-early clocksource registered if it errors out
early.

This was reported by Diego, who on his Core2 era machine got TSC
invalidated while it was running with tsc-early (due to C-states).
This results in keeping tsc-early with very bad effects.

Reported-and-Tested-by: Diego Viola <diego.viola@gmail.com>
Fixes: aa83c45762a2 ("x86/tsc: Introduce early tsc clocksource")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: len.brown@intel.com
Cc: rjw@rjwysocki.net
Cc: diego.viola@gmail.com
Cc: rui.zhang@intel.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180430100344.350507853@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/tsc.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1205,7 +1205,7 @@ static void tsc_refine_calibration_work(
 
 	/* Don't bother refining TSC on unstable systems */
 	if (tsc_unstable)
-		return;
+		goto unreg;
 
 	/*
 	 * Since the work is started early in boot, we may be
@@ -1258,11 +1258,12 @@ static void tsc_refine_calibration_work(
 
 out:
 	if (tsc_unstable)
-		return;
+		goto unreg;
 
 	if (boot_cpu_has(X86_FEATURE_ART))
 		art_related_clocksource = &clocksource_tsc;
 	clocksource_register_khz(&clocksource_tsc, tsc_khz);
+unreg:
 	clocksource_unregister(&clocksource_tsc_early);
 }
 
@@ -1272,8 +1273,8 @@ static int __init init_tsc_clocksource(v
 	if (!boot_cpu_has(X86_FEATURE_TSC) || tsc_disabled > 0 || !tsc_khz)
 		return 0;
 
-	if (check_tsc_unstable())
-		return 0;
+	if (tsc_unstable)
+		goto unreg;
 
 	if (tsc_clocksource_reliable)
 		clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
@@ -1289,6 +1290,7 @@ static int __init init_tsc_clocksource(v
 		if (boot_cpu_has(X86_FEATURE_ART))
 			art_related_clocksource = &clocksource_tsc;
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
+unreg:
 		clocksource_unregister(&clocksource_tsc_early);
 		return 0;
 	}
