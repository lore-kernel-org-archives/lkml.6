Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224Usf+vhhVaHb8yIHyCUJCiLcXDHNm0TdFhd9yMfOYABS3GWXCrf682eY6PZof7bUtIb72k
ARC-Seal: i=1; a=rsa-sha256; t=1518708513; cv=none;
        d=google.com; s=arc-20160816;
        b=CJmfIJqB0DF0h15qwMu/DBP2VI9rdsJUbzYXRr9FldGsGJkogsO1PcRPXYamZRJfMS
         dOBxM+1ggE37mPk+q+B3TOziOnJHziAUpGYq66i4W3ovhFa15TShQWhsiawLQos0SyjW
         8X+7waY6wmjMetEUNsI5rnZvdI//b3DmSF6whufT6fr3W8x0vVBM2eOjkIa4BS0QRMgP
         hRtMGiMilKQ+kxNIxdvWykly+RV+wB9CPQ9R2GN152qVrXJE+HyvqjL6X6OdKeOKDv/d
         SdpnEt8VrmI4hEknMsqJmGO3ManqbN+lqzQULaRKEbAaSAwC8GMgVPYTd4VkCPvLgTCM
         V7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LFOH/VUvHq3hG/RXTyX7nbCepzWn6NUTAv0hNbBW568=;
        b=DfCwyPvmJUiv+b4qnaihO95QE53YCdx+HxfUCpBJ/24LJkNfUJuYUKWmQNzA/8llUY
         /nKoeGCLGfim/YIT96QlE0k5Y9lVrLBoYsPsOZh7E5qI9dfM3Q0GQNrzQ5PsIxAvUAU/
         LMzGiBlA5jzvIWO8sXuG1Yhasz2vcNJnssZBBz0fU5TattVda6dnUMoRfxRD3ZnDS4ef
         tBfFcPV7pE/+AExHmdXbfTytllA7+XXkYEK8yCUzPNILwiWvLiEAnLNTf/YNZJh7T+iG
         /6v0Lh3UgluspAWmeVzv/Wsi7dfLrDFc3W+E+yWnr0ZZ9K8N9LCECfPsTRPdY03O8XNg
         Br2g==
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
Subject: [PATCH 4.9 70/88] signal/openrisc: Fix do_unaligned_access to send the proper signal
Date: Thu, 15 Feb 2018 16:17:37 +0100
Message-Id: <20180215151232.219981528@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480756245594866?=
X-GMAIL-MSGID: =?utf-8?q?1592481298095373823?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
