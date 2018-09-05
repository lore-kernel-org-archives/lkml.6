Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4057C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 00:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71197206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 00:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bWkRpIye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71197206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbeIEEr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 00:47:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40844 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbeIEEr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 00:47:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w850IhRW142516;
        Wed, 5 Sep 2018 00:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=zETsxMgmNx/pNcrNmXJfFYb5H053QfEH1iv5O+mkN1c=;
 b=bWkRpIyeVgFrwmVSK/mCsq1kl2LklnnrA5ibHZIPf79ObDHWL+fVIUxPovR1+OnNO4Yv
 zhwaMQJzuVba/upB7v17py7ICbzhmpEKq9TLaMUkTatdf0ofWJ7U9mGw80GdHsAN48HC
 Dge0veVBFDnoD+s/wA9hB/01ZidnDQ8rTmc48+GlquXou4KdUAXx8eIfy/40NewxRP7i
 NgJuSBfhGnL3M9LYlLmjkpa1wGEGlmZI1sZqhZ7nT5lJFgAqYi9L7gQQdnvh/GI7Zh32
 kaizlWdnw6MiJ5BYOcuE8QKBg7PVR6qdoCG66a4aa6zkEmoEcR5noiqvf500yTjdskFF MQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2m7kdqg83y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Sep 2018 00:19:59 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w850Jqf8007584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Sep 2018 00:19:52 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w850JpUJ016823;
        Wed, 5 Sep 2018 00:19:52 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Sep 2018 17:19:51 -0700
Subject: Re: [RFC PATCH 2/2] pipe: use pipe busy wait
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dhaval.giani@oracle.com, steven.sistare@oracle.com
References: <20180830202458.32579-1-subhra.mazumdar@oracle.com>
 <20180830202458.32579-3-subhra.mazumdar@oracle.com>
 <alpine.DEB.2.21.1809042351220.1416@nanos.tec.linutronix.de>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <e5f02d36-590d-e15c-01a5-60f1f890fbb2@oracle.com>
Date:   Tue, 4 Sep 2018 17:20:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809042351220.1416@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9006 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=994
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809050002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/04/2018 02:54 PM, Thomas Gleixner wrote:
> On Thu, 30 Aug 2018, subhra mazumdar wrote:
>>   
>> +void pipe_busy_wait(struct pipe_inode_info *pipe)
>> +{
>> +	unsigned long wait_flag = pipe->pipe_wait_flag;
>> +	unsigned long start_time = pipe_busy_loop_current_time();
>> +
>> +	pipe_unlock(pipe);
>> +	preempt_disable();
>> +	for (;;) {
>> +		if (pipe->pipe_wait_flag > wait_flag) {
>> +			preempt_enable();
>> +			pipe_lock(pipe);
>> +			return;
>> +		}
>> +		if (pipe_busy_loop_timeout(pipe, start_time))
>> +			break;
>> +		cpu_relax();
>> +	}
>> +	preempt_enable();
> You are not really serious about busy looping with preemption disabled?
>
> That's just wrong. Why do you want to block others from getting on the CPU
> if there is nothing in the pipe?
>
> There is no point in doing so, really. If the wait loop is preempted
> because there is more important work to do, then it will come back and
> either see new data, or leave due to wait time reached.
Makes sense. I will remove it.

Thanks,
Subhra
>
> Thanks,
>
> 	tglx
>

