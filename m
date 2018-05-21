Return-Path: <yehs2007@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526916052; cv=none;
        d=google.com; s=arc-20160816;
        b=SG4Nwu0N29rFV2YsiB8NpKPitozxN2UVQA8oAVT8vAnYSZLb2LTe97xcrWofDz72CJ
         OWkRfwo8OlqvjCzEqgxcLVqIP/8lu2edVCn7jpB5b62iqvaAXjOOK45t/b6iiUavszWG
         Vfq100IuNIiwzKykCDopZz1btIjgxGCikDlEhSeGHXP6Na8R4ltZEoWjEXtXL/XYcL3B
         G5MlRSP0zJvfuBZkyF3DOeMIVyYX2GW2fypyMmFOTkGyKP5hNbLfVPcd/W4o9Kxu0UiM
         3qzwFa/AgqQOeuLV4/FKZQyqwuTiOPC7zEgGIcCKF17mej7dyeEE5jDetVu5VG3g0xTF
         LJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Pzs2NzeRlCb9X0ibpkf1mD9br6NpgeDf+l77IWkXvG4=;
        b=wcpQ8+jDgkX2djt6v1vz/jxlOXpWYlXSKi8/Yj1ho0/Qt6EUdutUv7PK1ITxc0YAfD
         4+ndjL8bvIE6f8VBOhxhheKEqd8qMIAFEdSOsYz+QlNLyqXVRtx9dca9ySpx896OU3/E
         wbayNW6Gs2lIlOHSFVWuGMB2CjC/7ovDZrAIe42mVRkdofNFg2/6zAsWpvOdCx/SQQME
         3GSEDlwbFkFePv7WbnxEg6KzZSEeV1XQqkkTN9/Df4HQRcWjgusilhT4A98+XkgKeKAY
         S/nkzpSgRNVFrAGjO3bbRKvp2xZcOmxdt391ZY6d7DK5a2ppm0NbNkUIwug5DpIGwm4L
         H/9w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MQn9gBEE;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MQn9gBEE;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpVAZvz1PxSltGd4psCJG6EaEMmfGQJ8l1ZcUvd3x7p2B1fVx0jLNS83Fs1Zb7VVDFEkaIUVw==
From: Huaisheng Ye <yehs2007@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: mhocko@suse.com,
	willy@infradead.org,
	vbabka@suse.cz,
	mgorman@techsingularity.net,
	kstewart@linuxfoundation.org,
	alexander.levin@verizon.com,
	gregkh@linuxfoundation.org,
	colyli@suse.de,
	chengnt@lenovo.com,
	hehy1@lenovo.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	xen-devel@lists.xenproject.org,
	linux-btrfs@vger.kernel.org,
	Huaisheng Ye <yehs1@lenovo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [RFC PATCH v2 02/12] arch/x86/kernel/amd_gart_64: update usage of address zone modifiers
Date: Mon, 21 May 2018 23:20:23 +0800
Message-Id: <1526916033-4877-3-git-send-email-yehs2007@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601087527015520115?=
X-GMAIL-MSGID: =?utf-8?q?1601087527015520115?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Huaisheng Ye <yehs1@lenovo.com>

Use __GFP_ZONE_MASK to replace (__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32).

___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 have been deleted from GFP
bitmasks, the bottom three bits of GFP mask is reserved for storing
encoded zone number.
__GFP_DMA, __GFP_HIGHMEM and __GFP_DMA32 should not be operated by OR.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 arch/x86/kernel/amd_gart_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index ecd486c..1dd6971 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -485,7 +485,7 @@ static int gart_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 	struct page *page;
 
 	if (force_iommu && !(flag & GFP_DMA)) {
-		flag &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
+		flag &= ~__GFP_ZONE_MASK;
 		page = alloc_pages(flag | __GFP_ZERO, get_order(size));
 		if (!page)
 			return NULL;
-- 
1.8.3.1
