Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrVDSgibuJ4320LSRFhwSvnhVe/REERb9FEV+bFMxuD19AqooSr+Bo8mek4pjhF2Dyk5c9y
ARC-Seal: i=1; a=rsa-sha256; t=1526937404; cv=none;
        d=google.com; s=arc-20160816;
        b=0Rxs46VcNici8NlGjTaayjSlCjZbLaiLyfp9xx7W0vpJj+GapuqNhYVbnQbZmRhAyJ
         ujFRctNrGlG26a9SEwtJCkKxXMbl2rWeLlCx42fF0E8dyu0aSAtFqYh558h/U3qOPbF+
         I4s0o6loOjGOJK4Wcb4pxce6u2tZgg/7BHG7fTOAoxVAt1X+uTbagcBIBRp8PSK0fB96
         iLo3pjgp547vp3/TUCqOiLsO88HL1HdztXdC3KzJtdWN5zqWD2t59nBGFtLlPobweZsO
         7iUuRv+bKPBZ815UHftBovbYg0A8TPMJQKGTsDy1XS2reaa2NErJ6ZpfJZqFdx11YN6E
         OYJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=/r5SZU9VHdU5PG/XB/DFnTLavXVG8WOerOVDqe1Yq40=;
        b=R73m+MfC2MwrtcP+4lcLjFgA4bMVxbYm73Z69aLiUvmihZqD8gx2riYpJClDlKb/wE
         lugJlKO80Cg1BPAjYUuI6P1E9urY4asp2WrCw2/pTWSFFWamqHfHctnWzV5nbrYRWRmQ
         eUUrl7vTROkIcdZWoyuo6u+rzkYMKuEQzMQZYWOJ3/vYwWTfOXZDhFBiE/AoLXWYy+FH
         FAYEMkfrbzwD4rzzaVFyAPwwkvVYEyDBc8SMtdqrDSHgYlISTCW6ocUqxbGcvKPaweFp
         /cpuJRs+41eM7SzDHRvrtfJbXZyEVIt0yvnPPz4YPCzgc4QU2fEcNm01cLHw3rcr0t5d
         LzeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=q6c2wOXq;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=q6c2wOXq;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 70/87] x86/cpu: Make alternative_msr_write work for 32-bit code
Date: Mon, 21 May 2018 23:11:46 +0200
Message-Id: <20180521210426.188619225@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109915496238144?=
X-GMAIL-MSGID: =?utf-8?q?1601109915496238144?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Mattson <jmattson@google.com>

commit 5f2b745f5e1304f438f9b2cd03ebc8120b6e0d3b upstream

Cast val and (val >> 32) to (u32), so that they fit in a
general-purpose register in both 32-bit and 64-bit code.

[ tglx: Made it u32 instead of uintptr_t ]

Fixes: c65732e4f721 ("x86/cpu: Restore CPUID_8000_0008_EBX reload")
Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/nospec-branch.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -265,8 +265,8 @@ void alternative_msr_write(unsigned int
 {
 	asm volatile(ALTERNATIVE("", "wrmsr", %c[feature])
 		: : "c" (msr),
-		    "a" (val),
-		    "d" (val >> 32),
+		    "a" ((u32)val),
+		    "d" ((u32)(val >> 32)),
 		    [feature] "i" (feature)
 		: "memory");
 }
