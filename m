Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935095AbeEWXPS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 19:15:18 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36701 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935051AbeEWXPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 19:15:13 -0400
X-Google-Smtp-Source: AB8JxZocta2grHAFODEOh5jTbK+SyyJgW3VmFCL70dV3UUfeEMiSOSEbBQ+HcWpWHbHv6pSp6UKVKjtWeGwFxQoECmM=
MIME-Version: 1.0
In-Reply-To: <1527065574-11299-1-git-send-email-vladbu@mellanox.com>
References: <20180523073239.GC3155@nanopsycho> <1527065574-11299-1-git-send-email-vladbu@mellanox.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Wed, 23 May 2018 16:14:51 -0700
Message-ID: <CAM_iQpWNRRND4+uav4Sqwe1ctsb_J61eueShaSkRmYeW1=KMJw@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: sched: don't disable bh when accessing
 action idr
To: Vlad Buslov <vladbu@mellanox.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 1:52 AM, Vlad Buslov <vladbu@mellanox.com> wrote:
> Initial net_device implementation used ingress_lock spinlock to synchronize
> ingress path of device. This lock was used in both process and bh context.
> In some code paths action map lock was obtained while holding ingress_lock.
> Commit e1e992e52faa ("[NET_SCHED] protect action config/dump from irqs")
> modified actions to always disable bh, while using action map lock, in
> order to prevent deadlock on ingress_lock in softirq. This lock was removed
> in commit 555353cfa1ae ("netdev: The ingress_lock member is no longer
> needed.").
>
> Another reason to disable bh was filters delete code, that released actions
> in rcu callback. This code was changed to release actions from workqueue
> context in patch set "net_sched: close the race between call_rcu() and
> cleanup_net()".
>
> With these changes it is no longer necessary to continue disable bh while
> accessing action map.
>
> Replace all action idr spinlock usage with regular calls that do not
> disable bh.

Looks much better now!

I _guess_ we perhaps can even get rid of this spinlock since most of
the callers hold RTNL lock, not sure about the dump() path where
RTNL might be removed recently.

Anyway,

Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
