Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Cji5rLkCw3X+CjCpGKcrmGicaRBnlmXvNTTPw4LTEZizAP04Yhe6TURWW/MhoScyKIeKO
ARC-Seal: i=1; a=rsa-sha256; t=1524406468; cv=none;
        d=google.com; s=arc-20160816;
        b=MSWmNzVkNIgVjlapwG2rVrCFCIeNyFx+4AVXLLIo80wxpD+HfFO/7K0aCzYWusLKjt
         +AHEi3rEQERxYCO3L2dTwOxK3Y/eMRLs/Y0B5dpvJ/pfMXf6CuCLfUIyZkAce8fEmMBw
         3P6wNZjR+BX+A49tSZMW6lV/vu+2Kb31cPebsXr7JaaEopflCdHAwaWOlJRIAvyRJi+i
         NWbT2JtX0TAurfgU95bgWffdLv0YB0dKNj+KIH/+4uoYJTOMtyRbbRREytfYeu+PGy1B
         TXK2vk6h7KlyVz1BbDCKeSQpTvob4zUHdaSWzbulaCUJ4zeu0xQ7TKYL9wG+dq8QuVxX
         2rIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kn6k1H9w+aEWWdLgItIZGHu2+znAnCYtrqhrKy6AKQU=;
        b=JixOtvYocdaUnJW/tCFvO0HjgfvIDrJgpTUpvDFanXvn1+5Wr3AmaKqZNLEcFmJssi
         Qcd/01Kjvjf4eOHmzwRu0drwS2xp83SWTr00yZlcB8LiPLVPvdUEZKFBixYyfs7H00Lk
         scgEk/aU1yGHoQS/pjz4jlWMUv3j6UH6Tix6oU4XmUCego+xluPbHhofE9H7lNJClArU
         tOZkJYh+DL6PDciPWzcARLdblt4SaJju0ufAiekItRAmmeJUd7Fa7lSP+bYsjN/xqSe/
         pEYMM+eQkTNnTT2xUwH1vkVN/+ujPBB5UMRHKFmofi7VeiYoFQftj7dprSO/qL/obkJ8
         ZrZQ==
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
Subject: [PATCH 4.9 82/95] MIPS: memset.S: Fix clobber of v1 in last_fixup
Date: Sun, 22 Apr 2018 15:53:51 +0200
Message-Id: <20180422135213.782881483@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455270804661651?=
X-GMAIL-MSGID: =?utf-8?q?1598456036394721045?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@mips.com>

commit c96eebf07692e53bf4dd5987510d8b550e793598 upstream.

The label .Llast_fixup\@ is jumped to on page fault within the final
byte set loop of memset (on < MIPSR6 architectures). For some reason, in
this fault handler, the v1 register is randomly set to a2 & STORMASK.
This clobbers v1 for the calling function. This can be observed with the
following test code:

static int __init __attribute__((optimize("O0"))) test_clear_user(void)
{
  register int t asm("v1");
  char *test;
  int j, k;

  pr_info("\n\n\nTesting clear_user\n");
  test = vmalloc(PAGE_SIZE);

  for (j = 256; j < 512; j++) {
    t = 0xa5a5a5a5;
    if ((k = clear_user(test + PAGE_SIZE - 256, j)) != j - 256) {
        pr_err("clear_user (%px %d) returned %d\n", test + PAGE_SIZE - 256, j, k);
    }
    if (t != 0xa5a5a5a5) {
       pr_err("v1 was clobbered to 0x%x!\n", t);
    }
  }

  return 0;
}
late_initcall(test_clear_user);

Which demonstrates that v1 is indeed clobbered (MIPS64):

Testing clear_user
v1 was clobbered to 0x1!
v1 was clobbered to 0x2!
v1 was clobbered to 0x3!
v1 was clobbered to 0x4!
v1 was clobbered to 0x5!
v1 was clobbered to 0x6!
v1 was clobbered to 0x7!

Since the number of bytes that could not be set is already contained in
a2, the andi placing a value in v1 is not necessary and actively
harmful in clobbering v1.

Reported-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/19109/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lib/memset.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -257,7 +257,7 @@
 
 .Llast_fixup\@:
 	jr		ra
-	andi		v1, a2, STORMASK
+	 nop
 
 .Lsmall_fixup\@:
 	PTR_SUBU	a2, t1, a0
