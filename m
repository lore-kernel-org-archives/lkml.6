Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226lnIdHLerktz5kvpsOtYoJpWTwcl7JZ2ax8Y1B9e0pAWebI68KVItzcveA2u9z05tOTNSt
ARC-Seal: i=1; a=rsa-sha256; t=1518709256; cv=none;
        d=google.com; s=arc-20160816;
        b=fHIhYzSx2Wr5XnNgsL13/RN0wZ1jVsqn5i8mJZ8ovhNnRT5V/PpJS2ybirVHz9EoWp
         2GrJCF6WD2UfOCsZftIYFMtDXFk2rXC2x97mJmeGH7QTkTA//LtA51Jvzm5JpNIx9TUo
         XcpbI07m+x2eDxEI/52Weng7WlcHo7bGFYoMQXvWiCU6g5YtzI8cK0IgI4wrnBMsY92Q
         DJabQvbLmyvrOJMHTj+OdYfJzFMzzctsf15nrQ2uV17TsfUxMmREmt18vxV398bTN9TL
         FyCr6SLIcctT27Mmp/REe4u9cQs8FVncALRjHvPdH94qhgV/nC92oE505+3LxvjNe8z0
         6h2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=i/2VpSiX9n5ZddGQ1XINHX0I4wgbugr/eY2RwKLf9vU=;
        b=DT3dAdvUzfFw15m4xt4dWps4aTV3ziTXuv+hYVGdsSRO5OF3D0v+/2NC74LkRwCF8h
         jXWLrc4/y9O5j7o7vm80FpJ/5RSYVvyRZpLHH7xdnefAccuGjR0VOSl7aSfCiu8aAz4u
         M2b6i5NPPlz4STFDL5AIW4IwZhpGQk/mybc+FdYNTpIae4KjrZ0z8tNpxAMdCPoiYqaK
         QiYcEuyLi/gJ6npKp+0NsJVjwcSuF3xpWKi3wWNqHpqw9v1fy7ZdzBstsYViR967AYGF
         uk8kY+UTYJU6PNuh95ojNTvKUx9zkIitVDy8zQ0FkGmMQ1tV5CTeOgIGIVUineC/qyoz
         P6pA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 046/202] [Variant 3/Meltdown] arm64: entry: Reword comment about post_ttbr_update_workaround
Date: Thu, 15 Feb 2018 16:15:46 +0100
Message-Id: <20180215151715.590617213@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481614830808398?=
X-GMAIL-MSGID: =?utf-8?q?1592482077206724877?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/entry.S |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1010,16 +1010,9 @@ alternative_else_nop_endif
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
 
