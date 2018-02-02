Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224uRbHF5kJ9kb/VRnNeU2nqJkdhfS3xXrDHODMnHyATOHovGd4qB0cx0yAJBkGgLAqM4NZ0
ARC-Seal: i=1; a=rsa-sha256; t=1517591008; cv=none;
        d=google.com; s=arc-20160816;
        b=d96XLG38RHxRC34iJoGL/k+/FWg4ObNxDblcO6RMg1WAULR/GKop+0uGfNaNCKNcyt
         vJx6XP6hiZ7Sa12A5ZvS6Sfr4mtthFfUUVZ8Q8kW2R7XEDgUyUKMUaScL3NdBTE8n3pu
         6CdCBpTcgI1xZ7wivn05w4ZyQEHA/lg99b67aY3yEIxAEBmWcnfwssz7WGZ2sa2qf2dc
         eQdMg6RRCfgP39oxays0MretGHxAt88VYG0Re3OcJkxb1pKMdoqsTGbwMU5GnACWq6kE
         66LgXMfC3YBrgPFqLiwsJtshFedcX+DZcuo5cNf2n80IJMwfOnP13Ehm4YuvCo7rdApd
         nhWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=O/I5NQuTNrqiDprgwSqoQxKgK3jFaEBZ9ZpDm4cenNk=;
        b=A8kxSIGxw2mp3jJPOt9D5Fo1MxWdv5j8xrUG0G24fIFKhOqcEDg9Ri9jOqUEr7kvO+
         WNTal7whE0R5vRrYpeZEpN1+EiCzqvhJcbAnx1nFkbQR568Zqt7/SbffAhDYIhQITEj5
         fHdxqeCrWn4JGxANSlexPMxV1xmeTPu8ZeQhcMm71PPN7kjBhChPlx2V7ANzdmr2SLhi
         C+ege5MytpSekForp9pEuC6x8a+DXOBHAEudboGuAMj2dqGGFaLTe4ptqvyZSH7oVHmK
         vj1whzbnSVWve1A+kYrdZ/f28iSsrgJW6i1ZsFV/SPUv6JW+Y+E/DNnCt1hyXvi2fuK3
         dSxA==
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
Subject: [PATCH 4.9 21/86] KVM: x86: Dont re-execute instruction when not passing CR2 value
Date: Fri,  2 Feb 2018 17:57:41 +0100
Message-Id: <20180202140824.686813348@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309306306746799?=
X-GMAIL-MSGID: =?utf-8?q?1591309509557194134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1113,7 +1113,8 @@ int x86_emulate_instruction(struct kvm_v
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
@@ -6257,7 +6257,7 @@ static int handle_invalid_guest_state(st
 		if (test_bit(KVM_REQ_EVENT, &vcpu->requests))
 			return 1;
 
-		err = emulate_instruction(vcpu, EMULTYPE_NO_REEXECUTE);
+		err = emulate_instruction(vcpu, 0);
 
 		if (err == EMULATE_USER_EXIT) {
 			++vcpu->stat.mmio_exits;
