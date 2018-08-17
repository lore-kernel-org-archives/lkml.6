Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD07C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D778521866
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D8+1gWD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D778521866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbeHQGWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 02:22:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47908 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbeHQGWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 02:22:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7H3Imqf115847;
        Fri, 17 Aug 2018 03:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=vPwpMceu+v93HbhFdr94VMaD4CT2+jx0gdkexWWQphc=;
 b=D8+1gWD4ffC7xnJAEcRVM7v6fChrfYHM4HToEKaEGm79h0nZa72kDN9agvH7dJDGSJfQ
 AFKpfquzy+MuW6vXPQJSGWqbPHp8RD2dzP3Oj4sS/onMYdMNdlpr5KkVaYKp3MWy5VUX
 XoVca2HTfutUHmGktZzHpobBDjdKefLL/2Wutc04bFFY2CqhvJCLBgb5pXUukIj6WPA0
 e9E1TYNqnQ+lhStK1I3dpy4Tfv4D71/XNYzYuoKvgjPK3GDHkHJk29Bvb1fR5k2AbMTj
 XSIjRl2mwzrvH/FG93P7ka6FaHQafWPoRoHyWfQMUR9EWXlDJQlYYZU5ClYFUw4v3S/3 5A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2ksqrpne12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Aug 2018 03:20:12 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7H3KBOV025843
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Aug 2018 03:20:12 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7H3K9qq012437;
        Fri, 17 Aug 2018 03:20:10 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Aug 2018 20:20:09 -0700
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Jeffrey Lien <Jeff.Lien@wdc.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto\@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "herbert\@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "tim.c.chen\@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "martin.petersen\@oracle.com" <martin.petersen@oracle.com>,
        David Darrington <david.darrington@wdc.com>,
        Jeff Furlong <jeff.furlong@wdc.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
        <20180810201601.GA80850@gmail.com>
        <SN1PR04MB1824A5944E0428AC84B62886EA3E0@SN1PR04MB1824.namprd04.prod.outlook.com>
        <ba74a9d1-cccc-913a-927a-82e561afef3d@interlog.com>
        <7f1b5ca8-cd89-71cc-21bb-5a058bc1e908@c-s.fr>
        <e2f9fa43-6104-214e-1570-b3753cb14b13@interlog.com>
Date:   Thu, 16 Aug 2018 23:20:05 -0400
In-Reply-To: <e2f9fa43-6104-214e-1570-b3753cb14b13@interlog.com> (Douglas
        Gilbert's message of "Thu, 16 Aug 2018 13:38:22 -0400")
Message-ID: <yq1a7plel22.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8987 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=802
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808170034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> With regard to your comment about slice (table ?) size, that is
> partially addressed by a kernel build time option shown in the above
> patch. That could be taken a bit further with a sysfs knob (where ?)
> to reduce the effective table size from that which the kernel is built
> with. To increase the size of the table would imply fetching some more
> heap and having an algorithm that could generate the extra part of
> that table required.

I am not a big fan of punting the decision to whoever compiles the
kernel to pick a number between 1 and 11 ("this CRC calculation is one
louder"). I would prefer to find a reasonable compromise between
bandwidth and cache thrashing side effects instead of overwhelming
people with build time choices and runtime tunables.

Almost everyone is running either Tim's PCLMULQDQ version or using IP
checksum for DIX. The software T10 CRC table implementation is mainly
there as a reference. I don't know of any production environments using
the table-based T10 CRC.

I don't have a problem making the code genuinely useful so it can be
leveraged by processors without hardware CRC acceleration capability.
But there needs to be some solid data guiding this decision so I'm
looking forward to see what WDC has in store.

Our results definitely matched Christophe's in that larger slice-by-N
are not always a win. And "faster" isn't automatically "better" from an
application performance perspective. With the caveat that our
measurements were done about 10 years ago and I'm sure we've come a long
way with processors and caches since then. So the results should be
interesting...

-- 
Martin K. Petersen	Oracle Linux Engineering
