Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A71C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AC620879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fC5PL8oG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfAJNCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:02:50 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42324 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfAJNCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:02:49 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0ACxLA7016901;
        Thu, 10 Jan 2019 13:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=BvdGAZZGoVwFCNBc3H3CyGU9G1OYwx5u635RP5ESyMM=;
 b=fC5PL8oGgB0pRG3dkpJYXVdiCguIhB2vRvEyPpdYaxOPINsdPbt2NrObpYKH/bOdJXG4
 m2MM1KoVlzqUv4i1/+vNKrS3wD1fHcQj9tN40BwfsNrClgdHkJdykeI5AjDJitXkQ5eH
 yW8Q8ZvCGWrE6hj5TOSaMLv1dV6qFa47KDAZLFfz8M8ptq7AAx7bAldMgm2pN5eFJmqy
 shzr7RnIP/9lMDLyytyH0Gkmlp+/YR90qbBUe6l1YSfHfFculi87BV6LFtQ9cplO8vlF
 e46crOg4OSt3lvz7+XM4NFzrbFzpB0/UZ/iEvg6HgiYmyv0z2TM3XUyaLof6C1cV4KJ1 5A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2ptm0uf3ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 13:02:42 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0AD2bDG026653
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 13:02:37 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0AD2aRv010833;
        Thu, 10 Jan 2019 13:02:36 GMT
Received: from kadam (/197.157.0.17)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jan 2019 05:02:36 -0800
Date:   Thu, 10 Jan 2019 16:02:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alexandre.bounine@idt.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] [PATCH] rapidio: Potential oops in riocm_ch_listen()
Message-ID: <20190110130230.GB27017@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9131 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=889
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901100106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If riocm_get_channel() fails, then we should just return -EINVAL.
Calling riocm_put_channel() will trigger a NULL dereference and
generally we should call put() if the get() didn't succeed.

Fixes: b6e8d4aa1110 ("rapidio: add RapidIO channelized messaging driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/rapidio/rio_cm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index bad0e0ea4f30..cf45829585cb 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -1215,7 +1215,9 @@ static int riocm_ch_listen(u16 ch_id)
 	riocm_debug(CHOP, "(ch_%d)", ch_id);
 
 	ch = riocm_get_channel(ch_id);
-	if (!ch || !riocm_cmp_exch(ch, RIO_CM_CHAN_BOUND, RIO_CM_LISTEN))
+	if (!ch)
+		return -EINVAL;
+	if (!riocm_cmp_exch(ch, RIO_CM_CHAN_BOUND, RIO_CM_LISTEN))
 		ret = -EINVAL;
 	riocm_put_channel(ch);
 	return ret;
-- 
2.17.1

