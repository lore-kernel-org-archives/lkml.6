Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48RSLdNWHXhSsM80H3BOBqRRBnyrZkLxspcgudpF2a64cy0QAJXnfDcSL/CAXNYAFbErWgd
ARC-Seal: i=1; a=rsa-sha256; t=1524406894; cv=none;
        d=google.com; s=arc-20160816;
        b=uswPtmJiyI3pH6eQ6oUjKdcuCInoZeuSXa3k2UAK83dcJTXOZM//rgjXeOUDFJ9BK+
         QrmHwxB+/2Bz76Xi/1eQGAfu5V5Afwkm7wMa8l8yZEqBMSpzSj/iJ2b70Obmq8lI3e5K
         miCcHHH1V4DKI+mWB/v/rxkp4tYt0ohQe8iH5WX9iW+/Ia6c1bVbHmPGqgCt4YrP8FuJ
         Emq76YjwOf9BMeN/yibbZ2Ct7xzpexhSanKDhga7ywkICLzvoU4LJcZEYKvZfrPagNnp
         yETH4vIINgbuIFaehU5rd6o+rlPas4o2cfRiuRulBAiQ+mHmlRQSUWQGDeX8KFXh0BEc
         vYeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mcSQud/jpEZOGO58OGq+hHUIWS4UTd7MoyMNy0mDbz8=;
        b=AHyug17XOivHa0f18+nVz4BURqENeftpwwN2RoicZnve/UmA6w1V7d/Fy2Hz+ckekH
         g6bHRL9elQha+BgEG4oeIzNEkJJ7LNz/+rlKEwDf2M+sqcRP8HQjcY/kWRW6OwK9YlNj
         sil0E+mG2Zkq9n6u6rPjaeTZYj/zh67ExDcWRhnY8luGICDFUS8LGQuCmy+u+dFTLUb2
         +6DgPDOP1KbZMIsZcSbqCRzwL3qEVjpRN9sAHokyMYM789zBDpFqihjyfN2YrYaFQA4y
         9vuOBNHMRSB5kbHut32PkW7aPhX7vcCpo+e4HmY4I0Qui+BfqYAwkMVAgn+p8tu/8uOi
         wfLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chuanhua Lei <chuanhua.lei@intel.com>,
	Matt Redfearn <matt.redfearn@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org,
	James Hogan <jhogan@kernel.org>
Subject: [PATCH 3.18 43/52] MIPS: memset.S: EVA & fault support for small_memset
Date: Sun, 22 Apr 2018 15:54:16 +0200
Message-Id: <20180422135317.359576812@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455262967185714?=
X-GMAIL-MSGID: =?utf-8?q?1598456484096613267?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@mips.com>

commit 8a8158c85e1e774a44fbe81106fa41138580dfd1 upstream.

The MIPS kernel memset / bzero implementation includes a small_memset
branch which is used when the region to be set is smaller than a long (4
bytes on 32bit, 8 bytes on 64bit). The current small_memset
implementation uses a simple store byte loop to write the destination.
There are 2 issues with this implementation:

1. When EVA mode is active, user and kernel address spaces may overlap.
Currently the use of the sb instruction means kernel mode addressing is
always used and an intended write to userspace may actually overwrite
some critical kernel data.

2. If the write triggers a page fault, for example by calling
__clear_user(NULL, 2), instead of gracefully handling the fault, an OOPS
is triggered.

Fix these issues by replacing the sb instruction with the EX() macro,
which will emit EVA compatible instuctions as required. Additionally
implement a fault fixup for small_memset which sets a2 to the number of
bytes that could not be cleared (as defined by __clear_user).

Reported-by: Chuanhua Lei <chuanhua.lei@intel.com>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/18975/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lib/memset.S |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -178,7 +178,7 @@
 1:	PTR_ADDIU	a0, 1			/* fill bytewise */
 	R10KCBARRIER(0(ra))
 	bne		t1, a0, 1b
-	sb		a1, -1(a0)
+	 EX(sb, a1, -1(a0), .Lsmall_fixup\@)
 
 2:	jr		ra			/* done */
 	move		a2, zero
@@ -212,6 +212,11 @@
 	jr		ra
 	andi		v1, a2, STORMASK
 
+.Lsmall_fixup\@:
+	PTR_SUBU	a2, t1, a0
+	jr		ra
+	 PTR_ADDIU	a2, 1
+
 	.endm
 
 /*
