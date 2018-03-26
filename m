Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeCZDsM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 23:48:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751011AbeCZDsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 23:48:10 -0400
Subject: Re: possible deadlock in handle_rx
To: syzbot <syzbot+7f073540b1384a614e09@syzkaller.appspotmail.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
References: <001a113fe6d043b2a605684578f4@google.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b68023f4-f917-d229-6d2d-e10f35a99062@redhat.com>
Date: Mon, 26 Mar 2018 11:48:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <001a113fe6d043b2a605684578f4@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年03月26日 08:01, syzbot wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> cb6416592bc2a8b731dabcec0d63cda270764fc6 (Sun Mar 25 17:45:10 2018 +0000)
> Merge tag 'dmaengine-fix-4.16-rc7' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma
> syzbot dashboard link: 
> https://syzkaller.appspot.com/bug?extid=7f073540b1384a614e09
>
> So far this crash happened 4 times on upstream.
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6506789075943424
> syzkaller reproducer: 
> https://syzkaller.appspot.com/x/repro.syz?id=5716250550337536
> Raw console output: 
> https://syzkaller.appspot.com/x/log.txt?id=5142038655795200
> Kernel config: 
> https://syzkaller.appspot.com/x/.config?id=-5034017172441945317
> compiler: gcc (GCC) 7.1.1 20170620
>
> IMPORTANT: if you fix the bug, please add the following tag to the 
> commit:
> Reported-by: syzbot+7f073540b1384a614e09@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for 
> details.
> If you forward the report, please keep this part and the footer.
>
>
> ============================================
> WARNING: possible recursive locking detected
> 4.16.0-rc6+ #366 Not tainted
> --------------------------------------------
> vhost-4248/4760 is trying to acquire lock:
>  (&vq->mutex){+.+.}, at: [<000000003482bddc>] 
> vhost_net_rx_peek_head_len drivers/vhost/net.c:633 [inline]
>  (&vq->mutex){+.+.}, at: [<000000003482bddc>] handle_rx+0xeb1/0x19c0 
> drivers/vhost/net.c:784
>
> but task is already holding lock:
>  (&vq->mutex){+.+.}, at: [<000000004de72f44>] handle_rx+0x1f5/0x19c0 
> drivers/vhost/net.c:766
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(&vq->mutex);
>   lock(&vq->mutex);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation

Yes, it's a missing of nesting notation.

Will post a patch soon.

Thanks
