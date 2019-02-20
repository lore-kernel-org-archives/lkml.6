Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B719C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C5E2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TawXR2tZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfBTUUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:20:22 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36216 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbfBTUSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:18:36 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8YIC087297;
        Wed, 20 Feb 2019 20:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=YZ80s2dOqvHZLSQICuv37RTvDVLvQVdgaR+I/O+Ppao=;
 b=TawXR2tZtIHJQg0fJ3iWk9NXhfNqK5+2LgqSUautIUcoNAtdrcFluwEI6ZfWFP5EbiRY
 wL7/QhsLf7ie6hBe3eSbpl5bcFsLS71iLDivSHoL1rxNQYNSn6UGBJJEpIe5SvjGEYqa
 ZBNcyzvGETuQA9qPZ4RlU4Fy8Yi5Qj5IASIA3EaTo/AJWntzh+dekpEZLtu0LDFvrKhI
 hwIt+GSrLprs8zU7P7s1yGPPioYs/a5bcRCAuLgxJHyDQb3IlrlgvJdXlhPi5LuqrlM1
 tuGuLCibtTpQ5jdGg+Z9gyogAFQht172H1iYiZUeFFvnHnt7futsI7F+uJ+rP9as+8Kt 1g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qpb5rktuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:23 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIHmo024795
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:17 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KKIGjM015848;
        Wed, 20 Feb 2019 20:18:16 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:18:16 -0800
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
Subject: [PATCH RFC 26/39] KVM: x86/xen: grant unmap support
Date:   Wed, 20 Feb 2019 20:15:56 +0000
Message-Id: <20190220201609.28290-27-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=803 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ankur Arora <ankur.a.arora@oracle.com>

Grant unmap removes the grant from maptrack and marks it as not in use.
We maintain a one-to-one correspondence between grant table and maptrack
entries so there's no contention in allocation/free.

Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 arch/x86/kvm/xen.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 3603645086a7..8f06924e0dfa 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1684,6 +1684,69 @@ static int shim_hcall_gntmap(struct kvm_xen *ld,
 	return 0;
 }
 
+static int shim_hcall_gntunmap(struct kvm_xen *xen,
+			       struct gnttab_unmap_grant_ref *op)
+{
+	struct kvm_grant_map *map, unmap;
+	struct grant_entry_v1 **rgt;
+	struct grant_entry_v1 *shah;
+	struct kvm *rd = NULL;
+	domid_t domid;
+	u32 ref;
+
+	domid = handle_get_domid(op->handle);
+	ref = handle_get_grant(op->handle);
+
+
+	rd = kvm_xen_find_vm(domid);
+	if (unlikely(!rd)) {
+		/* We already teardown all ongoing grant maps */
+		op->status = GNTST_okay;
+		return 0;
+	}
+
+	if (unlikely(ref >= gnttab_entries(rd))) {
+		pr_err("gnttab: bad ref %u\n", ref);
+		op->status = GNTST_bad_handle;
+		return 0;
+	}
+
+	rgt = rd->arch.xen.gnttab.frames_v1;
+	map = maptrack_entry(rd->arch.xen.gnttab.handle, ref);
+
+	/*
+	 * The test_and_clear_bit (below) serializes ownership of this
+	 * grant-entry.  After we clear it, there can be a grant-map on this
+	 * entry. So we cache the unmap entry before relinquishing ownership.
+	 */
+	unmap = *map;
+
+	if (!test_and_clear_bit(_KVM_GNTMAP_ACTIVE,
+				(unsigned long *) &map->flags)) {
+		pr_err("gnttab: bad flags for %u (dom %u ref %u) flags %x\n",
+			op->handle, domid, ref, unmap.flags);
+		op->status = GNTST_bad_handle;
+		return 0;
+	}
+
+	/* Give up the reference taken in get_user_pages_remote(). */
+	put_page(virt_to_page(unmap.gpa));
+
+	shah = shared_entry(rgt, unmap.ref);
+
+	/*
+	 * We have cleared _KVM_GNTMAP_ACTIVE, so a simultaneous grant-map
+	 * could update the shah and we would stomp all over it but the
+	 * guest deserves it.
+	 */
+	if (!(unmap.flags & GNTMAP_readonly))
+		clear_bit(_GTF_writing, (unsigned long *) &shah->flags);
+	clear_bit(_GTF_reading, (unsigned long *) &shah->flags);
+
+	op->status = GNTST_okay;
+	return 0;
+}
+
 static int shim_hcall_gnttab(int op, void *p, int count)
 {
 	int ret = -ENOSYS;
@@ -1698,6 +1761,16 @@ static int shim_hcall_gnttab(int op, void *p, int count)
 		ret = 0;
 		break;
 	}
+	case GNTTABOP_unmap_grant_ref: {
+		struct gnttab_unmap_grant_ref *ref = p;
+
+		for (i = 0; i < count; i++) {
+			shim_hcall_gntunmap(xen_shim, ref + i);
+			ref[i].host_addr = 0;
+		}
+		ret = 0;
+		break;
+	}
 	default:
 		pr_info("lcall-gnttab:op default=%d\n", op);
 		break;
-- 
2.11.0

