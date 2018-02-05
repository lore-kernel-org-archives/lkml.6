Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227kL+QxHDrytab3MyP9Bsf7wUFrz6rkUrWlxSNmu95xqBRuuItMxoB7QdD175d/m03U8QtN
ARC-Seal: i=1; a=rsa-sha256; t=1517855173; cv=none;
        d=google.com; s=arc-20160816;
        b=mSdxOh5a4VCkamyaHGONhP/IbPKsAROEQDVL5dDlkAjEI5hBRYpFvOozQOa6X41sn6
         9D8qcS548iDAriPytAl1TMJ0Mie0mgdKgWZ+/RvWQkoQEknAL22G0wInYz6auGKCUiR7
         DijnoFEcNrx9GQHKoYG1TocgWioORJr0T6HwsWiupRp86jRbo0CCoU7A3necEHWEpVfm
         wnmntA0Asmu3Wbg4zCA+7+j1tg3QsGUow8KQzD2xHFkm+k4PuUC6fPkqxZVrqEyjQ+eD
         /T8OM44v2hppheVy6JqTUevS2/I2VVzn0ZWO78wMzn9ku7QDb9EJHxV4gOS+vLhqHfEk
         JmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pQXcFFHeBGVGJM5cnXmUW7Ke00Z9FmHZiG19j0jRK2A=;
        b=iDsKtFMkJvUvDN3Ym30ll1sRLZHrCtSfSOtP0+vRDTz9HXBxOIExgt2yO+OgS24rtx
         ke9EH3CTFwYtA9VBtMNPp3U2oSOB+kUPBYg0PJWLVbcoV5qEl57tuzz4EsxGFHeAAIeC
         sco6eR+gDvvvMRL0t6hYZ79lVL41QLx6tls9rwmbBv/wrbJz0NJ1hS4cyRoqSl+xTJAh
         f1SK/ZYwOsh/FxbZORvWS25R6Lhsq5TAmVH/dWjxdfI3CmYRcwSfwFUh781EwCbGQWM6
         I9VL+30H+zX0mAKbtNg8ZxfC3Si0KbRjYaoItQ7qwUk20zq8clCl9u0hl+Nn6K/o5qPS
         3myQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pedro Fonseca <pfonseca@cs.washington.edu>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Wanpeng Li <wanpeng.li@hotmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 11/36] KVM: X86: Fix operand/address-size during instruction decoding
Date: Mon,  5 Feb 2018 10:23:39 -0800
Message-Id: <20180205182352.238366763@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586506012255573?=
X-GMAIL-MSGID: =?utf-8?q?1591586506012255573?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/emulate.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -4385,6 +4385,8 @@ int x86_decode_insn(struct x86_emulate_c
 	bool op_prefix = false;
 	bool has_seg_override = false;
 	struct opcode opcode;
+	u16 dummy;
+	struct desc_struct desc;
 
 	ctxt->memop.type = OP_NONE;
 	ctxt->memopp = NULL;
@@ -4403,6 +4405,11 @@ int x86_decode_insn(struct x86_emulate_c
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
