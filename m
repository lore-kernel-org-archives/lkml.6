Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226pRQVjsUph+QLzze1ApcvGALLjTdW+ATJnua/QnJoh/26bEAPpaIDULuscd/EBQl8xt+L3
ARC-Seal: i=1; a=rsa-sha256; t=1517590835; cv=none;
        d=google.com; s=arc-20160816;
        b=q6hi27SgW5Kij4CdyEw6SiAOXsRhaPYw15OmG/pbLI7hETmqd3QvxX10DME5gsU8uj
         InXR2SMjuAPrF1OHQFrJ3Y8NGqLrwYwGXocR9SGKlaNYFiPVNlL6L5D0EFn1NHTLn3qF
         FY+FlAHW0p87iWP6S/q/VNeS6FB7Lwe0EgjF1LMoCukUVPNBvZZhlOmZXhg/oYdSxETJ
         tn8SxIgGF77yAfQluZChyBp48givGAA1vZ4oAvc0HfY0fLN6wysIYQ4VM1wNm8ww9ber
         IgHBBjAbzUicMZp98/D9IrLdSml32PoQrZAPhQ/svuTn7j/u5kth9uztx2msec8bcZe6
         /qyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Q2FByB1aZYpufaiPMkAOslNlp9oYvA5ABW5k8Gzi3aE=;
        b=MVBwmZLBJ6HjGLnA/Hnjz6zelXpHOL4tvagRz0Y4YLpnywfQyYbX4qdM8AI0NYb0BZ
         v57mwTlH8lpN7Xbl0y5zZMsEKFEfS2xAFG3Yn7ZZ6BKI8TK5Lp+Op5wMdQpJlFlEcE/D
         t76VxjszHB5xTZN8qqlBwBYqi63nZPL/YJKj+neo/R/Ha1LwHrENDcxFK5bu7AfBIRMS
         wdD6VkbcGpbFW2DYf9bx7N/SG7AyXc9+ArX6N+OgUekeJX9GtflXFN1wIaEqNo8Yhvcm
         q2WtdQXFxhubzBGvRyj4/G680h0mJOE2I21jakWwgSTYAo7mU+6GKJm5xNSMda/wi09u
         FA5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"ast@kernel.org, daniel@iogearbox.net, stable@vger.kernel.org, Eric Dumazet" <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH 4.4 08/67] bpf: fix divides by zero
Date: Fri,  2 Feb 2018 17:57:37 +0100
Message-Id: <20180202140816.159023846@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309328138704672?=
X-GMAIL-MSGID: =?utf-8?q?1591309328138704672?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ upstream commit c366287ebd698ef5e3de300d90cd62ee9ee7373e ]

Divides by zero are not nice, lets avoid them if possible.

Also do_div() seems not needed when dealing with 32bit operands,
but this seems a minor detail.

Fixes: bd4cf0ed331a ("net: filter: rework/optimize internal BPF interpreter's instruction set")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -444,7 +444,7 @@ select_insn:
 		DST = tmp;
 		CONT;
 	ALU_MOD_X:
-		if (unlikely(SRC == 0))
+		if (unlikely((u32)SRC == 0))
 			return 0;
 		tmp = (u32) DST;
 		DST = do_div(tmp, (u32) SRC);
@@ -463,7 +463,7 @@ select_insn:
 		DST = div64_u64(DST, SRC);
 		CONT;
 	ALU_DIV_X:
-		if (unlikely(SRC == 0))
+		if (unlikely((u32)SRC == 0))
 			return 0;
 		tmp = (u32) DST;
 		do_div(tmp, (u32) SRC);
