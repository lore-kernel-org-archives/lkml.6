Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224B67wGDhgkpfIZhAE4z5HD4vG6kWYtkRMFtRGFYXXnHLk9upPSEI5noMWj+wz4W9IbEoua
ARC-Seal: i=1; a=rsa-sha256; t=1519676801; cv=none;
        d=google.com; s=arc-20160816;
        b=QDKNacPXk0exy55M49I9ugB2cEZYbAR9c8C+Uz8dLvWKPpQOA7ZJYGPSOYuWo3yv1F
         ux71h65bf357K/v8eqX5wFpIeCUMAsnR3BatIshS3cJXknOZ/jrkgBFHqJyfYCoTmnzo
         RgmLMQF/xtOoZvVDa5BJrlV7hA2J/pTrW3mq1ZZ1bwsemGL/rswz7W6ZrkItqbNgIXgq
         eE0jOmxrxmH6KWC18aHYkOrMQHSLzuuS+5KYwW8yN5ZW0Os4cMl9kKMjKY9DvQ6l9TX6
         hQ20DtSDcb4iBTx0qHQyJlN4DcWCnt+r9HXkcHYwD15CkAT4j6M5Cos+RlikLOGQj/60
         d1Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wQhfSaKrdkblMerMNF4n4SeyuCx2TmQXbFmghVkJW6Q=;
        b=ERtZZUrJ4N8F8N0T9ZaqAUlDMx0HFyZihMFgxtWbBnqEQdtSCoB6I0RlHr2uNbfvDy
         sJl0pNZJWx5AxZIwBcpsPrWJjDrli2irP1vED7a2FzLB0kkYmDy8qJTvwAENW06c2rvH
         mXOxHNJysbxp7fI6mhgWwPd2KzMaa5JffuQGVcC09rOg+EZ/nrBL7nj6ukcikWXMYtIm
         R1ilJRN4usF+2KfE0G85FwXFbuwZN2/BXRnfx0L4Aq+7oQA9pxWITbIj0/m5V3s4UUy0
         0oFgWRDpUEjy5ccAzvYFY6+4vtFcWE3FUB8w86Bu1MhSJO1gSaoctwJjfw0STxWoHm44
         Q0kQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nicolas Dechesne <nicolas.dechesne@linaro.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 02/64] arm64: mm: dont write garbage into TTBR1_EL1 register
Date: Mon, 26 Feb 2018 21:21:39 +0100
Message-Id: <20180226202153.550888076@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496441412121999?=
X-GMAIL-MSGID: =?utf-8?q?1593496621658560853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Stable backport commit 173358a49173 ("arm64: kpti: Add ->enable callback
to remap swapper using nG mappings") of upstream commit f992b4dfd58b did
not survive the backporting process unscathed, and ends up writing garbage
into the TTBR1_EL1 register, rather than pointing it to the zero page to
disable translations. Fix that.

Cc: <stable@vger.kernel.org> #v4.14
Reported-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/mm/proc.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -155,7 +155,7 @@ ENDPROC(cpu_do_switch_mm)
 
 .macro	__idmap_cpu_set_reserved_ttbr1, tmp1, tmp2
 	adrp	\tmp1, empty_zero_page
-	msr	ttbr1_el1, \tmp2
+	msr	ttbr1_el1, \tmp1
 	isb
 	tlbi	vmalle1
 	dsb	nsh
