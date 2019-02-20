Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E93C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3822146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IY8CS4+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfBTUSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:18:01 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35478 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbfBTUR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:17:58 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8Z4o087545;
        Wed, 20 Feb 2019 20:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=qBbl27sHElfrv/UD8a84o+I89etq4k6ZdourMYL0T0Y=;
 b=IY8CS4+RKNYXD7dKDvyKMn+88JSyOhD/QgBU8Bf5BI4MINsPZw86zGoj9hN2cd1QUoEZ
 18c8DYOjkeyO5NFzPIv0cIJTaGdtgB7pOGFutf/YhMiqtpp6QQnMErJcNCekYK55cgIP
 ZbcKMIyge8RuxKX/Qa27Orv8BHep+S/ht0XSPhhZ2foQ/hklZJRXRjn1TPBs7dS/ZmPo
 XVoMc5j1dqn2P71vv92AXYBWFgwbFhEUXXETOx+NDJtJ5zBSjoRdBSYMzu1Jel7W+2LG
 vwVvd9LJJO4jIQsilV5wiW28oZs4a+85Lx33fgT+LgfrfSQqVBaZ3HeONB1QL2za6Iu7 Ag== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qpb5rktqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:43 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHg3F004724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:42 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHfUr011919;
        Wed, 20 Feb 2019 20:17:41 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:17:41 -0800
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
Subject: [PATCH RFC 15/39] KVM: x86/xen: handle PV spinlocks slowpath
Date:   Wed, 20 Feb 2019 20:15:45 +0000
Message-Id: <20190220201609.28290-16-joao.m.martins@oracle.com>
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

From: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Add support for SCHEDOP_poll hypercall.

This implementation is optimized for polling for a single channel, which
is what Linux does. Polling for multiple channels is not especially
efficient (and has not been tested).

PV spinlocks slow path uses this hypercall, and explicitly crash if it's
not supported.

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/include/asm/kvm_host.h |   3 ++
 arch/x86/kvm/xen.c              | 108 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7fcc81dbb688..c629fedb2e21 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -554,6 +554,8 @@ struct kvm_vcpu_xen {
 	unsigned int virq_to_port[KVM_XEN_NR_VIRQS];
 	struct hrtimer timer;
 	atomic_t timer_pending;
+	wait_queue_head_t sched_waitq;
+	int poll_evtchn;
 };
 
 struct kvm_vcpu_arch {
@@ -865,6 +867,7 @@ struct kvm_xen {
 	struct shared_info *shinfo;
 
 	struct idr port_to_evt;
+	unsigned long poll_mask[BITS_TO_LONGS(KVM_MAX_VCPUS)];
 	struct mutex xen_lock;
 };
 
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 753a6d2c11cd..07066402737d 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -563,6 +563,16 @@ static int kvm_xen_evtchn_set_pending(struct kvm_vcpu *svcpu,
 					     evfd->port);
 }
 
+static void kvm_xen_check_poller(struct kvm_vcpu *vcpu, int port)
+{
+	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(vcpu);
+
+	if ((vcpu_xen->poll_evtchn == port ||
+	     vcpu_xen->poll_evtchn == -1) &&
+	    test_and_clear_bit(vcpu->vcpu_id, vcpu->kvm->arch.xen.poll_mask))
+		wake_up(&vcpu_xen->sched_waitq);
+}
+
 static int kvm_xen_evtchn_send(struct kvm_vcpu *vcpu, int port)
 {
 	struct eventfd_ctx *eventfd;
@@ -581,6 +591,8 @@ static int kvm_xen_evtchn_send(struct kvm_vcpu *vcpu, int port)
 			eventfd_signal(eventfd, 1);
 	}
 
+	kvm_xen_check_poller(kvm_get_vcpu(vcpu->kvm, evtchnfd->vcpu), port);
+
 	return 0;
 }
 
@@ -669,6 +681,94 @@ static int kvm_xen_hcall_set_timer_op(struct kvm_vcpu *vcpu, uint64_t timeout)
 	return 0;
 }
 
+static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
+			       evtchn_port_t *ports)
+{
+	int i;
+	struct shared_info *shared_info =
+		(struct shared_info *)vcpu->kvm->arch.xen.shinfo;
+
+	for (i = 0; i < nr_ports; i++)
+		if (test_bit(ports[i],
+			     (unsigned long *)shared_info->evtchn_pending))
+			return true;
+
+	return false;
+}
+
+static int kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, gpa_t gpa)
+{
+	struct kvm_vcpu_xen *vcpu_xen = vcpu_to_xen_vcpu(vcpu);
+	int idx, i;
+	struct sched_poll sched_poll;
+	evtchn_port_t port, *ports;
+	struct shared_info *shared_info;
+	struct evtchnfd *evtchnfd;
+	int ret = 0;
+
+	if (kvm_vcpu_read_guest(vcpu, gpa,
+				&sched_poll, sizeof(sched_poll)))
+		return -EFAULT;
+
+	shared_info = (struct shared_info *)vcpu->kvm->arch.xen.shinfo;
+
+	if (unlikely(sched_poll.nr_ports > 1)) {
+		/* Xen (unofficially) limits number of pollers to 128 */
+		if (sched_poll.nr_ports > 128)
+			return -EINVAL;
+
+		ports = kmalloc_array(sched_poll.nr_ports,
+				      sizeof(*ports), GFP_KERNEL);
+		if (!ports)
+			return -ENOMEM;
+	} else
+		ports = &port;
+
+	set_bit(vcpu->vcpu_id, vcpu->kvm->arch.xen.poll_mask);
+
+	for (i = 0; i < sched_poll.nr_ports; i++) {
+		idx = srcu_read_lock(&vcpu->kvm->srcu);
+		gpa = kvm_mmu_gva_to_gpa_system(vcpu,
+						(gva_t)(sched_poll.ports + i),
+						NULL);
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
+
+		if (!gpa || kvm_vcpu_read_guest(vcpu, gpa,
+						&ports[i], sizeof(port))) {
+			ret = -EFAULT;
+			goto out;
+		}
+
+		evtchnfd = idr_find(&vcpu->kvm->arch.xen.port_to_evt,
+				    ports[i]);
+		if (!evtchnfd) {
+			ret = -ENOENT;
+			goto out;
+		}
+	}
+
+	if (sched_poll.nr_ports == 1)
+		vcpu_xen->poll_evtchn = port;
+	else
+		vcpu_xen->poll_evtchn = -1;
+
+	if (!wait_pending_event(vcpu, sched_poll.nr_ports, ports))
+		wait_event_interruptible_timeout(
+			 vcpu_xen->sched_waitq,
+			 wait_pending_event(vcpu, sched_poll.nr_ports, ports),
+			 sched_poll.timeout ?: KTIME_MAX);
+
+	vcpu_xen->poll_evtchn = 0;
+
+out:
+	/* Really, this is only needed in case of timeout */
+	clear_bit(vcpu->vcpu_id, vcpu->kvm->arch.xen.poll_mask);
+
+	if (unlikely(sched_poll.nr_ports > 1))
+		kfree(ports);
+	return ret;
+}
+
 static int kvm_xen_hcall_sched_op(struct kvm_vcpu *vcpu, int cmd, u64 param)
 {
 	int ret = -ENOSYS;
@@ -687,6 +787,9 @@ static int kvm_xen_hcall_sched_op(struct kvm_vcpu *vcpu, int cmd, u64 param)
 		kvm_vcpu_on_spin(vcpu, true);
 		ret = 0;
 		break;
+	case SCHEDOP_poll:
+		ret = kvm_xen_schedop_poll(vcpu, gpa);
+		break;
 	default:
 		break;
 	}
@@ -744,6 +847,9 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 		r = kvm_xen_hcall_sched_op(vcpu, params[0], params[1]);
 		if (!r)
 			goto hcall_success;
+		else if (params[0] == SCHEDOP_poll)
+			/* SCHEDOP_poll should be handled in kernel */
+			return r;
 		break;
 	/* fallthrough */
 	default:
@@ -770,6 +876,8 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 
 void kvm_xen_vcpu_init(struct kvm_vcpu *vcpu)
 {
+	init_waitqueue_head(&vcpu->arch.xen.sched_waitq);
+	vcpu->arch.xen.poll_evtchn = 0;
 }
 
 void kvm_xen_vcpu_uninit(struct kvm_vcpu *vcpu)
-- 
2.11.0

