Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1715849-1520641444-2-146547817993486818
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
    t=1520641443; b=PwFO7RJQnh4Aqziv8FO0Ascuh/L5eeqyfqZzhOb9lj0uuwN
    FIAeX5CCWZm/91N6qC1AKJVpQPM/kaCi6NB2czmOUQ5JSwgcWKCo7WBKbWWQX8Gx
    iV3/fvr2D89kGcWm/aj8Noue78yFmQQGJ4e3ZcX+KVIpKa8MEtnzjZdbNBuGTKfL
    oU3JFYycn5cBCAPpWmpRrHjgARabIUWwktxR35ny6ni3fjMtW3VLcVbg/UaccLRE
    aQflsi9sFcb1nU1GjtJmMBIK5u+7uaKio7gA/X3QhQ4RTmvFwL53vWfvaCLn14tp
    X72tZWNPR4yhTqyXshvzxA4Lw1/4ZMq8fdkHk8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641443; bh=PFto53GB4BUIGHAt60OC9C4x7Z
    b9NmujsjzoJKmigH4=; b=uo//H+T7pcMbQ14pBe8YQApz/R4yjapovTgPIpY6DA
    pn3yV35Pgt/IJKnHkx13p501hWGGpJchwpOCuf6NhVatsHO/DU0sW4K6PGlDHaD7
    i6PR8d2wSR4J5afbU1BVeBfeZdvoCW1I0LyNj/Gqe/pWa8zqppQHfaiMRXxbKIIv
    k56BarZiHBr1qcCZhaZBBypEP57a0zNNhRQoI93Y4cV8QcGQ71fUveIF4uHPqQo6
    lHr96xkurIgvRiXmwkLsLKyjfG6x/Zi676tk60yKhALvUaLcoe/563+YcLmlqSFr
    g+s8kKH1CUCY9UO0EdlBpqI2mDnsqL1ttF3Jl0zeXltA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S934208AbeCJAX5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:23:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41264 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933762AbeCJAX4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:23:56 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        Sreekanth Reddy <Sreekanth.Reddy@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 09/11] scsi: mpt3sas: fix oops in error handlers after shutdown/unload
Date: Fri,  9 Mar 2018 16:19:23 -0800
Message-Id: <20180310001835.061798273@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001834.560857664@linuxfoundation.org>
References: <20180310001834.560857664@linuxfoundation.org>
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

From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

commit 9ff549ffb4fb4cc9a4b24d1de9dc3e68287797c4 upstream.

This patch adds checks for 'ioc->remove_host' in the SCSI error handlers, so
not to access pointers/resources potentially freed in the PCI shutdown/module
unload path.  The error handlers may be invoked after shutdown/unload,
depending on other components.

This problem was observed with kexec on a system with a mpt3sas based adapter
and an infiniband adapter which takes long enough to shutdown:

The mpt3sas driver finished shutting down / disabled interrupt handling, thus
some commands have not finished and timed out.

Since the system was still running (waiting for the infiniband adapter to
shutdown), the scsi error handler for task abort of mpt3sas was invoked, and
hit an oops -- either in scsih_abort() because 'ioc->scsi_lookup' was NULL
without commit dbec4c9040ed ("scsi: mpt3sas: lockless command submission"), or
later up in scsih_host_reset() (with or without that commit), because it
eventually called mpt3sas_base_get_iocstate().

After the above commit, the oops in scsih_abort() does not occur anymore
(_scsih_scsi_lookup_find_by_scmd() is no longer called), but that commit is
too big and out of the scope of linux-stable, where this patch might help, so
still go for the changes.

Also, this might help to prevent similar errors in the future, in case code
changes and possibly tries to access freed stuff.

Note the fix in scsih_host_reset() is still important anyway.

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Acked-by: Sreekanth Reddy <Sreekanth.Reddy@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -2998,7 +2998,8 @@ scsih_abort(struct scsi_cmnd *scmd)
 	_scsih_tm_display_info(ioc, scmd);
 
 	sas_device_priv_data = scmd->device->hostdata;
-	if (!sas_device_priv_data || !sas_device_priv_data->sas_target) {
+	if (!sas_device_priv_data || !sas_device_priv_data->sas_target ||
+	    ioc->remove_host) {
 		sdev_printk(KERN_INFO, scmd->device,
 			"device been deleted! scmd(%p)\n", scmd);
 		scmd->result = DID_NO_CONNECT << 16;
@@ -3060,7 +3061,8 @@ scsih_dev_reset(struct scsi_cmnd *scmd)
 	_scsih_tm_display_info(ioc, scmd);
 
 	sas_device_priv_data = scmd->device->hostdata;
-	if (!sas_device_priv_data || !sas_device_priv_data->sas_target) {
+	if (!sas_device_priv_data || !sas_device_priv_data->sas_target ||
+	    ioc->remove_host) {
 		sdev_printk(KERN_INFO, scmd->device,
 			"device been deleted! scmd(%p)\n", scmd);
 		scmd->result = DID_NO_CONNECT << 16;
@@ -3122,7 +3124,8 @@ scsih_target_reset(struct scsi_cmnd *scm
 	_scsih_tm_display_info(ioc, scmd);
 
 	sas_device_priv_data = scmd->device->hostdata;
-	if (!sas_device_priv_data || !sas_device_priv_data->sas_target) {
+	if (!sas_device_priv_data || !sas_device_priv_data->sas_target ||
+	    ioc->remove_host) {
 		starget_printk(KERN_INFO, starget, "target been deleted! scmd(%p)\n",
 			scmd);
 		scmd->result = DID_NO_CONNECT << 16;
@@ -3179,7 +3182,7 @@ scsih_host_reset(struct scsi_cmnd *scmd)
 	    ioc->name, scmd);
 	scsi_print_command(scmd);
 
-	if (ioc->is_driver_loading) {
+	if (ioc->is_driver_loading || ioc->remove_host) {
 		pr_info(MPT3SAS_FMT "Blocking the host reset\n",
 		    ioc->name);
 		r = FAILED;
