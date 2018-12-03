Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FE8C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D572146D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uhZOdu7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D572146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeLCSjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:39:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46272 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeLCSjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:39:12 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB3IcwgE013673;
        Mon, 3 Dec 2018 18:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=lQR75RHIbNeJOgYq9t5iJE/0WJ71p3vFgYCK3+FwrGM=;
 b=uhZOdu7ln/28v2Nvv3cPXquB4mdye6kqTDMYJ/q0XBdP38e2LsKo72ScBWuD3zG5JdMa
 ZfP/gvCKqdSRsybRSz//W/NpFp76oE1ui6ntBaYMvN/BcUgrVAodgENsHaNrWbhJC8fE
 YzJhNdJbFNcaSlOuXE3/xKdNFAsLfb1pJlqVp7CMLx1FbtGaEsQBpQkjCDSjhn2S2Z4Y
 4S8yOR2ji/grlf9CUWmp1wVguHvNuDJnkjR3SG8gcXcOmynPtwPRDUoFbBZpzeljtl1S
 FE4Wk9pCdQWbTWHYzOTLdCEWAm+GSQDdEcs9mDfvOBB4tgGwAiWyLyxLKHIKwvdchHXo xg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2p3jxr82ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Dec 2018 18:38:57 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB3Icugs010819
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Dec 2018 18:38:56 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB3IctHL014157;
        Mon, 3 Dec 2018 18:38:55 GMT
Received: from unbuntlaptop (/197.157.0.63)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Dec 2018 10:38:55 -0800
Date:   Mon, 3 Dec 2018 21:41:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "olaf@aepfle.de" <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] [repost] Drivers: hv: vmbus: Offload the handling of
 channels to two workqueues
Message-ID: <20181203184100.GF3073@unbuntlaptop>
References: <PU1P153MB016946D99D63F9713E32B99ABFD20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181129074435.GA12347@kroah.com>
 <20181203115019.GG3095@unbuntlaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203115019.GG3095@unbuntlaptop>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9096 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812030172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 02:50:19PM +0300, Dan Carpenter wrote:
> The list is still rejecting @microsoft.com patches...  :(
> 
> I mentioned this last time when you guys were complaining that no one
> reads your patches and someone sent me a link to marc.info.  I want to
> help but obviously no one has time to look at patches on marc.info...
> 

Oh... Hm.  Sorry, my bad.  They're making it to the list but somehow
gmail is eating them.  I search my spam folder and they're not there
either.  :(

I don't know what's going on.

regards,
dan carpenter

