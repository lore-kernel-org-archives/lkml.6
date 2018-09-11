Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBB8C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111FC20833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YcUoA2b1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111FC20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeIKKVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 06:21:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44518 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeIKKVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 06:21:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8B5F2u0027750;
        Tue, 11 Sep 2018 05:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=xsD43bH5NcApZb+3a6S4RqRtqzt3GODitVBJiYwkqIQ=;
 b=YcUoA2b1Gh+qHIhmP8CsFoQ2TWu+y+Oda2C66d7MV/M3EEhC7uefpE0hJrbVz63VLJRJ
 31O8P4owtO82l1wf1UqgjLPB252OmZ2rKUJbJt5SRk+/D0rzy1RxQ0RmDmjd9MIdHOJx
 UQ5kT70rGftwa8118dTXwmNUn3guHOAGJhQdnVk4+XfbJmuT7/afT91aHpPVes+W4v2B
 E/U3deSTk/Z+I7fEopAHLtXzkHIHe7LeF78PAHwJuVBKjbpUz7/VkILDyfTgZspYuODm
 KssMyrDN1oMzXLS5eSKX/5YFauDaFqq1Mt3l2cQum8m2kRuv2BClQvj2MIPeQDPOZwI+ dg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2mc72qhjy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 05:23:24 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8B5NNfh013399
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 05:23:23 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8B5NMAW032398;
        Tue, 11 Sep 2018 05:23:22 GMT
Received: from will-ThinkPad-L470.cn.oracle.com (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Sep 2018 22:23:21 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     qla2xxx-upstream@qlogic.com, Himanshu.Madhani@cavium.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: reduce time granularity of qla2x00_eh_wait_on_command
Date:   Tue, 11 Sep 2018 13:23:21 +0800
Message-Id: <1536643401-18015-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9012 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=747
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809110058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the cmd has not be returned after aborted by qla2x00_eh_abort,
we have to wait for it. However, the time is 1000ms at least currently.
If there are a lot cmds need to be aborted, the delay could be long
enough to lead to panic due to such as hung task, ocfs2 heartbeat,
etc, just before scsi recovery works.

Change the granularity to 1ms, even though more context switches
would be introduced, but it should be ok as it is not hot path.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 42b8f0d..570d93b 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1065,7 +1065,7 @@ qla2xxx_mqueuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd,
 static int
 qla2x00_eh_wait_on_command(struct scsi_cmnd *cmd)
 {
-#define ABORT_POLLING_PERIOD	1000
+#define ABORT_POLLING_PERIOD	1
 #define ABORT_WAIT_ITER		((2 * 1000) / (ABORT_POLLING_PERIOD))
 	unsigned long wait_iter = ABORT_WAIT_ITER;
 	scsi_qla_host_t *vha = shost_priv(cmd->device->host);
-- 
2.7.4

