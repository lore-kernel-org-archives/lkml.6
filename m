Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF83BECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41CA21486
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DF021Tkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41CA21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbeJSCAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbeJSCAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:00:01 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A13121476;
        Thu, 18 Oct 2018 17:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885476;
        bh=PJpztucavY2ev6RVxGFQSYPNnQWBHcD0FyURJ/PvTvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DF021TkjWfX3i+KCuLyzVERNQXSQpFzp27YBhZE2FLEwDG3024pr/oEfM6aEYyzc2
         IPFze++mg1q7Pshg38X2xz9LI7yR16jGBmF9fLCK04CpSgPOU35pd9A4cu5gc6npsO
         ROSGfIpp0q8yBo/fc7sKTaeGmoXajEDRuxkxyTDY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 35/53] scsi: sd: dont crash the host on invalid commands
Date:   Thu, 18 Oct 2018 19:54:28 +0200
Message-Id: <20181018175422.756667694@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <jthumshirn@suse.de>

[ Upstream commit f1f1fadacaf08b7cf11714c0c29f8fa4d4ef68a9 ]

When sd_init_command() get's a command with a unknown req_op() it crashes the
system via BUG().

This makes debugging the actual reason for the broken request cmd_flags pretty
hard as the system is down before it's able to write out debugging data on the
serial console or the trace buffer.

Change the BUG() to a WARN_ON() and return BLKPREP_KILL to fail gracefully and
return an I/O error to the producer of the request.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/sd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1277,7 +1277,8 @@ static int sd_init_command(struct scsi_c
 	case REQ_OP_ZONE_RESET:
 		return sd_zbc_setup_reset_cmnd(cmd);
 	default:
-		BUG();
+		WARN_ON_ONCE(1);
+		return BLKPREP_KILL;
 	}
 }
 


