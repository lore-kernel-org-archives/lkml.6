Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B756C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11B6218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H4Q1jVpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfBTUSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:18:54 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53246 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbfBTUSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:18:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8ZDJ081724;
        Wed, 20 Feb 2019 20:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=SgHD9NVfwS2nZ8X3B3FNB8zCOkq9pVflU3V9h8Ufw4Y=;
 b=H4Q1jVpbdxB8niJnlfhNM+b5amup3s7H37wbFI/ZDHxpSsaYmKa3ISPDKi4+d/uywI30
 zgHvqvHNlUtjcFM/7J1ozxcJobITDFgmeRJuBkmiH98AuGKExNSthwPQOorHk2OfSGmU
 sw1NNy0xYv6FJOQr09yCgp3QRQw0MFoMzrG58SMh40Fz0a9rh1x9NKvlBwfspxT/LVob
 9cPrfPGZrQWA9F9VXDKB4BCtsJTM316KKRAzSTPINDv97b4poPUR0A/zG3NjtCP1NTxS
 drXjhXRxZRrDqmHAJnk5HpH+Kd//qhGz18JjNfX5i4JLlT4f5Z8KI5XW2lTXZ4y/9psH ug== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qp9xu3xne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:36 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIUR3019979
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:30 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KKIUhI018949;
        Wed, 20 Feb 2019 20:18:30 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:18:29 -0800
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
Subject: [PATCH RFC 30/39] KVM: x86/xen: add additional evtchn ops
Date:   Wed, 20 Feb 2019 20:16:00 +0000
Message-Id: <20190220201609.28290-31-joao.m.martins@oracle.com>
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

From: Ankur Arora <ankur.a.arora@oracle.com>

Add support for changing event channel affinity (EVTCHNOP_bind_vcpu)
and closing an event (EVTCHNOP_close).

We just piggy back on the functionality already implemented for
guest event channels.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/kvm/xen.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 1988ed3866bf..666dd6d1f5a3 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -2188,6 +2188,38 @@ static int shim_hcall_evtchn(int op, void *p)
 		ret = shim_hcall_evtchn_send(xen_shim, send);
 		break;
 	}
+	case EVTCHNOP_bind_virq: {
+		struct evtchn_bind_virq *un;
+
+		un = (struct evtchn_bind_virq *) p;
+
+		evt.fd = -1;
+		evt.port = 0;
+		evt.type = XEN_EVTCHN_TYPE_VIRQ;
+		ret = kvm_xen_eventfd_assign(NULL, &xen_shim->port_to_evt,
+					     &xen_shim->xen_lock, &evt);
+		un->port = evt.port;
+		break;
+	}
+	case EVTCHNOP_bind_vcpu: {
+		struct evtchn_bind_vcpu *bind_vcpu;
+
+		bind_vcpu = (struct evtchn_bind_vcpu *) p;
+
+		evt.port = bind_vcpu->port;
+		evt.vcpu = bind_vcpu->vcpu;
+		ret = kvm_xen_eventfd_update(NULL, &xen_shim->port_to_evt,
+					     &xen_shim->xen_lock, &evt);
+		break;
+	}
+	case EVTCHNOP_close: {
+		struct evtchn_close *cls;
+
+		cls = (struct evtchn_close *) p;
+		ret = kvm_xen_eventfd_deassign(NULL, &xen_shim->port_to_evt,
+					       &xen_shim->xen_lock, cls->port);
+		break;
+	}
 	default:
 		ret = -EINVAL;
 		break;
-- 
2.11.0

