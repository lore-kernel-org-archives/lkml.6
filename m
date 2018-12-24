Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B215C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 03:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A149214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 03:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbeLXDnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 22:43:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbeLXDnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 22:43:39 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5CC0937E85;
        Mon, 24 Dec 2018 03:43:39 +0000 (UTC)
Received: from [10.72.12.182] (ovpn-12-182.pek2.redhat.com [10.72.12.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A27C85D9CB;
        Mon, 24 Dec 2018 03:43:34 +0000 (UTC)
Subject: Re: [PATCH net V2 4/4] vhost: log dirty page correctly
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jintack Lim <jintack@cs.columbia.edu>
References: <20181212100819.21295-1-jasowang@redhat.com>
 <20181212100819.21295-5-jasowang@redhat.com>
 <20181212092435-mutt-send-email-mst@kernel.org>
 <0239c220-e7ca-c08f-be26-eb9be63fced3@redhat.com>
 <20181213092930-mutt-send-email-mst@kernel.org>
 <519ee6f7-06fc-ad49-03da-c096aeb24ced@redhat.com>
 <20181214081821-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <55b3d55a-950f-eeaf-1908-bed78a1a9200@redhat.com>
Date:   Mon, 24 Dec 2018 11:43:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181214081821-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 24 Dec 2018 03:43:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/14 下午9:20, Michael S. Tsirkin wrote:
> On Fri, Dec 14, 2018 at 10:43:03AM +0800, Jason Wang wrote:
>> On 2018/12/13 下午10:31, Michael S. Tsirkin wrote:
>>>> Just to make sure I understand this. It looks to me we should:
>>>>
>>>> - allow passing GIOVA->GPA through UAPI
>>>>
>>>> - cache GIOVA->GPA somewhere but still use GIOVA->HVA in device IOTLB for
>>>> performance
>>>>
>>>> Is this what you suggest?
>>>>
>>>> Thanks
>>> Not really. We already have GPA->HVA, so I suggested a flag to pass
>>> GIOVA->GPA in the IOTLB.
>>>
>>> This has advantages for security since a single table needs
>>> then to be validated to ensure guest does not corrupt
>>> QEMU memory.
>>>
>> I wonder how much we can gain through this. Currently, qemu IOMMU gives
>> GIOVA->GPA mapping, and qemu vhost code will translate GPA to HVA then pass
>> GIOVA->HVA to vhost. It looks no difference to me.
>>
>> Thanks
> The difference is in security not in performance.  Getting a bad HVA
> corrupts QEMU memory and it might be guest controlled. Very risky.


How can this be controlled by guest? HVA was generated from qemu ram 
blocks which is totally under the control of qemu memory core instead of 
guest.


Thanks


>   If
> translations to HVA are done in a single place through a single table
> it's safer as there's a single risky place.
>
