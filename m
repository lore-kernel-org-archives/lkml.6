Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3366930-1521215584-2-2565725197684019774
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521215584; b=XjXrDnr5XRAvQV2fZKnxjYqr2KR2u8LLnCvgFT3Hp0fNUFu
    sY6Gx73M7R+oC2XuWCmcjEzi+pOP2LHHWmEKx/j1ajEQLySvDtfLWbh6YFGYW6ql
    A7dsJHt+oLzqGXf0nhWxdlK8KVubBkyyy7DKKbx3ncOKfVg4bhur9JNDVqpa7Mg5
    +HICLamM25lnmPxD6NCBySChFq3+wFiU4j1S+dFezzX9XjygNwfOvvRRkiLepKXe
    E5I0k5Ft/K1CTeoql5QBAGAXm0ZKitFTRBWdD7Ke4iViGictM63JAP8ybUF7Bqp4
    EVUiGOn85xwtLeordAi8FxVbY4ApuU/PyRmFzBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521215584; bh=l8nZbqYQbi5hr68LU9NKswakSh
    excDSVm7oO7qvH9MU=; b=Ur4X4FjWbozxPDCq4lFMVrVYzjvjl/J8sjBpEB5C8o
    es3zPwb2DgiipqZ499bLdailPZosV6p3OTfkHxxHEmaXnbv3pHOCI/BPhZnXT5Rg
    n2NxLDqtXz3YMenuyvgsH41eJk2uXjWQoHdI2YXu60I83PcuIWLh80G6OR2v/nyR
    JQpdgRqBoVZrcMhCnVxTiHMB4opjCwK+fSFMInymNFuyJsGNa5wgR4wUrpOfAebK
    WPmwtjhDNFo1mXrYhO7DfVFW05fHqb959vEMXCNISaFSucv5TbkOiDCKzDDZQIGC
    KtbdjSnl8mdpPPKrnu00kM+BpIoYVnS2Pd68fOILoO/A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932582AbeCPPwt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:52:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45906 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965386AbeCPPoR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:44:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yong Zhao <yong.zhao@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 111/128] drm/amdkfd: Fix memory leaks in kfd topology
Date: Fri, 16 Mar 2018 16:24:12 +0100
Message-Id: <20180316152342.059496800@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yong Zhao <yong.zhao@amd.com>


[ Upstream commit 5108d768408abc80e4e8d99f5b406a73cb04056b ]

Kobject created using kobject_create_and_add() can be freed using
kobject_put() when there is no referenece any more. However,
kobject memory allocated with kzalloc() has to set up a release
callback in order to free it when the counter decreases to 0.
Otherwise it causes memory leak.

Signed-off-by: Yong Zhao <yong.zhao@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -501,11 +501,17 @@ static ssize_t sysprops_show(struct kobj
 	return ret;
 }
 
+static void kfd_topology_kobj_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct sysfs_ops sysprops_ops = {
 	.show = sysprops_show,
 };
 
 static struct kobj_type sysprops_type = {
+	.release = kfd_topology_kobj_release,
 	.sysfs_ops = &sysprops_ops,
 };
 
@@ -541,6 +547,7 @@ static const struct sysfs_ops iolink_ops
 };
 
 static struct kobj_type iolink_type = {
+	.release = kfd_topology_kobj_release,
 	.sysfs_ops = &iolink_ops,
 };
 
@@ -568,6 +575,7 @@ static const struct sysfs_ops mem_ops =
 };
 
 static struct kobj_type mem_type = {
+	.release = kfd_topology_kobj_release,
 	.sysfs_ops = &mem_ops,
 };
 
@@ -607,6 +615,7 @@ static const struct sysfs_ops cache_ops
 };
 
 static struct kobj_type cache_type = {
+	.release = kfd_topology_kobj_release,
 	.sysfs_ops = &cache_ops,
 };
 
@@ -729,6 +738,7 @@ static const struct sysfs_ops node_ops =
 };
 
 static struct kobj_type node_type = {
+	.release = kfd_topology_kobj_release,
 	.sysfs_ops = &node_ops,
 };
 
