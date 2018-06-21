Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3E8C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B178820846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZFshUI2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B178820846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933216AbeFUIY1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:24:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42580 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932727AbeFUIXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:23:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5L8J0Np070589;
        Thu, 21 Jun 2018 08:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=eKd5og1v0k8mCl8ffVvgqUQEddKm4YwxgFUMXfvgac8=;
 b=ZFshUI2ni/ca2kRLvTM9POk1V+VbX0nxCrc0m1UImouornu30O4Bwysy9Sjk6vnEroiP
 ofEC8kMFjwN9FYMSpt9Pnv/EWZoWxnwF2LKTep16oAqsQi3AICoJbnqKTGKxTyERrICt
 d/EqyU48DE/GXy0nAFfzcWOE4A7eGJ3yXiWkU44nnaNMITPXnlp3RoBgVJDxJFufVoLD
 gRAH88+nn+HX86SnMKxlrJogyBW7/6kUWo9JBhGYj/0y92/h9k1gUJUOql2fooZtBPZA
 ZZGgDnJg6BPcC679qxWd+iySI2O09hvCdJtQgjyTIejhlH6xWXJIbutQU4qq/9GCrPeP hQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jmtgwypds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 08:23:39 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5L8NcNX032260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 08:23:38 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5L8NcWY027575;
        Thu, 21 Jun 2018 08:23:38 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Jun 2018 01:23:38 -0700
Subject: Re: [PATCH] blk-mq: use mutex_trylock to avoid lock inversion
To:     Bart Van Assche <Bart.VanAssche@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1529391637-1704-1-git-send-email-jianchao.w.wang@oracle.com>
 <2409013d789ca266879d24c815b76c2193e23fe3.camel@wdc.com>
 <d528a730-8e44-225b-2a35-3544160761dc@oracle.com>
 <2c2003ff1baac05688495677f67239d52f6d9527.camel@wdc.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <2a1dda06-5c7c-b75b-c1ae-75d1a2a49694@oracle.com>
Date:   Thu, 21 Jun 2018 16:23:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2c2003ff1baac05688495677f67239d52f6d9527.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8930 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=393
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806210094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart

On 06/21/2018 12:18 AM, Bart Van Assche wrote:
> On Wed, 2018-06-20 at 10:09 +0800, jianchao.wang wrote:
>> It is very easy to reproduce with following scripts.
>>
>> script 0
>> while true
>> do
>> 	modprobe null_blk queue_mode=2 shared_tags=1
>> 	sleep 0.1
>> 	rmmod null_blk
>> 	sleep 0.1
>> done
>>
>> script 1
>> file0="/sys/block/nullb0/mq/0/nr_tags"
>> file1="/sys/block/nullb0/mq/0/cpu0/rq_list"
>> while true;
>> do
>> 	if [ -e $file0 ];then
>> 		cat $file0
>> 	fi
>> 	if [ -e $file1 ];then
>> 		cat $file1
>> 	fi
>> done
> 
> Hello Jianchao,
> 
> Thanks for having shared a reproducer. However, the approach of the patch you
> posted doesn't seem like the right approach to me. I propose to proceed as
> follows:
> * Convert the reproducer into a blktests test and submit is as a patch to the
>   blktests project (https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_osandov_blktests&d=DwIGaQ&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=_TjwODcX-0o-OZfrVTFMpvbS0QbYxoya17aHM9pZAXw&s=wdVpTkE6PJX3GXvjXNwEup3opdflyCGY324CAYXSixY&e=).
> * Remove the mutex_lock/unlock(&sysfs_lock) calls from blk_cleanup_queue().
>   These calls are useless.  Block drivers are required to call del_gendisk()
>   before calling blk_cleanup_queue(). That means that sysfs attributes are
>   removed synchronously before blk_cleanup_queue() is called. The following
>   statement in blk_cleanup_queue() verifies that:
>     WARN_ON_ONCE(q->kobj.state_in_sysfs);
>   BTW, this also means that the blk_queue_dying() checks in various show and
>   store methods are superfluous.
> * Introduce a new mutex to serialize blk_mq_register_dev() and
>   blk_mq_sysfs_register() and blk_mq_sysfs_unregister(). I think it is wrong
>   that these functions use sysfs_mutex.
> * Document the purpose of sysfs_mutex in include/linux/blkdev.h, namely to
>   serialize the sysfs .show() and .store() callback functions and also to
>   serialize elevator changes.
> 

Really appreciate your kindly and detailed directive.
I will post the V2 version based on your suggestions later.

Thanks
Jianchao
> 
> 
> 
