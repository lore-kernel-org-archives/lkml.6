Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49Tcvitb1irbrzbesByzTg/kaLGPBoPwLeHUIbjpGDXmP9jKI/v2y2Ps/fSiPL8KPubiasr
ARC-Seal: i=1; a=rsa-sha256; t=1522168644; cv=none;
        d=google.com; s=arc-20160816;
        b=rVtog0naZz9RUJFPNqtbTlyTgJxTlCBDQJUOfKCTMOCH+JP7d9wNRzqqXwo8HDy3Tk
         2oMLKqA1FUwGoilgA2bKth7tfTW633boXQEfDjsgFgwRrAf/nA1R+OTN3bjrrK6MAh6Z
         +ZfrcfarIdNrLQBt8T1YtR65lpjm+m1Zb8HFe6fnHIiBN+l6mIiT2kVvZopG2KO2E6ln
         6YTK4aycg/5/HEpjANonvvFVT9iiupkoyspCi9+ap0nuxiOCM2N3F20MyGpZobQI4aLV
         ZXbvd9VYellHlCSHuSXgiCBMeuqBHY1lBHiLOxTN5xcf7a2qFMgWxm3UzYZUdWFez6On
         k4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZRbpyWU6cENxrPnD8nqnrvk1F940VVGNYWd9P317CfA=;
        b=ZzQrqTyNpUMNvVOFURBbm8Qc+FhcvRd2PuHhtaYVgSbkqwU/xOGUebxQS/jwp0loAq
         WVFV/Ko3UMmz3O90UANX3/SIKk8HiRwm9ZTQcCMxb0qk17JNc9yOxeEtPbsRXbSpI8yV
         M1fuPmPa5TqHnl4eLuQIJWO/GuHXL553igR8nx3LHzfgiJtvL93ihELLM5Rjcq+4jk21
         /C5i1bjCa8wmXzvwQugndwwo1VooDNUccKTgmWa0RTVWYmYeWSwErtyYpOByptCiblIx
         eiGVFOhxBmPFMojBfvPKacD8XHFwp0/X8Xc18fhYaiJ3QWNge2dUTC0LBiQygG9ktIy5
         Yk6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Waiman Long <longman@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-efi@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 081/101] x86/efi: Free efi_pgd with free_pages()
Date: Tue, 27 Mar 2018 18:27:53 +0200
Message-Id: <20180327162755.041436623@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109508223875583?=
X-GMAIL-MSGID: =?utf-8?q?1596109508223875583?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <longman@redhat.com>

commit 06ace26f4e6fcf747e890a39193be811777a048a upstream.

The efi_pgd is allocated as PGD_ALLOCATION_ORDER pages and therefore must
also be freed as PGD_ALLOCATION_ORDER pages with free_pages().

Fixes: d9e9a6418065 ("x86/mm/pti: Allocate a separate user PGD")
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1521746333-19593-1-git-send-email-longman@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/platform/efi/efi_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -227,7 +227,7 @@ int __init efi_alloc_page_tables(void)
 	if (!pud) {
 		if (CONFIG_PGTABLE_LEVELS > 4)
 			free_page((unsigned long) pgd_page_vaddr(*pgd));
-		free_page((unsigned long)efi_pgd);
+		free_pages((unsigned long)efi_pgd, PGD_ALLOCATION_ORDER);
 		return -ENOMEM;
 	}
 
