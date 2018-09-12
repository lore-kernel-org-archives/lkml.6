Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4C6C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B2C20854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nv3XL8Fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B2C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeILSgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:36:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38988 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeILSgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:36:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8CDTEKi041266;
        Wed, 12 Sep 2018 13:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=wIQl5Jcc5252bXoEoaBBGvv+myxEy41bsq+Hf3UwZVQ=;
 b=nv3XL8FzNHlHBdxxvRLLEKbQxGSNyUVkSD+kwXSEqtQl2PChFLtA3z5yDNj7YgwRplS4
 ZOYmqvhwMDEMtBJvWpEA5J6avN+0ESdWO/l6CSTLMLAqKIykfNo0Gs8TRWgJJ3Wbq9it
 aKSkSVyqhsfRvAwx603FK5CM8msAS2Cdn8w+KNs73bCKlu1rkXUspYU/4wVzmiardvY+
 F5gh7gd0hUA9/BFTS9rYOHeSwU9MlCaNhuPtImHx5jSlRywwB8Y2xEHINP8DtVT500LT
 A+UO9RwppHuHN7rIM7pLN+vR2Xi1dYkIZJww/ogJwfJzC52B+U5B9kQqGjf8G/D78VZO fw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mc5utj5dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 13:31:31 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8CDVOZv027819
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 13:31:25 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8CDVNiI021059;
        Wed, 12 Sep 2018 13:31:23 GMT
Received: from [10.152.34.32] (/10.152.34.32)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Sep 2018 06:31:23 -0700
Subject: Re: [RFC PATCH v2 2/8] mm: make zone_reclaim_stat updates thread-safe
To:     Laurent Dufour <ldufour@linux.vnet.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc:     aaron.lu@intel.com, ak@linux.intel.com, akpm@linux-foundation.org,
        dave.dice@oracle.com, dave.hansen@linux.intel.com,
        hannes@cmpxchg.org, levyossi@icloud.com,
        mgorman@techsingularity.net, mhocko@kernel.org,
        Pavel.Tatashin@microsoft.com, steven.sistare@oracle.com,
        tim.c.chen@intel.com, vdavydov.dev@gmail.com, ying.huang@intel.com
References: <20180911004240.4758-1-daniel.m.jordan@oracle.com>
 <20180911004240.4758-3-daniel.m.jordan@oracle.com>
 <fe814c4f-f049-9b7f-0f4c-7238f159f144@linux.vnet.ibm.com>
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
Message-ID: <7e0c2fe0-c867-3ea2-83a2-c3bcb35057d7@oracle.com>
Date:   Wed, 12 Sep 2018 09:30:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <fe814c4f-f049-9b7f-0f4c-7238f159f144@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9013 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809120140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/18 12:40 PM, Laurent Dufour wrote:
> On 11/09/2018 02:42, Daniel Jordan wrote:
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index 32699b2dc52a..6d4c23a3069d 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -229,6 +229,12 @@ struct zone_reclaim_stat {
>>   	 *
>>   	 * The anon LRU stats live in [0], file LRU stats in [1]
>>   	 */
>> +	atomic_long_t		recent_rotated[2];
>> +	atomic_long_t		recent_scanned[2];
> 
> It might be better to use a slightly different name for these fields to
> distinguish them from the ones in the zone_reclaim_stat_cpu structure.

Sure, these are now named recent_rotated_cpu and recent_scanned_cpu, absent better names.

Thanks for your comments.
