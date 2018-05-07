Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753344AbeEGVub (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 17:50:31 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:17723 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752930AbeEGVua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 17:50:30 -0400
Subject: Re: WARNING in __mutex_unlock_slowpath
To: Paolo Bonzini <pbonzini@redhat.com>,
        syzbot <syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <000000000000170595056affab1c@google.com>
 <59d3e273-293d-7597-7d69-b5278318a026@redhat.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        x86@kernel.org, Roman Kagan <rkagan@virtuozzo.com>,
        Cathy Avery <cavery@redhat.com>
Message-ID: <a92c15a3-ac06-c8b8-6f39-a5ad49dc2818@I-love.SAKURA.ne.jp>
Date: Tue, 8 May 2018 06:49:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <59d3e273-293d-7597-7d69-b5278318a026@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/05/08 2:19, Paolo Bonzini wrote:
>> ------------[ cut here ]------------
>> DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current)
>> WARNING: CPU: 0 PID: 4525 at kernel/locking/mutex.c:1032
>> __mutex_unlock_slowpath+0x62e/0x8a0 kernel/locking/mutex.c:1032
>> Kernel panic - not syncing: panic_on_warn set ...
> 
> This doesn't make much sense, unless it's a "generic" memory corruption,
> but at least the reproducer seems to be simple, just (in pseudocode)
> 
>   ioctl(kvm_vm_fd, KVM_HYPERV_EVENTFD,
>         { fd = some_eventfd, conn_id = 0, flags = 0 })
>   ioctl(kvm_vm_fd, KVM_HYPERV_EVENTFD,
>         { fd = -1, conn_id = 5, flags = KVM_HYPERV_EVENTFD_DEASSIGN })
> 

This makes much sense if this is use-after-free memory access which was
manifested differently due to reallocated after released.

  mutex_lock(&hv->hv_lock);
  eventfd = idr_remove(&hv->conn_to_evt, conn_id); // <= Memory block containing hv->hv_lock was released by other thread and reallocated by other thread.
  mutex_unlock(&hv->hv_lock); // <= Hence, __owner_task(owner) != current at this point.
