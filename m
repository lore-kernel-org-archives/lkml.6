Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E917C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1530620848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cug6jqtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1530620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbeLCLtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:49:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39210 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeLCLtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:49:23 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB3Bd4Ss037247;
        Mon, 3 Dec 2018 11:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=0z66vn935tiB8hJV9o++DXCmcEiiq8yvNsuAq5E5fCk=;
 b=Cug6jqtNN3/3sljOETgbQ+epaLFZ7fZ1ZIzangeYFZZjAemZ50EgYkFdF6xXpiDUYkgs
 xzVxMN2z0OR8O6Q4mlvtyTXSkFPDQFvHxFaDBrvOkhHd3F7XesC0IbyZHhOBP/dmZMwm
 DfJKCvOCeFXv/RlQ+ufLMqImt6SvVyLyqz+7VyJaMNyWFdFoWSapuhwaTIrkpkG3bv69
 qC3qjeMps1jQWfWG2s7XDJ0yMXULgD5Z5SPehLJGEXE9QGrVVRu/mWZpSSu4rizxHbKJ
 MibSzYdzMLX11+8/yQgEEVQgvFV6kfHshU8ZyvsQjuKuqYUg/ZIuAN4OXjQKG2qP8gjG ow== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2p3jxr5p9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Dec 2018 11:48:30 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB3BmSkb010806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Dec 2018 11:48:28 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB3BmQRX025470;
        Mon, 3 Dec 2018 11:48:26 GMT
Received: from unbuntlaptop (/197.157.0.63)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Dec 2018 03:48:26 -0800
Date:   Mon, 3 Dec 2018 14:50:19 +0300
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
Message-ID: <20181203115019.GG3095@unbuntlaptop>
References: <PU1P153MB016946D99D63F9713E32B99ABFD20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181129074435.GA12347@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129074435.GA12347@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9095 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=929
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812030113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list is still rejecting @microsoft.com patches...  :(

I mentioned this last time when you guys were complaining that no one
reads your patches and someone sent me a link to marc.info.  I want to
help but obviously no one has time to look at patches on marc.info...

regards,
dan carpenter

