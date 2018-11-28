Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F23C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9777F2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9777F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeK1PeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:34:13 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.97]:41503 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727107AbeK1PeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:34:13 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id D6E5F58464
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:33:58 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RrXygAwkPSjJARrXygYPHn; Tue, 27 Nov 2018 22:33:58 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.127] (port=58388 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gRrXx-001qNo-SJ; Tue, 27 Nov 2018 22:33:58 -0600
Date:   Tue, 27 Nov 2018 22:33:54 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 37/41] scsi: st: mark expected switch fall-throughs
Message-ID: <e0f4aa25970996146427e633bbf92be3eeee2e35.1543374820.git.gustavo@embeddedor.com>
References: <cover.1543374820.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1543374820.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.78.127
X-Source-L: No
X-Exim-ID: 1gRrXx-001qNo-SJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.127]:58388
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 255
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 114994 ("Missing break in switch")
Addresses-Coverity-ID: 114995 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/st.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 7ff22d3f03e3..7c7a742a5ef7 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -337,12 +337,14 @@ static void st_analyze_sense(struct st_request *SRpnt, struct st_cmdstatus *s)
 		switch (sense[0] & 0x7f) {
 		case 0x71:
 			s->deferred = 1;
+			/* fall through */
 		case 0x70:
 			s->fixed_format = 1;
 			s->flags = sense[2] & 0xe0;
 			break;
 		case 0x73:
 			s->deferred = 1;
+			/* fall through */
 		case 0x72:
 			s->fixed_format = 0;
 			ucp = scsi_sense_desc_find(sense, SCSI_SENSE_BUFFERSIZE, 4);
@@ -2721,6 +2723,7 @@ static int st_int_ioctl(struct scsi_tape *STp, unsigned int cmd_in, unsigned lon
 	switch (cmd_in) {
 	case MTFSFM:
 		chg_eof = 0;	/* Changed from the FSF after this */
+		/* fall through */
 	case MTFSF:
 		cmd[0] = SPACE;
 		cmd[1] = 0x01;	/* Space FileMarks */
@@ -2735,6 +2738,7 @@ static int st_int_ioctl(struct scsi_tape *STp, unsigned int cmd_in, unsigned lon
 		break;
 	case MTBSFM:
 		chg_eof = 0;	/* Changed from the FSF after this */
+		/* fall through */
 	case MTBSF:
 		cmd[0] = SPACE;
 		cmd[1] = 0x01;	/* Space FileMarks */
-- 
2.17.1

