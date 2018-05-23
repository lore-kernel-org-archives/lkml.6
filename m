Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753663AbeEWBKv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 21:10:51 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34278 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752654AbeEWBKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 21:10:49 -0400
X-Google-Smtp-Source: AB8JxZrneOvpDvAPtrbewDD9WPlYtdYji3GwBVqPTNlMfOehOuZ8ILFS+fyqsNxm0V4LChj+Z13w+TJv5sS4GoAbUdA=
MIME-Version: 1.0
In-Reply-To: <1526932984-11544-1-git-send-email-vladbu@mellanox.com>
References: <20180519.230258.1374885458106197707.davem@davemloft.net> <1526932984-11544-1-git-send-email-vladbu@mellanox.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 22 May 2018 18:10:28 -0700
Message-ID: <CAM_iQpVMFSxnN6dEi0U4=aw7s7TcJ88ShiNTDXcoRUVL82jTZw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: sched: don't disable bh when accessing
 action idr
To: Vlad Buslov <vladbu@mellanox.com>
Cc: David Miller <davem@davemloft.net>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 1:03 PM, Vlad Buslov <vladbu@mellanox.com> wrote:
> Initial net_device implementation used ingress_lock spinlock to synchronize
> ingress path of device. This lock was used in both process and bh context.
> In some code paths action map lock was obtained while holding ingress_lock.
> Commit e1e992e52faa ("[NET_SCHED] protect action config/dump from irqs")
> modified actions to always disable bh, while using action map lock, in
> order to prevent deadlock on ingress_lock in softirq. This lock was removed
> from net_device, so disabling bh, while accessing action map, is no longer
> necessary.
>
> Replace all action idr spinlock usage with regular calls that do not
> disable bh.

While your patch is probably fine, the above justification seems not.

In the past, tc actions could be released in BH context because tc
filters use call_rcu(). However, I moved them to a workqueue recently.
So before my change I don't think you can remove the BH protection,
otherwise race with idr_remove()...
