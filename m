Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49HD7mHma6q8uo37HO6hJeOsIq/KTzXPDiLzcEpOWZivPPTp/I097U0L++aUijWWIoFJ1g9
ARC-Seal: i=1; a=rsa-sha256; t=1522168999; cv=none;
        d=google.com; s=arc-20160816;
        b=LXbbRWR/AXn+M72agdxA1Bmi9qDFtvACKSDmI8oda7tzKsAikC3CnhSrAgVvrVif/T
         aGcT5EnkHooigyXH73+Bw3Putv8ZwYPV1DMqX5I3Sl72FHZ9QA6bOJvpgvbykxQmrec2
         1N+bn1mpU5kT9XO06ZM9symHbsGt/KxOp5WNKF/1+4z6egtuz13dnSLLcS6j/f6PrxOD
         vZ9Reh6mUARxUQrqDbjePezJz+pRl0YUwDl7TZWp23sa7Y1a7tjNcTvdza/UV2elqgN9
         mgfSLi2YmQCi9uwzE8PojZCgHaEfbC6Bp/q8fXJUNnNCKEpPM25VTzEB9RIMk1hClExo
         P/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pblzqvEv6I9XAkNZ2QGf9imguNx+ipBH8x2H/wANHn4=;
        b=Lyq/HRedDU+Ou/wgEXa2jN/ReedOg4TRdMC9anz631h+WgmscyQXBifb/pkirV6eRD
         fJBlXeXkdyMTAxgRl/CceVM/H4DSbm6/NsxrNt48I5SAQs0sWCcVwDRyVN8iicvA2NQT
         2ydTD7k+8Dbry9uTdnrlxG6sU9KxoXgNtwqscJQlDNnwm9nANxbLpEa747n7tRvPt7vZ
         ogsXYXrqQY7UObf6UpbGyXlAZBLPWV54VtPhx8H71FcH/PSweAAcyj2SKe1PMvmgY2CR
         tYN68NmX2RA3v0vU+o9GbZrL9QsKx3fea22iNZk5ASugTg6l5SSpPsiBHxOzhIqLG42Z
         X6uw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH 4.15 105/105] bpf, x64: increase number of passes
Date: Tue, 27 Mar 2018 18:28:25 +0200
Message-Id: <20180327162804.286886754@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109079875177032?=
X-GMAIL-MSGID: =?utf-8?q?1596109881362267132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

commit 6007b080d2e2adb7af22bf29165f0594ea12b34c upstream.

In Cilium some of the main programs we run today are hitting 9 passes
on x64's JIT compiler, and we've had cases already where we surpassed
the limit where the JIT then punts the program to the interpreter
instead, leading to insertion failures due to CONFIG_BPF_JIT_ALWAYS_ON
or insertion failures due to the prog array owner being JITed but the
program to insert not (both must have the same JITed/non-JITed property).

One concrete case the program image shrunk from 12,767 bytes down to
10,288 bytes where the image converged after 16 steps. I've measured
that this took 340us in the JIT until it converges on my i7-6600U. Thus,
increase the original limit we had from day one where the JIT covered
cBPF only back then before we run into the case (as similar with the
complexity limit) where we trip over this and hit program rejections.
Also add a cond_resched() into the compilation loop, the JIT process
runs without any locks and may sleep anyway.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/net/bpf_jit_comp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1156,7 +1156,7 @@ struct bpf_prog *bpf_int_jit_compile(str
 	 * may converge on the last pass. In such case do one more
 	 * pass to emit the final image
 	 */
-	for (pass = 0; pass < 10 || image; pass++) {
+	for (pass = 0; pass < 20 || image; pass++) {
 		proglen = do_jit(prog, addrs, image, oldproglen, &ctx);
 		if (proglen <= 0) {
 			image = NULL;
@@ -1183,6 +1183,7 @@ struct bpf_prog *bpf_int_jit_compile(str
 			}
 		}
 		oldproglen = proglen;
+		cond_resched();
 	}
 
 	if (bpf_jit_enable > 1)
