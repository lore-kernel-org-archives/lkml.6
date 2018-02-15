Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227QxFvf9ikdGKRtT/tp0JTWuLnzMT2vuqxVCWeWrg5316ftvWn/XNJisPt2zlrgqtvioBRx
ARC-Seal: i=1; a=rsa-sha256; t=1518709285; cv=none;
        d=google.com; s=arc-20160816;
        b=sJxwrE1rJNdub9mQ/lVp8toxrYYF/y+ExKZiS0HkxZc9GOUAy1reuB4KDbM1h4GkA8
         oDtm8ojRFtrTuBJVIc4wVGazGTukDGv4PKpvpyViAolhcojVl3j0i/AgRPoPu0o9QicE
         5If6qQgSJY79dUEaXz3LCo9R3C7XB+1oxU3RiEOmUgvpeV/5rRONqTvohYT9CxfA7VJ/
         PS9NpAlwVpEVrOZnzpjdXDNcmRoAentHCKj4xBkDA0l3DpbN9K49ZXc97+QfEH3PK3dB
         60dxkOsjZS9COX34bPLuogHyFJdbB4kFaCTONXidYj/zvbEh/hZ1W8p8wVNrl1qGM0Zp
         QfMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RUPGn9dJTKuY0WdlLNGthuB2Bml3Y4vmmdZFj5V0hiM=;
        b=EhB+aS0xBNsEGbwBW/mpMjpNe6VQ+95RpaBFFD/epP21i4inCfH7a3KqsqAmzpuNIs
         /MaAo9jjyh0qn8kOMkV+Nf9+m73DqEpvYLcYQZyoSermGxtJhbzZdkwSswjlgGG40IqW
         XDjNL1/ja4GL4iekNPNS/Aktq7aXruHNG5XiWjOHT/yzxxdFhWHlHRdXFaMtA5yVFBeA
         lJNHFmcC3I0FjeqwWJFrE8H5rvLBE4x3FDzQRfbQzJST6z9IYgk7ifwfDvpr3lBE2ucH
         3kvmT7XqFJY8pQkIeSR173uRzSaWDLX+ZryvyMJw7IYWivzowZvTgTJcFj9Ye7/ibVBv
         WRzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 064/202] [Variant 2/Spectre-v2] arm64: Move BP hardening to check_and_switch_context
Date: Thu, 15 Feb 2018 16:16:04 +0100
Message-Id: <20180215151716.771905035@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481559754840687?=
X-GMAIL-MSGID: =?utf-8?q?1592482108392274903?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit a8e4c0a919ae upstream.

We call arm64_apply_bp_hardening() from post_ttbr_update_workaround,
which has the unexpected consequence of being triggered on every
exception return to userspace when ARM64_SW_TTBR0_PAN is selected,
even if no context switch actually occured.

This is a bit suboptimal, and it would be more logical to only
invalidate the branch predictor when we actually switch to
a different mm.

In order to solve this, move the call to arm64_apply_bp_hardening()
into check_and_switch_context(), where we're guaranteed to pick
a different mm context.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/mm/context.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -231,6 +231,9 @@ void check_and_switch_context(struct mm_
 	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
 
 switch_mm_fastpath:
+
+	arm64_apply_bp_hardening();
+
 	/*
 	 * Defer TTBR0_EL1 setting for user threads to uaccess_enable() when
 	 * emulating PAN.
@@ -246,8 +249,6 @@ asmlinkage void post_ttbr_update_workaro
 			"ic iallu; dsb nsh; isb",
 			ARM64_WORKAROUND_CAVIUM_27456,
 			CONFIG_CAVIUM_ERRATUM_27456));
-
-	arm64_apply_bp_hardening();
 }
 
 static int asids_init(void)
