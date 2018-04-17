Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48UfbNS80d+fgKush7jqJBAzspyN3FTfTzfb7uk5cTWSv0HfnQ1krmybfLB754l9KYEeDRc
ARC-Seal: i=1; a=rsa-sha256; t=1523981332; cv=none;
        d=google.com; s=arc-20160816;
        b=YHyNMXlcEEsT9X12S+T73Uj9h58zhnHwX8A/0NKwQkq6n4J9YDl81qv8SqV7a8fbfB
         UhjH2al5DpMIc0CLxWmf1hPfuOnxwHCrqJZxbHCvUoTkj1xa/3wr6T3+5+ga3Y6HpuAc
         xfY5mnVb5unXLhrHtOZFFL1wuJqX3e1u1jIdexqwpE7VWNJPRv+6RaXiZ666hABKt4oR
         j01zn/nL29L/2bnO0NR+ZWHZ1BvB2IFGYRaKeK3cnn8mul6gqSixc7Cr0ex+WzZCJter
         y1v+9HNo6Ng5QWrqoca/3RNGzSjksP9ZYQ903jFCMvqOAXM49fJrc+QgrGgNS+H8w+ln
         KWTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vR/YClZjJYDgvLGiUXJfQ//dhNb9ZeEszSq4h+zIsU8=;
        b=CE8rqVLEoFQ3p18NuF3rzzeFcxMYgam12dF1E8dviu0uTqAuym4PFLAOea6L/Kw/Oh
         8Gccvg92BBLfi7UXdSafQFCAx1xdcW//WWtebHXNq4cEsOC/GkpL6jE7MV4dCv67o6L5
         PIl4NC7Y9gIY8PLyxzWR4/5JNApu11onhTNcU6Dl3gSWeKg/TIP55NA6GXRJxQ0aCe1p
         0nqU5YLGJZzvt4Mugu4RTzsmn4DbMqJXH0+e+Otwg7tOqWScjPg0Vh/CpPWhxA9eFwnE
         AhCBwn3XO8QEd6FbDabRLx2fnDspeuly3oei5heIDEhXnvwOJh7mfCqTIEbCh37A7pPA
         E+zQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 26/66] arm64: Move BP hardening to check_and_switch_context
Date: Tue, 17 Apr 2018 17:58:59 +0200
Message-Id: <20180417155647.000585170@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010250030090987?=
X-GMAIL-MSGID: =?utf-8?q?1598010250030090987?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Marc Zyngier <marc.zyngier@arm.com>

commit a8e4c0a919ae310944ed2c9ace11cf3ccd8a609b upstream.

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
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/mm/context.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -230,6 +230,9 @@ void check_and_switch_context(struct mm_
 	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
 
 switch_mm_fastpath:
+
+	arm64_apply_bp_hardening();
+
 	cpu_switch_mm(mm->pgd, mm);
 }
 
@@ -240,8 +243,6 @@ asmlinkage void post_ttbr_update_workaro
 			"ic iallu; dsb nsh; isb",
 			ARM64_WORKAROUND_CAVIUM_27456,
 			CONFIG_CAVIUM_ERRATUM_27456));
-
-	arm64_apply_bp_hardening();
 }
 
 static int asids_init(void)
