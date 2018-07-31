Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35000C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD80E208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GMW2uuny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD80E208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbeGaG6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 02:58:13 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50900 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbeGaG6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 02:58:12 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6V5IiAJ062864;
        Tue, 31 Jul 2018 05:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=9cQ0TNneGq4sKOlI4REU00u/TKD7WXNyixK0CuKn3oI=;
 b=GMW2uunykrsjoCLNGmifkmnUFQP0YElVNjtX1WhMHHQEh6X4SiTZ87mXMehBUM03hCkN
 +eK6vyzCAyg700oTrPw4rrSYo1k0QXAwQtejQV/uRRl6PEaNEECX/AtJ8O+EUQlyee6E
 YJPZJ23IByqLet0vVPL6qsnWvbB2/riFZNHc8B9esE55nTmynCGLJXdLPGbDcTeclRgE
 eXP7600CvM8LXHzgyzx/YsKlgAZ4Ehacdpy5gLsq4qD2RSiRWvT9nEmupZT2UssQyXvh
 a0jFbK/AjNgi+dPNFbIDnBWahShCHbunlwQd/VJTJIdJGY15Gz7AMteG/DqzCLycNhyx hw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2kge0cycau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jul 2018 05:19:43 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6V5JgQP031642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jul 2018 05:19:42 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6V5Jg0m032245;
        Tue, 31 Jul 2018 05:19:42 GMT
Received: from [10.182.69.179] (/10.182.69.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Jul 2018 22:19:41 -0700
Subject: Re: [RFC] blk-mq: clean up the hctx restart
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, bart.vanassche@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1533009735-2221-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180731045805.GE15701@ming.t460p>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <8a3383e6-2926-6858-d8f2-671f3cb9e460@oracle.com>
Date:   Tue, 31 Jul 2018 13:19:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731045805.GE15701@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8970 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807310058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

On 07/31/2018 12:58 PM, Ming Lei wrote:
> On Tue, Jul 31, 2018 at 12:02:15PM +0800, Jianchao Wang wrote:
>> Currently, we will always set SCHED_RESTART whenever there are
>> requests in hctx->dispatch, then when request is completed and
>> freed the hctx queues will be restarted to avoid IO hang. This
>> is unnecessary most of time. Especially when there are lots of
>> LUNs attached to one host, the RR restart loop could be very
>> expensive.
> 
> The big RR restart loop has been killed in the following commit:
> 
> commit 97889f9ac24f8d2fc8e703ea7f80c162bab10d4d
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Mon Jun 25 19:31:48 2018 +0800
> 
>     blk-mq: remove synchronize_rcu() from blk_mq_del_queue_tag_set()
> 
> 

Oh, sorry, I didn't look into this patch due to its title when iterated the mail list,
therefore I didn't realize the RR restart loop has already been killed. :)

The RR restart loop could ensure the fairness of sharing some LLDD resource,
not just avoid IO hung. Is it OK to kill it totally ?

Thanks
Jianchao

