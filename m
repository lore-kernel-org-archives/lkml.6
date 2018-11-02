Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89102C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F4820862
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KAElC0/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F4820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbeKBJsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 05:48:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45794 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeKBJsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 05:48:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA20dfMw186271;
        Fri, 2 Nov 2018 00:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=I2BjZzx4L+Yjwo7CrwFlb+XzIAoWGoxUImIjHRGixEQ=;
 b=KAElC0/RZOHcVT6TlLrytNOEfponspJugmyYZvR/jSDN3+QYeVxe2uZcOYYPXqZ1J13a
 ZCt/LnrHhP84jfNb1EHiGhItQH7e7Te+ing/y25Q0f5hzNT1/UbqFkNMSrSvdyqpN5v7
 T3l4LdhaQcr+ovtySUdU/yai4kAySrNQgTG55wG0avOXwMsPAEwiS0VPbl3li2js/5Zu
 mHCfhEOwhgGGrNa/G1MYopI6cyQkpICGzPlseITKbAWP3afwzCpvBLUBj514/PxcyuB5
 9OS/D92zmORlioRKNqA2WA9uY87lty4T/P+1IXSnQACAgt7GdY9IwaVk0Y7QfA+PAEeL Mw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2ncfyqbvgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Nov 2018 00:41:41 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA20faPQ024811
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Nov 2018 00:41:36 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA20fYQ3006490;
        Fri, 2 Nov 2018 00:41:35 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Nov 2018 17:41:34 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v4] mm/page_owner: clamp read count to PAGE_SIZE
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20181101144723.3ddc1fa1ab7f81184bc2fdb8@linux-foundation.org>
Date:   Thu, 1 Nov 2018 18:41:33 -0600
Cc:     miles.chen@mediatek.com, Michal Hocko <mhocko@suse.com>,
        Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Michal Hocko <mhocko@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD1082D9-916E-47A4-95D3-59F308AD6D55@oracle.com>
References: <1541091607-27402-1-git-send-email-miles.chen@mediatek.com>
 <20181101144723.3ddc1fa1ab7f81184bc2fdb8@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9064 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=917
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811020004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 1, 2018, at 3:47 PM, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> -	count =3D count > PAGE_SIZE ? PAGE_SIZE : count;
> +	count =3D min_t(size_t, count, PAGE_SIZE);
> 	kbuf =3D kmalloc(count, GFP_KERNEL);
> 	if (!kbuf)
> 		return -ENOMEM;

Is the use of min_t vs. the C conditional mostly to be more =
self-documenting?

The compiler-generated assembly between the two versions seems mostly a =
wash.

    William Kucharski=
