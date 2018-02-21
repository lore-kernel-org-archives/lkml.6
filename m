Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226XEx7gr/feTe9aAe5BXuJR9FZ0s6hKELJy1cLNKZocozDJdJlFe8GfKerYDaRPLFy9rAMq
ARC-Seal: i=1; a=rsa-sha256; t=1519218550; cv=none;
        d=google.com; s=arc-20160816;
        b=U21NO5Mfo/het0mu7HsAgk1VRFRy/M4eL5fj57IDHR/NLoRLkXf2ZCt9VmhwQU6y7x
         Zz/516OD89pOqkrasIiU4KWzRbckWrAzIk9b6gY07gyfeh8JwhDMsAF9ukSuTkM2khrw
         deXZGFMzVhFhTUgRvqwegaAna6RBUTBI1zFjTL5kqWJIjh6tW9hnKayEDMNsc1dhT/Pu
         zZBMFPsqtwaJTmoFNP1XK4fchiIR7y1sc4YvHRIlNoBHgVU+tPtGkiEC86t06bZGKZDk
         gOU/dzbDg9RXO0hz/O+Cccszxc7LwUeg19jOFWrjoU+AQbsizafmnayEYcXDSNu0SS9k
         Dq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=951wmQsPQs+Lo5B81AhD7SVLsKdnTcf6FXgQgxdomDc=;
        b=Q7H4yZhF5tk2V1XeGt98dxrqhZSlRxk4EgdhNd85y9DpdnniOYprJbQblC6nKyUDhJ
         ARPbPSLW+VahjXXZtKSgIqIkbbb0tn25wWLobNCn+c+3bZ5D3a0ep7kpdHj/nk58E7XS
         lUXeNcbG6+z8DjfSQ7zWNa6bDqFUw1DimXB1lNcvFi9y43DeC/xMSJp85aI7NDYZzVf0
         awBQ2cwarD3p2JfSBL2CSnL21YhhxV5aPp1vYBAE7q+DsgZWGyVoq+TDiEVrDflXwwno
         smdVwcpXPo88Cj9v8ZW1VyJ4Cxs9/n730g6PL0o2qM3R9juU8QLDHWMp08kAyYJuLTXE
         6ylg==
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
Subject: [PATCH 4.15 079/163] x86/speculation: Fix up array_index_nospec_mask() asm constraint
Date: Wed, 21 Feb 2018 13:48:28 +0100
Message-Id: <20180221124534.809121884@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015326563332665?=
X-GMAIL-MSGID: =?utf-8?q?1593016111626105440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
