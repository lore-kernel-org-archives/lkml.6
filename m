Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226b1vmHgoz/3FSLJQMjFXZpj/jpi20dInoUExyq7hXNDJKbfaO1K/xZ68/HG/fEyVkzcAKh
ARC-Seal: i=1; a=rsa-sha256; t=1518707996; cv=none;
        d=google.com; s=arc-20160816;
        b=CxVWhIeEzwDZkiEJ37fNlg1CKc1nAePWRMl3oL7dzxNL85qHzA01LSGGEQ2mkdjuYQ
         04y95S4VqSM1VeAv8a/Od5eddMhs9lyDDUHoQJ2CNXuMFsssU1FQ6XLYcq27QDczEZbX
         hlbCfTX643HV8bSMTte0gItJTCo3o3GFGwJ4UwslIUtWObtk8NYXK5Dxl99Gm+YpaKOD
         zhji9kn8aFBuYH9HT/mLkOpVpz8iOxQ/rpnFdfwym6zZ6nRrqHZxYiNbEA0DcqzkkeNB
         5WcG/jT875/Kz0+aevGT/m/USQUHbzd3JOfhFmVtL4SZ+QRwMyq5mwwSKw9SBY2U3TUH
         UlRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hlt82rXkGXrpfSLO0nsObN6aK9B6HBXiKDrAmlVL2R0=;
        b=R3Mwo5mIBQ0DVQIlHF4JRA8f5TARcAsQpxQbCHOlfx+31vSR0tIH8pddRD3yU4FHvt
         3izwqTw/m12WaQcZOfJKEUMUXvbR51K/Ok/FShpn668TUlcT/9uClCHM43sCltBBiC/5
         kiD/JEehxZ2+wWFc+b+mJk01up1G7qwcRsxB6vx2jsn5Mb7JuNDB0gFUAzs/ksbl3hS1
         lygMMxliRX0PtST9Pqums+1jqX7t7Vlqc2pQRYLuRAZrm3IQ293eloOdsQ3VtNY8+ja/
         4mKNj0jizCHCSdBl+gY3RcOJfrAu7aLlZzm9qBM/Imwra8XSxGXOAsdRFdrDEKkl7gQL
         ydLw==
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
Subject: [PATCH 3.18 37/45] signal/openrisc: Fix do_unaligned_access to send the proper signal
Date: Thu, 15 Feb 2018 16:17:28 +0100
Message-Id: <20180215144123.809884631@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480756245594866?=
X-GMAIL-MSGID: =?utf-8?q?1592480756245594866?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -302,12 +302,12 @@ asmlinkage void do_unaligned_access(stru
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
