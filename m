Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49m5kaMOAHviCgCMJIbHN4rAU6rZFX/MgQGQKUdsJWY70+W6DFc8jRbJ25XHQZv4EweDuPR
ARC-Seal: i=1; a=rsa-sha256; t=1523021742; cv=none;
        d=google.com; s=arc-20160816;
        b=cixbfH9XruKvjAZxZu9LYvvpLHUuLMtYGy+b4kvLlZgsd669e2bcAcK/Ww3A7YwD2/
         Efv0RyiL630bys+fEoQOwDgdeghyRZZpCsVsONqIP/Fl23N72fE5iuqPphJhDKaJ4Az6
         h8h3wNzAQul+2TW/qlwtjd1tcx2IJCMfcQKjvjw8w8QhvhDgsiGenspckMRyYikEBxsw
         9EyRwnY6YSLGmwr7BgZUcKLwBKOYNIaILisepEvj5yjduMMgQfMXGEkHN4BtzOtGU81W
         DmnHfTxWSss9OjZK+bnQgpLOMI48BL/kmwMT38P5yTphMty/U85sED+0q2Bpcekygcfl
         x09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oGkR5gGRY0uA1IoYAON/3+eyQrpBjL9A8T2xmYMDo1U=;
        b=UA8k9ShaOaQfakuKKHsy3qtFAQv5ww/ygUfDEpvBStPoIMvtcjHvrhfzi/LrXGDQcQ
         GaM+jQE6TglNy1qGlAzKluLeUp7SjOLYfFOpe1eRTF6s1dciTwrcAV29+BZJzXnsqzIT
         /tTE8+l2lKJr9u9UFQtWaoWIcebdt9Cmmi5cPaKw/RKRWfshcY7XdHgzNopgqfYrMQEi
         P/ltpXleOXGCGPdcqxGeyLVMkEvjeUvO7WRSNDArzRf/+ArdKjSdQbt3zEzOG8iH1PnA
         OcODQprH9JZKI67PJAaRcZ9cOL2hwAd5G/IcygVp936q4t/C/rT43vNoSJhfDP8OpaO7
         0d+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Alex Shi <alex.shi@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 075/102] arm64: entry: Reword comment about post_ttbr_update_workaround
Date: Fri,  6 Apr 2018 15:23:56 +0200
Message-Id: <20180406084342.062083807@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004046559769022?=
X-GMAIL-MSGID: =?utf-8?q?1597004046559769022?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit f167211a93ac upstream.

We don't fully understand the Cavium ThunderX erratum, but it appears
that mapping the kernel as nG can lead to horrible consequences such as
attempting to execute userspace from kernel context. Since kpti isn't
enabled for these CPUs anyway, simplify the comment justifying the lack
of post_ttbr_update_workaround in the exception trampoline.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org> [v4.9 backport]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/entry.S |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -861,16 +861,9 @@ __ni_sys_trace:
 	orr	\tmp, \tmp, #USER_ASID_FLAG
 	msr	ttbr1_el1, \tmp
 	/*
-	 * We avoid running the post_ttbr_update_workaround here because the
-	 * user and kernel ASIDs don't have conflicting mappings, so any
-	 * "blessing" as described in:
-	 *
-	 *   http://lkml.kernel.org/r/56BB848A.6060603@caviumnetworks.com
-	 *
-	 * will not hurt correctness. Whilst this may partially defeat the
-	 * point of using split ASIDs in the first place, it avoids
-	 * the hit of invalidating the entire I-cache on every return to
-	 * userspace.
+	 * We avoid running the post_ttbr_update_workaround here because
+	 * it's only needed by Cavium ThunderX, which requires KPTI to be
+	 * disabled.
 	 */
 	.endm
 
