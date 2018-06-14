Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B32FAC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7D4208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVtNxs6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7D4208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966219AbeFNONU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966150AbeFNONS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:13:18 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38582208DB;
        Thu, 14 Jun 2018 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985597;
        bh=SPkbFSGFuWq45mFOol61IWSZX1jlK+wIOAAuRb/oPo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jVtNxs6UscqTCZ9AkipAn9gdE0ZvKz1dSy80ThyDnNBO+YG6QQ9y3D0XJLDeh9Dm6
         HpwEZlkHZ5Jx65i2818DBk4Rk4F7WYGgfHf8VU/zGklrMk4YDjn0a61AQPZ3jdvZv1
         c4tfnn0w7OC04b4krNoAkcYG56o8KQxlvh8FH+hc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.4 17/24] KVM: x86: introduce linear_{read,write}_system
Date:   Thu, 14 Jun 2018 16:05:12 +0200
Message-Id: <20180614132725.171656552@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132724.483802160@linuxfoundation.org>
References: <20180614132724.483802160@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit 79367a65743975e5cac8d24d08eccc7fdae832b0 upstream.

Wrap the common invocation of ctxt->ops->read_std and ctxt->ops->write_std, so
as to have a smaller patch when the functions grow another argument.

Fixes: 129a72a0d3c8 ("KVM: x86: Introduce segmented_write_std", 2017-01-12)
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/emulate.c |   64 ++++++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -790,6 +790,19 @@ static inline int jmp_rel(struct x86_emu
 	return assign_eip_near(ctxt, ctxt->_eip + rel);
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
@@ -1488,8 +1501,7 @@ static int read_interrupt_descriptor(str
 		return emulate_gp(ctxt, index << 3 | 0x2);
 
 	addr = dt.address + index * 8;
-	return ctxt->ops->read_std(ctxt, addr, desc, sizeof *desc,
-				   &ctxt->exception);
+	return linear_read_system(ctxt, addr, desc, sizeof *desc);
 }
 
 static void get_descriptor_table_ptr(struct x86_emulate_ctxt *ctxt,
@@ -1552,8 +1564,7 @@ static int read_segment_descriptor(struc
 	if (rc != X86EMUL_CONTINUE)
 		return rc;
 
-	return ctxt->ops->read_std(ctxt, *desc_addr_p, desc, sizeof(*desc),
-				   &ctxt->exception);
+	return linear_read_system(ctxt, *desc_addr_p, desc, sizeof(*desc));
 }
 
 /* allowed just for 8 bytes segments */
@@ -1567,8 +1578,7 @@ static int write_segment_descriptor(stru
 	if (rc != X86EMUL_CONTINUE)
 		return rc;
 
-	return ctxt->ops->write_std(ctxt, addr, desc, sizeof *desc,
-				    &ctxt->exception);
+	return linear_write_system(ctxt, addr, desc, sizeof *desc);
 }
 
 static int __load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
@@ -1729,8 +1739,7 @@ static int __load_segment_descriptor(str
 				return ret;
 		}
 	} else if (ctxt->mode == X86EMUL_MODE_PROT64) {
-		ret = ctxt->ops->read_std(ctxt, desc_addr+8, &base3,
-				sizeof(base3), &ctxt->exception);
+		ret = linear_read_system(ctxt, desc_addr+8, &base3, sizeof(base3));
 		if (ret != X86EMUL_CONTINUE)
 			return ret;
 		if (is_noncanonical_address(get_desc_base(&seg_desc) |
@@ -2043,11 +2052,11 @@ static int __emulate_int_real(struct x86
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
 
@@ -3025,35 +3034,30 @@ static int task_switch_16(struct x86_emu
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
 		return ret;
 
 	save_state_to_tss16(ctxt, &tss_seg);
 
-	ret = ops->write_std(ctxt, old_tss_base, &tss_seg, sizeof tss_seg,
-			     &ctxt->exception);
+	ret = linear_write_system(ctxt, old_tss_base, &tss_seg, sizeof tss_seg);
 	if (ret != X86EMUL_CONTINUE)
 		return ret;
 
-	ret = ops->read_std(ctxt, new_tss_base, &tss_seg, sizeof tss_seg,
-			    &ctxt->exception);
+	ret = linear_read_system(ctxt, new_tss_base, &tss_seg, sizeof tss_seg);
 	if (ret != X86EMUL_CONTINUE)
 		return ret;
 
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
 			return ret;
 	}
@@ -3169,38 +3173,34 @@ static int task_switch_32(struct x86_emu
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
 		return ret;
 
 	save_state_to_tss32(ctxt, &tss_seg);
 
 	/* Only GP registers and segment selectors are saved */
-	ret = ops->write_std(ctxt, old_tss_base + eip_offset, &tss_seg.eip,
-			     ldt_sel_offset - eip_offset, &ctxt->exception);
+	ret = linear_write_system(ctxt, old_tss_base + eip_offset, &tss_seg.eip,
+				  ldt_sel_offset - eip_offset);
 	if (ret != X86EMUL_CONTINUE)
 		return ret;
 
-	ret = ops->read_std(ctxt, new_tss_base, &tss_seg, sizeof tss_seg,
-			    &ctxt->exception);
+	ret = linear_read_system(ctxt, new_tss_base, &tss_seg, sizeof tss_seg);
 	if (ret != X86EMUL_CONTINUE)
 		return ret;
 
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
 			return ret;
 	}


