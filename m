Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+LFP0xwQaJxPA1XI4AGrhXyoyaRXwC9TkSKv4dP8E2I/njarVFhqwgktIYZ1syK7xa36RV
ARC-Seal: i=1; a=rsa-sha256; t=1523473440; cv=none;
        d=google.com; s=arc-20160816;
        b=dX+RmYqmmL7MfFwhB/a3L54momiuRl7agmOflv8x/dJQEcC3vbPGxfm8fNnPIMZTD4
         bUcyXoLS5Lh3JD7LiYEUK19yJLNocqXQsyxCrz4juboaqMjXC7wHzJLonMUkiMS+KBsI
         VMmorSFnF8+Ep07i7GOMl3dq79b2Tyc09G8aeaz92KeDkNV4F3CvIyenwEhNgQHm+ncw
         /75oKR1tFo7LPWj4j4tuJTBGCpJsCHNXRVquCsAUXS+zC9fSIbGwQrc1EtijKJ8CgQ61
         FN8XOfOTdmG2PRFXfvmmPCKep431LhWnSpLeU71460DihrWZ9srg7y4nP2Q/7FsTyS2i
         22zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GdICHsbQhyegdCVxEBTSVbtp/HaUe2nApfh3KMER8Iw=;
        b=L+7iNsafavqGNJLIXdY9WsgOVZrXK6V/HrhsHvQDp5LKERl+HzuvuF0Yb5VQzeGXXS
         g2y6QzLotssPK9iPUXOE1rXgHOyyZ266qbPIYH682oP1cWP/GSlLwmufTpx2mdpf6Cn5
         ryxCES40mlvAYiI04z7Z9pQ7DPEke6FdXkOpJ7fSGDsOMnW3yayFIJGujVATTVOGCoI1
         LXO+V6lEl+bheky6zWPzB5xFjBY7gRxf7sRf3ed6rsaaZMxcvib/UCGZVtrfPyjqaaC2
         nDFV79QQjDBNQFF7R5vkNDpP3EmfJ6zjWnfwqVqGkSDDgZ+1eSKi7uV3IwVE2FcKZM6j
         7HHA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 214/310] KVM: nVMX: Update vmcs12->guest_linear_address on nested VM-exit
Date: Wed, 11 Apr 2018 20:35:53 +0200
Message-Id: <20180411183631.767922376@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477686281625331?=
X-GMAIL-MSGID: =?utf-8?q?1597477686281625331?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Mattson <jmattson@google.com>


[ Upstream commit d281e13b0bfe745a21061a194e386a949784393f ]

The guest-linear address field is set for VM exits due to attempts to
execute LMSW with a memory operand and VM exits due to attempts to
execute INS or OUTS for which the relevant segment is usable,
regardless of whether or not EPT is in use.

Fixes: 119a9c01a5922 ("KVM: nVMX: pass valid guest linear-address to the L1")
Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10664,8 +10664,7 @@ static void prepare_vmcs12(struct kvm_vc
 		vmcs12->guest_pdptr3 = vmcs_read64(GUEST_PDPTR3);
 	}
 
-	if (nested_cpu_has_ept(vmcs12))
-		vmcs12->guest_linear_address = vmcs_readl(GUEST_LINEAR_ADDRESS);
+	vmcs12->guest_linear_address = vmcs_readl(GUEST_LINEAR_ADDRESS);
 
 	if (nested_cpu_has_vid(vmcs12))
 		vmcs12->guest_intr_status = vmcs_read16(GUEST_INTR_STATUS);
