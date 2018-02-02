Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224V6rRjcSdFDzQffpFArSSb2AvGTPMgnB7Oyh95aB4aRY3Vox6ltOardeLqpL3mql8aGDQ/
ARC-Seal: i=1; a=rsa-sha256; t=1517591417; cv=none;
        d=google.com; s=arc-20160816;
        b=S6JHg9ZnNJhrehyhYif93YmvOvIyCJYd8b5Dx8DeFNjvbPOnagFvSUW1iNCWw0i0nm
         ExcJbPnlpsdXVbhm0+YZm5VKeu1qhUwHNhOFAE28ogqyzlkix9bpdPQGaxcldQEjEE7f
         CZ65tDmxM0nQlLBk5EI0KDmRAffSQL+sFE+ivV0SJksSZrvD0JE0qO480rcZX71Xlq88
         QMQ9yNsEFQe/i23uiT0BDbYpVt/QLlxC6KRqNfBkHMjaaLGSGddzRTM/IwnQrFhrJzOI
         cyyCH6b6iHua2L4cWYgijU62NSfaLKj1hahiNQv2bi1BnqGmb4xcS2pyiWmWO4gFe1CU
         gUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Dqq4wI/Ai9+2tnkfLp8AZL6MYgKyR7Zc29u4neznQYs=;
        b=ymsCKiv2qvpcs7v6zpQn4Xetw2HV6ZLQCec017J812VRwX+hbZuSEm5OAWsqABVcAc
         JE3YfBATaCnHpuOOo6g4eAQA49Fj5/SJVLPeiMTunO7gXe9TmBqq0aRo6EVf3JaHeVWE
         az5KrBty6KVevqZlyMml45n32i+WLHsKtkq56f7Zq54K1Jm87tskEf8k3CjLVx0HoqKY
         UiFwM7W76pDdX9Mmmnhwr6L5uZpbbldDgahYMVyUbFDHqcuxGjuSQAtfdNrhOVasNrPO
         1M2KVAuiKMB+aykEtjIMXB9ykTpifB6XBkagZN74aJb1Yiuyx/TADH6wy8wtRBTBg/SZ
         X00w==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 038/156] KVM: x86: Dont re-execute instruction when not passing CR2 value
Date: Fri,  2 Feb 2018 17:56:59 +0100
Message-Id: <20180202140842.020181790@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309306306746799?=
X-GMAIL-MSGID: =?utf-8?q?1591309938170173650?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/kvm_host.h |    3 ++-
 arch/x86/kvm/vmx.c              |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1156,7 +1156,8 @@ int x86_emulate_instruction(struct kvm_v
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
@@ -6607,7 +6607,7 @@ static int handle_invalid_guest_state(st
 		if (kvm_test_request(KVM_REQ_EVENT, vcpu))
 			return 1;
 
-		err = emulate_instruction(vcpu, EMULTYPE_NO_REEXECUTE);
+		err = emulate_instruction(vcpu, 0);
 
 		if (err == EMULATE_USER_EXIT) {
 			++vcpu->stat.mmio_exits;
