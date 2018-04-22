Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48MADH0Iy/7NCiikusWC+2CxmiEJ4fQbJoVEhhlo7LZjRph8zZHzYv46P6mNPN2SgMc2Yyp
ARC-Seal: i=1; a=rsa-sha256; t=1524406208; cv=none;
        d=google.com; s=arc-20160816;
        b=mHlMjn63VrR14Up9VP5rW7c3O5VW9+7szVZ0OdUOHwcOVQl7Ya4E7Autg47zBg4JIR
         EAQ2jlsM7OKgwvu8niUdg/g2Sqj018gk0MO9YjzGigXAEmTSpxJ02+HQBFR/w/gQ5lXv
         2GZ0od37/+Wj1AhypqAqtIwvhXXiYM/pdsBl9CpzVU7VsZp7KCM+j1DrzOI8uTEdmn/b
         TTrcDSdMg6KYwG/mZkIZCQYLS5pMDTznMD7o/wDNasPoaJGdqu70HnxZk75wE2sFuVcK
         a/z0JsoqdfKq4cojTXjM9Ss+Fx4/774eWu8XlIrbFxUp8WX+bqMylO51svudOzMvLFjO
         ykQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qSeqefD5js1q+og+jJXiLL7fECCZeEUqpvB4FGcxbmg=;
        b=0e4xxrT8/Rtk2YvxgVAaF1SR3XeFcB64dSJ+5bkEOtcMkezvrZbdXG/6YgNwJgep1u
         BHqklBEw/iC2wLmstt6IbPbncLyYzQHWA3kLP4gFlgOoBxUFo74bpaIeimCEMHDFMNaA
         FoYedsMWtCGoRxOOX1vlbckMJA+9d+IfMU5w3mhAgNAKpLy0uX2XIZ8A82xTX2/eOQR6
         owlNqt2PLUl0PGojkaTBGdWj46kqRAliq52GTSDmxEyH1O004RdWf8eU2BPzY/SMAWHP
         EjjmIjTMiLgEP7CAQgYz+gSIA35zBVozkP1Kq9kmxXIRcvKAVpUg9fvBHOvB9nPd20fr
         RwXw==
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
Subject: [PATCH 4.14 144/164] MIPS: memset.S: Fix clobber of v1 in last_fixup
Date: Sun, 22 Apr 2018 15:53:31 +0200
Message-Id: <20180422135141.371839514@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455270804661651?=
X-GMAIL-MSGID: =?utf-8?q?1598455764175508039?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -258,7 +258,7 @@
 
 .Llast_fixup\@:
 	jr		ra
-	andi		v1, a2, STORMASK
+	 nop
 
 .Lsmall_fixup\@:
 	PTR_SUBU	a2, t1, a0
