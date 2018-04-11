Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+XF3HXH2JeyLK9G2MPG/WuyIA0BbSPDzssGd+Bkqh/UfqJ4A7SAHvpopOKe/FHapFH96L0
ARC-Seal: i=1; a=rsa-sha256; t=1523473359; cv=none;
        d=google.com; s=arc-20160816;
        b=bFlk92K/RNxArqPF/9Jq1wEFyhP0b0PQyLGXzL2iahM2OJCB9yXP97SuTrl3T9L4Fu
         lTwx+9YOm4iwBhctFFy8ldtx7AS8/S4k1PbB4ON+ApMPGV2tT/+hT9LbgkxJgDaL9PQj
         dIUxUC+gBixkYbp65f5NlmzhfKeVUT/XEFM9+y3JLlF/ajzuDmcp0YUV9jZQwL8/Mvg3
         4MkuM/U1sBl19DxY8gHLIBk5MtTk92tMjwLB87cnHGzPV/qZnuidQQivixgSa/FmrUgO
         L0j9qqtOpB7TSZ5gMEwLM3XW69g0cqYQUZ+YUIX2AsLo3GbldcTD0bzpRMF4zpaVyP58
         O94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SUj5NZ6HG/IyVxE46WEEC9AMDTCpznZramJeCHqfIbA=;
        b=czukGn4O4jQESw+aCVjvRYWnFc9ennneyAmLtMyuyXi3M+qCVo1yg7NrMKQ7cnOcrp
         rl0r17o9JYtwRxEDQ1Umeu+QUTLT3S44WWfujY17ZatYqk87fkUTpCWaojniU8r9GWMO
         kfTq0+LntIC3yokmN44d4nYzTZ23xvCy6Sp2FG8uBTUoaPbfjrI1CUTDf69YPlYdir5u
         Gs1w2lEQDK8vj/OHu8cYZcqknecf7fhekYV7TPZyeJlN1LALfuv75PyhR9BbWUbqNKRy
         3QPbbfGH7n6g19PSK7fVgo44sJy3kcuH+KCoLJLuX0YnbeJPSdHptDz2nN2XRDXH2xPP
         UpdQ==
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
Subject: [PATCH 4.9 220/310] MIPS: kprobes: flush_insn_slot should flush only if probe initialised
Date: Wed, 11 Apr 2018 20:35:59 +0200
Message-Id: <20180411183632.010909466@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476260596132380?=
X-GMAIL-MSGID: =?utf-8?q?1597477601664878968?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
