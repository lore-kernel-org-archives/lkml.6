Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA20ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040D320877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LcIx5cmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040D320877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbeISKzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 06:55:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34494 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbeISKzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 06:55:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8J5IuNK137264;
        Wed, 19 Sep 2018 05:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=2NyCwPocYTtt1gHksHJfAJKwThQnTDY3VpexHxiclKk=;
 b=LcIx5cmZC69gZ9WpXyDErJzZ7Z1GilFJLJGiqHkzskAwC3DbFS13BFWbqUV7k9vv7xLm
 oFk5sFe36ecMniSVc7UI0SriudIL1UhWIVAZB+U45vOZn9BWhyS1c7fPbLMOoBJIpZWj
 cQgUsazgFsCh+hEWtwXlRWjtvUaBtUeKUPdU/6N5K7xw3/qRqFmSm7pgC/Huzie1HiDB
 iR8L7ndo1+fayvIHArucn5682hM/6m84pfDtZKfkBtG8MskAtmR+QQU3qkpAZDB2YjyE
 0/tQN/IWfPze4n4SrEHR42TCBmMcd3OnAmQu39JY+5Y3tWqhv44BcFwZdpXn/p3V1InQ yA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2mgt1prnf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Sep 2018 05:19:01 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8J5J0Ja005856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Sep 2018 05:19:00 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8J5J0J3025782;
        Wed, 19 Sep 2018 05:19:00 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Sep 2018 22:18:59 -0700
Subject: Re: [PATCH 2/4] lib/percpu-refcount: introduce percpu_ref_resurge()
To:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
References: <20180918101946.13329-1-ming.lei@redhat.com>
 <20180918101946.13329-3-ming.lei@redhat.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <242969d0-1370-b342-025d-a11b7f59d28f@oracle.com>
Date:   Wed, 19 Sep 2018 13:19:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918101946.13329-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9020 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=661
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809190055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

On 09/18/2018 06:19 PM, Ming Lei wrote:
> +		unsigned long __percpu *percpu_count;
> +
> +		WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));
> +
> +		/* get one extra ref for avoiding race with .release */
> +		rcu_read_lock_sched();
> +		atomic_long_add(1, &ref->count);
> +		rcu_read_unlock_sched();
> +	}

The rcu_read_lock_sched here is redundant. We have been in the critical section
of a spin_lock_irqsave.

The atomic_long_add(1, &ref->count) may have two result.
1. ref->count > 1
   it will not drop to zero any more.
2. ref->count == 1
   it has dropped to zero and .release may be running.

Thanks
Jianchao


