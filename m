Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoZ7NvJiGkjWc/bF9r7ZqMNwLctbv8YWV3P1OA3YrbsW8+FWNQ4lMTfHMO8BvYVxayBMPDE
ARC-Seal: i=1; a=rsa-sha256; t=1527156171; cv=none;
        d=google.com; s=arc-20160816;
        b=LZMaRD+Sb4aiy2n/gkrlxte8tzqXOreSagnVSqPj2krbvspoTgWUuWh9FNuUp6AFlo
         xENPMLRetDeGXp8PR9z7wOxXm74Z5gvrArq+II0J0BxiOEqM5xDTIF1x6tV/YD46IQ7B
         KM4g893HyU7t/d4VU8IX+/7KXHCWsgp3GMMmNXtnpLpBFqjPmoh4lbfEu88vYxOzn/Oq
         bMZIRNWWaBZRx7f7w5Ec4hVvW3jbiUdbaviAMtCmje2NNob07/w/wmv46EDJHug9UCiI
         cbU/ocJFxhSby9zpRL/mUG70WcL2WaXWgr8JHCF7DNBvowkTWOH9wAFB0WVG/Ot29AWx
         KhbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=llO5OID4YoWV2mk4+fSKm0358uhiuBIluMvJldNyuUs=;
        b=sq7bfFkLd1e5EUvN01z5/4/Y/TZwgFbKvtIam+AwdcleI+l8bIhhBNI4uPimQnM+Ye
         Odw2YZ9suvudpXsDzYS5J+MtcuuhcGL7hX40rRxq6kMwvzOIwqVP6M6TM2f8e+bP6cg3
         BlDTD0gON0q+0DChDaN9EvDxY9VwnPRHNExm0gSWmDmm8euQLDHzyL+/2dIIXEkbLXhR
         z7aGaTBxOA+rsuu0BV3dpf8bel1LYhBpfqC3MNnTWWvMVCqu6/rhXQlm6L0i5/2yyo68
         Lh2q49x3Yx+h4tUfRUYKh1cGlQROa5a9azy128NdXmRtOraPESU1rg0Lkr6Nn4AwwNSQ
         yjBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BW50lwY3;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BW50lwY3;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot <syzbot+d96f60296ef613fe1d69@syzkaller.appspotmail.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Thomas Gleixner <tglx@linutronix.de>,
	Baoquan He <bhe@redhat.com>,
	thomas.lendacky@amd.com,
	prudo@linux.vnet.ibm.com,
	Huang Ying <ying.huang@intel.com>,
	syzkaller-bugs@googlegroups.com,
	takahiro.akashi@linaro.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	akpm@linux-foundation.org,
	dyoung@redhat.com,
	kirill.shutemov@linux.intel.com
Subject: [PATCH 4.16 089/161] x86/kexec: Avoid double free_page() upon do_kexec_load() failure
Date: Thu, 24 May 2018 11:38:34 +0200
Message-Id: <20180524093029.112448487@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338027570262893?=
X-GMAIL-MSGID: =?utf-8?q?1601339310317978726?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit a466ef76b815b86748d9870ef2a430af7b39c710 upstream.

>From ff82bedd3e12f0d3353282054ae48c3bd8c72012 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 9 May 2018 12:12:39 +0900
Subject: [PATCH 4.16 089/161] x86/kexec: Avoid double free_page() upon do_kexec_load() failure

syzbot is reporting crashes after memory allocation failure inside
do_kexec_load() [1]. This is because free_transition_pgtable() is called
by both init_transition_pgtable() and machine_kexec_cleanup() when memory
allocation failed inside init_transition_pgtable().

Regarding 32bit code, machine_kexec_free_page_tables() is called by both
machine_kexec_alloc_page_tables() and machine_kexec_cleanup() when memory
allocation failed inside machine_kexec_alloc_page_tables().

Fix this by leaving the error handling to machine_kexec_cleanup()
(and optionally setting NULL after free_page()).

[1] https://syzkaller.appspot.com/bug?id=91e52396168cf2bdd572fe1e1bc0bc645c1c6b40

Fixes: f5deb79679af6eb4 ("x86: kexec: Use one page table in x86_64 machine_kexec")
Fixes: 92be3d6bdf2cb349 ("kexec/i386: allocate page table pages dynamically")
Reported-by: syzbot <syzbot+d96f60296ef613fe1d69@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Baoquan He <bhe@redhat.com>
Cc: thomas.lendacky@amd.com
Cc: prudo@linux.vnet.ibm.com
Cc: Huang Ying <ying.huang@intel.com>
Cc: syzkaller-bugs@googlegroups.com
Cc: takahiro.akashi@linaro.org
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: akpm@linux-foundation.org
Cc: dyoung@redhat.com
Cc: kirill.shutemov@linux.intel.com
Link: https://lkml.kernel.org/r/201805091942.DGG12448.tMFVFSJFQOOLHO@I-love.SAKURA.ne.jp
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/machine_kexec_32.c |    6 +++++-
 arch/x86/kernel/machine_kexec_64.c |    5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -57,12 +57,17 @@ static void load_segments(void)
 static void machine_kexec_free_page_tables(struct kimage *image)
 {
 	free_page((unsigned long)image->arch.pgd);
+	image->arch.pgd = NULL;
 #ifdef CONFIG_X86_PAE
 	free_page((unsigned long)image->arch.pmd0);
+	image->arch.pmd0 = NULL;
 	free_page((unsigned long)image->arch.pmd1);
+	image->arch.pmd1 = NULL;
 #endif
 	free_page((unsigned long)image->arch.pte0);
+	image->arch.pte0 = NULL;
 	free_page((unsigned long)image->arch.pte1);
+	image->arch.pte1 = NULL;
 }
 
 static int machine_kexec_alloc_page_tables(struct kimage *image)
@@ -79,7 +84,6 @@ static int machine_kexec_alloc_page_tabl
 	    !image->arch.pmd0 || !image->arch.pmd1 ||
 #endif
 	    !image->arch.pte0 || !image->arch.pte1) {
-		machine_kexec_free_page_tables(image);
 		return -ENOMEM;
 	}
 	return 0;
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -38,9 +38,13 @@ static struct kexec_file_ops *kexec_file
 static void free_transition_pgtable(struct kimage *image)
 {
 	free_page((unsigned long)image->arch.p4d);
+	image->arch.p4d = NULL;
 	free_page((unsigned long)image->arch.pud);
+	image->arch.pud = NULL;
 	free_page((unsigned long)image->arch.pmd);
+	image->arch.pmd = NULL;
 	free_page((unsigned long)image->arch.pte);
+	image->arch.pte = NULL;
 }
 
 static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
@@ -90,7 +94,6 @@ static int init_transition_pgtable(struc
 	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, PAGE_KERNEL_EXEC_NOENC));
 	return 0;
 err:
-	free_transition_pgtable(image);
 	return result;
 }
 
