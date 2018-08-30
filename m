Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35332C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31512073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VSdj1NJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31512073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbeH3TD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:03:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54128 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbeH3TD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:03:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7UExSSB144287;
        Thu, 30 Aug 2018 15:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=OKH6TA5Uqar48upSlXi2AXoDrM9YXuaf1IBH3NZA8r4=;
 b=VSdj1NJPvXfWl7NKudmNSjWT1sOkA8MlYHIl0/hTrJpHd907gcwwQ+n4xMs3Zyc5w/4h
 yMRHyM4uC9L1ZMAifFFwX/E5VHtAmb7gytmY/a2w7Iv/aYFzsTQ1A0sgfB7wGcGr0xyS
 a0Ch5geBe06v6ApsC+GVvBYESrixymlbHzmyaXwTBzxiac45VbjW7q3cxKMNIxO9nIh3
 ZJJjgXiEDQPbhG5wQK0APEI5sXwndaaR3EBX9o6S1Nj/cqUS79r19S+DH2IqKzWKTEen
 +UmygIrEuiKA1VWG13b+EIo2S0H0b0htzWhGNwlRZf8BXSzLFQKXwQLIemRc1Nv+YJWx RA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2m2xhu530h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 15:00:31 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7UF0U0K003295
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 15:00:30 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7UF0UNc009914;
        Thu, 30 Aug 2018 15:00:30 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Aug 2018 08:00:29 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     herbert@gondor.apana.org.au
Cc:     Jeff.Lien@wdc.com, ard.biesheuvel@linaro.org,
        david.darrington@wdc.com, hch@infradead.org, jeff.furlong@wdc.com,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, tim.c.chen@linux.intel.com
Subject: [PATCH v2 3/3] crc-t10dif: Allow current transform to be inspected in sysfs
Date:   Thu, 30 Aug 2018 11:00:16 -0400
Message-Id: <20180830150016.15661-3-martin.petersen@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830150016.15661-1-martin.petersen@oracle.com>
References: <20180827060918.tfz7ljufqhlej4kq@gondor.apana.org.au>
 <20180830150016.15661-1-martin.petersen@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9000 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a way to print the currently active CRC algorithm in:

	/sys/module/crc_t10dif/parameters/transform

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 lib/crc-t10dif.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/crc-t10dif.c b/lib/crc-t10dif.c
index 52f577a3868d..6507fa101eff 100644
--- a/lib/crc-t10dif.c
+++ b/lib/crc-t10dif.c
@@ -107,6 +107,17 @@ static void __exit crc_t10dif_mod_fini(void)
 module_init(crc_t10dif_mod_init);
 module_exit(crc_t10dif_mod_fini);
 
+static int crc_t10dif_transform_show(char *buffer, const struct kernel_param *kp)
+{
+	if (static_key_false(&crct10dif_fallback))
+		return sprintf(buffer, "fallback\n");
+
+	return sprintf(buffer, "%s\n",
+		crypto_tfm_alg_driver_name(crypto_shash_tfm(crct10dif_tfm)));
+}
+
+module_param_call(transform, NULL, crc_t10dif_transform_show, NULL, 0644);
+
 MODULE_DESCRIPTION("T10 DIF CRC calculation");
 MODULE_LICENSE("GPL");
 MODULE_SOFTDEP("pre: crct10dif");
-- 
2.17.1

