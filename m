Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/GZ0tl8FhQCe+f5fl2yv60zEOIZE30Oq7BhBwM838WShgO/+RiXdb/AcZ0d9io1KBxhVI/
ARC-Seal: i=1; a=rsa-sha256; t=1522168723; cv=none;
        d=google.com; s=arc-20160816;
        b=TFX4oRkjVyE49NkjM8nb3YrQpapZrYlsJpvmtIZgpMKwQPPfmYWwNdhqMVBjJ80wCs
         6KL3tuMaXdgd+6oaYg0ihDiTgT4VAGhWx/CLMcv7PepO1womUs+KdGT9sCrfo0QbKinO
         Kg69V4owfsr9BIEny6a0t1rtgTThkvU8heHvHRytsSu3Lh93kYQkSMYazqrgoGg3hWfV
         wwlP4DWkpd9+23/9lK0/2JQBxRPsozfLCX+f56APeWKwNAqRi2A15+jamhqQaLZUyibT
         dAczf5w8CLBf8TFR4Hwzygqw0DCEseJRMmn4KJzxBEeKXo1FH93Ju1QBP5SvLGgnjjAY
         4lZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ce1eSWJOqZjBf3AwWYdqF1BZY/CGjCV86AY8jmtZd9A=;
        b=DxkHGkGnQiRutSRy8F6WjMo0Yxbb8rm0SeDQ7XHFhMKUdxI6m0bLECh/42b3VWaOW3
         6fLitAAyTn1J91CcdTT8MiksEAY177ZyTVWTmNKXdwK00s39ALzRZCn4bkte7JJLS6Jz
         P1FaKs0t/BwObGKFMSNuPq5RcSNBPwNuRATq2fXyGI38PdYT3AS/1DmycyeaSRZ6XdRe
         WVv4x6GJ1Wu05TE526vvnwUUdG8PYu7NOw8zqvEg+YI+ukS47M837NCMN6O8bzy6J+1f
         igeb4RlBugvdVGlShS9jZFPIfiGYoerwNKQw4r/BrEUCM4sxbZWuJuLCGukhZ44CNNZp
         gDWg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	NeilBrown <neil@brown.name>,
	John Crispin <john@phrozen.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org,
	James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.15 001/105] MIPS: ralink: Remove ralink_halt()
Date: Tue, 27 Mar 2018 18:26:41 +0200
Message-Id: <20180327162757.869381918@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108957348876087?=
X-GMAIL-MSGID: =?utf-8?q?1596109590899730680?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neil@brown.name>

commit 891731f6a5dbe508d12443175a7e166a2fba616a upstream.

ralink_halt() does nothing that machine_halt() doesn't already do, so it
adds no value.

It actually causes incorrect behaviour due to the "unreachable()" at the
end. This tells the compiler that the end of the function will never be
reached, which isn't true. The compiler responds by not adding a
'return' instruction, so control simply moves on to whatever bytes come
afterwards in memory. In my tested, that was the ralink_restart()
function. This means that an attempt to 'halt' the machine would
actually cause a reboot.

So remove ralink_halt() so that a 'halt' really does halt.

Fixes: c06e836ada59 ("MIPS: ralink: adds reset code")
Signed-off-by: NeilBrown <neil@brown.name>
Cc: John Crispin <john@phrozen.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.9+
Patchwork: https://patchwork.linux-mips.org/patch/18851/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ralink/reset.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/arch/mips/ralink/reset.c
+++ b/arch/mips/ralink/reset.c
@@ -96,16 +96,9 @@ static void ralink_restart(char *command
 	unreachable();
 }
 
-static void ralink_halt(void)
-{
-	local_irq_disable();
-	unreachable();
-}
-
 static int __init mips_reboot_setup(void)
 {
 	_machine_restart = ralink_restart;
-	_machine_halt = ralink_halt;
 
 	return 0;
 }
