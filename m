Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FC8C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD5720843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hrAmJx63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD5720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbeGYSFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:05:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52620 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbeGYSFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:05:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6PGo1mC044849;
        Wed, 25 Jul 2018 16:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=IImg7MCjyzTAi+iW6O//WdJRY8vIIYXkbE6/HHewhjc=;
 b=hrAmJx634AXM94UavmprkXrSGwQoJzHjHnGSgM+gY41t2IJ6wNxqTogL7LLs1sYjxB44
 wNVtvsuh5SvCu2oyJJPbEXaMoR2cHLBML0Gxk3b5KYaouz19LBFa3mixQoI8s3xExAke
 SLyXBGQJJdvKU+ewjUOIPeiYdRfCTpmhJG3N9X8HmyR6VgzHpcpVqxLmtIaliG73/GT7
 h7WYocP5rorMJ4sNyq21KGA/dlnVXUIsU2DPLpOF7AXzR/Kwo+tWBCZa+4T3cH2tiKr9
 n1FN0Ld48ODybtJWieQRx6ISPi6mzHCs1FxHVca4E6nVQBK1CpoeCn06uXi/A7EHdiwj Jw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2kbv8t6bh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 16:52:51 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6PGqo4s011442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 16:52:50 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6PGqnEA014057;
        Wed, 25 Jul 2018 16:52:49 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Jul 2018 09:52:48 -0700
Subject: Re: [PATCH] rds: send: Fix dead code in rds_sendmsg
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20180725152227.GA26303@embeddedor.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <088b745e-4f59-4283-16c1-755f46890990@oracle.com>
Date:   Wed, 25 Jul 2018 09:52:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725152227.GA26303@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8964 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=927
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807250179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/2018 8:22 AM, Gustavo A. R. Silva wrote:
> Currently, code at label *out* is unreachable. Fix this by updating
> variable *ret* with -EINVAL, so the jump to *out* can be properly
> executed instead of directly returning from function.
> 
> Addresses-Coverity-ID: 1472059 ("Structurally dead code")
> Fixes: 1e2b44e78eea ("rds: Enable RDS IPv6 support")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
Looks fine.
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
