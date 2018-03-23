Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521804755-2-8502056998156635738
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804755; b=dDZ8aOS7pGx3WmnjOcoLh4ak8HEw8VnYbzrvzA2TNH1QoHn
    dsYSj4WCS/yVcDv9YEYkTY7+l/RsWMdI1naQabjKeaVikTB53C3q3b+bSYNZq0Vo
    4hK4A7C75kj6a4U4lkHLf/l6X3eLWd98mj3CX2+2toDuE2L5kLmqsacyBo9oCjjM
    LKFHHTlO3HnUsJyR+214a9nMRfMT3J5drsu+zGB+UfPZV+bf9Cvpywn6lYja+jE+
    pOk7U/e3N5/q2B7lRG8Pe7hsMx5zJtwkkF8Cx+ZIGtkg+f+l8WH4mS21SojjNvqd
    /QbfAPXkOTG2P+bwqcjvpxMtuR3rjxrHIaaCswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804755; bh=QfCFCc82uiMLEtJtXMIJMIAL3a
    rcdQ8qLGbEW+3yWWE=; b=TCy0LsZnu53goXrzoTuaEWRw3R7vVqHSJSllF3U4wJ
    V0cUeFO3P9OYlz8Stf6RjZk7A81wyfumniFq4ayQ2foCIQm213DY7LPkb8Dg/UEk
    22B32sVqsTOGSotdqcCDYVgEdf2MHDnK1pUFQpbfeRQk6FBRc/s52Kvk7ZxlqiYJ
    J4SaE9aX/E4r1qso0oKeoe+RQ45Itqk4Z20CII3vg6YlC7bCNtO5wpF5QRZA6ee7
    d5gq3Jj61X8VnjutcyTcchwLfeB//ngaWABmPxUbDmiOWFh7lzi4uA22TxTkCnk9
    vY3q+6cZbrP0yiupB/tub1PcAXa0rmbf2l3j5ZnowRfA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755130AbeCWKF5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:05:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40582 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755081AbeCWKFx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:05:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 032/177] scsi: virtio_scsi: Always try to read VPD pages
Date: Fri, 23 Mar 2018 10:52:40 +0100
Message-Id: <20180323094206.594552915@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Gibson <david@gibson.dropbear.id.au>


[ Upstream commit 25d1d50e23275e141e3a3fe06c25a99f4c4bf4e0 ]

Passed through SCSI targets may have transfer limits which come from the
host SCSI controller or something on the host side other than the target
itself.

To make this work properly, the hypervisor can adjust the target's VPD
information to advertise these limits.  But for that to work, the guest
has to look at the VPD pages, which we won't do by default if it is an
SPC-2 device, even if it does actually support it.

This adds a workaround to address this, forcing devices attached to a
virtio-scsi controller to always check the VPD pages.  This is modelled
on a similar workaround for the storvsc (Hyper-V) SCSI controller,
although that exists for slightly different reasons.

A specific case which causes this is a volume from IBM's IPR RAID
controller (which presents as an SPC-2 device, although it does support
VPD) passed through with qemu's 'scsi-block' device.

[mkp: fixed typo]

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/virtio_scsi.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -28,6 +28,7 @@
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_tcq.h>
+#include <scsi/scsi_devinfo.h>
 #include <linux/seqlock.h>
 
 #define VIRTIO_SCSI_MEMPOOL_SZ 64
@@ -705,6 +706,28 @@ static int virtscsi_device_reset(struct
 	return virtscsi_tmf(vscsi, cmd);
 }
 
+static int virtscsi_device_alloc(struct scsi_device *sdevice)
+{
+	/*
+	 * Passed through SCSI targets (e.g. with qemu's 'scsi-block')
+	 * may have transfer limits which come from the host SCSI
+	 * controller or something on the host side other than the
+	 * target itself.
+	 *
+	 * To make this work properly, the hypervisor can adjust the
+	 * target's VPD information to advertise these limits.  But
+	 * for that to work, the guest has to look at the VPD pages,
+	 * which we won't do by default if it is an SPC-2 device, even
+	 * if it does actually support it.
+	 *
+	 * So, set the blist to always try to read the VPD pages.
+	 */
+	sdevice->sdev_bflags = BLIST_TRY_VPD_PAGES;
+
+	return 0;
+}
+
+
 /**
  * virtscsi_change_queue_depth() - Change a virtscsi target's queue depth
  * @sdev:	Virtscsi target whose queue depth to change
@@ -776,6 +799,7 @@ static struct scsi_host_template virtscs
 	.change_queue_depth = virtscsi_change_queue_depth,
 	.eh_abort_handler = virtscsi_abort,
 	.eh_device_reset_handler = virtscsi_device_reset,
+	.slave_alloc = virtscsi_device_alloc,
 
 	.can_queue = 1024,
 	.dma_boundary = UINT_MAX,
