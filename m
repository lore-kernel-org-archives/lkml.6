Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B7BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B969821722
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5IrEddDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B969821722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeH0Hgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 03:36:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56768 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeH0Hgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 03:36:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7R3ncBP158849;
        Mon, 27 Aug 2018 03:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Dy/zir8dpOcjvly0sDcVFFO8kFVllXs2S8pbbSXadps=;
 b=5IrEddDT1YeKgjuDqAW/WeFx4Lk3ZCr7kbJsqKvlj2TlhaGYXdT7KI2lCCutrDCjl/xD
 h2RArok6Sf+WFmeDVSFBzjinN8MzAzdtSBw2n1ANQ+BRBpvc7KpfaPqHlil+IYZOdt+N
 dJ9vPjbV37H51rQypf+jPheiN1nKOszwmUv0lF/SJ+aG3AknMl31dLdVmYnbODhRLoRZ
 2tFDDqd6KBdvIffysoW1mbRWXuQVXFVaUAUrGd3YjQ/hwMhkk7vUZYBqhbB7vA4yrZ26
 uvEhb2kJQy1+44V31IlPloWsGGgyUR2kXqe7K5eG4r+SnSgmq3AppIWB8cUENwOeOw85 Rw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2m2y2p3f8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Aug 2018 03:51:47 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7R3pkap006720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Aug 2018 03:51:46 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7R3pjta026694;
        Mon, 27 Aug 2018 03:51:46 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 26 Aug 2018 20:51:45 -0700
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
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <00445460-d826-4d85-c5f4-fa565892da01@oracle.com>
Date:   Mon, 27 Aug 2018 11:52:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2fecf2f2-f00b-f6ba-710a-54ceaacfedbb@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8997 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=917
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808270041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens

On 08/25/2018 11:41 PM, Jens Axboe wrote:
>  	do {
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> +		if (test_bit(0, &data.flags))
> +			break;
>  
> -		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
> +		WARN_ON_ONCE(list_empty(&data.wq.entry));
> +
> +		if (!has_sleeper &&
> +		    rq_wait_inc_below(rqw, get_limit(rwb, rw))) {
> +			finish_wait(&rqw->wait, &data.wq);
> +
> +			/*
> +			 * We raced with wbt_wake_function() getting a token,
> +			 * which means we now have two. Put ours and wake
> +			 * anyone else potentially waiting for one.
> +			 */
> +			if (test_bit(0, &data.flags))
> +				wbt_rqw_done(rwb, rqw, wb_acct);
>  			break;

Just use 'bool' variable should be OK 
After finish_wait, no one could race with us here.

> +		}
>  
>  		if (lock) {
>  			spin_unlock_irq(lock);
> @@ -511,11 +569,11 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
>  			spin_lock_irq(lock);
>  		} else
>  			io_schedule();
> +
>  		has_sleeper = false;
>  	} while (1);

I cannot get the point of "since we can't rely on just being woken from the ->func handler
we set".
Do you mean there could be someone else could wake up this task ?

Thanks
Jianchao
