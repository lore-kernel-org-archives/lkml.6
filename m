Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224JPYnW9GySGyrligMWhcUDMmWDuRt228hPxWfD3gE5kcqRAumKEY4iBlIdsNyv+DIZA6ui
ARC-Seal: i=1; a=rsa-sha256; t=1517590829; cv=none;
        d=google.com; s=arc-20160816;
        b=fgP+3NhspwhzO1ScCbIkkr5rw0vBIvZWoWyZVMzG+I0ejhqXyIURssLCK8Tez7oH20
         Ytqix94HmTAO1PtuqHS998EWXlpiJN61buiKTKpM0n2dyEwIG7zYnvfL8TnNyDKfP3Yi
         Mgv8jEV5azzcUMHIFIBxpuvvsYyOi0a8RD6YwrCdJ2R5BGZW+NCOLCQaJZ3vzDOxwDmH
         EADEIlvw13ZG+N+CE72Ncd2x9hTiT3+z05+MtrPStaAs+x9AOlS9FCfv6qjLGDdPJusd
         hfq9RYqyXummq5pUerRH4dxdH9M63urYQs/GOiULG61DbgoJvvuXNe9nWd3PypslgXaR
         ENJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yHisiwJ+MPmHw6qRVU1O1OS6WGQeAjtniLfyc6OaE6M=;
        b=csTR06aSCVqJQp9BnSsv4I98CvgGQwPuiLtKDKQzMRWLtc3YwFidQ8UB3I0W6Ey/ZM
         /HCqrfb30yBKVLmh3ZANXD+/2/FcALVJqESmPE0y2t6Q8rfpDQl6CcROIiswRH90Lii8
         fOBV03uxlnxT0XN5bkJthevlnoHgFbMpTyXolIusD+GDjR+SGClNUUQayPGOpA/5sF7N
         Di+l743uZ0piTCbn2OEouDnlpdZ9wFb23HpSs3XWePHIZ0BF0pRPluWAyX+Wj54hI/vA
         1vv1JKDBCdNIMMZGZi8+7CssnrwyL+zKa0V7jvKiO7CAqHCrVtVsbsBw1H6FRWi8rSS/
         JPEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+93c4904c5c70348a6890@syzkaller.appspotmail.com,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 4.4 06/67] bpf: arsh is not supported in 32 bit alu thus reject it
Date: Fri,  2 Feb 2018 17:57:35 +0100
Message-Id: <20180202140815.955954801@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309322223364612?=
X-GMAIL-MSGID: =?utf-8?q?1591309322223364612?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ upstream commit 7891a87efc7116590eaba57acc3c422487802c6f ]

The following snippet was throwing an 'unknown opcode cc' warning
in BPF interpreter:

  0: (18) r0 = 0x0
  2: (7b) *(u64 *)(r10 -16) = r0
  3: (cc) (u32) r0 s>>= (u32) r0
  4: (95) exit

Although a number of JITs do support BPF_ALU | BPF_ARSH | BPF_{K,X}
generation, not all of them do and interpreter does neither. We can
leave existing ones and implement it later in bpf-next for the
remaining ones, but reject this properly in verifier for the time
being.

Fixes: 17a5267067f3 ("bpf: verifier (add verifier core)")
Reported-by: syzbot+93c4904c5c70348a6890@syzkaller.appspotmail.com
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1165,6 +1165,11 @@ static int check_alu_op(struct verifier_
 			return -EINVAL;
 		}
 
+		if (opcode == BPF_ARSH && BPF_CLASS(insn->code) != BPF_ALU64) {
+			verbose("BPF_ARSH not supported for 32 bit ALU\n");
+			return -EINVAL;
+		}
+
 		if ((opcode == BPF_LSH || opcode == BPF_RSH ||
 		     opcode == BPF_ARSH) && BPF_SRC(insn->code) == BPF_K) {
 			int size = BPF_CLASS(insn->code) == BPF_ALU64 ? 64 : 32;
