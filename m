Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48i9aWq1iJPfC6bu26HRDxZTiuEwD41tNt0gPuSAeDAQexDmCOBdgp9ii66ScHQmxUw3T6u
ARC-Seal: i=1; a=rsa-sha256; t=1523981319; cv=none;
        d=google.com; s=arc-20160816;
        b=qVB5aoM3zNwlmB4lKHKuUT3cndQhGeJMw7x15SARcdTePnjLUap3FHj4i58dchmJiM
         ws4IZK79ChkjanabWuGAWkEfkgceY1/rvqb8ueNtoPubM+e3LBdV132oOgPcqrbKJKis
         8UNhexBe9uLRSVZqwQglgqEcagtkoKzVHBk7OLYVwEpviE9hETWAg7IZHYzM8zyB6C8q
         fnL/RdBReou6Bx2SW5sj67G+FaczLbEqcXfw3zJ/zOSS/jW9bmAYGsLw4Zj/1217H2lo
         kBEaASFef42zEpg8TRarl7Zb6fOPCN7INGQGJx4vdpgoPs1R6JoowNRhKRPUpxRb/l9A
         VQgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Fq4Q5N5NVzYYlvaFn+DN/EJNOQ/FgywT9+yHtfyRiv4=;
        b=X26/6If3agaAv9yIj2vxqUmiCp6lrtGnrsKXn/c4kIbD0VYuaxgQFJJuqtqgH/bBQn
         kvzzU9K1I2LQXNfZ2GzQPDcnUmX2DCSXVnLFlEyestbid9iwOd+0nA/Fn4dUx7CEZ8Nx
         JGEJ/6CzE63JslrWCH6QJKB3tt0978F+KkPWNW3zazVo4aVkYxo21z/MEG/j2a0bRary
         DlrIiRIAw9mU4DRougw6qrE/MACqudhkT6pvXToe5jSmHctU2Ot9vm+clwlbwlq10DQI
         5FFzAemZl6P57dNuch+3FlyFGclgwemISZk4+Ku4XDMhRj7j3iyRq7u0GiRnifnet2Pt
         k2tg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 21/66] arm64: cpufeature: Pass capability structure to ->enable callback
Date: Tue, 17 Apr 2018 17:58:54 +0200
Message-Id: <20180417155646.768192153@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010235863649524?=
X-GMAIL-MSGID: =?utf-8?q?1598010235863649524?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Will Deacon <will.deacon@arm.com>

commit 0a0d111d40fd1dc588cc590fab6b55d86ddc71d3 upstream.

In order to invoke the CPU capability ->matches callback from the ->enable
callback for applying local-CPU workarounds, we need a handle on the
capability structure.

This patch passes a pointer to the capability structure to the ->enable
callback.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpufeature.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1058,7 +1058,7 @@ void __init enable_cpu_capabilities(cons
 			 * uses an IPI, giving us a PSTATE that disappears when
 			 * we return.
 			 */
-			stop_machine(caps->enable, NULL, cpu_online_mask);
+			stop_machine(caps->enable, (void *)caps, cpu_online_mask);
 }
 
 /*
@@ -1115,7 +1115,7 @@ verify_local_cpu_features(const struct a
 			cpu_die_early();
 		}
 		if (caps->enable)
-			caps->enable(NULL);
+			caps->enable((void *)caps);
 	}
 }
 
