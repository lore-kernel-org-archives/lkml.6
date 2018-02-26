Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsi2aTm6C1Ol5nUnLmtoO5VMIDtiiAHKRHtwTm7D7/6ZXq0xDPBy2bC81+FnqilELil7+ND
ARC-Seal: i=1; a=rsa-sha256; t=1519676629; cv=none;
        d=google.com; s=arc-20160816;
        b=IotYIA3bMixsFUizqEew92AFiVelX8fUUFKIkf9R3XlFAokUNvV5ZJKzZflVv5GM9F
         Om67WqMGy2qwkpTXrmtomnvPrm4fVHLjsbG6/m1SaECc0Jj42MWMR4m8cm9iYVtFyPr5
         XPVCPXdcALW//QjCpkZhrPYngky/1NYsJeSUYfiICT97xgxzJ9nxTvnQrNnn9jPpRgE2
         G7vfoB0J13rCIVO3k57bCkJe1IhIB8X+P2NVVFl1nKtz/c2kW/HOfoqWJViuL8IhRoiW
         +ibCGaeJsbwyOl+uSrwlnSthOH9FQSBDqS29Vg8OTxKZzyNz/oU+B/OkA/Zfc9wgTZW+
         cUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yNTVGHdBPsWZBoF7Cy3KS0aD8K73X91BxU5KgE4+ZEo=;
        b=TLlcj/AwskkfDNwmIysIc6ZgUkKeKHoKRi1W8JPvYZQ3NxEiT/5nwXHTQ6QyezJzLv
         ny4vyYXq+PO/YZuROuDTOpo7Pm/5gB4+d8EYvRlfa1KhJ+y1gWlLKjXr0M+NVB6g55Ov
         uWSI5Gb1ax0d50znNTV22VtHGH3XtRv2xizjdXdInTtX0Twd0fmmGYDwZG7p592B2sd2
         aPdi4UIC9ytYcpM9HgS+fiyviFn5n5Z5S+j5Kl733jZbN3je4SNqY0Yyr0SVxcKxLGLo
         YXC4MKyAs97kNdrcMtqDPVDwViuJeVnnOzhcU7Bmf5Q09cdKMIQuPqzqZD/EnOx+X6U6
         zlGA==
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
Subject: [PATCH 4.14 02/54] arm64: mm: dont write garbage into TTBR1_EL1 register
Date: Mon, 26 Feb 2018 21:21:39 +0100
Message-Id: <20180226202144.483348512@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496441412121999?=
X-GMAIL-MSGID: =?utf-8?q?1593496441412121999?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
