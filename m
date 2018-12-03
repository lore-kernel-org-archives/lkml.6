Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498F1C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050A820850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lWITEb/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050A820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeLCKDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:03:36 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49912 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbeLCKDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:03:36 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB39xm0s193627;
        Mon, 3 Dec 2018 10:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=QgwlWOCuShW3FxjssMZOYUd25oeml3zh5NddFCOomMg=;
 b=lWITEb/Q9AA/Rrh5vaLl+QRFKO7xVjAMBMKE0YKSzsC9MAUAH1cxsGFYI2AbhP4avi3j
 QWMk2hudzP+pYNw//1WhMNgdUOoiiKQVHBH025QtfkBjr5c34iFfLknqJRaYMVfnCBdV
 GbJ8pnxDK5uMpUYp3DqnkG6S4WttWWTv24b7LkQjiv1gIY96XuzpRTpjuHoqZpZ1XTlM
 DEDRsml9MU9galZC1xKUDH8t3ql7uHBJodDdgppAxrYJQAlN2KoB9G9zGGHC2Zej9D2B
 HV5wiumvWw8v2lAgKm4Gvb8wuUOMEuhOVhmTbBhnNj7WkiDJCJwq7U4LEyRM6pWOnFZM gQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2p3hqtnbh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Dec 2018 10:03:14 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB3A37Cu021091
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Dec 2018 10:03:07 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB3A37hq022750;
        Mon, 3 Dec 2018 10:03:07 GMT
Received: from unbuntlaptop (/197.157.0.63)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Dec 2018 02:03:06 -0800
Date:   Mon, 3 Dec 2018 13:04:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ptp: fix an IS_ERR() vs NULL check
Message-ID: <20181203100458.GZ3073@unbuntlaptop>
References: <20181130125834.u42dhxgof66rhya2@kili.mountain>
 <20181130163252.e6z33t23j3qud57z@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130163252.e6z33t23j3qud57z@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9095 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=640
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812030097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 08:32:52AM -0800, Richard Cochran wrote:
> On Fri, Nov 30, 2018 at 03:58:34PM +0300, Dan Carpenter wrote:
> > The pps_register_source() function doesn't return NULL, it returns
> > error pointers.
> 
> It keeps a local variable for errno, but then it returns NULL.
> But this is about to change with this recent patch:
> 
>    26.Nov'18 YueHaibing [PATCH -next] pps: using ERR_PTR instead of NULL while pps_register_source fails
> 
> It hasn't been merged yet AFAICT, but gregkh said he take it.

Oh, yeah.  That patch has actually been applied, but we didn't update
the caller.  I should have made the Fixes tag point to that YueHaibing's
patch.

regards,
dan carpenter



