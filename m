Return-Path: <yehs2007@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526916042; cv=none;
        d=google.com; s=arc-20160816;
        b=fbH4IgWXcYSxwqmPhl1saOK8hwdfhM/dxOyRizWeM79LwPfV2xbgpvIDiATjVS0W8D
         jW2rsG25s8zo3wP+Rep7AkPunkWt432R7Uyjt+yMdbaVLx9uf9DuiBh1yMfCIhLfBIql
         1ChWalzGRtT2+qNU9pXyUOwtG3H7/j/V9hroAQnMB3NmFJW2rRhstJSH4quSiY0B9gFG
         C+4Mz2sNFzil8OwWpb1E2J21x+tUoqkvIcbbXAtzeoBF0JNP8U/bXLL5sPxgE7iZwRL9
         M69YXMZTPch2zFYjXGF/3MuC3lyvL/EQm4Eb58cmJyl2bRkXDdv8zftNqqKxIddOgvRR
         ykEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=G8TTXbKLrxMwtFaM3DlGa+eBKWQt/8m2+RFUkp9qT2U=;
        b=dgNsPa0ngngAr/zAKrWfXQscHUba8eLSGyd7o+swFcwaGLblxkT7p4goq9GTmIVSIx
         3tNuHnoED/4PGcaw5azYoOfglamTdU6ZAY+W9CkZrfK7AuOH5ASrv6mOwFoHDQ1VWV4F
         0trQSNILZuSbLECQZ8GZlqq1fljGCa1yvJUipYFlnJAgwtPhRU0OJyTWD0e7SvI9zQdm
         sYjCYOEDJD/Sp51omnMtD04n8bu6HswFjzPsDHMObc7AunHgtQCv3noAV7xtwbRzmIXd
         eW1SQ1hx55SYMMrjfbXPZ4D9IPOAMGpux/vJuOfc44DKbMWP3hwifoG4vhu5fjqYkpM6
         aW8w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YTpu4tOS;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YTpu4tOS;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZo5i/bH/VyI1YGUIPQpwb8cUKshHxPoUGCje6JDNjzUGP7gV95e29ZvNFZiO0ASB7nJHlUwXA==
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
	Huaisheng Ye <yehs1@lenovo.com>
Subject: [RFC PATCH v2 00/12] get rid of GFP_ZONE_TABLE/BAD
Date: Mon, 21 May 2018 23:20:21 +0800
Message-Id: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
X-Mailer: git-send-email 1.8.3.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601087516393165793?=
X-GMAIL-MSGID: =?utf-8?q?1601087516393165793?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Huaisheng Ye <yehs1@lenovo.com>

Replace GFP_ZONE_TABLE and GFP_ZONE_BAD with encoded zone number.

Delete ___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 from GFP bitmasks,
the bottom three bits of GFP mask is reserved for storing encoded
zone number.

The encoding method is XOR. Get zone number from enum zone_type,
then encode the number with ZONE_NORMAL by XOR operation.
The goal is to make sure ZONE_NORMAL can be encoded to zero. So,
the compatibility can be guaranteed, such as GFP_KERNEL and GFP_ATOMIC
can be used as before.

Reserve __GFP_MOVABLE in bit 3, so that it can continue to be used as
a flag. Same as before, __GFP_MOVABLE respresents movable migrate type
for ZONE_DMA, ZONE_DMA32, and ZONE_NORMAL. But when it is enabled with
__GFP_HIGHMEM, ZONE_MOVABLE shall be returned instead of ZONE_HIGHMEM.
__GFP_ZONE_MOVABLE is created to realize it.

With this patch, just enabling __GFP_MOVABLE and __GFP_HIGHMEM is not
enough to get ZONE_MOVABLE from gfp_zone. All callers should use
GFP_HIGHUSER_MOVABLE or __GFP_ZONE_MOVABLE directly to achieve that.

Decode zone number directly from bottom three bits of flags in gfp_zone.
The theory of encoding and decoding is,
        A ^ B ^ B = A

Changes since v1,

v2: Add __GFP_ZONE_MOVABLE and modify GFP_HIGHUSER_MOVABLE to help
callers to get ZONE_MOVABLE. Add __GFP_ZONE_MASK to mask lowest 3
bits of GFP bitmasks.
Modify some callers' gfp flag to update usage of address zone
modifiers.
Modify inline function gfp_zone to get better performance according
to Matthew's suggestion.

Link: https://marc.info/?l=linux-mm&m=152596791931266&w=2

Huaisheng Ye (12):
  include/linux/gfp.h: get rid of GFP_ZONE_TABLE/BAD
  arch/x86/kernel/amd_gart_64: update usage of address zone modifiers
  arch/x86/kernel/pci-calgary_64: update usage of address zone modifiers
  drivers/iommu/amd_iommu: update usage of address zone modifiers
  include/linux/dma-mapping: update usage of address zone modifiers
  drivers/xen/swiotlb-xen: update usage of address zone modifiers
  fs/btrfs/extent_io: update usage of address zone modifiers
  drivers/block/zram/zram_drv: update usage of address zone modifiers
  mm/vmpressure: update usage of address zone modifiers
  mm/zsmalloc: update usage of address zone modifiers
  include/linux/highmem: update usage of movableflags
  arch/x86/include/asm/page.h: update usage of movableflags

 arch/x86/include/asm/page.h      |  3 +-
 arch/x86/kernel/amd_gart_64.c    |  2 +-
 arch/x86/kernel/pci-calgary_64.c |  2 +-
 drivers/block/zram/zram_drv.c    |  6 +--
 drivers/iommu/amd_iommu.c        |  2 +-
 drivers/xen/swiotlb-xen.c        |  2 +-
 fs/btrfs/extent_io.c             |  2 +-
 include/linux/dma-mapping.h      |  2 +-
 include/linux/gfp.h              | 98 +++++-----------------------------------
 include/linux/highmem.h          |  4 +-
 mm/vmpressure.c                  |  2 +-
 mm/zsmalloc.c                    |  4 +-
 12 files changed, 26 insertions(+), 103 deletions(-)

-- 
1.8.3.1
