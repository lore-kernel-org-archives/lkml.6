Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226TfqMeJoIuQZzzm+zOdi/JUjDU+aMjzZ23o7vKTvhFdDh59uk2ExrU3PwBDbg4f137EWgZ
ARC-Seal: i=1; a=rsa-sha256; t=1517591011; cv=none;
        d=google.com; s=arc-20160816;
        b=C0pX74SizLT4/QLu1b9On4zarD+fKfzMTHJzcxnpmAruJ0BusNFW1+aCWyNfOnPr5h
         M37MTQUXOL6HPWFC7Exjb40hpWawU7t+EBDgqrHFCUdHmgFgdQ6p+VmrtMJRDRpT7Uqr
         BHwwUUAjgtYoP1g8pVNkpOvJi7iNi7V03az7LwFQmjtYp2CNWnEtZJ0fSe2OueRgsayb
         jqg3YHdg7nAyQWDwf46UrvscVMVzSYSg+wpbdeNyBLOgxS4YcAQgVughfsCG6usR0puo
         WwxtIZaWQZD2vzYG/NE12IhSyyVShFDr9fTyTiql2/T9oj/6VyYzYlRLSh25RZZdI/9P
         mT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JQknGv75E+CPWwz0sCAD+2jk2NNafuoE92G91a7FEzE=;
        b=077+luSiNS5CooBHxT2d6WRyCToQZWn6eXvjbfuDIacej1hghGZ+3UH0AdoMspta0r
         rnFozZcNZjWNHdnazmM9dFLicr8pzYoO1qtElOhMzp/4jYtaVSTJbCsAlBN7kBtftXr/
         8kP0UIVW16MfW3ZGtepuVlLXeH4FZ2Kt4IyZi1rJ85/fJ+h6l0mR9CjP31y3rKoLXdv4
         pYhCQy6IagbIWgQ/lWtLQwjbPEsR+/akG3MdTvt8UtzvbTase1CLg6m7WUpW4itYCbM0
         h9i93kUo5E1K3cMCQcxQ2gw0mH6H19QZSi711k0PzxSDZuPE2uZ0SK3BQBf/ftWePnks
         HQ6g==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 22/86] KVM: X86: Fix operand/address-size during instruction decoding
Date: Fri,  2 Feb 2018 17:57:42 +0100
Message-Id: <20180202140824.743794349@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309309879638297?=
X-GMAIL-MSGID: =?utf-8?q?1591309511910518492?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4990,6 +4990,8 @@ int x86_decode_insn(struct x86_emulate_c
 	bool op_prefix = false;
 	bool has_seg_override = false;
 	struct opcode opcode;
+	u16 dummy;
+	struct desc_struct desc;
 
 	ctxt->memop.type = OP_NONE;
 	ctxt->memopp = NULL;
@@ -5008,6 +5010,11 @@ int x86_decode_insn(struct x86_emulate_c
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
