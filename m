Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE4BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B039218AE
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfBFPsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:48:01 -0500
Received: from mga06.intel.com ([134.134.136.31]:44555 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726914AbfBFPsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:48:01 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 07:48:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="136369031"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 06 Feb 2019 07:47:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 349F0F7; Wed,  6 Feb 2019 17:47:57 +0200 (EET)
Date:   Wed, 6 Feb 2019 18:47:57 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Kyle D Pelton <kyle.d.pelton@intel.com>,
        Wei Huang <wei@redhat.com>
Subject: Re: [PATCH] x86/boot/compressed/64: Do not corrupt EDX on EFER.LME=1
 setting
Message-ID: <20190206154756.matwldebbxkmlnae@black.fi.intel.com>
References: <20190206115253.1907-1-kirill.shutemov@linux.intel.com>
 <20190206152141.GF7314@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206152141.GF7314@zn.tnic>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 03:21:41PM +0000, Borislav Petkov wrote:
> On Wed, Feb 06, 2019 at 02:52:53PM +0300, Kirill A. Shutemov wrote:
> > RDMSR in the trampoline code overrides EDX, but we use the register to
> > indicate if 5-level paging has to enabled. It leads to failure to boot
> > on a 5-level paging machine.
> > 
> > Preserve EDX on the stack while we are dealing with EFER.
> 
> Comment says:
> 
>  * Non zero RDX on return means we need to enable 5-level paging.
> 
> Is that per-chance refering to struct paging_config which
> paging_prepare() returns and on that return rdx contains
> paging_config.l5_required which is 1 when 5 level is to be enabled?

Yes.

> If so, is that written somewhere explicitly? Because it is not
> immediately clear at least to me why that RDX is live...

What about this:

From d43b9d157c574baf782f6d9982fe6f2c1f918c0e Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 6 Feb 2019 18:29:08 +0300
Subject: [PATCH] x86/boot/compressed/64: Fix confusing comment for
 paging_config()

paging_prepare() returns two-quadword structure which lands
into RDX:RAX:
  - Address of the trampoline is returned in RAX.
  - Non zero RDX means trampoline needs to enable 5-level paging.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/compressed/head_64.S | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index f62e347862cc..87509a3f00f4 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -358,8 +358,11 @@ ENTRY(startup_64)
 	 * paging_prepare() sets up the trampoline and checks if we need to
 	 * enable 5-level paging.
 	 *
-	 * Address of the trampoline is returned in RAX.
-	 * Non zero RDX on return means we need to enable 5-level paging.
+	 * paging_prepare() returns two-quadword structure which lands
+	 * into RDX:RAX:
+	 *   - Address of the trampoline is returned in RAX.
+	 *   - Non zero RDX means trampoline needs to enable 5-level
+	 *     paging.
 	 *
 	 * RSI holds real mode data and needs to be preserved across
 	 * this function call.
@@ -565,7 +568,7 @@ adjust_got:
  *
  * RDI contains the return address (might be above 4G).
  * ECX contains the base address of the trampoline memory.
- * Non zero RDX on return means we need to enable 5-level paging.
+ * Non zero RDX means trampoline needs to enable 5-level paging.
  */
 ENTRY(trampoline_32bit_src)
 	/* Set up data and stack segments */
-- 
 Kirill A. Shutemov
