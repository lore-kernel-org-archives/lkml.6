Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85BCC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F1E21B69
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WdsenBpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732794AbfBKSqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:46:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49868 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfBKSqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:46:01 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1BIdIuG065616;
        Mon, 11 Feb 2019 18:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=P712n5qP/vF6aT2RzCHExqBGgGq431f5sawVDo+k3Mg=;
 b=WdsenBpXIxHMz8hrzi8xL4Vg+rEImvEmWpJwUMbrTW7iRMmpA12SrbcZQlX+wxEJQ1E7
 tJZqIGrp4xx90J2HZSd9zNK8qnYEZjMneQm5kZcFe1fnq6zws2tPysCtWbjPjMuM5CGC
 N5ck3dlHR8+i9DQL0XYz4QpwyjDzofiizErn3pIYIASleZkJzuhvo2CigEDqvtzx4y6m
 cIpqSL9L7l27biKxK+IxrcH6OC2jkOurYZEbCeFYhl0JHkcWaOx3AtObSOgg/0qxmFEe
 pX/vmfVC9xuu/G+gBpkRGCno8Gth2eZmNkxOI+eH0Ji0CBHxluC2HdLsWtWdUwqAqaRQ Gw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qhrek7jyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Feb 2019 18:45:56 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1BIjs4e009324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Feb 2019 18:45:55 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1BIjsbJ005708;
        Mon, 11 Feb 2019 18:45:54 GMT
Received: from kadam (/41.202.241.46)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Feb 2019 10:45:53 -0800
Date:   Mon, 11 Feb 2019 21:45:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Julien Freche <jfreche@vmware.com>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        Nadav Amit <namit@vmware.com>
Cc:     "VMware, Inc." <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] vmw_balloon: release lock on error in vmballoon_reset()
Message-ID: <20190211184545.GC22106@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9164 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902110137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We added some locking to this function but forgot to drop the lock on
these two error paths.  This bug would lead to an immediate deadlock.

Fixes: c7b3690fb152 ("vmw_balloon: stats rework")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/misc/vmw_balloon.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 6542a7711cac..ad807d5a3141 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1330,7 +1330,7 @@ static void vmballoon_reset(struct vmballoon *b)
 	vmballoon_pop(b);
 
 	if (vmballoon_send_start(b, VMW_BALLOON_CAPABILITIES))
-		return;
+		goto unlock;
 
 	if ((b->capabilities & VMW_BALLOON_BATCHED_CMDS) != 0) {
 		if (vmballoon_init_batching(b)) {
@@ -1341,7 +1341,7 @@ static void vmballoon_reset(struct vmballoon *b)
 			 * The guest will retry in one second.
 			 */
 			vmballoon_send_start(b, 0);
-			return;
+			goto unlock;
 		}
 	} else if ((b->capabilities & VMW_BALLOON_BASIC_CMDS) != 0) {
 		vmballoon_deinit_batching(b);
@@ -1357,6 +1357,7 @@ static void vmballoon_reset(struct vmballoon *b)
 	if (vmballoon_send_guest_id(b))
 		pr_err("failed to send guest ID to the host\n");
 
+unlock:
 	up_write(&b->conf_sem);
 }
 
-- 
2.17.1

