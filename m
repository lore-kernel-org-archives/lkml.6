Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCCEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DCB2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ijkbP7HL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfBTUSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:18:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53128 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbfBTUSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:18:41 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8Uhf081679;
        Wed, 20 Feb 2019 20:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ObvMkIO580oz+cYvFFnQV9+Yfz6Iys4YkrQlTPQzc0g=;
 b=ijkbP7HLCyY94yv4cDu+h4kxzcpki4HqC431yvgCZOoK72QjWVl6RIYmthE0Jfmepdbk
 qFuRHDXxleVoa9Fq7/eJdpm9LT/rq5H4v16dBci38UNVfvGsZyVBuEKIqMclIvXus7nQ
 6QJ/x+MTR6oLAu6SL5hKa1GoUQPWR70FjGdTz3l/exZ6u1TQ14XFhU4Yg4yNuy3Zl3VS
 OWEBCbNQToKGrW3hzJw4CaDJYyR9JdWSYUYCHYZQHzS0sqkzNyfuIu8IeovREK38QnLH
 pjKqkntfnxpvDcdKwQNhu5gTKJSBTAhC5PwWcCsoFU+p5jq/62lmMdih31GPjieRbr8t BQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2qp9xu3xmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:26 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIQ2K007388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:26 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIQ84010001;
        Wed, 20 Feb 2019 20:18:26 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:18:25 -0800
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
Subject: [PATCH RFC 29/39] KVM: x86/xen: evtchn unmask support
Date:   Wed, 20 Feb 2019 20:15:59 +0000
Message-Id: <20190220201609.28290-30-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=828 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ankur Arora <ankur.a.arora@oracle.com>

Handle hypercall to unmasks event channel ports.

A subtlety here is that we deliver an upcall if an actual unmask
happened and the event channel was pending (and if the vcpu-wide
evtchn_pending_sel was not already marked pending.)

Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 arch/x86/kvm/xen.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 420e3ebb66bc..1988ed3866bf 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -2102,6 +2102,29 @@ static int shim_hcall_evtchn_send(struct kvm_xen *dom0, struct evtchn_send *snd)
 	return 0;
 }
 
+static int shim_hcall_evtchn_unmask(struct kvm_xen *dom0, int port)
+{
+	struct shared_info *s = HYPERVISOR_shared_info;
+	struct evtchnfd *evtchnfd;
+	struct vcpu_info *v;
+
+	evtchnfd = idr_find(&dom0->port_to_evt, port);
+	if (!evtchnfd)
+		return -ENOENT;
+
+	v = per_cpu(xen_vcpu, evtchnfd->vcpu);
+
+	if (test_and_clear_bit(port, (unsigned long *) s->evtchn_mask) &&
+	    test_bit(port, (unsigned long *) s->evtchn_pending) &&
+	    !test_and_set_bit(port / BITS_PER_EVTCHN_WORD,
+			      (unsigned long *) &v->evtchn_pending_sel)) {
+		kvm_xen_evtchn_2l_vcpu_set_pending(v);
+		return kvm_xen_evtchn_call_function(evtchnfd);
+	}
+
+	return 0;
+}
+
 static int shim_hcall_evtchn(int op, void *p)
 {
 	int ret;
@@ -2151,6 +2174,13 @@ static int shim_hcall_evtchn(int op, void *p)
 		un->port = evt.port;
 		break;
 	}
+	case EVTCHNOP_unmask: {
+		struct evtchn_unmask *unmask;
+
+		unmask = (struct evtchn_unmask *) p;
+		ret = shim_hcall_evtchn_unmask(xen_shim, unmask->port);
+		break;
+	}
 	case EVTCHNOP_send: {
 		struct evtchn_send *send;
 
-- 
2.11.0

