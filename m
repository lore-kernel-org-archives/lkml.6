Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AB8JxZpWv1YatCGWnobw2jtjJP/8Q0gcZyXfeY0wpQZMCwmW9svnXpYx1jaDds8tKJUSP9BJscy3
ARC-Seal: i=1; a=rsa-sha256; t=1524652717; cv=none;
        d=google.com; s=arc-20160816;
        b=rbI6wuVr3FoUhnaSCjIDy24FK/hN0dKezjWtiwDjx+KaMjWHGoRXDuwHVhzzwQC/6a
         aqYpztz0lWx1UcN16IuxCw8qW2biEacI32k8HRkrhN3RJtGA/bYijFdyn084CREeNheQ
         UzYV5b/xwHolO1TA9V6D9DpsXuRyWlxL4/sOWBTmDG7+ZWfXm+/fb5VjsuL7dsLkwGLR
         mG6eCgtFakz8evu1Ae0ipfs0ZMOdhjXFS3HrGNfqr1q3/8yo+KaQF3svN4DEbSHRDlhC
         5htBMD7WLt6LdB+SF36CDMItfikLgnZcz8Cgbs1+YGZablrTB0F12nxor7xPEKhDbtkA
         91Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eCxL120O73QzCIa2TQm5EgZwGNHkPVLpTUs0t8Mw9P4=;
        b=k+JYz3UNysyrmQnevie9HV/WDV5GnaHhWZA5I6P/u+Pq8cRc3Nv6pBzCNfxkKidb4X
         iKD3gCNS8tQmhd0N0KtetOn/n19jkCAVoCf5VOvVJuCExrmWhVgBgonJXP/1y0S2EXXj
         xp3YkozFvkzfJLhTkU47KnP0QKMGgKLzpZyenlc9USSOS5ZYl7/VdM2qSudAqxtsulc3
         plprOfVcePc3P9X9CPHUnOjCeju1PD6I34WfPCsoDqIszEjO/tv+JjnAZJ8fwzOCuGNm
         3U9WUG5R6vzsJSX3PReiWplgcDpisxl3Vb0x1Va17+15+fKjNXvPN3qEcmoAF4PZY7Qq
         UJUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 044/183] powerpc: System reset avoid interleaving oops using die synchronisation
Date: Wed, 25 Apr 2018 12:34:24 +0200
Message-Id: <20180425103244.337739538@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714247748141841?=
X-GMAIL-MSGID: =?utf-8?q?1598714247748141841?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>


[ Upstream commit 4552d128c26e0f0f27a5bd2fadc24092b8f6c1d7 ]

The die() oops path contains a serializing lock to prevent oops
messages from being interleaved. In the case of a system reset
initiated oops (e.g., qemu nmi command), __die was being called
which lacks that synchronisation and oops reports could be
interleaved across CPUs.

A recent patch 4388c9b3a6ee7 ("powerpc: Do not send system reset
request through the oops path") changed this to __die to avoid
the debugger() call, but there is no real harm to calling it twice
if the first time fell through. So go back to using die() here.
This was observed to fix the problem.

Fixes: 4388c9b3a6ee7 ("powerpc: Do not send system reset request through the oops path")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/traps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -336,7 +336,7 @@ void system_reset_exception(struct pt_re
 	 * No debugger or crash dump registered, print logs then
 	 * panic.
 	 */
-	__die("System Reset", regs, SIGABRT);
+	die("System Reset", regs, SIGABRT);
 
 	mdelay(2*MSEC_PER_SEC); /* Wait a little while for others to print */
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
