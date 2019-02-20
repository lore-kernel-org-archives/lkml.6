Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900C3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6557A2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hVyhkVLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfBTURZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:17:25 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34888 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfBTURY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:17:24 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8ceC087610;
        Wed, 20 Feb 2019 20:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=V5q13HBn+4ZOF9QMLFs45AmHfiywEMNQk6g5OyP6QrY=;
 b=hVyhkVLIZA9ED2oyH5lx+R4dLdbhfDwfHVu1ctmirGljINrZQNNVP7wNkNcUdlJeyeLq
 Gvoc9LO4n6uwFbk/lYzh378RuYSwXNuevLEo4DLS2tFtoZRiSXlD5FWiDNAMFE9eIU/J
 Eg0xNPdxjLfFOItq7Rb9wC/avlJNb9JpMisxH0QavqWdYJgLZCv5fLcA3hBzGjDAcem0
 s/9QL0AhzZyUYOJ0IPBg9BU4o7OASLwFf/C2orP3eRurk2If/b86DvE9yFt7VelazjHu
 SZ9Gz77wHeBS7wBEQ/dQuQ0Zw0pyhOWu7DI+55F4h7tLm4cadX/Xzg1aQLP/Ndlq2m11 Hg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qpb5rktna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:10 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHAt1025009
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:10 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKH9OM011752;
        Wed, 20 Feb 2019 20:17:09 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:17:08 -0800
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
Subject: [PATCH RFC 05/39] KVM: x86/xen: update wallclock region
Date:   Wed, 20 Feb 2019 20:15:35 +0000
Message-Id: <20190220201609.28290-6-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=748 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wallclock on Xen is written in the shared_info page.

To that purpose, export kvm_write_wall_clock() and pass on the GPA of
its location to populate the shared_info wall clock data.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 arch/x86/kvm/x86.c | 2 +-
 arch/x86/kvm/x86.h | 1 +
 arch/x86/kvm/xen.c | 3 +++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6eb2afaa2af2..31a102b22042 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1418,7 +1418,7 @@ void kvm_set_pending_timer(struct kvm_vcpu *vcpu)
 	kvm_make_request(KVM_REQ_PENDING_TIMER, vcpu);
 }
 
-static void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock)
+void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock)
 {
 	int version;
 	int r;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 28406aa1136d..b5f2e66a4c81 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -256,6 +256,7 @@ static inline bool kvm_check_has_quirk(struct kvm *kvm, u64 quirk)
 }
 
 void kvm_set_pending_timer(struct kvm_vcpu *vcpu);
+void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock);
 int kvm_inject_realmode_interrupt(struct kvm_vcpu *vcpu, int irq, int inc_eip);
 
 void kvm_write_tsc(struct kvm_vcpu *vcpu, struct msr_data *msr);
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index b4bd1949656e..879bcfdd7b1d 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -19,6 +19,7 @@ static int kvm_xen_shared_info_init(struct kvm *kvm, gfn_t gfn)
 {
 	struct shared_info *shared_info;
 	struct page *page;
+	gpa_t gpa = gfn_to_gpa(gfn);
 
 	page = gfn_to_page(kvm, gfn);
 	if (is_error_page(page))
@@ -30,6 +31,8 @@ static int kvm_xen_shared_info_init(struct kvm *kvm, gfn_t gfn)
 	memset(shared_info, 0, sizeof(struct shared_info));
 	kvm->arch.xen.shinfo = shared_info;
 
+	kvm_write_wall_clock(kvm, gpa + offsetof(struct shared_info, wc));
+
 	kvm_make_all_cpus_request(kvm, KVM_REQ_MASTERCLOCK_UPDATE);
 	return 0;
 }
-- 
2.11.0

