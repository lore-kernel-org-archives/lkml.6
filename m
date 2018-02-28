Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932852AbeB1TCr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:02:47 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:57724 "EHLO
        mail2.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932088AbeB1TCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:02:45 -0500
Subject: Re: [PATCH net] virtio-net: disable NAPI only when enabled during XDP
 set
To: David Miller <davem@davemloft.net>, jasowang@redhat.com
References: <1519813204-10002-1-git-send-email-jasowang@redhat.com>
 <20180228.122231.1811613646832502397.davem@davemloft.net>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <d49359d8-08d3-686b-3606-843c6bb13dd8@candelatech.com>
Date: Wed, 28 Feb 2018 11:02:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
MIME-Version: 1.0
In-Reply-To: <20180228.122231.1811613646832502397.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/2018 09:22 AM, David Miller wrote:
> From: Jason Wang <jasowang@redhat.com>
> Date: Wed, 28 Feb 2018 18:20:04 +0800
>
>> We try to disable NAPI to prevent a single XDP TX queue being used by
>> multiple cpus. But we don't check if device is up (NAPI is enabled),
>> this could result stall because of infinite wait in
>> napi_disable(). Fixing this by checking device state through
>> netif_running() before.
>>
>> Fixes: 4941d472bf95b ("virtio-net: do not reset during XDP set")
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Yes, mis-paired NAPI enable/disable are really a pain.
>
> Probably, we can do something in the interfaces or mechanisms to make
> this less error prone and less fragile.
>
> Anyways, applied and queued up for -stable, thanks!


I just hit a similar bug in ath10k.  It seems like napi has plenty
of free bit flags so it could keep track of 'is-enabled' state and
allow someone to call napi_disable multiple times w/out deadlocking.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
