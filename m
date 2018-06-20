Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29AEC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717C22083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hIauDQXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717C22083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754152AbeFTCJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 22:09:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43244 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753619AbeFTCJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 22:09:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5K28vcG055751;
        Wed, 20 Jun 2018 02:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=f3IkzPvMrLoTHqPsCcpqLlqT3EEbVFy/ABFTRSw4GrY=;
 b=hIauDQXOYqmUXo5Ha0XYS6MeA6suD3sAXxGL0r7YVyzVG7Rkftb+T6Wnp26TXVuBeOo2
 7ih52Zbjgf9B/DiJciSuWba3f63th5kAhpM10o7e1xUMI1FZvZxo3+oOFo2nMkZhELwy
 8UQGWYFaVu2UmSrnEEajh1z5GB/WBxyC2FL5qm8F3vnxVnFZdBuozmYs9CMyKmFttnDB
 mvO3JB1epbJMjNDqrv9pUslKlnoEEnSgFbb6BvCErWTrF+d1/KN69MaWrNUtA9cYRWLo
 mgKzlKpAeZM6B8cjuG50Og0dvdTnCqCxlu4t96kWOOxroOfAWlTV+ir/Y3GsnxJ1cGqs Ew== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2jmtgwth1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 02:09:10 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5K299w9015162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 02:09:09 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5K298Tj000766;
        Wed, 20 Jun 2018 02:09:08 GMT
Received: from [10.182.69.179] (/10.182.69.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 19:09:08 -0700
Subject: Re: [PATCH] blk-mq: use mutex_trylock to avoid lock inversion
To:     Bart Van Assche <Bart.VanAssche@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1529391637-1704-1-git-send-email-jianchao.w.wang@oracle.com>
 <2409013d789ca266879d24c815b76c2193e23fe3.camel@wdc.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <d528a730-8e44-225b-2a35-3544160761dc@oracle.com>
Date:   Wed, 20 Jun 2018 10:09:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2409013d789ca266879d24c815b76c2193e23fe3.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=813
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart

On 06/19/2018 11:20 PM, Bart Van Assche wrote:
> On Tue, 2018-06-19 at 15:00 +0800, Jianchao Wang wrote:
>> Currently, the kobject_del for kobjs of mq, hctx and ctx is invoked
>> under sysfs_lock, lock inversion will come up when other one is
>> acessing the associated sysfs file and trying to acquire the
>> sysfs_lock. To fix it, use mutex_trylock in blk_mq_sysfs_ops and
>> blk_mq_hw_sysfs_ops, if the lock in on contending, return -EAGAIN.
> 
> Is this a theoretical issue or something you actually ran into? Which lock
> other than sysfs_lock do you think is involved in the lock inversion?
> 

It is very easy to reproduce with following scripts.

script 0
while true
do
	modprobe null_blk queue_mode=2 shared_tags=1
	sleep 0.1
	rmmod null_blk
	sleep 0.1
done

script 1
file0="/sys/block/nullb0/mq/0/nr_tags"
file1="/sys/block/nullb0/mq/0/cpu0/rq_list"
while true;
do
	if [ -e $file0 ];then
		cat $file0
	fi
	if [ -e $file1 ];then
		cat $file1
	fi
done

Here is the hung task log:

[  246.752087] INFO: task rmmod:12789 blocked for more than 30 seconds.
[  246.752801]       Not tainted 4.18.0-rc1 #88
[  246.753458] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  246.754192] rmmod           D    0 12789   3142 0x00000080
[  246.754951] Call Trace:
[  246.755715]  ? __schedule+0x3f9/0xae0
[  246.756546]  schedule+0x3c/0x90
[  246.757440]  __kernfs_remove+0x1d0/0x2b0
[  246.757644]  ? wait_woken+0xb0/0xb0
[  246.757850]  kernfs_remove+0x1f/0x30
[  246.758059]  kobject_del+0x13/0x40
[  246.758271]  blk_mq_unregister_dev+0x4f/0xb0
[  246.758488]  blk_unregister_queue+0x71/0x100
[  246.758709]  del_gendisk+0x139/0x280
[  246.758936]  null_del_dev+0x40/0xf0 [null_blk]
[  246.759165]  null_exit+0x50/0xbec [null_blk]
[  246.759397]  __x64_sys_delete_module+0x12e/0x1d0
[  246.759636]  do_syscall_64+0x5a/0x1a0
[  246.759876]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  246.760129] RIP: 0033:0x7fc518522927
[  246.760481] Code: Bad RIP value.
[  246.760736] RSP: 002b:00007ffee4c69b68 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  246.761005] RAX: ffffffffffffffda RBX: 00007ffee4c69bc8 RCX: 00007fc518522927
[  246.761309] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055783881b248
[  246.761612] RBP: 000055783881b1e0 R08: 0000000000000000 R09: 1999999999999999
[  246.761902] R10: 0000000000000000 R11: 0000000000000206 R12: 00007ffee4c69d90
[  246.762199] R13: 00007ffee4c6b774 R14: 000055783881a010 R15: 000055783881b1e0
[  246.762503] INFO: task cat:12790 blocked for more than 30 seconds.
[  246.762812]       Not tainted 4.18.0-rc1 #88
[  246.763124] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  246.763453] cat             D    0 12790   3141 0x00000080
[  246.763789] Call Trace:
[  246.764130]  ? __schedule+0x3f9/0xae0
[  246.764552]  schedule+0x3c/0x90
[  246.764895]  schedule_preempt_disabled+0x14/0x20
[  246.765244]  __mutex_lock+0x41c/0x990
[  246.765595]  ? blk_mq_hw_sysfs_show+0x35/0x80
[  246.765950]  ? preempt_count_sub+0x92/0xd0
[  246.766311]  ? blk_mq_hw_sysfs_show+0x35/0x80
[  246.766675]  blk_mq_hw_sysfs_show+0x35/0x80
[  246.767043]  sysfs_kf_seq_show+0xad/0x100
[  246.767416]  seq_read+0xa5/0x410
[  246.767790]  __vfs_read+0x23/0x160
[  246.768172]  vfs_read+0xa0/0x140
[  246.768627]  ksys_read+0x45/0xa0
[  246.769008]  do_syscall_64+0x5a/0x1a0
[  246.769391]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  246.769798] RIP: 0033:0x7f743e39e260
[  246.770216] Code: Bad RIP value.

Thanks
Jianchao
> 
> 
> 
