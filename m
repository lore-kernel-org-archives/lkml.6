Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BB6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE999218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4+DQc80N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfBTUSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:18:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52896 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbfBTUS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:18:29 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8kOn081907;
        Wed, 20 Feb 2019 20:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=rivwbgHTX2wSH2CMj2+32JN9qlvvnpg8s+YqWIE/nys=;
 b=4+DQc80NisZW5DlVbkL3WRa8vN0EQ9B4I4Ipg+jlX2FBSgdLh9tnQAGc/nGMfsoVKGeT
 oTNzokvcNsmOxVfvXsQ4JZxAIlWY643iBZdOsYlFAr+0wImnE94JHyhMFd6HLRM3rVav
 auBL4uij7byatucZeNdqyLWCbeFaOPbT3Zn9YGRrAiLzq95G1EC7qZZxDT1xjfnkFwEU
 l1yGOMWN0x7F8bvuL/Lb6Jx5LOtCv3iCdFkBX49QFIKcMCraFMk8cTknhCbd84dcXsan
 OtcvYnlvzs3a4KouyJQ75tQjj3ECSWkPzY4f+MVaHrIiVa91hwKfBCdlRgfezomNr4tH YQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qp9xu3xkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:14 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIDx7019291
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:13 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KKIDox018843;
        Wed, 20 Feb 2019 20:18:13 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:18:12 -0800
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
Subject: [PATCH RFC 25/39] KVM: x86/xen: grant map support
Date:   Wed, 20 Feb 2019 20:15:55 +0000
Message-Id: <20190220201609.28290-26-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ankur Arora <ankur.a.arora@oracle.com>

Introduce support for mapping grant references. The sequence of events
to map a grant is:

  rframe = read_shared_entry(guest_grant_table, grant-ref);
  rpfn = get_user_pages_remote(remote_mm, rframe);
  mark_shared_entry(guest_grant_table, grant-ref,
  		     GTF_reading | GTF_writing);

To correctly handle grant unmaps for mapped grants, we save the mapping
parameters in maptrack. Also, grant map (and unmap) can be called from
non-sleeping contexts, so we call get_user_pages_remote() in
non-blocking mode and ask the user to retry.

Also note that this code is not compliant with Xen's grant map/unmap
ABI. In particular, we do not support multiple simultaneous mappings of
a grant-reference. Later versions will support that.

Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 arch/x86/kvm/xen.c | 396 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 396 insertions(+)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 645cd22ab4e7..3603645086a7 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -9,6 +9,7 @@
 #include "xen.h"
 #include "ioapic.h"
 
+#include <linux/mman.h>
 #include <linux/kvm_host.h>
 #include <linux/eventfd.h>
 #include <linux/sched/stat.h>
@@ -29,9 +30,11 @@
 
 /* Grant v1 references per 4K page */
 #define GPP_V1 (PAGE_SIZE / sizeof(struct grant_entry_v1))
+#define shared_entry(gt, ref)	(&((gt)[(ref) / GPP_V1][(ref) % GPP_V1]))
 
 /* Grant mappings per 4K page */
 #define MPP    (PAGE_SIZE / sizeof(struct kvm_grant_map))
+#define maptrack_entry(mt, hdl)	(&((mt)[(hdl) / MPP][(hdl) % MPP]))
 
 struct evtchnfd {
 	struct eventfd_ctx *ctx;
@@ -81,6 +84,18 @@ static int kvm_xen_domid_init(struct kvm *kvm, bool any, domid_t domid)
 	return 0;
 }
 
+static struct kvm *kvm_xen_find_vm(domid_t domid)
+{
+	unsigned long flags;
+	struct kvm *vm;
+
+	read_lock_irqsave(&domid_lock, flags);
+	vm = idr_find(&domid_to_kvm, domid);
+	read_unlock_irqrestore(&domid_lock, flags);
+
+	return vm;
+}
+
 int kvm_xen_free_domid(struct kvm *kvm)
 {
 	struct kvm_xen *xen = &kvm->arch.xen;
@@ -1153,7 +1168,20 @@ int kvm_xen_gnttab_init(struct kvm *kvm, struct kvm_xen *xen,
 	gnttab->frames = addr;
 	gnttab->frames[0] = xen->gnttab.initial;
 	gnttab->max_nr_frames = max_frames;
+
+	addr = kcalloc(max_mt_frames, sizeof(addr), GFP_KERNEL);
+	if (!addr)
+		goto out;
+
+	/* Needs to be aligned at 16b boundary. */
+	gnttab->handle = addr;
 	gnttab->max_mt_frames = max_mt_frames;
+
+	addr = (void *) get_zeroed_page(GFP_KERNEL);
+	if (!addr)
+		goto out;
+	gnttab->handle[0] = addr;
+
 	gnttab->nr_mt_frames = 1;
 	gnttab->nr_frames = 0;
 
@@ -1162,6 +1190,7 @@ int kvm_xen_gnttab_init(struct kvm *kvm, struct kvm_xen *xen,
 	return 0;
 
 out:
+	kfree(xen->gnttab.handle);
 	kfree(xen->gnttab.frames);
 	kfree(xen->gnttab.frames_addr);
 	if (page)
@@ -1170,11 +1199,38 @@ int kvm_xen_gnttab_init(struct kvm *kvm, struct kvm_xen *xen,
 	return -ENOMEM;
 }
 
+static void kvm_xen_maptrack_free(struct kvm_xen *xen)
+{
+	u32 max_entries = xen->gnttab.nr_mt_frames * MPP;
+	struct kvm_grant_map *map;
+	int ref, inuse = 0;
+
+	for (ref = 0; ref < max_entries; ref++) {
+		map = maptrack_entry(xen->gnttab.handle, ref);
+
+		if (test_and_clear_bit(_KVM_GNTMAP_ACTIVE,
+				       (unsigned long *)&map->flags)) {
+			put_page(virt_to_page(map->gpa));
+			inuse++;
+		}
+	}
+
+	if (inuse)
+		pr_debug("kvm: dom%u teardown %u mappings\n",
+			 xen->domid, inuse);
+}
+
 void kvm_xen_gnttab_free(struct kvm_xen *xen)
 {
 	struct kvm_grant_table *gnttab = &xen->gnttab;
 	int i;
 
+	if (xen->domid)
+		kvm_xen_maptrack_free(xen);
+
+	for (i = 0; i < gnttab->nr_mt_frames; i++)
+		free_page((unsigned long)gnttab->handle[i]);
+
 	for (i = 0; i < gnttab->nr_frames; i++)
 		put_page(virt_to_page(gnttab->frames[i]));
 
@@ -1313,6 +1369,343 @@ void kvm_xen_unregister_lcall(void)
 }
 EXPORT_SYMBOL_GPL(kvm_xen_unregister_lcall);
 
+static inline int gnttab_entries(struct kvm *kvm)
+{
+	struct kvm_grant_table *gnttab = &kvm->arch.xen.gnttab;
+	int n = max_t(unsigned int, gnttab->nr_frames, 1);
+
+	return n * ((n << PAGE_SHIFT) / sizeof(struct grant_entry_v1));
+}
+
+/*
+ * The first two members of a grant entry are updated as a combined pair.
+ * The following union allows that to happen in an endian-neutral fashion.
+ * Taken from Xen.
+ */
+union grant_combo {
+	uint32_t word;
+	struct {
+		uint16_t flags;
+		domid_t  domid;
+	} shorts;
+};
+
+/* Marks a grant in use. Code largely borrowed from Xen. */
+static int set_grant_status(domid_t domid, bool readonly,
+			    struct grant_entry_v1 *shah)
+{
+	int rc = GNTST_okay;
+	union grant_combo scombo, prev_scombo, new_scombo;
+	uint16_t mask = GTF_type_mask;
+
+	/*
+	 * We bound the number of times we retry CMPXCHG on memory locations
+	 * that we share with a guest OS. The reason is that the guest can
+	 * modify that location at a higher rate than we can
+	 * read-modify-CMPXCHG, so the guest could cause us to livelock. There
+	 * are a few cases where it is valid for the guest to race our updates
+	 * (e.g., to change the GTF_readonly flag), so we allow a few retries
+	 * before failing.
+	 */
+	int retries = 0;
+
+	scombo.word = *(u32 *)shah;
+
+	/*
+	 * This loop attempts to set the access (reading/writing) flags
+	 * in the grant table entry.  It tries a cmpxchg on the field
+	 * up to five times, and then fails under the assumption that
+	 * the guest is misbehaving.
+	 */
+	for (;;) {
+		/* If not already pinned, check the grant domid and type. */
+		if ((((scombo.shorts.flags & mask) != GTF_permit_access) ||
+		    (scombo.shorts.domid != domid))) {
+			rc = GNTST_general_error;
+			pr_err("Bad flags (%x) or dom (%d); expected d%d\n",
+				scombo.shorts.flags, scombo.shorts.domid,
+				domid);
+			return rc;
+		}
+
+		new_scombo = scombo;
+		new_scombo.shorts.flags |= GTF_reading;
+
+		if (!readonly) {
+			new_scombo.shorts.flags |= GTF_writing;
+			if (unlikely(scombo.shorts.flags & GTF_readonly)) {
+				rc = GNTST_general_error;
+				pr_err("Attempt to write-pin a r/o grant entry\n");
+				return rc;
+			}
+		}
+
+		prev_scombo.word = cmpxchg((u32 *)shah,
+					   scombo.word, new_scombo.word);
+		if (likely(prev_scombo.word == scombo.word))
+			break;
+
+		if (retries++ == 4) {
+			rc = GNTST_general_error;
+			pr_err("Shared grant entry is unstable\n");
+			return rc;
+		}
+
+		scombo = prev_scombo;
+	}
+
+	return rc;
+}
+
+#define MT_HANDLE_DOMID_SHIFT	17
+#define MT_HANDLE_DOMID_MASK	0x7fff
+#define MT_HANDLE_GREF_MASK	0x1ffff
+
+static u32 handle_get(domid_t domid, grant_ref_t ref)
+{
+	return (domid << MT_HANDLE_DOMID_SHIFT) | ref;
+}
+
+static u16 handle_get_domid(grant_handle_t handle)
+{
+	return (handle >> MT_HANDLE_DOMID_SHIFT) & MT_HANDLE_DOMID_MASK;
+}
+
+static grant_ref_t handle_get_grant(grant_handle_t handle)
+{
+	return handle & MT_HANDLE_GREF_MASK;
+}
+
+static int map_grant_nosleep(struct kvm *rd, u64 frame, bool readonly,
+			     struct page **page, u16 *err)
+{
+	unsigned long rhva;
+	int gup_flags, non_blocking;
+	int ret;
+
+	*err = GNTST_general_error;
+
+	if (!err || !page)
+		return -EINVAL;
+
+	rhva  = gfn_to_hva(rd, frame);
+	if (kvm_is_error_hva(rhva)) {
+		*err = GNTST_bad_page;
+		return -EFAULT;
+	}
+
+	gup_flags = (readonly ? 0 : FOLL_WRITE) | FOLL_NOWAIT;
+
+	/* get_user_pages will reset this were IO to be needed */
+	non_blocking = 1;
+
+	/*
+	 * get_user_pages_*() family of functions can sleep if the page needs
+	 * to be mapped in. However, our main consumer is the grant map
+	 * hypercall and because we run in the same context as the caller
+	 * (unlike a real hypercall) sleeping is not an option.
+	 *
+	 * This is how we avoid it:
+	 *  - sleeping on mmap_sem acquisition: we handle that by acquiring the
+	 *    read-lock before calling.
+	 *    If mmap_sem is contended, return with GNTST_eagain.
+	 *  - sync wait for pages to be swapped in: specify FOLL_NOWAIT. If IO
+	 *    was needed, would be returned via @non_blocking. Return
+	 *    GNTST_eagain if it is necessary and the user would retry.
+	 *    Also, in the blocking case, mmap_sem will be released
+	 *    asynchronously when the IO completes.
+	 */
+	ret = down_read_trylock(&rd->mm->mmap_sem);
+	if (ret == 0) {
+		*err = GNTST_eagain;
+		return -EBUSY;
+	}
+
+	ret = get_user_pages_remote(rd->mm->owner, rd->mm, rhva, 1, gup_flags,
+				    page, NULL, &non_blocking);
+	if (non_blocking)
+		up_read(&rd->mm->mmap_sem);
+
+	if (ret == 1) {
+		*err = GNTST_okay;
+	} else if (ret == 0) {
+		*err = GNTST_eagain;
+		ret = -EBUSY;
+	} else if (ret < 0) {
+		pr_err("gnttab: failed to get pfn for hva %lx, err %d\n",
+			rhva, ret);
+		if (ret == -EFAULT) {
+			*err = GNTST_bad_page;
+		} else if (ret == -EBUSY) {
+			WARN_ON(non_blocking);
+			*err = GNTST_eagain;
+		} else {
+			*err = GNTST_general_error;
+		}
+	}
+
+	return (ret >= 0) ? 0 : ret;
+}
+
+static int shim_hcall_gntmap(struct kvm_xen *ld,
+			     struct gnttab_map_grant_ref *op)
+{
+	struct kvm_grant_map map_old, map_new, *map = NULL;
+	bool readonly = op->flags & GNTMAP_readonly;
+	struct grant_entry_v1 *shah;
+	struct page *page = NULL;
+	unsigned long host_kaddr;
+	int err = -ENOSYS;
+	struct kvm *rd;
+	kvm_pfn_t rpfn;
+	u32 frame;
+	u32 idx;
+
+	BUILD_BUG_ON(sizeof(*map) != 16);
+
+	if (unlikely((op->host_addr))) {
+		pr_err("gnttab: bad host_addr %llx in map\n", op->host_addr);
+		op->status = GNTST_bad_virt_addr;
+		return 0;
+	}
+
+	/*
+	 * Make sure the guest does not try to smuggle any flags here
+	 * (for instance _KVM_GNTMAP_ACTIVE.)
+	 * The only allowable flag is GNTMAP_readonly.
+	 */
+	if (unlikely(op->flags & ~((u16) GNTMAP_readonly))) {
+		pr_err("gnttab: bad flags %x in map\n", op->flags);
+		op->status = GNTST_bad_gntref;
+		return 0;
+	}
+
+	rd = kvm_xen_find_vm(op->dom);
+	if (unlikely(!rd)) {
+		pr_err("gnttab: could not find domain %u\n", op->dom);
+		op->status = GNTST_bad_domain;
+		return 0;
+	}
+
+	if (unlikely(op->ref >= gnttab_entries(rd))) {
+		pr_err("gnttab: bad ref %u\n", op->ref);
+		op->status = GNTST_bad_gntref;
+		return 0;
+	}
+
+	/*
+	 * shah is potentially controlled by the user. We cache the frame but
+	 * don't care about any changes to domid or flags since those get
+	 * validated in set_grant_status() anyway.
+	 *
+	 * Note that if the guest changes the frame we will end up mapping the
+	 * old frame.
+	 */
+	shah = shared_entry(rd->arch.xen.gnttab.frames_v1, op->ref);
+	frame = READ_ONCE(shah->frame);
+
+	if (unlikely(shah->domid != ld->domid)) {
+		pr_err("gnttab: bad domain (%u != %u)\n",
+			shah->domid, ld->domid);
+		op->status = GNTST_bad_gntref;
+		goto out;
+	}
+
+	idx = handle_get(op->dom, op->ref);
+	if (handle_get_grant(idx) < op->ref ||
+	    handle_get_domid(idx) < op->dom) {
+		pr_err("gnttab: out of maptrack entries (dom %u)\n", ld->domid);
+		op->status = GNTST_general_error;
+		goto out;
+	}
+
+	map = maptrack_entry(rd->arch.xen.gnttab.handle, op->ref);
+
+	/*
+	 * Cache the old map value so we can do our checks on the stable
+	 * version. Once the map is done, swap the mapping with the new map.
+	 */
+	map_old = *map;
+	if (map_old.flags & KVM_GNTMAP_ACTIVE) {
+		pr_err("gnttab: grant ref %u dom %u in use\n",
+			op->ref, ld->domid);
+		op->status = GNTST_bad_gntref;
+		goto out;
+	}
+
+	err = map_grant_nosleep(rd, frame, readonly, &page, &op->status);
+	if (err) {
+		if (err != -EBUSY)
+			op->status = GNTST_bad_gntref;
+		goto out;
+	}
+
+	err = set_grant_status(ld->domid, readonly, shah);
+	if (err != GNTST_okay) {
+		pr_err("gnttab: pin failed\n");
+		put_page(page);
+		op->status = err;
+		goto out;
+	}
+
+	rpfn = page_to_pfn(page);
+	host_kaddr = (unsigned long) pfn_to_kaddr(rpfn);
+
+	map_new.domid = op->dom;
+	map_new.ref = op->ref;
+	map_new.flags = op->flags;
+	map_new.gpa = host_kaddr;
+
+	map_new.flags |= KVM_GNTMAP_ACTIVE;
+
+	/*
+	 * Protect against a grant-map that could come in between our check for
+	 * KVM_GNTMAP_ACTIVE above and assuming the ownership of the mapping.
+	 *
+	 * Use cmpxchg_double() so we can update mapping atomically (which
+	 * luckily fits in 16b.)
+	 */
+	if (cmpxchg_double(&map->gpa, &map->fields,
+			map_old.gpa, map_old.fields,
+			map_new.gpa, map_new.fields) == false) {
+		put_page(page);
+		op->status = GNTST_bad_gntref;
+		goto out;
+	}
+
+	op->dev_bus_addr = rpfn << PAGE_SHIFT;
+	op->handle = idx;
+	op->status = GNTST_okay;
+	op->host_addr = host_kaddr;
+	return 0;
+
+out:
+	/* The error code is stored in @status. */
+	return 0;
+}
+
+static int shim_hcall_gnttab(int op, void *p, int count)
+{
+	int ret = -ENOSYS;
+	int i;
+
+	switch (op) {
+	case GNTTABOP_map_grant_ref: {
+		struct gnttab_map_grant_ref *ref = p;
+
+		for (i = 0; i < count; i++)
+			shim_hcall_gntmap(xen_shim, ref + i);
+		ret = 0;
+		break;
+	}
+	default:
+		pr_info("lcall-gnttab:op default=%d\n", op);
+		break;
+	}
+
+	return ret;
+}
+
 static int shim_hcall_version(int op, struct xen_feature_info *fi)
 {
 	if (op != XENVER_get_features || !fi || fi->submap_idx != 0)
@@ -1330,6 +1723,9 @@ static int shim_hypercall(u64 code, u64 a0, u64 a1, u64 a2, u64 a3, u64 a4)
 	int ret = -ENOSYS;
 
 	switch (code) {
+	case __HYPERVISOR_grant_table_op:
+		ret = shim_hcall_gnttab((int) a0, (void *) a1, (int) a2);
+		break;
 	case __HYPERVISOR_xen_version:
 		ret = shim_hcall_version((int)a0, (void *)a1);
 		break;
-- 
2.11.0

