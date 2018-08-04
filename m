Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C3CC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5663A217C6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5663A217C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733228AbeHDLGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:06:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49156 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeHDLGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:06:33 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B0A44BB3;
        Sat,  4 Aug 2018 09:06:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Ewan D. Milne" <emilne@redhat.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 32/32] scsi: sg: fix minor memory leak in error path
Date:   Sat,  4 Aug 2018 11:01:22 +0200
Message-Id: <20180804082651.504849455@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082649.908295462@linuxfoundation.org>
References: <20180804082649.908295462@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2185,6 +2185,7 @@ sg_add_sfp(Sg_device * sdp)
 	write_lock_irqsave(&sdp->sfd_lock, iflags);
 	if (atomic_read(&sdp->detaching)) {
 		write_unlock_irqrestore(&sdp->sfd_lock, iflags);
+		kfree(sfp);
 		return ERR_PTR(-ENODEV);
 	}
 	list_add_tail(&sfp->sfd_siblings, &sdp->sfds);


