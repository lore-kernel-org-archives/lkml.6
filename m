Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227mFd/Z75LAOKTtirA8bSd87YTPCfkbH97rkJjHMQEMKKzJsULvBzREAFcuIQ3VCBoE8GLn
ARC-Seal: i=1; a=rsa-sha256; t=1519218166; cv=none;
        d=google.com; s=arc-20160816;
        b=POssJbCUg2bKwk09fL3EX/oC+t2t2fRKW6KwQu0UTsko6iFvADhEZaqH0EYPT1DrZ3
         DKQDmOigdB3qKZ3GnUbPqFC0Z4IkR0s86J3kQYQDAY/nC/a35Cj5gKult5l10qTA6u7w
         Ut50poMu05sh+ezEWctOepdXbw9UcyBzH5uf9Ifh6FEr2qH+E+I40h/X74mauzJbT4AG
         71qqowp2T7ZzxnWzUy662qtMsTiqHpzsK8qnOTMwjsznMUICs/xhyRVEBpNM3u2CdSzq
         QAej6OqoNa5Q37MSPQEZaihL1SmTPB7do+BTYd8CV+aYx8NCOHEoccFHIkK/jtNj3DR6
         StxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YGEV3YExdWA3/eZVdg0Jp67CKVqRGJRWfwBS+U65TFU=;
        b=Ci66mlXkxbdVDjFfuXt/H26dxoQI2v5z85ilEThWMpPzY08lhU2Bc2cBnJ40Y/mwqa
         yr0IyElesqkm9ojiSaJylgD3UaKgASA4JN8t0Jaq2zMLtPtzjetTy/Xu510L95X1+40G
         m9HPbsBUNQNNd/P4ThQqmOqmWeb2hC8iN7ASnJLYFHjJ4+EkA2VK9tepVye0m9/0SmN9
         8JfoXJeMwZdvPkkV4VaI7Ai4eZJouiMaWw1jD0kPjMVhMLFCCelxYKOwxBOCbX1AnUfL
         tA0KfZFa+sr4Gj2gcgq2thrrInqXmMosgYsJgHTjBknyMxtEi3tAmnf9y9wWTv8iCDwq
         K+qg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 076/167] x86/speculation: Fix up array_index_nospec_mask() asm constraint
Date: Wed, 21 Feb 2018 13:48:07 +0100
Message-Id: <20180221124528.627101123@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015326563332665?=
X-GMAIL-MSGID: =?utf-8?q?1593015707588483420?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit be3233fbfcb8f5acb6e3bcd0895c3ef9e100d470 upstream.

Allow the compiler to handle @size as an immediate value or memory
directly rather than allocating a register.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/151797010204.1289.1510000292250184993.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/barrier.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -40,7 +40,7 @@ static inline unsigned long array_index_
 
 	asm ("cmp %1,%2; sbb %0,%0;"
 			:"=r" (mask)
-			:"r"(size),"r" (index)
+			:"g"(size),"r" (index)
 			:"cc");
 	return mask;
 }
