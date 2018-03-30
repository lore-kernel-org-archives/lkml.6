Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeC3U6e (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 16:58:34 -0400
Received: from gateway36.websitewelcome.com ([192.185.199.121]:40992 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752568AbeC3U6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 16:58:32 -0400
Subject: Re: [PATCH] rbd: remove VLA usage
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20180330191759.GA18176@embeddedgus>
 <CAOi1vP8jzp9s4Qj9rBf90eU1TVY9C3W8ezThUXcSHUOX-B=pQg@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <0e56a59e-6dbe-a4c9-f761-e7e7d63db297@embeddedor.com>
Date: Fri, 30 Mar 2018 15:34:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAOi1vP8jzp9s4Qj9rBf90eU1TVY9C3W8ezThUXcSHUOX-B=pQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f20jR-000ULn-2R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.67]) [189.145.54.187]:49244
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/30/2018 03:29 PM, Ilya Dryomov wrote:
> On Fri, Mar 30, 2018 at 9:17 PM, Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>> In preparation to enabling -Wvla, remove the use of stack VLA.
>>
>> In this particular case, variable buf_size is replaced with a constant
>> expression that can be computed at preprocessing time. This avoids two
>> VLA warnings. Also, as a consequence of the mentioned change, some code
>> was slightly refactored.
>>
>> The use of stack Variable Length Arrays needs to be avoided, as they
>> can be a vector for stack exhaustion, which can be both a runtime bug
>> or a security flaw. Also, in general, as code evolves it is easy to
>> lose track of how big a VLA can get. Thus, we can end up having runtime
>> failures that are hard to debug.
>>
>> Also, fixed as part of the directive to remove all VLAs from
>> the kernel: https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/block/rbd.c | 15 +++++++--------
>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 1e03b04..5133122 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -3091,20 +3091,20 @@ static int __rbd_notify_op_lock(struct rbd_device *rbd_dev,
>>   {
>>          struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
>>          struct rbd_client_id cid = rbd_get_cid(rbd_dev);
>> -       int buf_size = 4 + 8 + 8 + CEPH_ENCODING_START_BLK_LEN;
>> -       char buf[buf_size];
>> +       char buf[4 + 8 + 8 + CEPH_ENCODING_START_BLK_LEN];
>>          void *p = buf;
>>
>>          dout("%s rbd_dev %p notify_op %d\n", __func__, rbd_dev, notify_op);
>>
>>          /* encode *LockPayload NotifyMessage (op + ClientId) */
>> -       ceph_start_encoding(&p, 2, 1, buf_size - CEPH_ENCODING_START_BLK_LEN);
>> +       ceph_start_encoding(&p, 2, 1,
>> +                           sizeof(buf) - CEPH_ENCODING_START_BLK_LEN);
>>          ceph_encode_32(&p, notify_op);
>>          ceph_encode_64(&p, cid.gid);
>>          ceph_encode_64(&p, cid.handle);
>>
>>          return ceph_osdc_notify(osdc, &rbd_dev->header_oid,
>> -                               &rbd_dev->header_oloc, buf, buf_size,
>> +                               &rbd_dev->header_oloc, buf, sizeof(buf),
>>                                  RBD_NOTIFY_TIMEOUT, preply_pages, preply_len);
>>   }
>>
>> @@ -3610,19 +3610,18 @@ static void __rbd_acknowledge_notify(struct rbd_device *rbd_dev,
>>                                       u64 notify_id, u64 cookie, s32 *result)
>>   {
>>          struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
>> -       int buf_size = 4 + CEPH_ENCODING_START_BLK_LEN;
>> -       char buf[buf_size];
>> +       char buf[4 + CEPH_ENCODING_START_BLK_LEN];
>> +       int buf_size = 0;
>>          int ret;
>>
>>          if (result) {
>>                  void *p = buf;
>>
>> +               buf_size = sizeof(buf);
>>                  /* encode ResponseMessage */
>>                  ceph_start_encoding(&p, 1, 1,
>>                                      buf_size - CEPH_ENCODING_START_BLK_LEN);
>>                  ceph_encode_32(&p, *result);
>> -       } else {
>> -               buf_size = 0;
>>          }
>>
>>          ret = ceph_osdc_notify_ack(osdc, &rbd_dev->header_oid,
> 
> Already fixed:
> 
>    https://github.com/ceph/ceph-client/commit/2474e77e75215a3cad3b652d2f55ba5b123cb119
> 

Oh, that's great.

Good to know. :)

Thanks
--
Gustavo
