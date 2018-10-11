Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A145C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B232098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oosLF4IF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B232098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbeJKXNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:13:32 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CD662085B;
        Thu, 11 Oct 2018 15:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272747;
        bh=WLjmzrQlaEf1rXsXRLjFF+p+cdLlYAk3HxdITBpZDjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oosLF4IFX8GZkpwNH7N/uOb9YdfH3llfAJZ9PEx4l1L9Fa1C3tQg7cG4awgJ6CaOb
         wOCcmymyEVjGhKoDd9NL17vGiJzLmaJIhGokRPxAPoprbFungFV26AFUGrW0Kf6FD5
         I5dXeWZoI0gCFU9GjR/4eSCXbPyjTA3NgOBFpRyo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Romain Izard <romain.izard.pro@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.14 24/45] usb: cdc_acm: Do not leak URB buffers
Date:   Thu, 11 Oct 2018 17:39:51 +0200
Message-Id: <20181011152509.911971518@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152508.885515042@linuxfoundation.org>
References: <20181011152508.885515042@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Romain Izard <romain.izard.pro@gmail.com>

commit f2924d4b16ae138c2de6a0e73f526fb638330858 upstream.

When the ACM TTY port is disconnected, the URBs it uses must be killed, and
then the buffers must be freed. Unfortunately a previous refactor removed
the code freeing the buffers because it looked extremely similar to the
code killing the URBs.

As a result, there were many new leaks for each plug/unplug cycle of a
CDC-ACM device, that were detected by kmemleak.

Restore the missing code, and the memory leak is removed.

Fixes: ba8c931ded8d ("cdc-acm: refactor killing urbs")
Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-acm.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1527,6 +1527,7 @@ static void acm_disconnect(struct usb_in
 {
 	struct acm *acm = usb_get_intfdata(intf);
 	struct tty_struct *tty;
+	int i;
 
 	/* sibling interface is already cleaning up */
 	if (!acm)
@@ -1557,6 +1558,11 @@ static void acm_disconnect(struct usb_in
 
 	tty_unregister_device(acm_tty_driver, acm->minor);
 
+	usb_free_urb(acm->ctrlurb);
+	for (i = 0; i < ACM_NW; i++)
+		usb_free_urb(acm->wb[i].urb);
+	for (i = 0; i < acm->rx_buflimit; i++)
+		usb_free_urb(acm->read_urbs[i]);
 	acm_write_buffers_free(acm);
 	usb_free_coherent(acm->dev, acm->ctrlsize, acm->ctrl_buffer, acm->ctrl_dma);
 	acm_read_buffers_free(acm);


