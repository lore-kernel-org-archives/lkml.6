Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751375AbeEKPPr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:15:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:58753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750746AbeEKPPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:15:46 -0400
Message-ID: <1526051730.23162.3.camel@gmx.de>
Subject: [patch] swiotlb: fix ignored DMA_ATTR_NO_WARN request
From: Mike Galbraith <efault@gmx.de>
To: nouveau <nouveau@lists.freedesktop.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ben Skeggs <bskeggs@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Roger He <Hongbo.He@amd.com>, Christoph Hellwig <hch@lst.de>
Date: Fri, 11 May 2018 17:15:30 +0200
In-Reply-To: <1526022830.6288.3.camel@gmx.de>
References: <1525943427.8013.11.camel@gmx.de>
         <1525948096.29445.4.camel@gmx.de> <1526022830.6288.3.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8GHCwJNqycaaCt2knY+4eAUmZJhraSn4K2b7nrAmrlUs3izOR99
 OUXMzT6F9ayhVWWJHUT3dV0Ixl7AIN+6/nfUU7HNSY1VI3ljGVJTOEeiA5Z3MlobvaJSIOx
 AqsD8TE4yTnAdgZ2P7vksXJIUuviv6hWNcjdiyUHiEr3dFj99SkyqtuYZZEHyTN4EhyFXrW
 AKahxqpF5y4TBxkC1YpeA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WtwOm/OLYyM=:4xQ+TF2MO98w3lkJ3P/G9q
 L1XCVEbYOBUPkaVHjU4gov7DYvyMrc5frSPc58L/d32linO6V4tbmHJnukfxjdhCXQA4GHZ1T
 MGD5VYqb8MyTeYekj64GdwqLq39Nn5kdZPpvv0370jIND2eZDHw2SfEQyxKrEi5uAzeWHirfu
 egaloTwIBhfAUr3oflcerLzoYGDiH54RzJhnBlDyr02zmJOfFAm9CD1TJgdZG9hz/YgTyC8Fp
 xpW2Mptq0jNjxBzv4RS0FCa725RRctElQoS6ZHYyrGDFDzNq2O5DLQ8aAfeOI+lBZXE+jfRL6
 25gKIV4Y31NfySLvAUoRAk7566GKzxr/gDTUCcTW3Kgt53M7gc/1eEai0O82PKaq7duhLxwGC
 QMfRFTX3dH81dzAsZIow9xpJat0S+lviuXWZaApaiTYEnLIcCXvttiokSltBfcKGFjDd4Ar3I
 +Y4csKbH3ImqomW96r8XdgGr7eGtcI2mgGnc20xGvuj3mUunFq/FHj+0PTb/H7QWcIK461J+u
 HfdM1tP5u1BMXtgMk28VRjQfV6GYTwDgA55j5f4UUeG5vi64sDHYHzTYIFD/7+pQAhL1Znqx5
 oNBFF10vxSW09r34+Lv+cAx0Y4nuZ/4Z1lgMv118Q3X8chIJJWtUqSkev2z5eW6qReY8Y2F02
 x5ahay+Lllo2ffegdWQ30wge5gjQ1lLuarIn/RUnCu64aPbztTNIDnUtj+bT7t/ZD5pc6YG9n
 Vwk9jDHcDIxolUhd4TfJyvT2kRO9Zb63UjKWLTGBzLuUYQWIIufeYTrYFDVK6hyY217Eadmyv
 Dq/0MX+
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In the trace below, swiotlb_alloc() is called with __GFP_NOWARN, it ors
attrs with DMA_ATTR_NO_WARN and passes it to swiotlb_alloc_buffer(),
which does NOT pass it on to swiotlb_tbl_map_single(), leading to an
ever repeating warning that the caller of swiotlb_alloc() explicitly
asked to be squelched.  Pass the caller's request for silence onward.

 Xorg-3170  [006] ....   963.866098: swiotlb_alloc+0x1d/0x1a0: gfp & __GFP_NOWARN
 Xorg-3170  [006] ....   963.866101: <stack trace>
 => ttm_dma_populate+0x250/0x310 [ttm]
 => ttm_tt_populate+0x28/0x70 [ttm]
 => ttm_tt_bind+0x26/0x60 [ttm]
 => ttm_bo_handle_move_mem+0x51a/0x580 [ttm]
 => ttm_bo_validate+0xfa/0x110 [ttm]
 => ttm_bo_init_reserved+0x296/0x450 [ttm]
 => ttm_bo_init+0x73/0xd0 [ttm]
 => nouveau_bo_new+0x3eb/0x5c0 [nouveau]
 => nouveau_gem_new+0x66/0x110 [nouveau]
 => nouveau_gem_ioctl_new+0x48/0xc0 [nouveau]
 => drm_ioctl_kernel+0x66/0xb0 [drm]
 => drm_ioctl+0x28d/0x340 [drm]
 => nouveau_drm_ioctl+0x50/0xb0 [nouveau]
 => do_vfs_ioctl+0x92/0x5e0
 => ksys_ioctl+0x3a/0x70
 => __x64_sys_ioctl+0x16/0x20
 => do_syscall_64+0x5b/0x180
 => entry_SYSCALL_64_after_hwframe+0x44/0xa9
 Xorg-3170  [006] ....   963.866917: swiotlb_tbl_map_single+0x29b/0x2d0: swiotlb buffer is full (sz: 2097152 bytes)

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 lib/swiotlb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -714,7 +714,7 @@ swiotlb_alloc_buffer(struct device *dev,
 
 	phys_addr = swiotlb_tbl_map_single(dev,
 			__phys_to_dma(dev, io_tlb_start),
-			0, size, DMA_FROM_DEVICE, 0);
+			0, size, DMA_FROM_DEVICE, attrs);
 	if (phys_addr == SWIOTLB_MAP_ERROR)
 		goto out_warn;
 
