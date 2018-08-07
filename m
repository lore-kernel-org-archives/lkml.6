Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDA1C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F34E208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F34E208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404651AbeHGVPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:15:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35138 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733213AbeHGVPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:15:53 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0A0F374;
        Tue,  7 Aug 2018 19:00:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Ewan D. Milne" <emilne@redhat.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 3.18 81/85] scsi: sg: fix minor memory leak in error path
Date:   Tue,  7 Aug 2018 20:52:23 +0200
Message-Id: <20180807172400.365568088@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Battersby <tonyb@cybernetics.com>

commit c170e5a8d222537e98aa8d4fddb667ff7a2ee114 upstream.

Fix a minor memory leak when there is an error opening a /dev/sg device.

Fixes: cc833acbee9d ("sg: O_EXCL and other lock handling")
Cc: <stable@vger.kernel.org>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sg.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -2242,6 +2242,7 @@ sg_add_sfp(Sg_device * sdp)
 	write_lock_irqsave(&sdp->sfd_lock, iflags);
 	if (atomic_read(&sdp->detaching)) {
 		write_unlock_irqrestore(&sdp->sfd_lock, iflags);
+		kfree(sfp);
 		return ERR_PTR(-ENODEV);
 	}
 	list_add_tail(&sfp->sfd_siblings, &sdp->sfds);


