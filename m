Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9A6C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405FE20858
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r2mMhVFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405FE20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbeGSO1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:27:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36118 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730470AbeGSO1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:27:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6JDdJHV013395;
        Thu, 19 Jul 2018 13:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=XzyHsA7w88h4ckWQ+QShqrIDGfNkDBan+8BHWC71/5g=;
 b=r2mMhVFm/Gx3Z0YW0cwhmdModE189DHBRRearXY6EWkI/lFW0KIjZ916SFIA6Aqs1WxY
 llQ8fqee+P9URH64eEtgEIKAGLtSIgj7ViOUv/gOXgB78L4k/8W1CvFvROqtp3opKP3t
 Lk1KHT7jXir3BJu1hRWWOsR+RUVMpzupzC1Vn+YaRcw+zs+kLfGNXIm2JD1w/cy5HKJ2
 u0T6g/uwozarOwGBdZELyfw/Yv7W8ggfi3vQENOGreYOkOVzbR5Ys9dAytk7UbS14hGy
 C+aORWBBfXo/LEdwsvvi+8GBGjVylfXUZlP9me+lJCR0IDgy5mKSwi1IEE5bAGUl08D2 Dw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2k9yjx760g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 13:44:14 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6JDiCwY025728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 13:44:12 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6JDiBXw001100;
        Thu, 19 Jul 2018 13:44:11 GMT
Received: from [192.168.1.10] (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Jul 2018 06:44:11 -0700
Subject: Re: [PATCH v2 2/5] mm: access zone->node via zone_to_nid() and
 zone_set_nid()
To:     Michal Hocko <mhocko@kernel.org>, osalvador@techadventures.net
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>
References: <20180719132740.32743-1-osalvador@techadventures.net>
 <20180719132740.32743-3-osalvador@techadventures.net>
 <20180719134018.GB7193@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <760195c6-7cfb-76db-1c5c-b85456f3a4ad@oracle.com>
Date:   Thu, 19 Jul 2018 09:44:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180719134018.GB7193@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8958 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=939
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807190147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/19/2018 09:40 AM, Michal Hocko wrote:
> On Thu 19-07-18 15:27:37, osalvador@techadventures.net wrote:
>> From: Pavel Tatashin <pasha.tatashin@oracle.com>
>>
>> zone->node is configured only when CONFIG_NUMA=y, so it is a good idea to
>> have inline functions to access this field in order to avoid ifdef's in
>> c files.
> 
> Is this a manual find & replace or did you use some scripts?

I used opengrok:

http://src.illumos.org/source/search?q=%22zone-%3Enode%22&defs=&refs=&path=&hist=&project=linux-master

http://src.illumos.org/source/search?q=%22z-%3Enode%22&defs=&refs=&path=&hist=&project=linux-master

> 
> The change makes sense, but I haven't checked that all the places are
> replaced properly. If not we can replace them later.
> 
>> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
>> Signed-off-by: Oscar Salvador <osalvador@suse.de>
>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thank you,
Pavel
