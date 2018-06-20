Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F29DC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A43D20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ClPIj9eQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A43D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753960AbeFTKXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:23:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51674 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeFTKXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:23:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5KAJpMY138871;
        Wed, 20 Jun 2018 10:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=grLWF4GfJarnzRcaIi5CBPHe/N5USPjtaDQIFruLb3U=;
 b=ClPIj9eQs2J+GGLF/5l7EtPOnu8dEA9jxOTk4ERWqTso6kHv37SXZej0ajo7qmhEminI
 bQ9bDAS1zA1Y0eHnrCU0k5Z/urssmuK3Jhxl/XpquLZNd3l5HGE2Vyozd7CcMrmnssxp
 Jhjg4dvqVrQ+p4iFS90+g0oPYeJWKSFtIRRa1DvRHyf3CaAefvRAD/FYE2awi/TzpSCj
 DrMDPdywxp4f9VTJFO/A88/zrqUcftu13ufi2CA50B6wnXfmrmXiqedZSFIS1a6Yeaiu
 +v5MFILiMomvsj8g6j+BTwcYHmH6vyofT2UOlvdULpE9xPG/MQymGxApYbWUE50O/9d2 oQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2jmu6xuscy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 10:23:04 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5KAN23v023096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 10:23:02 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5KAN1Oq012045;
        Wed, 20 Jun 2018 10:23:01 GMT
Received: from mwanda (/197.157.34.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 03:23:00 -0700
Date:   Wed, 20 Jun 2018 13:22:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     cocci@systeme.lip6.fr, Julia Lawall <Julia.Lawall@lip6.fr>,
        gregkh@linuxfoundation.org, quytelda@tamalin.org,
        Larry.Finger@lwfinger.net, harshasharmaiitr@gmail.com,
        arushisinghal19971997@gmail.com, amitoj1606@gmail.com,
        jeremy.lefaure@lse.epita.fr, teo.dacquet@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Fix two possible
 sleep-in-atomic-context bugs in translate_scan()
Message-ID: <20180620102249.djwmdv34zp5vyj2h@mwanda>
References: <20180620095016.8484-1-baijiaju1990@gmail.com>
 <20180620095650.fga6xi7fyjgybs76@mwanda>
 <dd6eaaad-413e-bd5d-d0f4-0a6d05438395@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd6eaaad-413e-bd5d-d0f4-0a6d05438395@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=715
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 06:05:06PM +0800, Jia-Ju Bai wrote:
> > Thanks!  It occurs to me that another way to detect this bug is that
> > one of the allocations in this function already uses GFP_ATOMIC.  It
> > doesn't normally make sense to mix GFP_ATOMIC and GFP_KERNEL when there
> > isn't any locking in the function.
> 
> Yes, this pattern is interesting for bug finding :)
> But to fix the bugs of this pattern, we need to decide whether GFP_ATOMIC or
> GFP_KERNEL should be used here.
> 

Sure.  But either way it's a bug. Plus this would be the first static
checker warning which warns about using GFP_ATOMIC when it's supposed to
be GFP_KERNEL.  #milestone

regards,
dan carpenter
