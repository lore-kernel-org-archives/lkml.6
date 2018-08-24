Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B567C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80BB2156D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 02:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yTbbcyrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80BB2156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeHXFiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 01:38:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38958 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeHXFiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 01:38:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7O1wpiB158389;
        Fri, 24 Aug 2018 02:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=lpvdxCPk8cyrRuEZcpDHHRuWigvm11uos2KRuk3gj2w=;
 b=yTbbcyrMd+Fz4TKBKJ+YeluAGlTxzMz2wMHwK3Czaufp8yCOKxCR7QhZGLxDRFAJ+yTo
 wSylXXLfeIfFM9HEaiSQLOkqBeIQbrkTghgYnUCXhM6vWesh10KZ+pDaCZDq1PV2Sti/
 +nbdsNmBOMddPGbSHxfbxF9ejTmjzw1wN/yqivztr/6TKy330c+egmTqCkysa9mazr06
 MWCQ02ihFdl9HnRgQBJBc76ZoQUpKoViMZxaY1Uqg3dsJf9wHX33vcyD1WOdPNOWFts0
 RsQypnpXFG1ldxMAWcXX25c2pf+BEsjPxG8jPYuW3gfnIgsJnZO8nISC2+XX5YKnpmTs Pw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2kxavu4nad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Aug 2018 02:06:25 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7O26JGI019058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Aug 2018 02:06:19 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7O26IjH014474;
        Fri, 24 Aug 2018 02:06:19 GMT
Received: from [10.182.69.179] (/10.182.69.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Aug 2018 19:06:18 -0700
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <809b2243-7a76-3d8a-5d1b-b6b9d9712f41@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <d28bca3a-196d-1520-35cf-bec1e1872d34@oracle.com>
Date:   Fri, 24 Aug 2018 10:06:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <809b2243-7a76-3d8a-5d1b-b6b9d9712f41@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8994 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808240020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens

On 08/23/2018 11:42 PM, Jens Axboe wrote:
>> -
>> -	__set_current_state(TASK_RUNNING);
>> -	remove_wait_queue(&rqw->wait, &wait);
>> +	wbt_init_wait(&wait, &data);
>> +	prepare_to_wait_exclusive(&rqw->wait, &wait,
>> +			TASK_UNINTERRUPTIBLE);
>> +	if (lock) {
>> +		spin_unlock_irq(lock);
>> +		io_schedule();
>> +		spin_lock_irq(lock);
>> +	} else
>> +		io_schedule();
> Aren't we still missing a get-token attempt after adding to the
> waitqueue? For the case where someone frees the token after your initial
> check, but before you add yourself to the waitqueue.

I used to think about this.
However, there is a very tricky scenario here:
We will try get the wbt budget in wbt_wake_function.
After add a task into the wait queue, wbt_wake_function has been able to
be invoked for this task. If we get the wbt budget after prepare_to_wait_exclusive,
we may get wbt budget twice.

Thanks
Jianchao                                                               
