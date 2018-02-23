Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225jx9IQnFK4Yxru+u/a/0mMXolRty82/Qj6OwpnxbeuEStYzPeCGIDedncaXzOsH4QAAe/D
ARC-Seal: i=1; a=rsa-sha256; t=1519411306; cv=none;
        d=google.com; s=arc-20160816;
        b=dP+VPEPO3GditljYg68eOV1vfPJG6ZDF7NkjAYEG1fErnbgA55R7rwQSuPR9nsfqBA
         njibKHgiDRphEc0Lqae+XKLcHQDddJQuMhoS/lWMLLWYttRPywWgFyqIYGipizaAHZRU
         AQXgMd2uXJ1kfpjDmTjwJ/MIktX/LbZlq8CIQ40IpsIo4hnz9g7UgPbu3Er+qfB2KScP
         yrbNOkoix1U9JAiDAz6OGFxjtaF6G05dX7Ts+E/oflcyMt27Kw7zVWoLsb8NxE+rlCYa
         avM3RU5e+95fym0YWK68b2FrxjN0/eykGzSjdW7rfSNi/cH5gM1GgouhiQwOwTB3pVB0
         BRmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=A5OWk5tT06K6Jds3zynDy/uZiNCqMbtRc+Y7Bn331cE=;
        b=xY7yguTuM3osZLvimb0mQCBimRyhHbnqCxT/4OSbGIREcoeLYv6dUaOqhPhAesth47
         cqDd5RC7R4VlsheNfIb4dZ9qQNu0BQUuqy/oUrmj1CW7U5iGpo/CBWiSpfEItNOp8Dq6
         HcnmKAcCSVtv79D1R3N3M9mzyggV7+MwKxxGmYrNWHmuQRktMrK/XFAiZUnXkshMWyAo
         Afa/SNiqUsvPX3w8ugxqHPhRCJ5Y5pYWblh7KomTiQRWVv3cMPj3VW5EZ7A0OdnYD5UQ
         Z6Ji4hb1YGnx6Zy7k9H5xR7L+cPMmZSd2xTIjeW8plp7EdEFutl3UavVFBrStwS59BEy
         Zruw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.4 190/193] kvm: nVMX: Fix kernel panics induced by illegal INVEPT/INVVPID types
Date: Fri, 23 Feb 2018 19:27:03 +0100
Message-Id: <20180223170356.171796567@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218229906853297?=
X-GMAIL-MSGID: =?utf-8?q?1593218229906853297?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Mattson <jmattson@google.com>

commit 85c856b39b479dde410ddd09df1da745343010c9 upstream

Bitwise shifts by amounts greater than or equal to the width of the left
operand are undefined. A malicious guest can exploit this to crash a
32-bit host, due to the BUG_ON(1)'s in handle_{invept,invvpid}.

Signed-off-by: Jim Mattson <jmattson@google.com>
Message-Id: <1477496318-17681-1-git-send-email-jmattson@google.com>
[Change 1UL to 1, to match the range check on the shift count. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[jwang: port from linux-4.9 to 4.4 ]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -7361,7 +7361,7 @@ static int handle_invept(struct kvm_vcpu
 
 	types = (vmx->nested.nested_vmx_ept_caps >> VMX_EPT_EXTENT_SHIFT) & 6;
 
-	if (!(types & (1UL << type))) {
+	if (type >= 32 || !(types & (1 << type))) {
 		nested_vmx_failValid(vcpu,
 				VMXERR_INVALID_OPERAND_TO_INVEPT_INVVPID);
 		skip_emulated_instruction(vcpu);
@@ -7420,7 +7420,7 @@ static int handle_invvpid(struct kvm_vcp
 
 	types = (vmx->nested.nested_vmx_vpid_caps >> 8) & 0x7;
 
-	if (!(types & (1UL << type))) {
+	if (type >= 32 || !(types & (1 << type))) {
 		nested_vmx_failValid(vcpu,
 			VMXERR_INVALID_OPERAND_TO_INVEPT_INVVPID);
 		skip_emulated_instruction(vcpu);
