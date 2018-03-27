Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48uKhaXsyhwNTwN7oQ3/8MncMX21fOyPOiPGWaWgL3edgdS8bKmtp+E0gl/lq/QVZjM8MiA
ARC-Seal: i=1; a=rsa-sha256; t=1522168938; cv=none;
        d=google.com; s=arc-20160816;
        b=sQOCDkTlgfGKc2L6IBMSIXbMk01GqS8pY+tjGFpKHyG/7B0kiFsCka/WjTEkUWhQdU
         YnI2KjLXaYkKM4RC3fgY0WBS/SacQaXywul9UyErS0R9Lc5ciKKZG/xf8a0I75ZJbWOp
         Jh/aPBLlmZbF9Tg6IfElB2FV0VO/SLU92ML0xdLl6f+1VWF6EHFQgtroaKeeHe39lXgx
         16/7NwGNuAPJB9RE2VJRpgcJMrarw1YRfjUUoK7CuIPC3qSngJ8Mj3PPuy+f9jPK21cb
         OoR7UteqC8cNNCSWLlhbHhqbstD95IM/P+4tTl8QLgnAMFkk0j0PiLhZC2oEWlC8QFYK
         bd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Z1uNSY1FvUaBWYLTnQVIobn1cLoiDl1NjU7ihRMhXhk=;
        b=op43D3+KzkQRSVID+1f7hSnGSDYRxQW75LKknsXb4ZrbRc0f+7nnBPOF2A88L17nTL
         RYoAH+xiPmpOqtiIFDJA20fGx0V+OMsQ04E2mmaEWujaFGFtgwUGU3X/UMtrcO1Qhlrk
         k79mzzHpc3AtvBgLvNoj0vP9YCxkLXkIHIKf8QYHFu+ng/PlYSAwlieS3HhH+B1E4WeV
         s8OWF5QW5VarlidFK5iNuq27zA6z6a9EJoqvIqiyijEpmblMnjwieiycy4KHQVxVu2NU
         7GFauvv56gB/kanZMpEi6N7sFA6Dr6trLys//c8eA0g349HXL3H7oM4qFtAOryikWADn
         2YRA==
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
Subject: [PATCH 4.15 086/105] x86/efi: Free efi_pgd with free_pages()
Date: Tue, 27 Mar 2018 18:28:06 +0200
Message-Id: <20180327162803.520307492@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109508223875583?=
X-GMAIL-MSGID: =?utf-8?q?1596109816858138021?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -228,7 +228,7 @@ int __init efi_alloc_page_tables(void)
 	if (!pud) {
 		if (CONFIG_PGTABLE_LEVELS > 4)
 			free_page((unsigned long) pgd_page_vaddr(*pgd));
-		free_page((unsigned long)efi_pgd);
+		free_pages((unsigned long)efi_pgd, PGD_ALLOCATION_ORDER);
 		return -ENOMEM;
 	}
 
