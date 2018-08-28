Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0C2C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04D120878
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="krMmXwaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04D120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeH1SyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:54:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41128 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1SyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:54:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7SExhRS047953;
        Tue, 28 Aug 2018 15:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=eQg41StHJKe+k8N5g2WENs3shE0xNUap08VkWAF7aeE=;
 b=krMmXwaWe7ZUBwwHeidHGk2SbfOrS5hLmTw0R1Sa6L+EHtkeiiCPZJqWZjbaCCu0Rizg
 B28iUvzkubj1OQZ4Od/h4mh/Ck48yu+l7Ai3t+4mhIc1kB5aw52MBZdrRwagtKTIqw57
 I83CDoQGgaOyz3X9UfdrXQAyfzvrpdb1649xfZK7U1RKrZsp6k+LljS0YMXfZ51hBzkM
 RCOpxvMpPS17rOr/4oMpY5J+Wn7jWSDmUg88Cn+QpCVemmBHx5qDLhP4IxaS3gBrepHB
 u4qWcTxCyhjrFs+Qqb/FxJHZS8ZQowCalfXcm+HYLKGWHIvaeVcODvt3Bu/+u13bbsNf gA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2m2yrq4bsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Aug 2018 15:01:40 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7SF1esb017732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Aug 2018 15:01:40 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7SF1dh8027651;
        Tue, 28 Aug 2018 15:01:39 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Aug 2018 08:01:38 -0700
Date:   Tue, 28 Aug 2018 18:01:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: msghandler: ensure error value in rv is being
 returned on error
Message-ID: <20180828150130.de77knqsfyrvln7c@mwanda>
References: <20180828143642.11138-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828143642.11138-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8998 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=364
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808280152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 03:36:42PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently ipmi_set_my_LUN returns 0 instead of -EINVAL if the channel
> is out of range.  Fix this by returning the error return rv instead of 0.
> 
> Detected by Clang ("variable 'rv' set but not used")
> 
> Fixes: 048f7c3e352e ("ipmi: Properly release srcu locks on error conditions")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Somebody just sent that some hours ago.

regards,
dan carpenter

