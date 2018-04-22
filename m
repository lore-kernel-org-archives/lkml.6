Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4897y9GZ6Ng4rbGpKUXLXmrvl9jZbP3f0EVhCfUa/4WfoscaPSpgDp0NFdagYzMwEhY5Lsa
ARC-Seal: i=1; a=rsa-sha256; t=1524406897; cv=none;
        d=google.com; s=arc-20160816;
        b=mQiZ7yh6ZlBkcexrON3v9L+cWgNV7Cx6UlPdWMl7DKYcwccTm1BLBJVcC4FETIM3ZI
         A4D8oaoxTxBltyGBLZYO4shqU3EE6XDBKCRmvpRwcUugR7H/So+ZEMVI5vlrXrFL42pq
         TB7T7hd8bn+Nu9L1rXxxboRJoYMHIw3H83uYnv5+cGeSnRqEyO595cdp01n/XAdTob9d
         usHUxBHmY3qn77iX0XTceF2HCstMM1wg8FFPvMbNtMqGp94W4bKOUGovn4MRqJXYTwUC
         YJwc+GDZzfaFcN1oOzTg71kU6lcVdMqzOMsvdeMR6ixqEEHzQd8RtPKD78cvkt8wLguv
         LznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lIxakWpIuY6813CrwEr1fHpso4qOlKBmYtNyoC359qg=;
        b=04y7uq7jwFZbb6aKjQyH6bIl10lDoePG6GfFPOYLJN/6x7QQHtuIm9MP9vaOiFScOc
         BLkmb6tczFsT2uVPDDApC7xtTF3OmClAF3khPuJRXxKvA6wMkqvITeQpqy9xPkvUAIvI
         86V03Ocfg39uDOZgGhHi2e9sRcWaSrxCxQUozYd91nlcSyPrKAVNjzrdRXjgxTwyd6Go
         pb5uC4bfoCakkdUrFz6bPX7UEswdszsDBRzO8AUcQkasA0nt5VxIJkwPYFMbEqgiwkSU
         opoAx42Mhmh05qQsTawHq22EQzPjufy+5hLNiQQlEjzU0H79k3pnjaXJXqbWxodmx6n7
         lRcQ==
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
Subject: [PATCH 3.18 44/52] MIPS: memset.S: Fix return of __clear_user from Lpartial_fixup
Date: Sun, 22 Apr 2018 15:54:17 +0200
Message-Id: <20180422135317.399275218@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455264978774304?=
X-GMAIL-MSGID: =?utf-8?q?1598456486784308452?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -204,7 +204,7 @@
 	PTR_L		t0, TI_TASK($28)
 	andi		a2, STORMASK
 	LONG_L		t0, THREAD_BUADDR(t0)
-	LONG_ADDU	a2, t1
+	LONG_ADDU	a2, a0
 	jr		ra
 	LONG_SUBU	a2, t0
 
