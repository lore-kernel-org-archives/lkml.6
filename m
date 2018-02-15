Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224/71EVHIoR7YKg2desNR/sOP9Tzzl+iGRpIh9jGVmlm1kfp+kuGWZc2gG6I8IsgB5H2q5f
ARC-Seal: i=1; a=rsa-sha256; t=1518709311; cv=none;
        d=google.com; s=arc-20160816;
        b=Pk3r5yOzX7mxzqUVgF17/KGp1kKJWs5vkCYmGAZy42Es1oF3hqJnHtRc2H54cBKt5k
         YUTkDxoQkPUOeG1/NSeWNZIuN8iyHxudXwx37WmxuRLypbf5CeOI2dCnuD8xcK7Cm5wQ
         IsYd9SVzY6LiTjVDoSN5XyQa2CftoIAwr7ZrLPPL9DQ4MZEgPnyCPOstEtqSWJNklGb2
         usAp2sUfJxISDB44dq7hdlOObLre+qbEtwt+psVb+U1vP7dfclF4D8UetD9CnuU2Gd4y
         67rxYJ2I+6HDgvneFsgqvyHA3/zsSW8ZqgGhBmV+Gf+GiQOwEUuwiTXDhYUNz0F1s9WA
         RaIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MN2RVRc1yznBaYRI6mXOifpxnFHTmTPlyAnMpGtXUmY=;
        b=SPijKy9DYlN6gel4vt/ircPXJ08t4MHeKlL1bLkLvDV/ceRmY1oHsi0ppypHCzcptI
         fwR5XVRRSwgNZxvwuVC8G3I1XVkaZH21RQ5aM4iMshFSZ969aQkRhtx4QUsrJFpzDI8X
         uvtsIKSB1zRJvy0YFAS08SYjcDtavcdqAA19xjCGMACYnIk/1+7JLHQPb93NpY2CJyg6
         w5PuXJeUflqO8zBlo1rWDi3F9Zofczyu2CEd3b9F8TAA9nYQzpYvYlRY3rl2giOJkIU7
         NtHQm3TbqAfrQy5AGP+Y5K3nTSqTN3+c44X/0hKS+fBmC52FB8MPFmayZlW9ipjtKTrC
         u8bw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christoffer Dall <christoffer.dall@linaro.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 072/202] [Variant 2/Spectre-v2] arm64: KVM: Increment PC after handling an SMC trap
Date: Thu, 15 Feb 2018 16:16:12 +0100
Message-Id: <20180215151717.252169465@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481586711973563?=
X-GMAIL-MSGID: =?utf-8?q?1592482135242038054?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit f5115e8869e1 upstream.

When handling an SMC trap, the "preferred return address" is set
to that of the SMC, and not the next PC (which is a departure from
the behaviour of an SMC that isn't trapped).

Increment PC in the handler, as the guest is otherwise forever
stuck...

Cc: stable@vger.kernel.org
Fixes: acfb3b883f6d ("arm64: KVM: Fix SMCCC handling of unimplemented SMC/HVC calls")
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/handle_exit.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -54,7 +54,16 @@ static int handle_hvc(struct kvm_vcpu *v
 
 static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
+	/*
+	 * "If an SMC instruction executed at Non-secure EL1 is
+	 * trapped to EL2 because HCR_EL2.TSC is 1, the exception is a
+	 * Trap exception, not a Secure Monitor Call exception [...]"
+	 *
+	 * We need to advance the PC after the trap, as it would
+	 * otherwise return to the same address...
+	 */
 	vcpu_set_reg(vcpu, 0, ~0UL);
+	kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
 	return 1;
 }
 
