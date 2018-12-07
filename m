Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B7DC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69D8208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jdiS9lWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69D8208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeLGWgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:36:41 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48470 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeLGWgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 17:36:41 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB7MT6UZ114459;
        Fri, 7 Dec 2018 22:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=v/m4fByKBWxCAx/FXLVRFw1Zdd5U8GDbPAgzKFpQnv0=;
 b=jdiS9lWfGkhKep5OrKjN6c9zUFqbb6QOUHF9kNk9UvE7C6BoXQB2wBYkdUqo/FuZu1sS
 Fol9no5g6upPcZppCwbNFyqWJ04uLKMZnWlhohmsnH49SVWJqjXGX/ud1ZrRPQ2aaipe
 eOPvHrVBlUDrx2iN0Tk8wt+PGdW/H5C+PYs40eYU1/GfO0Cg+4LdCiq+ho7IPCY1HLT+
 QKdr4+6HzdCEB4h+cP5lG7A4fwCcQe3DlNiZ7VcTKpocGjTt6sSIMP7luM4Oxca5k9PJ
 85eRp0xBZiBsM28dpcVovFkZ6Krh7Zeke5EsoitNQDghtDYZMqZCQ12vXg2+oKWY8Jcs fQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2p3hqug7ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Dec 2018 22:36:18 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB7MaHl4014059
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Dec 2018 22:36:17 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB7MaGFS002816;
        Fri, 7 Dec 2018 22:36:16 GMT
Received: from [10.39.214.172] (/10.39.214.172)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Dec 2018 14:36:15 -0800
Subject: Re: [PATCH v4 08/10] sched/fair: Steal work from an overloaded CPU
 when CPU goes idle
To:     Valentin Schneider <valentin.schneider@arm.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
 <1544131696-2888-9-git-send-email-steven.sistare@oracle.com>
 <e4d5f90a-8780-dc43-412b-0ac97fb3d39f@arm.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <9f798c5d-f58a-e1fc-5b03-6598e04916bb@oracle.com>
Date:   Fri, 7 Dec 2018 17:36:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <e4d5f90a-8780-dc43-412b-0ac97fb3d39f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9100 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/2018 3:21 PM, Valentin Schneider wrote:
> Hi Steve,
> 
> On 06/12/2018 21:28, Steve Sistare wrote:
> [...]
>> @@ -6778,20 +6791,22 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
>>  	update_misfit_status(NULL, rq);
>>  
>>  	/*
>> -	 * We must set idle_stamp _before_ calling idle_balance(), such that we
>> -	 * measure the duration of idle_balance() as idle time.
>> +	 * We must set idle_stamp _before_ calling try_steal() or
>> +	 * idle_balance(), such that we measure the duration as idle time.
>>  	 */
>>  	rq_idle_stamp_update(rq); 
> 
> idle_balance() has a
> 
> 	/*
> 	 * Do not pull tasks towards !active CPUs...
> 	 */
> 	if (!cpu_active(this_cpu))
> 		return 0;
> 
> check which we probably want for stealing too, so we could hoist it up here
> to cover both idle_balance() and try_steal().

try_steal() already checks cpu_active.  I could hoist it.

- Steve

> 
>>  	new_tasks = idle_balance(rq, rf);
>> +	if (new_tasks == 0)
>> +		new_tasks = try_steal(rq, rf);
>>  
>>  	if (new_tasks)
>>  		rq_idle_stamp_clear(rq);
>>  
>>  	/*
>> -	 * Because idle_balance() releases (and re-acquires) rq->lock, it is
>> -	 * possible for any higher priority task to appear. In that case we
>> -	 * must re-start the pick_next_entity() loop.
>> +	 * Because try_steal() and idle_balance() release (and re-acquire)
>> +	 * rq->lock, it is possible for any higher priority task to appear.
>> +	 * In that case we must re-start the pick_next_entity() loop.
>>  	 */
>>  	if (new_tasks < 0)
>>  		return RETRY_TASK;
> [...]
> 
