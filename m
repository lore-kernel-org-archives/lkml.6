Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/C/Kibo3WDCJadcnRwXAIeNR0h+fARG6uVdyc7UR693cnUdQQRCTrg6FvvOMxllW/jtLPX
ARC-Seal: i=1; a=rsa-sha256; t=1522168241; cv=none;
        d=google.com; s=arc-20160816;
        b=WWkRQ75e5btxGH+C+XhazbHki/Wr15TXS372UfHd0dSgPiAKabs9znLv3suoVnNOxE
         QTYUVlxJoJy7x+XSPPf6oBH33aGe56HRLplxozY/f4Cw4TlPzipZAON1XTMOjym9V41T
         XYM7UxppleFnrRHfG6Ye67pseXm5sA5hnAHGT01YTwE44eyaWiqsn0iFi6JG0mRAyfoq
         pOklf1m2tE8IEbCbJ7r0Ge6QmUvOc/ZHVN8HF6Ss75SKwdPfOaEj4xcgaZcU4X2KeNvm
         2cbJUNOi4scWDzgpNXaeKRXXBGcf/LbLepEqovBLIN/iCoWNosKhmsO5AhbkUre90Q9G
         jWUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=B74ZiqjuX21f3PidCt9szp9Mgj8vKIsDIFgI/6biZVg=;
        b=UKegMD0MJlbnMv+gcBWTDEErbUJZiAclJTq5mNKCFR6cON0Iy5F9ZtLmrmNX0xD2fP
         rIShnKVfbubq8wY52GZYszyDIfE6MWI5GRAy3CqgkpvdBJih1CKGjAJsFR91xAMo21D1
         fkv2+Z/T29cJ4A8skoNZk2Z4s9c0r8wz/BDGgy9V5WJw8cBEmT1SS7dISYp/Xtmtg+Ik
         gvOCUVpPEl6TlPSmENiYiXGM4VeJV72Dj5TjJCcyA7Qahz2k+QwCRMebCKBf68L2ya+g
         NcTV6AHpg2BBOn7XowXQPW1Egts912+ZY00Ajysm0owNjRTaVGUgsr7/Glpseg8YacY7
         Ivcg==
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
Subject: [PATCH 4.9 01/67] MIPS: ralink: Remove ralink_halt()
Date: Tue, 27 Mar 2018 18:26:53 +0200
Message-Id: <20180327162726.776788856@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108957348876087?=
X-GMAIL-MSGID: =?utf-8?q?1596109086080254666?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
