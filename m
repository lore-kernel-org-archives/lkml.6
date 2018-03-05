Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964876AbeCENLJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:11:09 -0500
Received: from mout.web.de ([217.72.192.78]:58907 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932287AbeCENLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:11:05 -0500
To: linux-crypto@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
        "David S. Miller" <davem@davemloft.net>, Gary Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] crypto: ccp: Use memdup_user() rather than duplicating its
 implementation
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        kvm@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <ccd82e60-ba87-d224-3662-365662fa4e6e@users.sourceforge.net>
Date: Mon, 5 Mar 2018 14:10:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:9XUiC2pkpEDSTxmLoey4fXLOiWeotmv6f8cjpwq59tVgi0V6/Fl
 +Ond/OojPWq8N6gVg1GtpxMJ1fWBPic1kcWr0XtZ5c2bTqAPyzAH8MDgSsYlTlCVrY6yJZI
 q+BVu7D7V8SjgXCAIfKBCVFXpVTqRi4qFngziv5hesXd8a0DC4QsiqSV2OZwGoKmWPSjFIe
 VfdDSlOdLDYMpJnSs1mbg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8l9M2MfjDC4=:7Y3ay+MfPjEiZGgyterijg
 Vah7JCqaiICAtACeRi4Pz6afbV7nE/A39+ItgfgtMDG/wZqVmP3CowxevHKanW7strarFqN3s
 LWlLKSg0obM1cWbSnbEeLnKv9GuoZPIa2i2Dsq9XKoF+6e6xEEe/XJjHITTBweKI4PxEywOo5
 SzEWu7m7cMrPTS/CRqgozK7G1DiYiNRo31oQ6HhCX1iGEJw5X76XO+7aXytb3NgW8H0QRJPKy
 aqbiQeFagizPkGzpOcsevJ7VpNkesfZnuuugeQiXlNBxsxRMbA83BLYaiNz5nj+9cRjGEWOa2
 VRt18d0MLZUI1U3d+NpgFjpxx9yIWl4WO//xyJLYxVjBJ3MwBvqijZ+e/hwqu5E4OnW8Yv6Ss
 9R0GgGWPkIRa/YzXkJ/rV1X1jE6MeD0ES7l2tN5cu3gAS1a2WZCbyfPvqwAn3OaARbrX5edrL
 McD1cvRDGavPOOspQ3+BGXztBjINeVzTla8Niu9mo/rV2bShLTddg7wnPdvmRBN2PB/K+cynl
 Y5hY+l4Q3tVVkF2y3W0rizcRDoNG7rlsqLSRdkblrvJK2fAZPnlHJfQd/kvRTSdg6fmXNNPPB
 0GTkJGCy8TYd7LDMrdyqM/Wszg7H5Jxi3NcKuFr7JG7rWFEAE1u/jQ+zXvsFHyN1sIEenC0QD
 r1QE5xhNhZl8x0qWa+p+l+BpsngfWIdPY+oAhA69G91UcF32/rpLk9Od2XHSxLEP21qiBlats
 NZOFP47reJCymxWJWCFbUnho8KMdvuec3FI1rE1JvmitXS413fygKpXHiccxhVTJU3hMr2Dfo
 AnopD5+jvaFR62O/XdgAkBMp30WQzCE898s3xgGidDR91ZQ1fo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Mar 2018 13:50:13 +0100

Reuse existing functionality from memdup_user() instead of keeping
duplicate source code.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/crypto/ccp/psp-dev.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index fcfa5b1eae61..8255258cd040 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -367,8 +367,6 @@ static int sev_ioctl_do_pek_csr(struct sev_issue_cmd *argp)
 
 void *psp_copy_user_blob(u64 __user uaddr, u32 len)
 {
-	void *data;
-
 	if (!uaddr || !len)
 		return ERR_PTR(-EINVAL);
 
@@ -376,18 +374,7 @@ void *psp_copy_user_blob(u64 __user uaddr, u32 len)
 	if (len > SEV_FW_BLOB_MAX_SIZE)
 		return ERR_PTR(-EINVAL);
 
-	data = kmalloc(len, GFP_KERNEL);
-	if (!data)
-		return ERR_PTR(-ENOMEM);
-
-	if (copy_from_user(data, (void __user *)(uintptr_t)uaddr, len))
-		goto e_free;
-
-	return data;
-
-e_free:
-	kfree(data);
-	return ERR_PTR(-EFAULT);
+	return memdup_user((void __user *)(uintptr_t)uaddr, len);
 }
 EXPORT_SYMBOL_GPL(psp_copy_user_blob);
 
-- 
2.16.2
