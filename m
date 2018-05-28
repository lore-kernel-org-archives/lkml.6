Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165269AbeE1NQi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163630AbeE1KuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:50:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Gilbert <dgilbert@interlog.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 199/496] scsi: core: return BLK_STS_OK for DID_OK in __scsi_error_from_host_byte()
Date: Mon, 28 May 2018 11:59:44 +0200
Message-Id: <20180528100328.325324152@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit e39a97353e5378eb46bf01679799c5704d397f32 ]

When converting __scsi_error_from_host_byte() to BLK_STS error codes the
case DID_OK was forgotten, resulting in it always returning an error.

Fixes: 2a842acab109 ("block: introduce new block status code type")
Cc: Doug Gilbert <dgilbert@interlog.com>
Signed-off-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/scsi_lib.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -720,6 +720,8 @@ static blk_status_t __scsi_error_from_ho
 		int result)
 {
 	switch (host_byte(result)) {
+	case DID_OK:
+		return BLK_STS_OK;
 	case DID_TRANSPORT_FAILFAST:
 		return BLK_STS_TRANSPORT;
 	case DID_TARGET_FAILURE:
