Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2270fIWzFB1NcY3m4Ys48KjY7CdyTFme+XnRPml21wZEr5pCSvBd6mCqapcaRLXvPFdRdbFe
ARC-Seal: i=1; a=rsa-sha256; t=1517590814; cv=none;
        d=google.com; s=arc-20160816;
        b=IbiZWS3QG5oAiP40BZ6D9g0dgl74j2YcEP3DKejUvoQMbyq2QyjcXE03ebdK6hOMBp
         juFNe3JEdfva8kZc9FavifczBqX/hnsIb7xH4aafgSxAbPsLpNp7ccikg2TvIQP+NIzn
         wt5xk9uQHp5nl4k/6KkCEL7Z6iYSNthdsdIWMQ3/6WUrdba/ulJ3xAjAhI9znFHGiPzg
         fEekwVk8jK1ASB2RuULzgS1RpAWLejo8WJ92879UXiOw6wsuSsTcHFaWf1HmQg/SEhCC
         PqB457Ybk3jjh5bHCtoLL8xef10uS7fwnXoyCJTCgNdarS/i8mblMPN/humiAid+aKGP
         Y7vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=J+GJFUFlYiSej1p6HSsK1joH9s6uRVEQ+pBGLzeRfFs=;
        b=HfbYZZrnhkg6oFWsNguZUtgCgDTuCmogXaaJtSbkEa6r/Mtwez6E2RAbS1VZaXjveE
         1WW153uxOLX9tjusVebq36v0w4SlBUYhhfdCKWFvEZduNGwJZMU5bIQhxDwwOm0hlJ5Q
         BC6u8g8+Qi0UwfQ6s7KK955s7OVlj6EHXOf5scOCT9BMZjsPNiIKUew3LUAwBaP079zE
         da3irGsYFB2IeJtGxyry/Jltr234W30YPid78JRT5yJfArFqakxBIdXCGOxAcrP1011a
         ZJCuqIBvJ1qSYY1pQ4uQlN9Mc/rRiNHkAoHZD4sBFK9i4wlg2pUc0mS3cNV1Fil2Ynjb
         H9iA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liran Alon <liran.alon@oracle.com>,
	Nikita Leshenko <nikita.leshchenko@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Wanpeng Li <wanpeng.li@hotmail.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 22/67] KVM: x86: Dont re-execute instruction when not passing CR2 value
Date: Fri,  2 Feb 2018 17:57:51 +0100
Message-Id: <20180202140817.809899333@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309306306746799?=
X-GMAIL-MSGID: =?utf-8?q?1591309306306746799?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liran Alon <liran.alon@oracle.com>


[ Upstream commit 9b8ae63798cb97e785a667ff27e43fa6220cb734 ]

In case of instruction-decode failure or emulation failure,
x86_emulate_instruction() will call reexecute_instruction() which will
attempt to use the cr2 value passed to x86_emulate_instruction().
However, when x86_emulate_instruction() is called from
emulate_instruction(), cr2 is not passed (passed as 0) and therefore
it doesn't make sense to execute reexecute_instruction() logic at all.

Fixes: 51d8b66199e9 ("KVM: cleanup emulate_instruction")

Signed-off-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Wanpeng Li <wanpeng.li@hotmail.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/kvm_host.h |    3 ++-
 arch/x86/kvm/vmx.c              |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -998,7 +998,8 @@ int x86_emulate_instruction(struct kvm_v
 static inline int emulate_instruction(struct kvm_vcpu *vcpu,
 			int emulation_type)
 {
-	return x86_emulate_instruction(vcpu, 0, emulation_type, NULL, 0);
+	return x86_emulate_instruction(vcpu, 0,
+			emulation_type | EMULTYPE_NO_REEXECUTE, NULL, 0);
 }
 
 void kvm_enable_efer_bits(u64);
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -6023,7 +6023,7 @@ static int handle_invalid_guest_state(st
 		if (test_bit(KVM_REQ_EVENT, &vcpu->requests))
 			return 1;
 
-		err = emulate_instruction(vcpu, EMULTYPE_NO_REEXECUTE);
+		err = emulate_instruction(vcpu, 0);
 
 		if (err == EMULATE_USER_EXIT) {
 			++vcpu->stat.mmio_exits;
