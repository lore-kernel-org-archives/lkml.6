Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D545DC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DD420854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vih8bRpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DD420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeILSfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:35:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37896 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeILSfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:35:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8CDT9Pq041219;
        Wed, 12 Sep 2018 13:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=NMVqQB9SiIeRZTH2H/BUYZ35VOohkeIZGngJMh06Exc=;
 b=vih8bRpWLpgDKKX1qtMNYHMoMNlZZUJ6i+bE0+XCYhGttTyOqyV2Hf8tk1NcgrTtz84f
 zRaSoKLVUgHVj3+NUBBeUjYSN4AXQb6U6LlyhUssLHX/moRSb+z8K1TLBrX4YQc4FyyR
 KtYTQkF2qQZzFmc0zT0gat8V8h+PnbsrDw6jZcl6/s9trgqX7EoI4i8NlrXoQrgwmY9g
 sM/xYj4s9xGZsXszDYAUkIbCGN6l6r3amd8CxKwzUIe3gq/4HUs3VYA7iYqS7JiO+Yju
 mPRXpQE3xbEF1xauoG1rrikQEpaIGvf/cfQMBonclGDt8yk6PHmet16nZrTvjZ3EDQMx 0w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2mc5utj52w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 13:29:57 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8CDTuV2030419
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 13:29:56 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8CDTrpv014011;
        Wed, 12 Sep 2018 13:29:53 GMT
Received: from [10.152.34.32] (/10.152.34.32)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Sep 2018 06:29:52 -0700
Subject: Re: [RFC PATCH v2 1/8] mm, memcontrol.c: make memcg lru stats
 thread-safe without lru_lock
To:     Laurent Dufour <ldufour@linux.vnet.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc:     aaron.lu@intel.com, ak@linux.intel.com, akpm@linux-foundation.org,
        dave.dice@oracle.com, dave.hansen@linux.intel.com,
        hannes@cmpxchg.org, levyossi@icloud.com,
        mgorman@techsingularity.net, mhocko@kernel.org,
        Pavel.Tatashin@microsoft.com, steven.sistare@oracle.com,
        tim.c.chen@intel.com, vdavydov.dev@gmail.com, ying.huang@intel.com,
        daniel.m.jordan@oracle.com
References: <20180911004240.4758-1-daniel.m.jordan@oracle.com>
 <20180911004240.4758-2-daniel.m.jordan@oracle.com>
 <e62ef1a0-9518-5a16-df5b-86977b4e8881@linux.vnet.ibm.com>
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
Message-ID: <a81f27b1-00c0-53ac-4d0b-241effdca9a6@oracle.com>
Date:   Wed, 12 Sep 2018 09:28:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <e62ef1a0-9518-5a16-df5b-86977b4e8881@linux.vnet.ibm.com>
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

On 9/11/18 12:32 PM, Laurent Dufour wrote:
> On 11/09/2018 02:42, Daniel Jordan wrote:
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index d99b71bc2c66..6377dc76dc41 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -99,7 +99,8 @@ struct mem_cgroup_reclaim_iter {
>>   };
>>
>>   struct lruvec_stat {
>> -	long count[NR_VM_NODE_STAT_ITEMS];
>> +	long node[NR_VM_NODE_STAT_ITEMS];
>> +	long lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
> 
> It might be better to use different name for the lru_zone_size field to
> distinguish it from the one in the mem_cgroup_per_node structure.

Yes, not very grep-friendly.  I'll change it to this:

struct lruvec_stat {
	long node_stat_cpu[NR_VM_NODE_STAT_ITEMS];
	long lru_zone_size_cpu[MAX_NR_ZONES][NR_LRU_LISTS];
};

So the fields are named like the corresponding fields in the mem_cgroup_per_node structure, plus _cpu.  And I'm certainly open to other ideas.
