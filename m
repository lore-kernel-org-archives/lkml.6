Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeDBF30 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 01:29:26 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:45679 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbeDBF3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 01:29:25 -0400
X-Google-Smtp-Source: AIpwx49031Gk59xSLp+p6p7lwsO845EPLwLI35KDp5+7AYLlIO9/GxgYMgrUaquihO8W5SvkaHRD2g==
Date: Mon, 2 Apr 2018 14:29:20 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: wen.yang99@zte.com.cn
Cc: yanaijie@huawei.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bart.VanAssche@wdc.com, pmladek@suse.com,
        sergey.senozhatsky.work@gmail.com, tj@kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn, tan.hu@zte.com.cn
Subject: Re: =?utf-8?B?562U5aSNOiBSZTogW1BBVENIIHYy?=
 =?utf-8?Q?=5D_scsi=3A_Introduc?= =?utf-8?Q?e?= sdev_printk_ratelimited to
 throttlefrequent printk
Message-ID: <20180402052920.GF3795@jagdpanzerIV>
References: <5AC1976F.1040801@huawei.com>
 <201804021314481872986@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201804021314481872986@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/02/18 13:14), wen.yang99@zte.com.cn wrote:
> 
>    > It's true that this print for the same device is useless. But it's
>    > useful for different devices. Is it possible to limit the print only
>    > for the same device?
> 
>    In our scene, it's  just for the same device (q->queuedata), Thanks.

Yes, what Jason meant was that rate limit struct is shared by different call
sites - including scsi_request_fn() from different devices.

If device1->scsi_request_fn()->sdev_printk_ratelimited() causes printk rate
limit, then messages from device2->scsi_request_fn()->sdev_printk_ratelimited()
may be lost entirely, unless you have enough of them.

	-ss
