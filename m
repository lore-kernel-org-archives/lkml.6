Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225ijWFEPNZqmXFwaaqLsP+3rE8iDaaBKNE05r6fWATtgjley4mAVP+aV08Yd5RmOOrG2Z8H
ARC-Seal: i=1; a=rsa-sha256; t=1518708815; cv=none;
        d=google.com; s=arc-20160816;
        b=vqG0YPOllwA62O1f2gdzxqZ+kdSdhg5EAqnAHqMH40n7wX3GRoXP3PDzK5lOKIVHvD
         gBq8jJNjsPMeDZn5rNMUTj9aN8pDU7jyW+QkdOAYWyn8FpMepG4FJEHyc3ESdO9PQD+H
         +WEGUS1ImZKZCv8DLw+9YM3vA9+/p0VRg92S88sFGzO5c7EUkP2fS7ivLjXlU1OET3Qh
         zl3vHO3k2m9JbGy7sQ0MCmhWkbnoeDMOONiK0bZc6suajedfETvZCxSlHK1yJKEE6XuC
         tYsYuxTpCqyPwU3lvn8eOKi1TfhbIXWCD8zm0k5fzqzmmPa7LjFq/7YF+MUuMsiOnLdL
         xtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lmUvg6EibFIPLn8uztA8rYxVesKAddpu+kvGDCbyQpQ=;
        b=ruJohljKQtSo0tgA1iYCi1BHmjvVXmceRSGHgOraUS0OD4WzbOdbAgMzuAVUYydeie
         05MmpdXwhCEjjOlcGwgeiPU6zXtrkmQJTbsuDg29sQjYDV71AOL7/kyWIv8S9iXYPfkw
         TJdQ7XmnEccQacwrtG5N2gZO6KCEdODBbxXnJIlVAzJIyjpj3pJ3R6vBxZa12N7lbVtq
         VyjB0Pj0WxsZd9sEFXRo1blZpcUpwzlMpv9b+7P16McXNLui6CSxupKFAHsH/0qLCrDI
         VsFl8+teG0WnjEcLD/SiX5I7l9xN2uaOQlXIXJkoS4H/SJ5DpDUj4PASea+BjICJE1Hc
         hd9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 054/195] [Variant 3/Meltdown] arm64: entry: Reword comment about post_ttbr_update_workaround
Date: Thu, 15 Feb 2018 16:15:45 +0100
Message-Id: <20180215151708.438842785@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481614830808398?=
X-GMAIL-MSGID: =?utf-8?q?1592481614830808398?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit f167211a93ac upstream.

We don't fully understand the Cavium ThunderX erratum, but it appears
that mapping the kernel as nG can lead to horrible consequences such as
attempting to execute userspace from kernel context. Since kpti isn't
enabled for these CPUs anyway, simplify the comment justifying the lack
of post_ttbr_update_workaround in the exception trampoline.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/entry.S |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -962,16 +962,9 @@ alternative_else_nop_endif
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
 
