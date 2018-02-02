Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224tiaIN8Ssb2nVd2lCVzGUAoeVD9euU28MqlDYy7tp94kYAJI/IMf58AxIltII8p3uNqO9/
ARC-Seal: i=1; a=rsa-sha256; t=1517590838; cv=none;
        d=google.com; s=arc-20160816;
        b=n1JRwsju8Abb3fedvfM+Jodksr6pQGrJVrAd2PVXt7FJ98/H77sHRGUrlp+d3nNm0a
         hy4DHcQP9jxDtv047XL4geGn9TSZyEGFhc0qQqZdyQGpob5RIU4vbPrJ3P6oqYhwSnFu
         +EsHNePe53FLlozeLfPtnYqd+OMV2k7rp11daKaE2kVO/2KZsDopw93D+Y5BsimwnXhd
         1GuUxjvUX2KrDRiIVah0VxED9Rxpa/jL+Q8AcRh6RgAfow6H9kAtiYTpCezLHNzTQsWf
         eVlkfSWbp0XjGzvOat5UPfGvQaJpgLXNEUYDDf41sNQoxNeLic/fIforBi4lXBVoTxbt
         mc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uccpZixSY6+G46tcKeRaUk6mpW6ToZIAP7rt8cxkvmI=;
        b=NNhShFXJ17N8w8odGcZ5WSwS0JImcbsLrAs+22OSlBiozaKDhPTHp9GaBQ56fco7o0
         ZhsJJwml0xwpbqkEj93wjBqkB6/JAGy08eYlawLnUNAeGecq+fvxO+bQe6OG4+t3uRvs
         kcZf2fG240O1drs9pf8DJvjRfXPGlyCmL80tiUc+IU9Ywajs3KTUmdU215w4buzJGLS6
         yV2Jj1WVOHax1PcAJxfSh37fTVyGPkTmPOAJpcZFT1ftzb9PzfNz3qlWagynBurEmc00
         jKHWg4+byHz35RvuGvd+8IWbVt/NPmtQ+Dtro7pSWzkILsF7PQiYan0VDuT3+a1bhHBG
         JT/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+48340bb518e88849e2e3@syzkaller.appspotmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.4 09/67] bpf: fix 32-bit divide by zero
Date: Fri,  2 Feb 2018 17:57:38 +0100
Message-Id: <20180202140816.287771547@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309331274938520?=
X-GMAIL-MSGID: =?utf-8?q?1591309331274938520?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexei Starovoitov <ast@kernel.org>

[ upstream commit 68fda450a7df51cff9e5a4d4a4d9d0d5f2589153 ]

due to some JITs doing if (src_reg == 0) check in 64-bit mode
for div/mod operations mask upper 32-bits of src register
before doing the check

Fixes: 622582786c9e ("net: filter: x86: internal BPF JIT")
Fixes: 7a12b5031c6b ("sparc64: Add eBPF JIT.")
Reported-by: syzbot+48340bb518e88849e2e3@syzkaller.appspotmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |   18 ++++++++++++++++++
 net/core/filter.c     |    4 ++++
 2 files changed, 22 insertions(+)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2248,6 +2248,24 @@ static int fixup_bpf_calls(struct verifi
 	int i, cnt, delta = 0;
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
+		if (insn->code == (BPF_ALU | BPF_MOD | BPF_X) ||
+		    insn->code == (BPF_ALU | BPF_DIV | BPF_X)) {
+			/* due to JIT bugs clear upper 32-bits of src register
+			 * before div/mod operation
+			 */
+			insn_buf[0] = BPF_MOV32_REG(insn->src_reg, insn->src_reg);
+			insn_buf[1] = *insn;
+			cnt = 2;
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			continue;
+		}
+
 		if (insn->code != (BPF_JMP | BPF_CALL))
 			continue;
 
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -430,6 +430,10 @@ do_pass:
 			    convert_bpf_extensions(fp, &insn))
 				break;
 
+			if (fp->code == (BPF_ALU | BPF_DIV | BPF_X) ||
+			    fp->code == (BPF_ALU | BPF_MOD | BPF_X))
+				*insn++ = BPF_MOV32_REG(BPF_REG_X, BPF_REG_X);
+
 			*insn = BPF_RAW_INSN(fp->code, BPF_REG_A, BPF_REG_X, 0, fp->k);
 			break;
 
