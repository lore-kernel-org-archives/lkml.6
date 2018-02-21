Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227YTFmPyongUCkqAf9N4a35sR5Gr+bYGGjFSa/xmfEbHIHZeA7ayR125l0J61uUAZCtyTUu
ARC-Seal: i=1; a=rsa-sha256; t=1519217902; cv=none;
        d=google.com; s=arc-20160816;
        b=x3vulYsEaqK0JOLHwxa24HCbiDp7TKqGI8J5E6rdfAuwWctaI4rKKBzDhYFVkhcQpR
         fiKTcT+mNj/W/r2kcrtcOxeJ7/PWjk6XoVXbNS1W4+ZMPtNlE4NmEaVgLMsEMpSGTTvu
         pbphUxl46WBd8XsOeOB6SWd3kTiQbHE468cBdV1rrrDWSU+T2frocLbo4Wta70OS28Er
         sgn8knwVPi4CITP2vpEqhOQIfJnS4yoiQjBLJP1TmBw2G5sXYW4Zr3OSS609VgW0rqPv
         Hn8PXPw8ichF0Qmplzj5OWNpEHiWQzciOD8n1igTxszxir/z0AwUBwr5e2c1MYpKW/fD
         psxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=v9DZ8O7sPeEly3E8aGLMIWsgmqiLLXU9NLVLTl6A4Ko=;
        b=tg23sG3x5JBLAFXrzCHOnKkeCRxo0fCBU/NR7msulRV9jTnbZZyumD69bryof6IWSI
         bgKnsefnnPjaj/p3gQbWeEhQ3Chq+Z7YmWIducRsCZaX6Z0+zeu9uJmY+J+JN49xjP65
         gHbFtddsp+3DgNoj39/OqhCEtWbj3/Lm3ZgYm3RCY5WUmIQjw9lFm6eyjJVyhNKPcLo8
         BLSZCdMF3pi4hc77kQCpgYQ+UImorPD2U3Jq9e1ksFY0NZXGRFGiyaRAApgTa0tYUwz4
         HyYdtC0+QNiQnnn08DsCRnqgByoQr3tPXmxAM4zlwBIaW3LlTVYRoNm0+qhah7a9Bhi5
         KsQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	Balbir Singh <bsingharora@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 019/167] powerpc/radix: Remove trace_tlbie call from radix__flush_tlb_all
Date: Wed, 21 Feb 2018 13:47:10 +0100
Message-Id: <20180221124525.656642817@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015431627887973?=
X-GMAIL-MSGID: =?utf-8?q?1593015431627887973?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

commit 8d81296cfcce89013a714feb8d25004a156f8181 upstream.

radix__flush_tlb_all() is called only in kexec path in real mode and any
tracepoints at this stage will make kexec to fail if enabled.

To verify enable tlbie trace before kexec.

$ echo 1 > /sys/kernel/debug/tracing/events/powerpc/tlbie/enable
== kexec into new kernel and kexec fails.

Fix this by not calling trace_tlbie from radix__flush_tlb_all().

Fixes: 0428491cba92 ("powerpc/mm: Trace tlbie(l) instructions")
Cc: stable@vger.kernel.org # v4.13+
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/tlb-radix.c |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -453,14 +453,12 @@ void radix__flush_tlb_all(void)
 	 */
 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(1), "i"(ric), "r"(rs) : "memory");
-	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 	/*
 	 * now flush host entires by passing PRS = 0 and LPID == 0
 	 */
 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(0) : "memory");
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
-	trace_tlbie(0, 0, rb, 0, ric, prs, r);
 }
 
 void radix__flush_tlb_pte_p9_dd1(unsigned long old_pte, struct mm_struct *mm,
