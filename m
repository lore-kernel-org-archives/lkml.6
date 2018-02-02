Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226WVZAwDA9A3oUuKJFUpKahRLAaAe6vySJI4RHqqxkYze+Ip0S6Rvx7Ngv8jsd5Br6s2UMe
ARC-Seal: i=1; a=rsa-sha256; t=1517591420; cv=none;
        d=google.com; s=arc-20160816;
        b=GJ4iB/XZ4nQenU6ZimLkkHNPUzRNmRXzHHJd3v5ymFYscqBHvVG11SxnPucrFeF+4w
         OB8XoNP4w9kX9kjiOYWWCrLOyEQ4RqPBJbNJ92OQCoUVfnPQw5JtzkDMT4zW5/UX8rY1
         XJ6YMQ3IivUrAAt7csma1Ap9Oc5z3QXH2317a+KPlzrLi+EYMrQg3hS9yjlIOq8W8Ld7
         A/tcnhRa+Q3YeixiGQvQkTVnXAwc7IEMjxW9k5t4rstuv4vs5KqRctLCJPwRx0npxg1T
         dY+Nunk0VESt70HCMJO8HkCyC0EbderSbl0x/c0RxIhS5zzcbkmaL7xIsOzyb7zxMAbZ
         kzJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WkyjsMG9bCJaGEl5P0Mh44sZccvPaOV78bqUuFs4KKk=;
        b=DTDmMf7VV5P0rze4ukeuNUc7H92f5YjEuAtkJLBO1YFul2ClIIU+4/7t8h99SCJSYC
         jsHo/4sHy2HUj/Uy2MYa7XI0xyc+aLSQLWifpPn3F/hEfW5GHskvckuUVYQgmRFg2RjE
         tqHsKMcWafTuJrqsWxnXzoX4P5J08nqtUydjWmDx2wipifiXI/6DHMpDlvm2CNWUiLQQ
         4CH85HUf8ZI6IhkX8p3ZagQn3x4JGqjnS5P8cgerFs2bd08JVwtehWNdDew+ITpNq1KV
         iAVs1PhqlM3IPJjb55HXFxswJudtxK8imbuZCqJ2nGifraFCLwo5eCGd+0ZdDYyx5RN8
         h4Bw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pedro Fonseca <pfonseca@cs.washington.edu>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Wanpeng Li <wanpeng.li@hotmail.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 039/156] KVM: X86: Fix operand/address-size during instruction decoding
Date: Fri,  2 Feb 2018 17:57:00 +0100
Message-Id: <20180202140842.061130251@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309309879638297?=
X-GMAIL-MSGID: =?utf-8?q?1591309941032560134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wanpeng Li <wanpeng.li@hotmail.com>


[ Upstream commit 3853be2603191829b442b64dac6ae8ba0c027bf9 ]

Pedro reported:
  During tests that we conducted on KVM, we noticed that executing a "PUSH %ES"
  instruction under KVM produces different results on both memory and the SP
  register depending on whether EPT support is enabled. With EPT the SP is
  reduced by 4 bytes (and the written value is 0-padded) but without EPT support
  it is only reduced by 2 bytes. The difference can be observed when the CS.DB
  field is 1 (32-bit) but not when it's 0 (16-bit).

The internal segment descriptor cache exist even in real/vm8096 mode. The CS.D
also should be respected instead of just default operand/address-size/66H
prefix/67H prefix during instruction decoding. This patch fixes it by also
adjusting operand/address-size according to CS.D.

Reported-by: Pedro Fonseca <pfonseca@cs.washington.edu>
Tested-by: Pedro Fonseca <pfonseca@cs.washington.edu>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Pedro Fonseca <pfonseca@cs.washington.edu>
Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/emulate.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -5009,6 +5009,8 @@ int x86_decode_insn(struct x86_emulate_c
 	bool op_prefix = false;
 	bool has_seg_override = false;
 	struct opcode opcode;
+	u16 dummy;
+	struct desc_struct desc;
 
 	ctxt->memop.type = OP_NONE;
 	ctxt->memopp = NULL;
@@ -5027,6 +5029,11 @@ int x86_decode_insn(struct x86_emulate_c
 	switch (mode) {
 	case X86EMUL_MODE_REAL:
 	case X86EMUL_MODE_VM86:
+		def_op_bytes = def_ad_bytes = 2;
+		ctxt->ops->get_segment(ctxt, &dummy, &desc, NULL, VCPU_SREG_CS);
+		if (desc.d)
+			def_op_bytes = def_ad_bytes = 4;
+		break;
 	case X86EMUL_MODE_PROT16:
 		def_op_bytes = def_ad_bytes = 2;
 		break;
