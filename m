Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+tA/Ttyq5OzJd5GmzpRdlNj9K7kSO4W7fFkIHuMeTIay3MEDOcvkVip0GJZ8GkGZEt0TW9
ARC-Seal: i=1; a=rsa-sha256; t=1524406265; cv=none;
        d=google.com; s=arc-20160816;
        b=Gz27BDaI6ntMmbzK80a7wlHP8vP1evtnw1PlXZd84M5zd9tppUB9Mhhnljpd4sg0Oj
         +sMuHSGi8sof2vFfRZDPxdRSsSmzp5rL8/FKnp6K6WmIQYPFOzL872+d+q18zmcy8P2R
         2ovKtm8FEWkd6pPUE7E+KTzgwy7KgJlWUOmUOuVeonLR81SRUz25AB8Cuw/gs59tHQCu
         EImElulWJKfrME2C6qvxVkdwFDlQhZmYwWsaAm+S6ut27piHQ0+XFVufcj2JjA3MS0uJ
         v+gg4DNaz1YbU07akPLASvbkO2ROX8EZpi75XGPAIsMp4vTIbgONkDMXXRF+g1FZ/RL3
         b2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=p5ge4z9a0vH6Lv1G+TJy6t6sU5pGD1OpAZTN15SITTQ=;
        b=Kzc8pnvaWbfdsjxC3EwGaQg/XkWC0x5nTWYE2o53m4qCt+yuOlgB1Zi+tA1IuG3Lfx
         mq86bXFvV/x74D0BivebINHrFgAOp4yLnYcufD9OKEmC4Hm+kH9stOvjdaHBZ7vRdFEj
         lfUDIxU0rbB3+L7+htnXd951sjxX9WFWWptQ+AKo/YFyjma4P6/gFlWHxTxvk9lJWFhI
         hlbNKd7esaACsgBmvqlpmnXJOEDZqRHZ5mkk0Mmj/lczs18EbCylYafdzZbq/hWJFd46
         oqWRe6snsIa3gzws1Y7qt3MQLBSXvTgAYoA+7BoNLDZ5myg4/PsTZLQ851sT29+5+kBf
         XPJw==
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
Subject: [PATCH 4.14 143/164] MIPS: memset.S: Fix return of __clear_user from Lpartial_fixup
Date: Sun, 22 Apr 2018 15:53:30 +0200
Message-Id: <20180422135141.322987742@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455264978774304?=
X-GMAIL-MSGID: =?utf-8?q?1598455824091199660?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -252,7 +252,7 @@
 	PTR_L		t0, TI_TASK($28)
 	andi		a2, STORMASK
 	LONG_L		t0, THREAD_BUADDR(t0)
-	LONG_ADDU	a2, t1
+	LONG_ADDU	a2, a0
 	jr		ra
 	LONG_SUBU	a2, t0
 
