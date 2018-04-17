Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/8rphfOq94h4cY6dCMD3+ruU08FyZwcyPSezgBpxucHBiuvHPIFAw4RN/XLrTAwC2wZ0sv
ARC-Seal: i=1; a=rsa-sha256; t=1523981011; cv=none;
        d=google.com; s=arc-20160816;
        b=ptyGJ1sBfJow3Y5FStbEOT/vRi7DdfDQ+7NQfXQbACMwuiVR8pjihigfdg+Xp1VXd7
         0mqGY4jXpgwy0xNk2M0rxG2GxpVO7aHK+LgHfq9flRJZLnpKuLDfZCTf68ObviQQolUa
         qHIJRZO8q7mZtpIcqJSRuZZluUOqfW4D1WSSuGxKeMTVaLggtvIK5EJyYbGGRzcQHyWa
         NKan18J9Sx8aRlM27/at489r9OXPXPHgU/+Lt+TMsiHq76U+p7YeOgiekEJPJKOFXwLd
         7guiK21bdn6pR5u2J4X74mAc/WHrB+1iZUJ6TqPBW3bQm1GsHQbEvzeOFIsnNTp2s/tw
         3uuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3kMZ/1Z4OVhaZRVpCvhR1X7myHCM1Ei0UDNuoRaZDIc=;
        b=YUm1C5eI9esmufbgTcPaHtj5tA5xTDa/bZlLR4RohVZcPIsmJ7Tv0WMz02cokrwFti
         N47/ayGQ0e+dm7Gj+U/0ffdkI9ePLaagZSoKVOvvJKYabIO2gZ3GgRpFiyko4rPtYCey
         t3cQh9ImubnYnqF7juKw+IZ3fWNnWpYabauqfpcEBn+hvizq5d1hN3Sr9KnLVA0U6ohy
         gh6nRosIJNZW5f1l6BBAhufPlA8J694YI0ZpXKvuxi45Lkk7kTMU0i0f0pg8tITSASNs
         FO4nNByLoXddZ4TCQznObXXuBSSmHyIhOKj9+BCH7PHDFlfgrjgOZIpuv9VZgNJwLZJB
         sx4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 4.15 16/53] parisc: Fix HPMC handler by increasing size to multiple of 16 bytes
Date: Tue, 17 Apr 2018 17:58:41 +0200
Message-Id: <20180417155723.911973594@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009710354383751?=
X-GMAIL-MSGID: =?utf-8?q?1598009913544000064?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit d5654e156bc4d68a87bbaa6d7e020baceddf6e68 upstream.

Make sure that the HPMC (High Priority Machine Check) handler is 16-byte
aligned and that it's length in the IVT is a multiple of 16 bytes.
Otherwise PDC may decide not to call the HPMC crash handler.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/kernel/hpmc.S |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/parisc/kernel/hpmc.S
+++ b/arch/parisc/kernel/hpmc.S
@@ -84,6 +84,7 @@ END(hpmc_pim_data)
 	.text
 
 	.import intr_save, code
+	.align 16
 ENTRY_CFI(os_hpmc)
 .os_hpmc:
 
@@ -300,12 +301,15 @@ os_hpmc_6:
 
 	b .
 	nop
+	.align 16	/* make function length multiple of 16 bytes */
 ENDPROC_CFI(os_hpmc)
 .os_hpmc_end:
 
 
 	__INITRODATA
+.globl os_hpmc_size
 	.align 4
-	.export os_hpmc_size
+	.type   os_hpmc_size, @object
+	.size   os_hpmc_size, 4
 os_hpmc_size:
 	.word .os_hpmc_end-.os_hpmc
