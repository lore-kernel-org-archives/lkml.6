Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1083DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41222146F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="45+2o02R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41222146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbeHBKRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:17:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50874 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729764AbeHBKRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:17:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w728NtSX187185;
        Thu, 2 Aug 2018 08:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=xObK6CfFo+3BLrRth77DQqgoF22OgMEYF+hkyaMfHWA=;
 b=45+2o02Rog4O2DeU4dfuucoLF80PAJ7trFAxroOyXfj2NVpPQtBrFCOdx9mBgbkYIMEg
 TKtbUHRF3zmIlbMdwYllbKBY1nAECePg9odeXFVsLByoljy4erZHfUjeRHug2vRVpD/f
 2/NA6+imd7VUYAFKlTtAygnU89GjRSP7+eig/5nEFG0Tw6ao5jkIngbWbwzQAwcsN5iu
 YzdHq+PBjAE5+qEN6DvGc492dczz3JXxhvWvSTDBjKc3PwHlL9pv5GSfNbZj5mNi08kg
 JAkNfW3mHduNf46rdv5/Qu1nZoB130XV9tRPB+BSZo3VEuvxV+NkXPU9/nbVS+DLf/t4 jQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2kgh4qa1xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Aug 2018 08:27:32 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w728RVob023016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Aug 2018 08:27:31 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w728RSJW022061;
        Thu, 2 Aug 2018 08:27:29 GMT
Received: from kili.mountain (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Aug 2018 01:27:28 -0700
Date:   Thu, 2 Aug 2018 11:27:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huy Duong <qhuyduong@hotmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] eeprom: idt_89hpesx: clean up an error pointer vs NULL
 inconsistency
Message-ID: <20180802082720.calhmn77gmkmcb2d@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8972 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=961
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1808020090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We check for IS_ERR_OR_NULL() here, but later we check the same thing
for NULL only.  It turns out that it can only be NULL so we can make the
checking consistent by removing the ERR_PTR stuff.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index 119eb05a5a91..8a4659518c33 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -1128,7 +1128,7 @@ static void idt_get_fw_data(struct idt_89hpesx_dev *pdev)
 
 	device_for_each_child_node(dev, fwnode) {
 		ee_id = idt_ee_match_id(fwnode);
-		if (IS_ERR_OR_NULL(ee_id)) {
+		if (!ee_id) {
 			dev_warn(dev, "Skip unsupported EEPROM device");
 			continue;
 		} else
