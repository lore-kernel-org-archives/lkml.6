Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49BMKKFQ+mxgoTh3rccdwGlB9blz3SPp4r6folJx1O3iJqAen7Z/XRkwdhgHxvuuCCUlx9a
ARC-Seal: i=1; a=rsa-sha256; t=1524406732; cv=none;
        d=google.com; s=arc-20160816;
        b=N/ihA54nJl8Xeu6RwioQsvAT/DrUovof5vdYBEgb4uRMuzPZtK8q6ImSz9paaEpRZv
         YCd25oogYe1GZJVnmTVfN2hC5CQwmvfvwc6XukRLhJZw+NMHre/lW35VgbxjaFr9FJ86
         XW3ETBs/NYIQ9wsddy/ZuszxjdwQb5HrLJHLAKanT4fkrc7cL9HUpwTT4+ILaeTNeEEj
         GPSwOI6qNEJxzMnmPrbxJrh6SW0c7cnbb2L9nQMC01UHGkH0WuxvlaTjQx8GSaUA6Abe
         OyFyRjpfypmpXCzS7gwtmwZi0/JfsJd1hn3BDB56icRfs8cUT0Q/aOexTEEaTWhm5X5V
         yjhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZxLfz5ewosiN2LDGR9psQh9WFIIN3iLfSKV72jIy30A=;
        b=wzcjeUGydii0eblMm+1mAigjq3kqVC12caDSZrslYwvofJa5M5hYASmn6E/jIezpdB
         qFCxQpZC6NytyO8SjiBn4Vkfk6UsjGgI4nE4JrNHkK7Dw4tUT9B/1HNf81LjNfEFGs6A
         MXv+9JeW/UkKuFlGa0JSTROuTnn7c46wyCNt0/gz3IyzN0/yZ4HheNm5etEvkP4HX/6c
         7rLWClyvlD1xve17oxm+WeozTzwPKhODCQ3QEIU5mDfNRTpakWIZ0yQG0Yme0BmScxRc
         UqewEyo0hbcEoBb14gc1qd3Mvad7oiJYCKNofH6vIpYDWNllstp0kcn0DsFLbbug0J9o
         cVpw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Hogan <jhogan@kernel.org>,
	Matt Redfearn <matt.redfearn@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: [PATCH 4.4 84/97] MIPS: memset.S: Fix return of __clear_user from Lpartial_fixup
Date: Sun, 22 Apr 2018 15:54:02 +0200
Message-Id: <20180422135309.790274421@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455264978774304?=
X-GMAIL-MSGID: =?utf-8?q?1598456313895970176?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@mips.com>

commit daf70d89f80c6e1772233da9e020114b1254e7e0 upstream.

The __clear_user function is defined to return the number of bytes that
could not be cleared. From the underlying memset / bzero implementation
this means setting register a2 to that number on return. Currently if a
page fault is triggered within the memset_partial block, the value
loaded into a2 on return is meaningless.

The label .Lpartial_fixup\@ is jumped to on page fault. In order to work
out how many bytes failed to copy, the exception handler should find how
many bytes left in the partial block (andi a2, STORMASK), add that to
the partial block end address (a2), and subtract the faulting address to
get the remainder. Currently it incorrectly subtracts the partial block
start address (t1), which has additionally been clobbered to generate a
jump target in memset_partial. Fix this by adding the block end address
instead.

This issue was found with the following test code:
      int j, k;
      for (j = 0; j < 512; j++) {
        if ((k = clear_user(NULL, j)) != j) {
           pr_err("clear_user (NULL %d) returned %d\n", j, k);
        }
      }
Which now passes on Creator Ci40 (MIPS32) and Cavium Octeon II (MIPS64).

Suggested-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/19108/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lib/memset.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -249,7 +249,7 @@
 	PTR_L		t0, TI_TASK($28)
 	andi		a2, STORMASK
 	LONG_L		t0, THREAD_BUADDR(t0)
-	LONG_ADDU	a2, t1
+	LONG_ADDU	a2, a0
 	jr		ra
 	LONG_SUBU	a2, t0
 
