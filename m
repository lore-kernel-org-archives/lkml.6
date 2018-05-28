Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935094AbeE1XNr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 19:13:47 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35730 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934579AbeE1XNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 19:13:43 -0400
X-Google-Smtp-Source: AB8JxZp1ZToAcGCgQdqZKoyxYWFY09DLfuiTNAZOtyiXfUwkt4F/IaT7onJ6JmD0l2JR7Nt1WSx6nYesAvWRTRKVJ8w=
MIME-Version: 1.0
In-Reply-To: <20180525.164337.1433478215018599363.davem@davemloft.net>
References: <20180524213829.15208-1-jmaxwell37@gmail.com> <20180525.164337.1433478215018599363.davem@davemloft.net>
From: Jonathan Maxwell <jmaxwell37@gmail.com>
Date: Tue, 29 May 2018 09:13:02 +1000
Message-ID: <CAGHK07AuYxdgXXd1sKZqB3OVeOGdUVP7hS+-PGqtUEtOVV6Jng@mail.gmail.com>
Subject: Re: [PATCH net-next] ifb: fix packets checksum
To: David Miller <davem@davemloft.net>
Cc: David Ahern <dsahern@gmail.com>, mschiffer@universe-factory.net,
        zhangshengju@cmss.chinamobile.com, ktkhai@virtuozzo.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jon Maxwell <jmaxwell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 6:43 AM, David Miller <davem@davemloft.net> wrote:
> From: Jon Maxwell <jmaxwell37@gmail.com>
> Date: Fri, 25 May 2018 07:38:29 +1000
>
>> Fixup the checksum for CHECKSUM_COMPLETE when pulling skbs on RX path.
>> Otherwise we get splats when tc mirred is used to redirect packets to ifb.
>>
>> Before fix:
>>
>> nic: hw csum failure
>>
>> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
>
> This definitely seems correct, but I am really surprised a bug like this has
> lasted as long as it has.
>

Sorry for the late reply I have been away for a few days. The customer never
saw this on bnx2x. Then they switched to the mlx5 driver and it started
happening continuously when doing iperf3 tests and also for other TCP traffic.

mlx5 uses CHECKSUM_COMPLETE. I think that bnx2x uses CHECKSUM UNNECESSARY
which avoided the code path that triggers the csum failure message in
__skb_checksum_complete(). It only logs the message for CHECKSUM_COMPLETE
skbs. Probably few Linux users are using a combination of NIC drivers that
use CHECKSUM_COMPLETE, tc mirred and ifb, which is why this has never been
reported before.

This is very similar to commit 7be709af2b65.

> So I'll let this sit for another day or two for review.
