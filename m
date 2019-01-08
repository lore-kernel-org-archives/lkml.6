Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFC6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14AE2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F9xzdgpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfAHJta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:49:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53022 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfAHJta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:49:30 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x089nL8u009815;
        Tue, 8 Jan 2019 09:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=CCZqnBr5X7fUulrz391lwnnp0fmZ0BbuU5v5+BAhJtE=;
 b=F9xzdgpFtUqZF/lEldJuFWyqimA04JdKqI1ffUYf08+hDgBG6Qjv6W5Z5z16M3U303PT
 l11V9Ck4b9I7WBB/rinH/oC/6lu+wQx3q36u5F4z6ebhun7VIS8FHxmvq4B/9LMEp/UL
 D33ze1YOACsJc8o1HsqOKc8QjZRtkbsTnWLZmgHZ1QJZXCwY986ZIAF5DTHzLbjzjhFC
 4zyDIp3ea537/75VORQFJRHH3kwTz7xffmwFj8zOJlv8cBtEX/WKnF4hRv5V7cOcTecx
 BuHBkQtTnqkcLvA8x5ZSJO05WT4Y170zX3tsfHRj+/AhPCj2P41axsf+Q24e9tQRokk6 Zw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2ptm0u2jwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jan 2019 09:49:22 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x089nL6U029562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Jan 2019 09:49:21 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x089nLNv016744;
        Tue, 8 Jan 2019 09:49:21 GMT
Received: from kadam (/197.157.0.45)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Jan 2019 01:49:21 -0800
Date:   Tue, 8 Jan 2019 12:47:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org
Subject: Re: [PATCH] hv_balloon: avoid touching uninitialized struct page
 during tail onlining
Message-ID: <20190108094755.GG3200@kadam>
References: <20190104141942.19126-1-vkuznets@redhat.com>
 <2ea7e975-6aae-de71-83e5-9302518802ef@redhat.com>
 <87d0p837lt.fsf@vitty.brq.redhat.com>
 <20190107175650.GG166797@sasha-vm>
 <87a7kc2u03.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7kc2u03.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9129 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=702
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901080081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 07:38:20PM +0100, Vitaly Kuznetsov wrote:
> (I remember Greg disliked when people were tagging patches for stable@
> themselves, he prefered maintainers deciding if the particular commit
> deserves stable@ or not - but as you have a tree now we may as well have
> different rules :-)

You're thinking of Dave Miller.  So far as I know he's the only
maintainer who handles stable that way.  It's a lot of work to do the
things Dave does.  #understatement

regards,
dan carpenter
