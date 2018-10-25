Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFEFECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35832075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S7+WWKI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35832075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeJYWid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:38:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37256 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbeJYWid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:38:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9PDwxL4160600;
        Thu, 25 Oct 2018 14:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ysiMP4+umwT9zfiZQZUv4/dwxLwKxzZSPF3sKfdzsGM=;
 b=S7+WWKI1I4cEaEIPS9L64K6QYHJbNSd65itWb5/ym6ocz39M+F8ZVk++BvFLCrEkQuDQ
 oCppXncWQ3JtQS/tjKEhabAF+92IabQOMRwf8FmQxq88zfnJjXhE6AtlFMvD29jZHI/H
 7UJ34GrKkHzg3hsCfEEeEGIogu/3N6N+EFEKZAUpmdXdJDmrsSwsXBPFc1xoyEYeMyhZ
 1R0pjmD/i06P9BppNmJOqg9KVISzOXyj9bOD9AMbetwmm6+9ZtvdcGy7LASPuYP/mszP
 biNUXPvmfscPdOMUuvlCCjGSfBAMZfsroqkH6zp8agCxewYk3ivFHLTTPMtnarOQ2sso 2Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2n7vaq9tqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 14:05:11 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9PE5BJq008747
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 14:05:11 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9PE5Aga019303;
        Thu, 25 Oct 2018 14:05:10 GMT
Received: from [10.152.35.100] (/10.152.35.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Oct 2018 07:05:10 -0700
Subject: Re: [PATCH 05/10] sched/fair: Hoist idle_stamp up from idle_balance
To:     Valentin Schneider <valentin.schneider@arm.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <1540220381-424433-6-git-send-email-steven.sistare@oracle.com>
 <2a368b7c-3ecf-9b0c-a930-d2e739ea9b17@arm.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <3cec1fb2-d2f8-9693-178e-ac1b9aa77506@oracle.com>
Date:   Thu, 25 Oct 2018 10:04:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2a368b7c-3ecf-9b0c-a930-d2e739ea9b17@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9056 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=958
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810250121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2018 9:47 AM, Valentin Schneider wrote:
> Hi Steve,
> 
> On 22/10/2018 15:59, Steve Sistare wrote:
> [...]
>> @@ -6740,8 +6744,19 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>>  	return p;
>>  
>>  idle:
>> +	/*
>> +	 * We must set idle_stamp _before_ calling idle_balance(), such that we
>> +	 * measure the duration of idle_balance() as idle time.
>> +	 */
>> +	IF_SMP(rq->idle_stamp = rq_clock(rq);)
>> +
>>  	new_tasks = idle_balance(rq, rf);
>>  
>> +	if (new_tasks)
>> +		IF_SMP(rq->idle_stamp = 0;)
>> +
>> +	schedstat_end_time(rq->find_time, time);
> 	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> That's a stray hunk from 10/10

Thanks Valentin, will fix in next version.  I reordered the patches and missed this.

- Steve
