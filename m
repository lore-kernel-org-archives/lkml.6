Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B876BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8D32082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SwYI1/AT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8D32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeLCOyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:54:15 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38344 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbeLCOyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:54:15 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB3Emrlb009898;
        Mon, 3 Dec 2018 14:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=3zHu2TS7q888PMagnnYuV5kIkL42s5TP4A1hxO+3J28=;
 b=SwYI1/AT87hS7QtyHQZMZHpby5X78CIyWeaIHjzX2VJ0w05VyM+9/xNq+VHqTsdFrGhe
 YGYsc5HxD3Cu5tRJtC5ipEmnviq/gSwkCcEOr40/JXaeHkPr8SZg6M/DyRrXIsvZg793
 vPwRtFVaV1/Oti2RlL96/5mY9RPZdiD7iPjPNLpHofkR49bgoYyWPu5n9LsWf9onzXza
 jNhoQgLwXsTTVtFolDRe6AZnDLI3xpbK/iLQh2Oe+sE00DWyRpoWWd5oZoCsGqq7KH7j
 88mAZwlHg2HxrXv4TrBBJ2l6Fj9oGLHoexKfZ0L/YCuxp5BT7m65UUK6PTrUQZXqUq9i 6w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2p3j8q6t92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Dec 2018 14:52:38 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB3EqWTc023471
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Dec 2018 14:52:32 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB3EqVSW027249;
        Mon, 3 Dec 2018 14:52:32 GMT
Received: from kili.mountain (/197.157.0.63)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Dec 2018 06:52:31 -0800
Date:   Mon, 3 Dec 2018 17:52:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] misc: vexpress: Off by one in vexpress_syscfg_exec()
Message-ID: <20181203145219.brmtuv26dj3vnc5y@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9096 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812030140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The > comparison should be >= to prevent reading beyond the end of the
func->template[] array.

(The func->template array is allocated in vexpress_syscfg_regmap_init()
and it has func->num_templates elements.)

Fixes: 974cc7b93441 ("mfd: vexpress: Define the device as MFD cells")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/misc/vexpress-syscfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/vexpress-syscfg.c b/drivers/misc/vexpress-syscfg.c
index 6c3591cdf855..a3c6c773d9dc 100644
--- a/drivers/misc/vexpress-syscfg.c
+++ b/drivers/misc/vexpress-syscfg.c
@@ -61,7 +61,7 @@ static int vexpress_syscfg_exec(struct vexpress_syscfg_func *func,
 	int tries;
 	long timeout;
 
-	if (WARN_ON(index > func->num_templates))
+	if (WARN_ON(index >= func->num_templates))
 		return -EINVAL;
 
 	command = readl(syscfg->base + SYS_CFGCTRL);
-- 
2.11.0

