Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeBBPrb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:47:31 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:54837 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbeBBPrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:47:23 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] vxfs: fix building with LTO
Date: Fri,  2 Feb 2018 16:47:01 +0100
Message-Id: <20180202154706.1624997-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:CokESm8dCIvopzcdBhgorOOTK5BPyuYQv8xbHBe32qaDtOQc+MS
 Xr44MVM+3jXhSbPO9dNMAcZon/dTRlo0NDsHfyxrS8vOPguXu7zgavgiwzwnykKW9+2YORw
 NpKJsMQWsmE080w+tTzPgdbgteZcvCTcy5wpUfhGK7Dz/178snnQJW5RzN3bbXFKQ6YymOc
 yl1RKlE5DYow7BrHugbbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QironpDZpJg=:NeivasZHj8IfetJEVtyvuC
 Drqwye2S5rBqPwXRKc2GUDqhnetmrUhR5pgWiYxAuV3HAkm3pRwVm0qF2YZ0S75RFZMuVGyfo
 BlRPNSjwDLshP2fJuXJDKF0txrD+JOKk+AaWBqliambJIAS3fykD5i6Z/wecf40KVnEKAfwAf
 8gI0WeYh2RKUAOp7YuhyRAWalrK0ha7/foSneKaVJeekwNJUAcA9du2w/9A2W3prmJLgVfR3M
 WiBdCAbPcs34fMjjo/SoMq9Ht60zeJZWhi6v4ExEiX5fOaYiqn3hLbZQfEbdqC+Ll+iSguX11
 mvfjn2rgUZRecuIq8G5+FX36kT/VtPLusvr/ENtSbXp5nCv3noSdRBHdJ/TJ2BQ2zw72MNRnQ
 WTLX2NMFuPUSwYq1eamrI/iRmYYG82IVepB98nC6mMngFPp85ZMayUV8rDUMI2dN12FqJ2HV5
 YmX8a2jeDk3hJ1pIHa/PE1E9B2rxhOM8pCQYtG+Z5YFeKvN32W97zHF/+EyrSXJVnRATt4AHx
 48uMFlRFw6mHMmbSYMc0RhSn+gSbfCRHPeLT3DXzHZT36zGAPxw4OMptRorAfxCFzVnBso2Cn
 Xk+sjJD58HQiG2cfxexLx7bjDpPS1jW8Dxv2H2QR+syl/y0tCmXRVor4Ll8lTfUF5IZKHuPvd
 nqki2u7m3YRZzrof2aOTnG878d0Zc1kmeou+xSg5ULUUb3z+pkgwk4bkagxDmSd29FlSkeXTf
 QbTQy2ARYrKQdXmAuqCDOE8dW2XS9Gga/e+POA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When link-time optimizations are enabled, vxfs fails to build:

fs/freevxfs/vxfs_lookup.c: In function 'vxfs_readdir':
fs/freevxfs/vxfs_subr.c:50:1: error: inlining failed in call to always_inline 'vxfs_put_page': function not declared inline and code size would grow
 vxfs_put_page(struct page *pp)
 ^
fs/freevxfs/vxfs_lookup.c:291:3: note: called from here
   vxfs_put_page(pp);
   ^
fs/freevxfs/vxfs_inode.c: In function '__vxfs_iget':
fs/freevxfs/vxfs_subr.c:50:1: error: inlining failed in call to always_inline 'vxfs_put_page': function not declared inline and code size would grow
fs/freevxfs/vxfs_lookup.c: In function 'vxfs_lookup':
fs/freevxfs/vxfs_subr.c:50:1: error: inlining failed in call to always_inline 'vxfs_put_page': function not declared inline and code size would grow

This removes the 'inline' annotation that obviously doesn't do much
anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/freevxfs/vxfs_subr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/freevxfs/vxfs_subr.c b/fs/freevxfs/vxfs_subr.c
index e806694d4145..8e213cce586f 100644
--- a/fs/freevxfs/vxfs_subr.c
+++ b/fs/freevxfs/vxfs_subr.c
@@ -46,7 +46,7 @@ const struct address_space_operations vxfs_aops = {
 	.bmap =			vxfs_bmap,
 };
 
-inline void
+void
 vxfs_put_page(struct page *pp)
 {
 	kunmap(pp);
-- 
2.9.0
