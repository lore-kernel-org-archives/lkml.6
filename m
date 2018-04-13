Return-Path: <kernel-hardening-return-12995-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48H1vBjaYrwAr+ODohUZzsZ8cGc36/Js84XO39sU/GHFNQSA8XtO/QPBwBJcRGVDhdE8V8s
ARC-Seal: i=1; a=rsa-sha256; t=1523657541; cv=none;
        d=google.com; s=arc-20160816;
        b=VDAqX7CuGNiNXW+iDBfeY2nkFtNIK8Z7Dpb3EA2WGmfreVgJGBzL39ONzlfXYxrxRT
         yYCr0wRt5yW1eUH8xjjvUnIMgmlxiHNyLW2fo8HBq51bkwkfbcM/C4JtIek71WBDDjEz
         9UQkrxaw46zUpEN/F2wv/JIYiKkIAXG0WRhqtDjmkTGvdbip5V1Pq8b7Sw7eO8fjg+Wy
         7AbIMNBKkjSl+Kqhw8Z16YgUwaQJ9MSw1rzsXxRC4xYon5X0AWQMQ4/FEQRYSy5RKCf2
         7/dpMXYvlpvreFJzBXEWpVkcS9szFNrbZVkHFdtW/q801bMvdm2OwqIayPUO0KC+PENz
         psgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=2/8HjuS2UQuxTlH6dZp1Oqp/dVN0PDHwDYfzQSzjByY=;
        b=bG0yGVkTe1hGv1DsOISjPyspFnRi1vWiJvsihg8mmerNLRLcm+JC7Lw7v7pBeVcQHA
         eTESbOHgovyacwFNXU4ov5WqHw7nj/sZOJmNa3VmYoYe5Rd5KgJY1NtNWIS8u4nzU2UX
         +Kellfja33YVqSE5wLYpwST19hnskgU2qWB1hjirXaRRKnD5O2UUYTu01QGTvdvu/4a8
         YiJxUU+jwnW07X0f61g5Lnu4SBSponei3UY7PZaaTwP2zaJpihqKLXr+loDKy/21rSDM
         KEJH6+ext6lyfNLcNNwZNNEIiSER6WG8wQB633YnpENAXXF1mMR+EO8aC7uJWaQP80rz
         3f3w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12995-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12995-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12995-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12995-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Laura Abbott <labbott@redhat.com>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>
Cc: Laura Abbott <labbott@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCH] x86/xen: Remove use of VLAs
Date: Fri, 13 Apr 2018 15:11:46 -0700
Message-Id: <20180413221146.28476-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597670729617678421?=
X-GMAIL-MSGID: =?utf-8?q?1597670729617678421?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There's an ongoing effort to remove VLAs[1] from the kernel to eventually
turn on -Wvla. The few VLAs in use have an upper bound based on a size
of 64K. This doesn't produce an excessively large stack so just switch
the upper bound.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 arch/x86/xen/enlighten_pv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index c36d23aa6c35..d96a5a535cbb 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -421,8 +421,7 @@ static void xen_load_gdt(const struct desc_ptr *dtr)
 {
 	unsigned long va = dtr->address;
 	unsigned int size = dtr->size + 1;
-	unsigned pages = DIV_ROUND_UP(size, PAGE_SIZE);
-	unsigned long frames[pages];
+	unsigned long frames[DIV_ROUND_UP(SZ_64K, PAGE_SIZE)];
 	int f;
 
 	/*
@@ -470,8 +469,7 @@ static void __init xen_load_gdt_boot(const struct desc_ptr *dtr)
 {
 	unsigned long va = dtr->address;
 	unsigned int size = dtr->size + 1;
-	unsigned pages = DIV_ROUND_UP(size, PAGE_SIZE);
-	unsigned long frames[pages];
+	unsigned long frames[DIV_ROUND_UP(SZ_64K, PAGE_SIZE)];
 	int f;
 
 	/*
-- 
2.14.3
