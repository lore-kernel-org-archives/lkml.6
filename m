Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B779CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC3520880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC3520880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388067AbeGWN0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:26:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45046 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387847AbeGWN0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:26:30 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A043DBC6;
        Mon, 23 Jul 2018 12:25:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>, stable@kernel.org,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.17 01/63] scsi: sd_zbc: Fix variable type and bogus comment
Date:   Mon, 23 Jul 2018 14:24:07 +0200
Message-Id: <20180723122446.409328057@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <damien.lemoal@wdc.com>

commit f13cff6c25bd8986627365346d123312ee7baa78 upstream.

Fix the description of sd_zbc_check_zone_size() to correctly explain that
the returned value is a number of device blocks, not bytes.  Additionally,
the 32 bits "ret" variable used in this function may truncate the 64 bits
zone_blocks variable value upon return. To fix this, change "ret" type to
s64.

Fixes: ccce20fc79 ("sd_zbc: Avoid that resetting a zone fails sporadically")
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: stable@kernel.org
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sd_zbc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -401,7 +401,8 @@ static int sd_zbc_check_capacity(struct
  * Check that all zones of the device are equal. The last zone can however
  * be smaller. The zone size must also be a power of two number of LBAs.
  *
- * Returns the zone size in bytes upon success or an error code upon failure.
+ * Returns the zone size in number of blocks upon success or an error code
+ * upon failure.
  */
 static s64 sd_zbc_check_zone_size(struct scsi_disk *sdkp)
 {
@@ -411,7 +412,7 @@ static s64 sd_zbc_check_zone_size(struct
 	unsigned char *rec;
 	unsigned int buf_len;
 	unsigned int list_length;
-	int ret;
+	s64 ret;
 	u8 same;
 
 	/* Get a buffer */


