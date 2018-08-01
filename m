Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F477C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F41B20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HXY5QtSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F41B20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388967AbeHANay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 09:30:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52792 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388889AbeHANay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 09:30:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w71BhqAP193202;
        Wed, 1 Aug 2018 11:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=jaqa7C12OB3zUgJGh3FZY7sMmb34izb0mG9Bs+pw+7o=;
 b=HXY5QtSed0aL+1URWqqWA1LNK1rdLzoMUBilCI4WBs43cnKB+vkPyfWehW565W1Df2OC
 kDnWsw9Wupcrrt68dRsm/WAY+u7QGlXfv+ULsJhF1yM1BSbCce6CK2le/CH97R8IpbLI
 acgP4aXw+SxdJJqI/R+ya7xe6FAeMXfWucRnGyo/jupfNr0ffIEJU6xKYSgtuaHSXHh6
 538tWsm0m8oeoWIDiD93mHzy7sov9DvfZLXpdmG5Dsnc4CWdan4OR2J6DmiHldlKGx0O
 fl/600yoNXDM/4W5hpu9wu/CEzXNONwa3iM2/WYkf8RC5gEzs23krQytKCu4SihAfBOq IA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2kgfwt58tj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Aug 2018 11:45:27 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w71BjRV7003471
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Aug 2018 11:45:27 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w71BjQPx031041;
        Wed, 1 Aug 2018 11:45:26 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Aug 2018 04:45:26 -0700
Date:   Wed, 1 Aug 2018 14:45:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jheng-Jhong Wu <goodwater.wu@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: mt29f_spinand: fix memory leak while
 programming pages
Message-ID: <20180801114518.ajkgsx7exjny63mt@mwanda>
References: <1533116658-14924-1-git-send-email-goodwater.wu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533116658-14924-1-git-send-email-goodwater.wu@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8971 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=613
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1808010124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_ resources are freed automatically when the device is removed.
The name devm_ stands for "device" and "managed".

regards,
dan carpenter

