Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025519-1521802303-2-4152737392983331430
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
    t=1521802302; b=d0HUK00n3BfIZrzWPkWDQp2dPgf2pfvRVEGvRWv/SBmB7SU
    VbflD+P7KUMoenNbnLraQG5mQzPVuMg3Knr6baL891lJQUCMK7ZE4i7trurTSawZ
    OHLy0iK459HrbwXTPWPkJGJr4IvBb1c4IEkKtn8PSpR2L/a54HbT/sQlTfBS/M1Q
    iGN+8eP8//qNJT37omvajsNbt3MVR2Ce0iv/GMsZQQgMywzeLEiiHOsffZCjJxNj
    ri9ZEPo0y1hw0G4H5J4aiGPqJ4q5s7ammZPkVUmTseloTkBen1STY0TaTzEIPX9d
    5kN7Uxv8AAQ6awOsNfXLkjDi9CmD8yL70xIDvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802302; bh=eW6w2kDYuzHzUE2CVyst3Ze74P
    kzGadryGNFIz/pl94=; b=GLyvi1EoxkUywPAkF4hkjBP7kKqmWTuWc6+PJX3pI9
    mhTcORlxXBpER3P7+0+4OlCKixdzfHoeF9xWoZqqPq7m7HutX/MmdRt03GiA4Cnl
    C/vatwm6Mr+X3py+vo+rT68PPPCNP1plUXH5nKPK5DUm2w8sLRVNVf579yQmrZ2Q
    zE93xCfecYuKP93c2W1KS+2KgxkVhZ5AkleSL/hmo2GiaL+Rp3Mr1HFqbgL606Yu
    OMK3Maa/TqCmdbNrXDGeQt2kr0kfjwnrsBuXV6FZl0Ymim5AKrtvIN/w4RtubIiE
    fAicJyu8E1lJLN/c5zJeZdSPJ5F15npDM5fiI7ldN74A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S932737AbeCWKOY (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:14:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45174 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756007AbeCWKOX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:14:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 22/97] scsi: virtio_scsi: Always try to read VPD pages
Date: Fri, 23 Mar 2018 10:54:09 +0100
Message-Id: <20180323094158.812011199@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -704,6 +705,28 @@ static int virtscsi_device_reset(struct
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
@@ -775,6 +798,7 @@ static struct scsi_host_template virtscs
 	.change_queue_depth = virtscsi_change_queue_depth,
 	.eh_abort_handler = virtscsi_abort,
 	.eh_device_reset_handler = virtscsi_device_reset,
+	.slave_alloc = virtscsi_device_alloc,
 
 	.can_queue = 1024,
 	.dma_boundary = UINT_MAX,
