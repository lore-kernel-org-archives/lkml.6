Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx484ag5835nEA7MuwYCBSo+ufltgWMZ7GkT64OMC1INI6UDf2rL9edIwXZogR9BN2Hd1qZOZ
ARC-Seal: i=1; a=rsa-sha256; t=1523472572; cv=none;
        d=google.com; s=arc-20160816;
        b=T8JlG/74A2tbxX4IJ8XfPN/vPLaEi4xXfDRHjPaVnOfBOq5b14aC2ckrwQlANeZWUl
         v3tJJVYWAy96leoRjXx+RUimh7W2G708QudoaAh611eXP4OXvDC9KuYQFYXUNN7j6ZdH
         HnIC/9+AIJLrrGbZJzLeeiRjzXOery1l1Lr81VRRBosh8F3pTyA0dawAdrEdqkLfVx8m
         8e+O4WSjznUIP7CK0TL3aKDNPd9Yyaj4kMteX89q4eCvCpiyhbf3NBsmTaattraoM4rx
         7l6GTMgSgX9pUBv0wOtxdqm4GQfmKb1in7e70L26wPTMFGebcOs4owGEP3Rkef0mVAl4
         fb2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=87uKH10EsT4tIhygA9nk+iX320mgZNZb3zIMAIFGiOU=;
        b=M33OMJQMDWCvSC/50jqtZee3/Mb6GKJW5S/EWzgupQVcwMX0xFQ5ai3MxlonEsaCGm
         /jFFWlNK+y/Mby+/y9y2quRomUXzKaJi0zbVdHuQ2EZY9SoMu7plBmtTX4/mImYy4GD5
         QD/iB2hGdrjxRlWt64Aa5D4h/XO9OLoXNCrC5oaewP1Nm2GKwWZo/dAS4RWWsZVXqoH2
         pci0AHEHEr1h/kaClmnea+SKq4/KUo2t0kiFyF7lgKY7N0kJ+ZEOuZJBYezqXp0XTU7A
         SvFOvG/pV7pBsfxQel5Wd/HRQ939JzBxyEGaoUDGwdmYBHL7pQaAenW0f58DShQNXcy+
         2Vng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
	linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 133/190] MIPS: kprobes: flush_insn_slot should flush only if probe initialised
Date: Wed, 11 Apr 2018 20:36:19 +0200
Message-Id: <20180411183600.156863716@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476260596132380?=
X-GMAIL-MSGID: =?utf-8?q?1597476777090097525?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>


[ Upstream commit 698b851073ddf5a894910d63ca04605e0473414e ]

When ftrace is used with kprobes, it is possible for a kprobe to contain
an invalid location (ie. only initialised to 0 and not to a specific
location in the code). Trying to perform a cache flush on such location
leads to a crash r4k_flush_icache_range().

Fixes: c1bf207d6ee1 ("MIPS: kprobe: Add support.")
Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16296/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/kprobes.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/mips/include/asm/kprobes.h
+++ b/arch/mips/include/asm/kprobes.h
@@ -40,7 +40,8 @@ typedef union mips_instruction kprobe_op
 
 #define flush_insn_slot(p)						\
 do {									\
-	flush_icache_range((unsigned long)p->addr,			\
+	if (p->addr)							\
+		flush_icache_range((unsigned long)p->addr,		\
 			   (unsigned long)p->addr +			\
 			   (MAX_INSN_SIZE * sizeof(kprobe_opcode_t)));	\
 } while (0)
