Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeEVRRS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:17:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752022AbeEVRRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:17:15 -0400
Subject: Re: [PATCH v4 0/2] vfio/mdev: Device namespace protection
To: Alex Williamson <alex.williamson@redhat.com>, kwankhede@nvidia.com,
        Dong Jia <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, cohuck@redhat.com
References: <20180518190145.3187.7620.stgit@gimli.home>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Tue, 22 May 2018 19:17:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518190145.3187.7620.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18052217-0020-0000-0000-000004200844
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052217-0021-0000-0000-000042B54326
Message-Id: <c666f6b7-bd49-79e4-703d-2724f7549c53@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805220188
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 From vfio-ccw perspective I join Connie's assessment: vfio-ccw should
be fine with these changes. I'm however not too deeply involved with
the mdev framework, thus I don't feel comfortable r-b-ing. That results
in
Acked-by: Halil Pasic <pasic@linux.ibm.com>
for both patches.

While at it I have would like to ask about the semantics and intended
use of the mdev interfaces.

static int vfio_ccw_sch_probe(struct subchannel *sch)
{

/* HALIL: 8< Not so interesting stuff happens here. >8 */
         ret = vfio_ccw_mdev_reg(sch);
         if (ret)
                 goto out_disable;
/*
  * HALIL:  
  * This might be racy. Somewhere in vfio_ccw_mdev_reg() the create attribute
  * is made available (it calls mdev_register_device()). For instance create will
  * attempt to decrement private->avail which is initialized below. I fail to
  * understand how is  this well synchronized.
  */
         INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
         atomic_set(&private->avail, 1);
         private->state = VFIO_CCW_STATE_STANDBY;

         return 0;

out_disable:
         cio_disable_subchannel(sch);
out_free:
         dev_set_drvdata(&sch->dev, NULL);
         kfree(private);
         return ret;
}

Should not initialization  of go before mdev_register_device(), and then rolled
back if necessary if mdev_register_device() fails?

In practice it does not seem very likely that userspace can trigger
mdev_device_create() before vfio_ccw_sch_probe() finishes so it should
not be a practical problem. But I would like to understand how synchronization
is supposed to work.

[Added Dong Jia, maybe he is also able to answer my question.]

Regards,
Halil

On 05/18/2018 09:10 PM, Alex Williamson wrote:
> v4: Fix the 'create' racing 'remove' gap noted by Kirti by moving
>      removal from mdev_list to mdev_device_release().  Fix missing
>      mdev_put_parent() cases in mdev_device_create(), also noted
>      by Kirti.  Added documention update regarding serialization as
>      noted by Cornelia.  Added additional commit log comment about
>      -EAGAIN vs -ENODEV for 'remove' racing 'create'.  Added second
>      patch to re-order sysfs attributes, with this my targeted
>      scripts can no longer hit the gap where -EAGAIN is regurned.
>      BTW, the gap where the current code returns -ENODEV in this
>      race condition is about 50% easier to hit than it exists in
>      this series with patch 1 alone.
> 
> Thanks,
> Alex
> 
> ---
> 
> Alex Williamson (2):
>        vfio/mdev: Check globally for duplicate devices
>        vfio/mdev: Re-order sysfs attribute creation
> 
> 
>   Documentation/vfio-mediated-device.txt |    5 ++
>   drivers/vfio/mdev/mdev_core.c          |  102 +++++++++++---------------------
>   drivers/vfio/mdev/mdev_private.h       |    2 -
>   drivers/vfio/mdev/mdev_sysfs.c         |   14 ++--
>   4 files changed, 49 insertions(+), 74 deletions(-)
> 
