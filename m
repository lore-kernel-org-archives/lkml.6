Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E428C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589EB2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jCdyIhHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfBTUSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:18:38 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33848 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbfBTUSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:18:34 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8VmG087414;
        Wed, 20 Feb 2019 20:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=87hDNam+EDhaaTcyC+shLftB4Uu5fmCyLj6CCzNbwoI=;
 b=jCdyIhHnnd59kr48KSPhb/CVx/UxspTKtJV5zW9PyFt1J9cwuTeCl9ejpJe201zxrvK5
 vMMg+hAr8H1NvhxDRbQ9iMPrcqrcl6BYwTtU6mhLCiTIoMQMzMysyLfP5tLz1DOx7pRT
 onwKSebJQSHBupbj4BK/RG7uWFnZK2ZS0xDOi3U1M8LMzhqZzW2sbfudQ4znI9uEUk26
 B8wU5PB80ldae+LhlQTnbUSJ7a9NYxllkz7GEhNTQGJVLvFd07RfuLP3f9U/0iqyex3j
 uGLiPhGWMFk0vXafNzarMrzH2p0KAph/dlhi4YUPR7Wtyh7RYV3Ehv2XOcA/HjSPLLIg 9w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qp81ec3df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:20 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIJ1v024885
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:19 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIJTA009962;
        Wed, 20 Feb 2019 20:18:19 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:18:19 -0800
From:   Joao Martins <joao.m.martins@oracle.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH RFC 27/39] KVM: x86/xen: grant copy support
Date:   Wed, 20 Feb 2019 20:15:57 +0000
Message-Id: <20190220201609.28290-28-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copies from source grant reference to dest grant reference (or the
other way around.)

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 arch/x86/kvm/xen.c | 151 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 8f06924e0dfa..fecc548b2f12 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -10,6 +10,7 @@
 #include "ioapic.h"
 
 #include <linux/mman.h>
+#include <linux/highmem.h>
 #include <linux/kvm_host.h>
 #include <linux/eventfd.h>
 #include <linux/sched/stat.h>
@@ -1747,6 +1748,148 @@ static int shim_hcall_gntunmap(struct kvm_xen *xen,
 	return 0;
 }
 
+static unsigned long __kvm_gfn_to_hva(struct kvm_vcpu *vcpu, gfn_t gfn)
+{
+	struct kvm_xen *xen = vcpu ? &vcpu->kvm->arch.xen : xen_shim;
+	unsigned long hva;
+
+	if (xen->domid == 0)
+		return (unsigned long) page_to_virt(pfn_to_page(gfn));
+
+	hva = gfn_to_hva(vcpu->kvm, gfn);
+	if (unlikely(kvm_is_error_hva(hva)))
+		return 0;
+
+	return hva;
+}
+
+static int __kvm_gref_to_page(struct kvm_vcpu *vcpu, grant_ref_t ref,
+			      domid_t domid, struct page **page,
+			      int16_t *status)
+{
+	struct kvm_xen *source = vcpu ? &vcpu->kvm->arch.xen : xen_shim;
+	struct grant_entry_v1 *shah;
+	struct grant_entry_v1 **gt;
+	struct kvm *dest;
+
+	dest = kvm_xen_find_vm(domid);
+	if (unlikely(!dest)) {
+		pr_err("gnttab: could not find domain %u\n", domid);
+		*status = GNTST_bad_domain;
+		return 0;
+	}
+
+	if (unlikely(ref >= gnttab_entries(dest))) {
+		pr_err("gnttab: bad ref %u\n", ref);
+		*status = GNTST_bad_gntref;
+		return 0;
+	}
+
+	gt = dest->arch.xen.gnttab.frames_v1;
+	shah = shared_entry(gt, ref);
+	if (unlikely(shah->domid != source->domid)) {
+		pr_err("gnttab: bad domain (%u != %u)\n",
+			shah->domid, source->domid);
+		*status = GNTST_bad_gntref;
+		return 0;
+	}
+
+	(void) map_grant_nosleep(dest, shah->frame, 0, page, status);
+
+	return 0;
+}
+
+static int shim_hcall_gntcopy(struct kvm_vcpu *vcpu,
+				   struct gnttab_copy *op)
+{
+	void *saddr = NULL, *daddr = NULL;
+	struct page *spage = NULL, *dpage = NULL;
+	unsigned long hva;
+	int err = -ENOSYS;
+	gfn_t gfn;
+
+	if (!(op->flags & GNTCOPY_source_gref) &&
+	    (op->source.domid == DOMID_SELF)) {
+		gfn = op->source.u.gmfn;
+		hva = __kvm_gfn_to_hva(vcpu, gfn);
+		if (unlikely(!hva)) {
+			pr_err("gnttab: bad source gfn:%llx\n", gfn);
+			op->status = GNTST_general_error;
+			err = 0;
+			return 0;
+		}
+
+		saddr = (void *) (((unsigned long) hva) + op->source.offset);
+	} else if (op->flags & GNTCOPY_source_gref) {
+		op->status = GNTST_okay;
+		if (__kvm_gref_to_page(vcpu, op->source.u.ref,
+				       op->source.domid, &spage, &op->status))
+			return -EFAULT;
+
+		if (!spage || op->status != GNTST_okay) {
+			pr_err("gnttab: failed to get page for source gref:%x\n",
+			       op->source.u.ref);
+			err = 0;
+			goto out;
+		}
+
+		saddr = kmap(spage);
+		saddr = (void *) (((unsigned long) saddr) + op->source.offset);
+	}
+
+	if (!(op->flags & GNTCOPY_dest_gref) &&
+	    (op->dest.domid == DOMID_SELF)) {
+		gfn = op->dest.u.gmfn;
+		hva = __kvm_gfn_to_hva(vcpu, gfn);
+		if (unlikely(!hva)) {
+			pr_err("gnttab: bad dest gfn:%llx\n", gfn);
+			op->status = GNTST_general_error;
+			err = 0;
+			return 0;
+		}
+
+		daddr = (void *) (((unsigned long) hva) + op->dest.offset);
+	} else if (op->flags & GNTCOPY_dest_gref) {
+		op->status = GNTST_okay;
+		if (__kvm_gref_to_page(vcpu, op->dest.u.ref,
+				       op->dest.domid, &dpage, &op->status))
+			return -EFAULT;
+
+		if (!dpage || op->status != GNTST_okay) {
+			pr_err("gnttab: failed to get page for dest gref:%x\n",
+			       op->dest.u.ref);
+			err = 0;
+			goto out;
+		}
+
+		daddr = kmap(dpage);
+		daddr = (void *) (((unsigned long) daddr) + op->dest.offset);
+	}
+
+	if (unlikely(!daddr || !saddr)) {
+		op->status = GNTST_general_error;
+		err = 0;
+		goto out;
+	}
+
+	memcpy(daddr, saddr, op->len);
+
+	if (spage)
+		kunmap(spage);
+	if (dpage)
+		kunmap(dpage);
+
+
+	err = 0;
+	op->status = GNTST_okay;
+out:
+	if (spage)
+		put_page(spage);
+	if (dpage)
+		put_page(dpage);
+	return err;
+}
+
 static int shim_hcall_gnttab(int op, void *p, int count)
 {
 	int ret = -ENOSYS;
@@ -1771,6 +1914,14 @@ static int shim_hcall_gnttab(int op, void *p, int count)
 		ret = 0;
 		break;
 	}
+	case GNTTABOP_copy: {
+		struct gnttab_copy *op = p;
+
+		for (i = 0; i < count; i++)
+			shim_hcall_gntcopy(NULL, op + i);
+		ret = 0;
+		break;
+	}
 	default:
 		pr_info("lcall-gnttab:op default=%d\n", op);
 		break;
-- 
2.11.0

