Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227+DZy53WIHZXMiGPbwab7waqNpjWrWCY070AU53xXx5lPuMurEkEfekEFf9OYL1JnCllSP
ARC-Seal: i=1; a=rsa-sha256; t=1518708752; cv=none;
        d=google.com; s=arc-20160816;
        b=UigiWsOaiHV6Czn5RAE5bUCMSOqsF30IUsDfJuPfeiiTWnR//3gCYOG2zZQFCan+gF
         wIANzVl+fb/tj6DvQJ4bXo1FxXHBwUBdSLI5FUQXogkntKkWqulrJbeouoQXDrrvLsYy
         NcOhAoM1esk1ZkIVvrPtB2ZnTYNn5M/cWSjm1pTp/+7kWM5z6klRV1SipZEYyM4SX4Rs
         lk7Rk4KflD9OElfvFDYeVc/XeUSmadXeq9tLCzNcZ8ebYEcbyV54gApaszTEbS3W9/1t
         44QRekXE0lEnvWsMdazZdGLcek+ChDAoXyrYZ/rCwcDj6GVzE/XPClSAZfDiDqLPyLr8
         e4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jQGt2mMVXlrHJOgGr7MYi9dw9HJk6DnrMHAbBQh/nqc=;
        b=YRmZ5u+hzjjWL9rny0Ch/lugJzIkirdwvpYtgI+e/QTBtx7VHkCG/mQvY+T53Us4Rd
         TeEp3We8wvRskQ9KyNLLfKOF6iSdT0m+bACFCSNMNKiweLrm5pgTha4xBIButasD9E3I
         Ez6QIeUXOIBi8i/G4uqNn/AMjEMq+b6TKyNHmThzwambRMaKmMJaQ/EyU/13Q9MJy6Xr
         E+Sti9oySZMJl41LhDh9Ey9dUuxPB/M2cqVO8VOHmUz7UOHL6EJO7xDncBzxLVOwsKgm
         UO8/e5DyBA7ldeUzIVDmp5GfUj8uEB3mYP4nKNMpIBM/ft+3AzA3/hUFNRZW/P+EoQYK
         5/Zg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 067/195] [Variant 2/Spectre-v2] arm64: cpufeature: Pass capability structure to ->enable callback
Date: Thu, 15 Feb 2018 16:15:58 +0100
Message-Id: <20180215151709.058317092@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481549255300629?=
X-GMAIL-MSGID: =?utf-8?q?1592481549255300629?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 0a0d111d40fd upstream.

In order to invoke the CPU capability ->matches callback from the ->enable
callback for applying local-CPU workarounds, we need a handle on the
capability structure.

This patch passes a pointer to the capability structure to the ->enable
callback.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpufeature.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1144,7 +1144,7 @@ void __init enable_cpu_capabilities(cons
 			 * uses an IPI, giving us a PSTATE that disappears when
 			 * we return.
 			 */
-			stop_machine(caps->enable, NULL, cpu_online_mask);
+			stop_machine(caps->enable, (void *)caps, cpu_online_mask);
 		}
 	}
 }
@@ -1203,7 +1203,7 @@ verify_local_cpu_features(const struct a
 			cpu_die_early();
 		}
 		if (caps->enable)
-			caps->enable(NULL);
+			caps->enable((void *)caps);
 	}
 }
 
