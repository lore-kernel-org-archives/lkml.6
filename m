Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbeEUCiT (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 22:38:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751094AbeEUCiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 22:38:18 -0400
Subject: Re: KASAN: use-after-free Read in vhost_chr_write_iter
From: Jason Wang <jasowang@redhat.com>
To: DaeRyong Jeong <threeearcat@gmail.com>, mst@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        byoungyoung@purdue.edu, kt0755@gmail.com, bammanag@purdue.edu
References: <20180517134544.GA20646@dragonet.kaist.ac.kr>
 <58419d62-3074-2e5a-8504-da1cdeb08280@redhat.com>
Message-ID: <fb27c1fd-5172-252a-cb8f-b53927a26d06@redhat.com>
Date: Mon, 21 May 2018 10:38:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <58419d62-3074-2e5a-8504-da1cdeb08280@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------FF39819B0B32F065DEF38149"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------FF39819B0B32F065DEF38149
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2018年05月18日 17:24, Jason Wang wrote:
>
>
> On 2018年05月17日 21:45, DaeRyong Jeong wrote:
>> We report the crash: KASAN: use-after-free Read in vhost_chr_write_iter
>>
>> This crash has been found in v4.17-rc1 using RaceFuzzer (a modified
>> version of Syzkaller), which we describe more at the end of this
>> report. Our analysis shows that the race occurs when invoking two
>> syscalls concurrently, write$vnet and ioctl$VHOST_RESET_OWNER.
>>
>>
>> Analysis:
>> We think the concurrent execution of vhost_process_iotlb_msg() and
>> vhost_dev_cleanup() causes the crash.
>> Both of functions can run concurrently (please see call sequence below),
>> and possibly, there is a race on dev->iotlb.
>> If the switch occurs right after vhost_dev_cleanup() frees
>> dev->iotlb, vhost_process_iotlb_msg() still sees the non-null value 
>> and it
>> keep executing without returning -EFAULT. Consequently, use-after-free
>> occures
>>
>>
>> Thread interleaving:
>> CPU0 (vhost_process_iotlb_msg)                CPU1 (vhost_dev_cleanup)
>> (In the case of both VHOST_IOTLB_UPDATE and
>> VHOST_IOTLB_INVALIDATE)
>> =====                            =====
>>                             vhost_umem_clean(dev->iotlb);
>> if (!dev->iotlb) {
>>             ret = -EFAULT;
>>                 break;
>> }
>>                             dev->iotlb = NULL;
>>
>>
>> Call Sequence:
>> CPU0
>> =====
>> vhost_net_chr_write_iter
>>     vhost_chr_write_iter
>>         vhost_process_iotlb_msg
>>
>> CPU1
>> =====
>> vhost_net_ioctl
>>     vhost_net_reset_owner
>>         vhost_dev_reset_owner
>>             vhost_dev_cleanup
>
> Thanks a lot for the analysis.
>
> This could be addressed by simply protect it with dev mutex.
>
> Will post a patch.
>

Could you please help to test the attached patch? I've done some smoking 
test.

Thanks

--------------FF39819B0B32F065DEF38149
Content-Type: text/x-patch;
 name="0001-vhost-synchronize-IOTLB-message-with-dev-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-vhost-synchronize-IOTLB-message-with-dev-cleanup.patch"

>From 88328386f3f652e684ee33dc4cf63dcaed871aea Mon Sep 17 00:00:00 2001
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 May 2018 17:33:27 +0800
Subject: [PATCH] vhost: synchronize IOTLB message with dev cleanup

DaeRyong Jeong reports a race between vhost_dev_cleanup() and
vhost_process_iotlb_msg():

Thread interleaving:
CPU0 (vhost_process_iotlb_msg)			CPU1 (vhost_dev_cleanup)
(In the case of both VHOST_IOTLB_UPDATE and
VHOST_IOTLB_INVALIDATE)
=====						=====
						vhost_umem_clean(dev->iotlb);
if (!dev->iotlb) {
	        ret = -EFAULT;
		        break;
}
						dev->iotlb = NULL;

The reason is we don't synchronize between them, fixing by protecting
vhost_process_iotlb_msg() with dev mutex.

Reported-by: DaeRyong Jeong <threeearcat@gmail.com>
Fixes: 6b1e6cc7855b0 ("vhost: new device IOTLB API")
Reported-by: DaeRyong Jeong <threeearcat@gmail.com>
---
 drivers/vhost/vhost.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index f3bd8e9..f0be5f3 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -981,6 +981,7 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
 {
 	int ret = 0;
 
+	mutex_lock(&dev->mutex);
 	vhost_dev_lock_vqs(dev);
 	switch (msg->type) {
 	case VHOST_IOTLB_UPDATE:
@@ -1016,6 +1017,8 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
 	}
 
 	vhost_dev_unlock_vqs(dev);
+	mutex_unlock(&dev->mutex);
+
 	return ret;
 }
 ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
-- 
2.7.4


--------------FF39819B0B32F065DEF38149--
