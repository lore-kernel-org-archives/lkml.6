Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48OS7RyPGb2YT004Z419m3t23apgovUJlY/W08rMX3pWajWAg+63sEdKRAUAQ7zlgnTLurE
ARC-Seal: i=1; a=rsa-sha256; t=1523021718; cv=none;
        d=google.com; s=arc-20160816;
        b=BJ6acznhE8KktaBpmyjBQYLOcnu7VGW8a8hPmPqNyZ2/FoqKcN0auqMvHL3ORMzoDK
         4RiiYsZl7nANCTLOtXKESEXLMMlWDPdCJGszM7U9K6UiEBxgFVr2DN+Nzmn3e17qSGcr
         EB9gvEJzOOh6SLxMNLFBeq+jPjg4zvEwfDEqQIUWhS0rbrDySoSyK9DLHZJZWdu1RmXO
         j+d0bC0gj3T6Z4ZGSmoFqKPJUlNcNXqqLc8LM575WfeMzH6Ru8i8m3ziBWJ/7uWpyQXS
         yWez1Csdq+SIa1o0zvrREV77tK/1Pyi5JVV5RAfsZ/vc8+jNAG1gLdya8GxkibuwdZDI
         poxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aPhHGnB1uci2pEc6+P2WqnZLPedDrNVRvgnv7s/030M=;
        b=w7EP7lEpBjNaVUbTYSarxGXCxnE+af1jmetsEMdRrTP1uhJOAZ+g6MOglRmiiD8CHV
         XADYtX9jfKYaOgGdXHCs+HU512uuJv7/KSFKw2YfT7Mp3UK0Lgxt31B/kt96Bmp3Fcy6
         t6ZCJdNp6DJOTDFyWRZc2kCiYMOKDy74tFKeumnYA/y2ovODMCddzDBXX0R/joZMsoub
         gYTVgDCCNWV/IXBJXGjG3oJIiIFa3s6RxEO9VB7xLpm/bl2caW7K8HwHuPnmXTubp03o
         cHIUoyZO+V6ACxLG6gfQUNFuMSCHRYX2Pw/DKoL9SwZoPVQv2kUVzgiVDIhWBW9iUWZA
         vv7Q==
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
Subject: [PATCH 4.9 064/102] arm64: use RET instruction for exiting the trampoline
Date: Fri,  6 Apr 2018 15:23:45 +0200
Message-Id: <20180406084340.553370699@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004021234023782?=
X-GMAIL-MSGID: =?utf-8?q?1597004021234023782?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit be04a6d1126b upstream.

Speculation attacks against the entry trampoline can potentially resteer
the speculative instruction stream through the indirect branch and into
arbitrary gadgets within the kernel.

This patch defends against these attacks by forcing a misprediction
through the return stack: a dummy BL instruction loads an entry into
the stack, so that the predicted program flow of the subsequent RET
instruction is to a branch-to-self instruction which is finally resolved
as a branch to the kernel vectors with speculation suppressed.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org> [v4.9 backport]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/entry.S |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -880,6 +880,14 @@ __ni_sys_trace:
 	.if	\regsize == 64
 	msr	tpidrro_el0, x30	// Restored in kernel_ventry
 	.endif
+	/*
+	 * Defend against branch aliasing attacks by pushing a dummy
+	 * entry onto the return stack and using a RET instruction to
+	 * enter the full-fat kernel vectors.
+	 */
+	bl	2f
+	b	.
+2:
 	tramp_map_kernel	x30
 #ifdef CONFIG_RANDOMIZE_BASE
 	adr	x30, tramp_vectors + PAGE_SIZE
@@ -892,7 +900,7 @@ __ni_sys_trace:
 	msr	vbar_el1, x30
 	add	x30, x30, #(1b - tramp_vectors)
 	isb
-	br	x30
+	ret
 	.endm
 
 	.macro tramp_exit, regsize = 64
