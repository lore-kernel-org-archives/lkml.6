Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753641AbeCVL5f convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 07:57:35 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:55360 "EHLO
        mail4.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753382AbeCVL5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 07:57:31 -0400
From: =?iso-2022-jp?B?GyRCNTUwZj9OO1YbKEIgLyBLQU1FSRskQiEkGyhCSElUT1NISQ==?=
        <hitoshi.kamei.xm@hitachi.com>
To: Dongsheng Yang <dongsheng.yang@easystack.cn>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "sage@redhat.com" <sage@redhat.com>,
        "elder@kernel.org" <elder@kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Re: [PATCH 1/2] rbd: RBD_DEV_FLAG_THICK rbd_dev_flags bit
Thread-Topic: [!]Re: [PATCH 1/2] rbd: RBD_DEV_FLAG_THICK rbd_dev_flags bit
Thread-Index: AQHTwDfHsSScvr/zPUOf79xKbPj4SqPcJZZg
Date: Thu, 22 Mar 2018 11:57:27 +0000
Deferred-Delivery: Thu, 22 Mar 2018 11:57:08 +0000
Message-ID: <C8603108370B1949BF3CC7742DDE5D35B8B39FD9@GSjpTKYDCembx31.service.hitachi.net>
References: <5AAFA682.2080901@hitachi.com> <5AB0E4F3.8090108@easystack.cn>
In-Reply-To: <5AB0E4F3.8090108@easystack.cn>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.29.202]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang, 

> I am not sure is this the best way for this case, what about adding an option in "rbd map -o thick rbd/test"?

I will add such option to the rbd map command to manipulate image settings. So, the end-user
do not change the settings directly via sysfs file.

>	@@ -4011,6 +4012,15 @@ static void rbd_queue_workfn(struct work_struct *work)
>	 		goto err;
>	 	}
>	
>	+	/* Ignore/skip discard requests for thick-provision image */
>
> Just ignore? or return -EOPNOTSUPP? 

Thanks, I think -EOPNOTSUPP is better because user programs cannot know
the result of requested operation when the kernel rbd driver ignores
discard request. The result of requested operation when the kernel rbd driver
ignores discard requests, which probably misleads the user programs.

> In addition, we should not ignore the REQ_OP_WRITE_ZEROES.

Relating to the above, the return code of REQ_OP_WRITE_ZEROS request
is also -EOPNOTSUPP instead of ignoring. I think the result of
-EOPNOTSUPP is also better for this request because the kernel
rbd driver can expect that user programs write zero data by itself.

>	+	spin_lock_irq(&rbd_dev->lock);
>	+	if (!strncmp(buf, "1", size))
>	+		set_bit(RBD_DEV_FLAG_THICK, &rbd_dev->flags);
>	+	else if (!strncmp(buf, "0", size))
>	+		clear_bit(RBD_DEV_FLAG_THICK, &rbd_dev->flags);
> else ?

I will add the warning message in else case.
	
>	 static DEVICE_ATTR(snap_id, S_IRUGO, rbd_snap_id_show, NULL);
>	 static DEVICE_ATTR(parent, S_IRUGO, rbd_parent_show, NULL);
>	+static DEVICE_ATTR(thick, 0644, rbd_thick_show, rbd_thick_store);
> maybe S_IRUGO | S_IWUGO?

I will change the code by using the flags.

Regards,

-- 
Hitoshi Kamei
