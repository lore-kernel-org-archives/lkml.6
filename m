Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3ECC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2AF20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfAQNJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:09:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfAQNJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:09:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A1BB19CBDB;
        Thu, 17 Jan 2019 13:09:48 +0000 (UTC)
Received: from [10.72.12.16] (ovpn-12-16.pek2.redhat.com [10.72.12.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC4C85DD7B;
        Thu, 17 Jan 2019 13:09:34 +0000 (UTC)
Subject: Re: [PATCH RFC 1/2] virtio-net: bql support
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com,
        tiwei.bie@intel.com, wexu@redhat.com, jfreimann@redhat.com,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20181205225323.12555-1-mst@redhat.com>
 <20181205225323.12555-2-mst@redhat.com>
 <21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com>
 <20181226102100-mutt-send-email-mst@kernel.org>
 <620cfd46-aa3e-7eb6-0757-f4afbafda44b@redhat.com>
 <20181230134539-mutt-send-email-mst@kernel.org>
 <01e0fe8f-bd75-c39b-9d77-c5a9baf87348@redhat.com>
 <20190102083202-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <a8f84698-9a60-93ac-c2ee-3634f6ba5cf7@redhat.com>
Date:   Thu, 17 Jan 2019 21:09:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190102083202-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 17 Jan 2019 13:09:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/2 下午9:54, Michael S. Tsirkin wrote:
> On Wed, Jan 02, 2019 at 11:30:11AM +0800, Jason Wang wrote:
>> On 2018/12/31 上午2:48, Michael S. Tsirkin wrote:
>>> On Thu, Dec 27, 2018 at 06:04:53PM +0800, Jason Wang wrote:
>>>> On 2018/12/26 下午11:22, Michael S. Tsirkin wrote:
>>>>> On Thu, Dec 06, 2018 at 04:17:36PM +0800, Jason Wang wrote:
>>>>>> On 2018/12/6 上午6:54, Michael S. Tsirkin wrote:
>>>>>>> When use_napi is set, let's enable BQLs.  Note: some of the issues are
>>>>>>> similar to wifi.  It's worth considering whether something similar to
>>>>>>> commit 36148c2bbfbe ("mac80211: Adjust TSQ pacing shift") might be
>>>>>>> benefitial.
>>>>>> I've played a similar patch several days before. The tricky part is the mode
>>>>>> switching between napi and no napi. We should make sure when the packet is
>>>>>> sent and trakced by BQL,  it should be consumed by BQL as well.
>>>>> I just went over the patch again and I don't understand this comment.
>>>>> This patch only enabled BQL with tx napi.
>>>>>
>>>>> Thus there's no mode switching.
>>>>>
>>>>> What did I miss?
>>>> Consider the case:
>>>>
>>>>
>>>> TX NAPI is disabled:
>>>>
>>>> send N packets
>>>>
>>>> turn TX NAPI on:
>>>>
>>>> get tx interrupt
>>>>
>>>> BQL try to consume those packets when lead WARN for dql.
>>>>
>>>>
>>>> Thanks
>>> Can one really switch tx napi on and off? How?
>>> While root can change the napi_tx module parameter, I don't think
>>> that has any effect outside device probe time. What did I miss?
>>>
>>>
>>>
>> We support switch the mode through ethtool recently. See
>>
>> commit 0c465be183c7c57a26446df6ea96d8676b865f92
>> Author: Jason Wang <jasowang@redhat.com>
>> Date:   Tue Oct 9 10:06:26 2018 +0800
>>
>>      virtio_net: ethtool tx napi configuration
>>
>>      Implement ethtool .set_coalesce (-C) and .get_coalesce (-c) handlers.
>>      Interrupt moderation is currently not supported, so these accept and
>>      display the default settings of 0 usec and 1 frame.
>>
>>      Toggle tx napi through setting tx-frames. So as to not interfere
>>      with possible future interrupt moderation, value 1 means tx napi while
>>      value 0 means not.
>>
>>      Only allow the switching when device is down for simplicity.
>>
>>      Link: https://patchwork.ozlabs.org/patch/948149/
>>      Suggested-by: Jason Wang <jasowang@redhat.com>
>>      Signed-off-by: Willem de Bruijn <willemb@google.com>
>>      Signed-off-by: Jason Wang <jasowang@redhat.com>
>>      Signed-off-by: David S. Miller <davem@davemloft.net>
>>
>> Thanks
>
> It's disabled when device is up - isn't that enough?


Consider the case:

1) tx napi is disabled

2) send packets

3) tx napi is enabled through ethtool

4) get tx interrupt

5) BQL may start to consume packet that was sent when tx napi is 
disabled which will trigger BUG or WARN in dql

Thanks


