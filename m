Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226UcGAX4k3hiK8TcCph2y61FiKm1i56elh0bq2CcoSup1GJuQcAJFs8LLO6JVTyp+6NhzQ3
ARC-Seal: i=1; a=rsa-sha256; t=1518709194; cv=none;
        d=google.com; s=arc-20160816;
        b=LKPKzh9KtnCNE1Ll0+u90YkqMa+zefsUyL00IzNakoI8hLqGvWbfE/g5j4stBnl18Q
         rygatV6l8GWJOPO5Vpvl5uLOOQJAxzCTWJcZKIYloWYZofmawfJ5RFwN8xm5y6YxYDhM
         D1TD6B+M0VPDpYmv0gai/Nc7e0MSMUAS2Qh5isJk0RSnZCMBJQ8owbFA6QiPqQLatPbT
         3IR4PbZy2ac74pQjRoju3cLNV08Hl9oAOaK67iq3dHmd8X4wCZwfrduJp1JEt+MldEHI
         qe94ypiymqMSiioDlszUseNsw3NNdi4D4ksj7O85qsvcrLc5MuQ5tFeJ5YaObSe7jix5
         Okqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=h8eM+qBH6hjecTi/tMLOUAYmMJJFuMKvjKjpnRKxcIk=;
        b=zkTDuglK9wXi/XnPsx0ameFwkF/25Ki2pctZK54kUuPz4cZp9PNepkgGVveBamBrcB
         7kSZ98QMCox2KGSYLGzZLTiq3pDao5pq189brsNomYq+SVKGTr3im1RAY49s9ukOSER4
         ixfYl3tuwPIlij7TT4HuPRrCW215TTWOEbnmLGmMyxj03liBrzX0Ae1TOuleGK/FankF
         t3W4PP+wZvWg5MikORxYrdsKZtXxiBHQqWaqH44yun/SpiZYoAlD/Yks1b+utlNHSvEP
         EsQI81k8FjOa+xtDgEoF09ib813g0PH1Jza7sG+TENC8WKwAie/vaMl67eHu4T7qHHy5
         nwEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 030/202] [Variant 3/Meltdown] arm64: tls: Avoid unconditional zeroing of tpidrro_el0 for native tasks
Date: Thu, 15 Feb 2018 16:15:30 +0100
Message-Id: <20180215151714.545675915@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481468965479077?=
X-GMAIL-MSGID: =?utf-8?q?1592482012325593744?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 18011eac28c7 upstream.

When unmapping the kernel at EL0, we use tpidrro_el0 as a scratch register
during exception entry from native tasks and subsequently zero it in
the kernel_ventry macro. We can therefore avoid zeroing tpidrro_el0
in the context-switch path for native tasks using the entry trampoline.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/process.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -370,16 +370,14 @@ void tls_preserve_current_state(void)
 
 static void tls_thread_switch(struct task_struct *next)
 {
-	unsigned long tpidr, tpidrro;
-
 	tls_preserve_current_state();
 
-	tpidr = *task_user_tls(next);
-	tpidrro = is_compat_thread(task_thread_info(next)) ?
-		  next->thread.tp_value : 0;
+	if (is_compat_thread(task_thread_info(next)))
+		write_sysreg(next->thread.tp_value, tpidrro_el0);
+	else if (!arm64_kernel_unmapped_at_el0())
+		write_sysreg(0, tpidrro_el0);
 
-	write_sysreg(tpidr, tpidr_el0);
-	write_sysreg(tpidrro, tpidrro_el0);
+	write_sysreg(*task_user_tls(next), tpidr_el0);
 }
 
 /* Restore the UAO state depending on next's addr_limit */
