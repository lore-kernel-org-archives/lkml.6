Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227bSofCHWW/TM1eUksXwAKkY29jFXNtlshpCBAZKQgUetSEypuAzVO6c7aFPZrbHuIPdbCD
ARC-Seal: i=1; a=rsa-sha256; t=1518709115; cv=none;
        d=google.com; s=arc-20160816;
        b=DMarQ0Po9xi7KoVxMwYkNJpXCg/qX86xAgXISacebBsitJSOPjZ0jt0JRISrAS4XmA
         HBVckHdx+r7NYjlfC+phG2llnGXK2lN1jL0ObHKgzG08TwFwcaut4tu9sSZhMBdTNCAP
         VBpnCK9gqV2xX9KW0X0Y2hDw/ETBHivpb+VKfTAo25NAfAkvNJP1pqdoAUYNfSBIpeFl
         gmSXTeR3NURh/ioPJNrmI1DgHTUnZ8O/aKVsacDYBG1nEC8D5V6Smaeg+CkAoGXJJ+Wb
         SXZj0FVFEfK53h2cMRheEEOxHayGkCIc8icgu+2/Qx0Yqlnh8CYgVS9Qd2SdxJV78qti
         xXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5xEbT0uWLLjnjVaeIfjrX5YBWs/yMq3wfO8mrwS7CpQ=;
        b=VYbNp8KTOwasB3uBgU1T3aCQxZx1Ki64QEslGvcxQoVpkOJ3D88PWJI0FQOctEbd8u
         MXXAEaEOvX8cn2aJFReHkjTWXjijJSlW+0Z14Qu/6tpX/NOclvVWgnQPPh3hd2wOngjq
         XGNgew2Lj77Tk9lDy0kU1n3oWwZtr1r5UhcX37HlEE+NxHzFB6TeqITlfvCf96ei5pPh
         Tlg+MLUJZdQK1giQY9sPDu3lxauDGngfLydroi1Zvoni1PBnRDZCa/xbWyzCSBvEvwqm
         EfwsCxPmJ4HxMvzEzSG2jcIlSEi6wVFOmPyqsJujSNobJB6SpkcE8dGQk/N+MOpN3LsF
         TBeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	openrisc@lists.librecores.org,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.14 162/195] signal/openrisc: Fix do_unaligned_access to send the proper signal
Date: Thu, 15 Feb 2018 16:17:33 +0100
Message-Id: <20180215151714.057556782@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480756245594866?=
X-GMAIL-MSGID: =?utf-8?q?1592481929710341078?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

commit 500d58300571b6602341b041f97c082a461ef994 upstream.

While reviewing the signal sending on openrisc the do_unaligned_access
function stood out because it is obviously wrong.  A comment about an
si_code set above when actually si_code is never set.  Leading to a
random si_code being sent to userspace in the event of an unaligned
access.

Looking further SIGBUS BUS_ADRALN is the proper pair of signal and
si_code to send for an unaligned access. That is what other
architectures do and what is required by posix.

Given that do_unaligned_access is broken in a way that no one can be
relying on it on openrisc fix the code to just do the right thing.

Fixes: 769a8a96229e ("OpenRISC: Traps")
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: openrisc@lists.librecores.org
Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/openrisc/kernel/traps.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -306,12 +306,12 @@ asmlinkage void do_unaligned_access(stru
 	siginfo_t info;
 
 	if (user_mode(regs)) {
-		/* Send a SIGSEGV */
-		info.si_signo = SIGSEGV;
+		/* Send a SIGBUS */
+		info.si_signo = SIGBUS;
 		info.si_errno = 0;
-		/* info.si_code has been set above */
-		info.si_addr = (void *)address;
-		force_sig_info(SIGSEGV, &info, current);
+		info.si_code = BUS_ADRALN;
+		info.si_addr = (void __user *)address;
+		force_sig_info(SIGBUS, &info, current);
 	} else {
 		printk("KERNEL: Unaligned Access 0x%.8lx\n", address);
 		show_registers(regs);
