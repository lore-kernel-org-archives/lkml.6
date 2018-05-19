Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbeESGCW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 02:02:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55112 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeESGCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 02:02:19 -0400
Date: Sat, 19 May 2018 09:01:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] KVM: X86: prevent integer overflows in
 KVM_MEMORY_ENCRYPT_REG_REGION
Message-ID: <20180519060135.GA4991@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8897 signatures=668699
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805190050
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a fix from reviewing the code, but it looks like it might be
able to lead to an Oops.  It affects 32bit systems.

The KVM_MEMORY_ENCRYPT_REG_REGION ioctl uses a u64 for range->addr and
range->size but the high 32 bits would be truncated away on a 32 bit
system.  This is harmless but it's also harmless to prevent it.

Then in sev_pin_memory() the "uaddr + ulen" calculation can wrap around.
The wrap around can happen on 32 bit or 64 bit systems, but I was only
able to figure out a problem for 32 bit systems.  We would pick a number
which results in "npages" being zero.  The sev_pin_memory() would then
return ZERO_SIZE_PTR without allocating anything.

I made it illegal to call sev_pin_memory() with "ulen" set to zero.
Hopefully, that doesn't cause any problems.  I also changed the type of
"first" and "last" to long, just for cosmetic reasons.  Otherwise on a
64 bit system you're saving "uaddr >> 12" in an int and it truncates the
high 20 bits away.  The math works in the current code so far as I can
see but it's just weird.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Again, this is a static checker fix.  The most risky parts of this
patch are blocking "ulen == 0" and changing the types of "first" and
"last".  I felt like those changes made the math easier to understand

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 220e5a89465a..de21d5c5168b 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1762,7 +1762,10 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
 	unsigned long npages, npinned, size;
 	unsigned long locked, lock_limit;
 	struct page **pages;
-	int first, last;
+	unsigned long first, last;
+
+	if (ulen == 0 || uaddr + ulen < uaddr)
+		return NULL;
 
 	/* Calculate number of pages. */
 	first = (uaddr & PAGE_MASK) >> PAGE_SHIFT;
@@ -6925,6 +6928,9 @@ static int svm_register_enc_region(struct kvm *kvm,
 	if (!sev_guest(kvm))
 		return -ENOTTY;
 
+	if (range->addr > ULONG_MAX || range->size > ULONG_MAX)
+		return -EINVAL;
+
 	region = kzalloc(sizeof(*region), GFP_KERNEL);
 	if (!region)
 		return -ENOMEM;
