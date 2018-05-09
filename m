Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964975AbeEIPOZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:14:25 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:60498 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935065AbeEIPOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:14:23 -0400
X-IronPort-AV: E=Sophos;i="5.49,381,1520899200";
   d="scan'208";a="72839191"
Date: Wed, 9 May 2018 16:11:39 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
CC: Juergen Gross <jgross@suse.com>, <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH v2 1/3] xen/pvh: enable and set default MTRR
 type
Message-ID: <20180509151139.nytwuepervqjkcat@MacBook-Pro-de-Roger.local>
References: <20180509102129.14832-1-roger.pau@citrix.com>
 <20180509102129.14832-2-roger.pau@citrix.com>
 <fbe18be3-0e2e-723f-a625-015c6aad89a3@citrix.com>
 <20180509113016.tavac64ba5fu3tob@MacBook-Pro-de-Roger.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180509113016.tavac64ba5fu3tob@MacBook-Pro-de-Roger.local>
User-Agent: NeoMutt/20180323
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 12:30:16PM +0100, Roger Pau Monné wrote:
> On Wed, May 09, 2018 at 11:56:40AM +0100, Andrew Cooper wrote:
> > On 09/05/18 11:21, Roger Pau Monne wrote:
> > I'm not sure that setting the default MTRR type is going to be a
> > clever idea in hindsight when we come to doing PCI Passthrough support.
> 
> Setting the default type to WB is also set by hvmloader, it's just
> that hvmloader also sets some of the fixed and variable ranges to UC
> in order to cover the iomem areas.
> 
> The expectations when doing pci-passthrough is that the guest will
> always use paging and PAT in order to set the appropriate cache
> attributes, or else the guest itself will have to program the UC MTRR
> ranges, I admit that's not very nice however.
> 
> What about enabling the default MTRR type and setting it to WB in the
> toolstack for PVH? IMO doing it Xen itself would be wrong.

I have the following patch to set the default MTRR type, but I think
if we go down this road then we will also have to set UC MTRRs for
MMIO areas, which again seems fine to me.

---8<---
diff --git a/tools/libxc/xc_dom_x86.c b/tools/libxc/xc_dom_x86.c
index e33a28847d..3cb1a1720f 100644
--- a/tools/libxc/xc_dom_x86.c
+++ b/tools/libxc/xc_dom_x86.c
@@ -938,6 +938,8 @@ static int vcpu_hvm(struct xc_dom_image *dom)
         HVM_SAVE_TYPE(HEADER) header;
         struct hvm_save_descriptor cpu_d;
         HVM_SAVE_TYPE(CPU) cpu;
+        struct hvm_save_descriptor mtrr_d;
+        HVM_SAVE_TYPE(MTRR) mtrr;
         struct hvm_save_descriptor end_d;
         HVM_SAVE_TYPE(END) end;
     } bsp_ctx;
@@ -1014,6 +1016,15 @@ static int vcpu_hvm(struct xc_dom_image *dom)
     if ( dom->start_info_seg.pfn )
         bsp_ctx.cpu.rbx = dom->start_info_seg.pfn << PAGE_SHIFT;
 
+    /* Set the MTRR. */
+    bsp_ctx.mtrr_d.typecode = HVM_SAVE_CODE(MTRR);
+    bsp_ctx.mtrr_d.instance = 0;
+    bsp_ctx.mtrr_d.length = HVM_SAVE_LENGTH(MTRR);
+    /* XXX: maybe this should be a firmware option instead? */
+    if ( !dom->device_model )
+        /* Enable MTRR (bit 11) and set the default type to WB (6). */
+        bsp_ctx.mtrr.msr_mtrr_def_type = (1u << 11) | 6;
+
     /* Set the end descriptor. */
     bsp_ctx.end_d.typecode = HVM_SAVE_CODE(END);
     bsp_ctx.end_d.instance = 0;
