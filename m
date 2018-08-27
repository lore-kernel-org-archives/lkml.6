Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FBFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E740921735
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="crbkzX6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E740921735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeH0J74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 05:59:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34354 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbeH0J7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 05:59:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7R64Dc2013548;
        Mon, 27 Aug 2018 06:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=x2BeIOOqN1NrL4nq7RoNAdPEamtcjr1RptUt30WBufQ=;
 b=crbkzX6yklVhs+ffEXKr5bRTLPZhU5WItmpFg0+46oiAxVN8Mj45UB2ULOn5ltKlgw5o
 5AxuSQ42ElrA+Tc9E37GV2/o1VTboCChF3T2P7FOe1gvRCOq1tqLPqDoCpnlIyANMOiC
 i7+cv0pwy2yG4RzRPzsAZHNzCKDcuo1gzNg+tdPIktMxBCjKCpeF3UGMD+lUPDfIxGEk
 o/eqlzYmJeVb75bvSpP3RQ6umlRRAj3pH37ZIp+Nnqf49hM3zTa5biBT74s8Qx0sX/4S
 Tm6v+01seTFnE+/uxIEXMZ1swyd7+Sna+y/YXgNOmlITK/kV7mfKwuPmscJUGiSxpDkD YA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2m2yrputw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Aug 2018 06:14:32 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7R6ERIw031835
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Aug 2018 06:14:27 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7R6EQqb010222;
        Mon, 27 Aug 2018 06:14:26 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 26 Aug 2018 23:14:26 -0700
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To:     Jens Axboe <axboe@kernel.dk>, Anchal Agarwal <anchalag@amzn.com>
Cc:     fllinden@amazon.com,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
 <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
 <20180823210144.GB5624@kaos-source-ops-60001.pdx1.amazon.com>
 <3eaa20ce-0599-c405-d979-87d91ea331d2@kernel.dk>
 <20180824181223.GA9049@kaos-source-ops-60001.pdx1.amazon.com>
 <677c8648-63fd-601c-b906-40a8502f9782@kernel.dk>
 <20180824203305.GA4690@kaos-source-ops-60001.pdx1.amazon.com>
 <dc734449-7cd8-3a8e-9fdc-d7d854393900@kernel.dk>
 <2fecf2f2-f00b-f6ba-710a-54ceaacfedbb@kernel.dk>
 <00445460-d826-4d85-c5f4-fa565892da01@oracle.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <3876c36c-fec6-6586-435f-dc177dc38c76@oracle.com>
Date:   Mon, 27 Aug 2018 14:15:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <00445460-d826-4d85-c5f4-fa565892da01@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8997 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808270066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/27/2018 11:52 AM, jianchao.wang wrote:
> Hi Jens
> 
> On 08/25/2018 11:41 PM, Jens Axboe wrote:
>>  	do {
>> -		set_current_state(TASK_UNINTERRUPTIBLE);
>> +		if (test_bit(0, &data.flags))
>> +			break;
>>  
>> -		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
>> +		WARN_ON_ONCE(list_empty(&data.wq.entry));
>> +
>> +		if (!has_sleeper &&
>> +		    rq_wait_inc_below(rqw, get_limit(rwb, rw))) {
>> +			finish_wait(&rqw->wait, &data.wq);
>> +
>> +			/*
>> +			 * We raced with wbt_wake_function() getting a token,
>> +			 * which means we now have two. Put ours and wake
>> +			 * anyone else potentially waiting for one.
>> +			 */
>> +			if (test_bit(0, &data.flags))
>> +				wbt_rqw_done(rwb, rqw, wb_acct);
>>  			break;
> 
> Just use 'bool' variable should be OK 
> After finish_wait, no one could race with us here.
> 
>> +		}
>>  
>>  		if (lock) {
>>  			spin_unlock_irq(lock);
>> @@ -511,11 +569,11 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
>>  			spin_lock_irq(lock);
>>  		} else
>>  			io_schedule();
>> +
>>  		has_sleeper = false;
>>  	} while (1);
> 
> I cannot get the point of "since we can't rely on just being woken from the ->func handler
> we set".
> Do you mean there could be someone else could wake up this task ?
> 

If we do need a recheck after the io_schedule, we could do as following:

static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
		       unsigned long rw, spinlock_t *lock)
	__releases(lock)
	__acquires(lock)
{
	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
	struct wbt_wait_data data = {
		.wq = {
			.func	= wbt_wake_function,
			.entry	= LIST_HEAD_INIT(data.wq.entry),
		},
		.curr = current,
		.rwb = rwb,
		.rqw = rqw,
		.rw = rw,
	};
	bool has_sleeper;
	bool got = false;

retry:
	has_sleeper = wq_has_sleeper(&rqw->wait);
	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
		return;

	prepare_to_wait_exclusive(&rqw->wait, &data.wq, TASK_UNINTERRUPTIBLE);

	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw))) {
		got = true;
		goto out;
	}

	if (lock) {
		spin_unlock_irq(lock);
		io_schedule();
		spin_lock_irq(lock);
	} else
		io_schedule();

out:
	finish_wait(&rqw->wait, &data.wq);

	/*
	 * We raced with wbt_wake_function() getting a token,
	 * which means we now have two. Put ours and wake
	 * anyone else potentially waiting for one.
	 */
	if (data.got && got)
		wbt_rqw_done(rwb, rqw, wb_acct);
	else if (!data.got && !got)
		goto retry;

Thanks
Jianchao

