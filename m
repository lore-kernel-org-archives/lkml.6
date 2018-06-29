Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FF9C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD37327B9D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S9OC0urU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD37327B9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753956AbeF2HqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:46:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38566 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbeF2HqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:46:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5T7iEjs195275;
        Fri, 29 Jun 2018 07:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=1Z4iWXAJdVATxeVEZtwaaJnjo4B0FGuNpNp9tiTU/j8=;
 b=S9OC0urU60/U1WHieaIZ/Z2zt2ZfIN5hOjsC2oi1j2cee+0QQ2bVbPBbhUsigb6u3xP2
 9UheXwj60r9kOr/PvHn3LqlWYTCDAojCrrDwL0qYKk+7CbjmkSj2SrDI8TUVMdQkeHSJ
 gH1le3lTtiYYvT8JWL//4shvqhI7p3SP/Hw6JRpfnz154lBxymLUwVU52O3DKKMnvso8
 BWodoB3BoRyj/B44YGeZienjKayyOS8KHechaHq2Ev5TLeDMrwkYDfAdDJLcS520lHPs
 ObetP8FmpEhGghyWdGvUQXXTeqiFltdW5D9MSb6OgbL53M7qsCno2zXYXxfkrANShbCl CQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2jum0ad6c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jun 2018 07:45:48 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5T7jkGO030750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jun 2018 07:45:47 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5T7jheC016541;
        Fri, 29 Jun 2018 07:45:43 GMT
Received: from mwanda (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Jun 2018 00:45:42 -0700
Date:   Fri, 29 Jun 2018 10:45:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Karim Eshapa <karim.eshapa@gmail.com>
Cc:     lars@metafoo.de, devel@driverdev.osuosl.org,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de, jic23@kernel.org
Subject: Re: [PATCH 4/4] staging:iio:adc:ad7280a: Use GFP_ATOMIC in interrupt
 handler
Message-ID: <20180629074532.cbwwjx2lh6cc3f72@mwanda>
References: <20180628234928.4205-1-karim.eshapa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628234928.4205-1-karim.eshapa@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8938 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=636
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806290086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 01:49:28AM +0200, Karim Eshapa wrote:
> Use GFP_ATOMIC rather GFP_KERNEL in interrupt handler,
> as GFP_KERNEL may sleep according to slab allocator.
> 

This is a threaded IRQ so it can sleep.

You should always think about the impact of a bug.  If this were a bug
it would have showed up in testing right away.  Most of my patches are
in error handling and so the impact is zero unless you deliberately try
to inject errors that's why they can go undetected for years.

Also you should always use the Fixes tag to see how the patch was
introduced.  I often see bugs where the patch is new and it was
introduced by someone doing major subsystem cleanups and they don't have
the hardware so I know it hasn't been tested.  If the patch is a couple
years old and the bug is in the success path which every one tests then
I wonder if I am misreading the code somehow.

regards,
dan carpenter

