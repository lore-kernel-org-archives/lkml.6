Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35ACC63685
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADA620866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PeEVto0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADA620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeINA6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:58:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59992 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbeINA6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:58:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8DJj1wO149912;
        Thu, 13 Sep 2018 19:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=70fa2E8iswN91twTHTxYOaYccSHx5csIR91ZiuFFFnA=;
 b=PeEVto0cIYB47/DNruFg9dH7sZtK5Hf7bl1PqA/NfvjSKzb8Rx4sciBIGp9EKGXstcxf
 3lTDZDYJbCAfvgFl+sPRFIOkIvDtDMAp9oDtBtvhBtJI6m2ATYTUPIS0BwuXmUDhJf6g
 CMI6LZpySLv0HPm1DEq2DzINWjrZIJP9DQKPLie1KCHb04jAzvjj4CdIc6skzs4Q+FpH
 qO/6KItDJ5a0VymEgS0tPKaMV6l1/8jMnGnvPw4grGVa/ZxXyTIWHtzQ2IJXcmt0p2Ub
 ebFHgfRyiS+mIhvpLp9re3QaiiT47R8sk+O3gbhwlXWs73mXXGX7nmyfATPq8OBiMgH/ 9Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2mc72r3cgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Sep 2018 19:47:04 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8DJl3hX007068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Sep 2018 19:47:03 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8DJl1Ug026172;
        Thu, 13 Sep 2018 19:47:02 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Sep 2018 12:47:01 -0700
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, jgross@suse.com, dunlapg@umich.edu,
        "Dr. Greg Wettstein" <greg@wind.enjellic.com>,
        "Dr . Greg Wettstein" <greg@enjellic.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH RESEND] tpm: Restore functionality to xen vtpm driver.
Date:   Thu, 13 Sep 2018 15:47:49 -0400
Message-Id: <20180913194749.32178-1-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9015 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809130198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dr. Greg Wettstein" <greg@wind.enjellic.com>

Functionality of the xen-tpmfront driver was lost secondary to
the introduction of xenbus multi-page support in commit ccc9d90a9a8b
("xenbus_client: Extend interface to support multi-page ring").

In this commit a pointer to the shared page address was being
passed to the xenbus_grant_ring() function rather then the
address of the shared page itself.  This resulted in a situation
where the driver would attach to the vtpm-stubdom but any attempt
to send a command to the stub domain would timeout.

A diagnostic finding for this regression is the following error
message being generated when the xen-tpmfront driver probes for a
device:

<3>vtpm vtpm-0: tpm_transmit: tpm_send: error -62

<3>vtpm vtpm-0: A TPM error (-62) occurred attempting to determine
the timeouts

This fix is relevant to all kernels from 4.1 forward which is the
release in which multi-page xenbus support was introduced.

Daniel De Graaf formulated the fix by code inspection after the
regression point was located.

Signed-off-by: Dr. Greg Wettstein <greg@enjellic.com>

[boris: fixed commit message formatting]
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: stable@vger.kernel.org # v4.1+
---
We've lost this patch a couple of years ago, re-submitting.


 drivers/char/tpm/xen-tpmfront.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
index 911475d36800..b150f87f38f5 100644
--- a/drivers/char/tpm/xen-tpmfront.c
+++ b/drivers/char/tpm/xen-tpmfront.c
@@ -264,7 +264,7 @@ static int setup_ring(struct xenbus_device *dev, struct tpm_private *priv)
 		return -ENOMEM;
 	}
 
-	rv = xenbus_grant_ring(dev, &priv->shr, 1, &gref);
+	rv = xenbus_grant_ring(dev, priv->shr, 1, &gref);
 	if (rv < 0)
 		return rv;
 
-- 
2.17.1

