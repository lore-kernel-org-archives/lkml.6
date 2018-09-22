Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF608ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900F72157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900F72157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392030AbeIVGKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:10:48 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44209 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391974AbeIVGKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:47 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vds-0008Ba-NB; Sat, 22 Sep 2018 01:19:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdn-0000qp-HY; Sat, 22 Sep 2018 01:19:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Paolo Bonzini" <pbonzini@redhat.com>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.136277185@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 15/63] KVM: x86: introduce linear_{read,write}_system
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit 79367a65743975e5cac8d24d08eccc7fdae832b0 upstream.

Wrap the common invocation of ctxt->ops->read_std and ctxt->ops->write_std, so
as to have a smaller patch when the functions grow another argument.

Fixes: 129a72a0d3c8 ("KVM: x86: Introduce segmented_write_std", 2017-01-12)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/emulate.c | 64 +++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -731,6 +731,19 @@ static int linearize(struct x86_emulate_
 }
 
 
+static int linear_read_system(struct x86_emulate_ctxt *ctxt, ulong linear,
+			      void *data, unsigned size)
+{
+	return ctxt->ops->read_std(ctxt, linear, data, size, &ctxt->exception);
+}
+
+static int linear_write_system(struct x86_emulate_ctxt *ctxt,
+			       ulong linear, void *data,
+			       unsigned int size)
+{
+	return ctxt->ops->write_std(ctxt, linear, data, size, &ctxt->exception);
+}
+
 static int segmented_read_std(struct x86_emulate_ctxt *ctxt,
 			      struct segmented_address addr,
 			      void *data,
@@ -1394,8 +1407,7 @@ static int read_interrupt_descriptor(str
 		return emulate_gp(ctxt, index << 3 | 0x2);
 
 	addr = dt.address + index * 8;
-	return ctxt->ops->read_std(ctxt, addr, desc, sizeof *desc,
-				   &ctxt->exception);
+	return linear_read_system(ctxt, addr, desc, sizeof *desc);
 }
 
 static void get_descriptor_table_ptr(struct x86_emulate_ctxt *ctxt,
@@ -1432,8 +1444,7 @@ static int read_segment_descriptor(struc
 		return emulate_gp(ctxt, selector & 0xfffc);
 
 	*desc_addr_p = addr = dt.address + index * 8;
-	return ctxt->ops->read_std(ctxt, addr, desc, sizeof *desc,
-				   &ctxt->exception);
+	return linear_read_system(ctxt, addr, desc, sizeof(*desc));
 }
 
 /* allowed just for 8 bytes segments */
@@ -1450,8 +1461,7 @@ static int write_segment_descriptor(stru
 		return emulate_gp(ctxt, selector & 0xfffc);
 
 	addr = dt.address + index * 8;
-	return ctxt->ops->write_std(ctxt, addr, desc, sizeof *desc,
-				    &ctxt->exception);
+	return linear_write_system(ctxt, addr, desc, sizeof *desc);
 }
 
 static int __load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
@@ -1599,8 +1609,7 @@ static int __load_segment_descriptor(str
 		if (ret != X86EMUL_CONTINUE)
 			return ret;
 	} else if (ctxt->mode == X86EMUL_MODE_PROT64) {
-		ret = ctxt->ops->read_std(ctxt, desc_addr+8, &base3,
-				sizeof(base3), &ctxt->exception);
+		ret = linear_read_system(ctxt, desc_addr+8, &base3, sizeof(base3));
 		if (ret != X86EMUL_CONTINUE)
 			return ret;
 	}
@@ -1917,11 +1926,11 @@ static int __emulate_int_real(struct x86
 	eip_addr = dt.address + (irq << 2);
 	cs_addr = dt.address + (irq << 2) + 2;
 
-	rc = ops->read_std(ctxt, cs_addr, &cs, 2, &ctxt->exception);
+	rc = linear_read_system(ctxt, cs_addr, &cs, 2);
 	if (rc != X86EMUL_CONTINUE)
 		return rc;
 
-	rc = ops->read_std(ctxt, eip_addr, &eip, 2, &ctxt->exception);
+	rc = linear_read_system(ctxt, eip_addr, &eip, 2);
 	if (rc != X86EMUL_CONTINUE)
 		return rc;
 
@@ -2573,27 +2582,23 @@ static int task_switch_16(struct x86_emu
 			  u16 tss_selector, u16 old_tss_sel,
 			  ulong old_tss_base, struct desc_struct *new_desc)
 {
-	const struct x86_emulate_ops *ops = ctxt->ops;
 	struct tss_segment_16 tss_seg;
 	int ret;
 	u32 new_tss_base = get_desc_base(new_desc);
 
-	ret = ops->read_std(ctxt, old_tss_base, &tss_seg, sizeof tss_seg,
-			    &ctxt->exception);
+	ret = linear_read_system(ctxt, old_tss_base, &tss_seg, sizeof tss_seg);
 	if (ret != X86EMUL_CONTINUE)
 		/* FIXME: need to provide precise fault address */
 		return ret;
 
 	save_state_to_tss16(ctxt, &tss_seg);
 
-	ret = ops->write_std(ctxt, old_tss_base, &tss_seg, sizeof tss_seg,
-			     &ctxt->exception);
+	ret = linear_write_system(ctxt, old_tss_base, &tss_seg, sizeof tss_seg);
 	if (ret != X86EMUL_CONTINUE)
 		/* FIXME: need to provide precise fault address */
 		return ret;
 
-	ret = ops->read_std(ctxt, new_tss_base, &tss_seg, sizeof tss_seg,
-			    &ctxt->exception);
+	ret = linear_read_system(ctxt, new_tss_base, &tss_seg, sizeof tss_seg);
 	if (ret != X86EMUL_CONTINUE)
 		/* FIXME: need to provide precise fault address */
 		return ret;
@@ -2601,10 +2606,9 @@ static int task_switch_16(struct x86_emu
 	if (old_tss_sel != 0xffff) {
 		tss_seg.prev_task_link = old_tss_sel;
 
-		ret = ops->write_std(ctxt, new_tss_base,
-				     &tss_seg.prev_task_link,
-				     sizeof tss_seg.prev_task_link,
-				     &ctxt->exception);
+		ret = linear_write_system(ctxt, new_tss_base,
+					  &tss_seg.prev_task_link,
+					  sizeof tss_seg.prev_task_link);
 		if (ret != X86EMUL_CONTINUE)
 			/* FIXME: need to provide precise fault address */
 			return ret;
@@ -2723,15 +2727,13 @@ static int task_switch_32(struct x86_emu
 			  u16 tss_selector, u16 old_tss_sel,
 			  ulong old_tss_base, struct desc_struct *new_desc)
 {
-	const struct x86_emulate_ops *ops = ctxt->ops;
 	struct tss_segment_32 tss_seg;
 	int ret;
 	u32 new_tss_base = get_desc_base(new_desc);
 	u32 eip_offset = offsetof(struct tss_segment_32, eip);
 	u32 ldt_sel_offset = offsetof(struct tss_segment_32, ldt_selector);
 
-	ret = ops->read_std(ctxt, old_tss_base, &tss_seg, sizeof tss_seg,
-			    &ctxt->exception);
+	ret = linear_read_system(ctxt, old_tss_base, &tss_seg, sizeof tss_seg);
 	if (ret != X86EMUL_CONTINUE)
 		/* FIXME: need to provide precise fault address */
 		return ret;
@@ -2739,14 +2741,13 @@ static int task_switch_32(struct x86_emu
 	save_state_to_tss32(ctxt, &tss_seg);
 
 	/* Only GP registers and segment selectors are saved */
-	ret = ops->write_std(ctxt, old_tss_base + eip_offset, &tss_seg.eip,
-			     ldt_sel_offset - eip_offset, &ctxt->exception);
+	ret = linear_write_system(ctxt, old_tss_base + eip_offset, &tss_seg.eip,
+				  ldt_sel_offset - eip_offset);
 	if (ret != X86EMUL_CONTINUE)
 		/* FIXME: need to provide precise fault address */
 		return ret;
 
-	ret = ops->read_std(ctxt, new_tss_base, &tss_seg, sizeof tss_seg,
-			    &ctxt->exception);
+	ret = linear_read_system(ctxt, new_tss_base, &tss_seg, sizeof tss_seg);
 	if (ret != X86EMUL_CONTINUE)
 		/* FIXME: need to provide precise fault address */
 		return ret;
@@ -2754,10 +2755,9 @@ static int task_switch_32(struct x86_emu
 	if (old_tss_sel != 0xffff) {
 		tss_seg.prev_task_link = old_tss_sel;
 
-		ret = ops->write_std(ctxt, new_tss_base,
-				     &tss_seg.prev_task_link,
-				     sizeof tss_seg.prev_task_link,
-				     &ctxt->exception);
+		ret = linear_write_system(ctxt, new_tss_base,
+					  &tss_seg.prev_task_link,
+					  sizeof tss_seg.prev_task_link);
 		if (ret != X86EMUL_CONTINUE)
 			/* FIXME: need to provide precise fault address */
 			return ret;

