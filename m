Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90744C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7026C20663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BUGs1lly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7026C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbeJWDEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 23:04:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38170 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbeJWDEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 23:04:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9MId5el151660;
        Mon, 22 Oct 2018 18:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=TJgdqb+fAnq8zFcP2+X9tzf8Wu13WFRRHygZlwtTTR4=;
 b=BUGs1llymg+4bP+dF5uC9sSYUG/o2qly3gVzyVHN3D1TEVuoORtdYn5Xu42QLa+3HXx/
 Oxd/3jPxL7gLwMM+PunHhRJQS2/L/T3M+Fcwxi+nTpQsTzv4BKFh1eY1PBhkx/PeTZtN
 lHaM60pwERWqVBtVadUSyzrpK135VQ7J70J2OgtSsEFzUlFvwOpe4QE2oMO1tlvb0oJY
 vcWALeTbF+LAsFjCCM3uR5qEoEUE8GIG4+IgiIO8t5MDMmvKzP1n+ffpeRHMfcJbO0i6
 v+rc//8dNlPjSKVyrYlBYLEVV1zNGhnQ3EcBdWeG/vAsXN4zhq3Ib46tuKVcqRdPbTM0 3w== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2n7usu0hcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 18:44:01 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9MIhxUH030089
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 18:44:00 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9MIhwxn018732;
        Mon, 22 Oct 2018 18:43:58 GMT
Received: from [10.39.206.107] (/10.39.206.107)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 11:43:58 -0700
Subject: Re: [PATCH 04/10] sched/fair: Dynamically update cfs_overload_cpus
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, subhra.mazumdar@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <1540220381-424433-5-git-send-email-steven.sistare@oracle.com>
 <20181022165631.GE3117@worktop.programming.kicks-ass.net>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <fbb2478e-41f0-37c7-7c22-f8748fa08389@oracle.com>
Date:   Mon, 22 Oct 2018 14:43:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181022165631.GE3117@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9054 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=989
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810220159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/2018 12:56 PM, Peter Zijlstra wrote:
> On Mon, Oct 22, 2018 at 07:59:35AM -0700, Steve Sistare wrote:
>> An overloaded CPU has more than 1 runnable task.  When a CFS task wakes
>> on a CPU, if h_nr_running transitions from 1 to more, then set the CPU in
>> the cfs_overload_cpus bitmap.  When a CFS task sleeps, if h_nr_running
>> transitions from 2 to less, then clear the CPU in cfs_overload_cpus.
> 
>> @@ -5111,8 +5147,12 @@ static inline void hrtick_update(struct rq *rq)
>>  		update_cfs_group(se);
>>  	}
>>  
>> -	if (!se)
>> +	if (!se) {
>>  		add_nr_running(rq, 1);
>> +		if (prev_nr == 1)
>> +			overload_set(rq);
>> +
>> +	}
> 
> This is very similar to what RT already has, except they also track if
> the tasks in question is in fact migratable (p->nr_cpus_allowed > 1).
> 
> And similarly, it might make sense to use the sparse mask thing over
> there.

Yes.  I forgot to mention RT as likely follow on work.

- Steve
