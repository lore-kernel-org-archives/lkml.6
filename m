Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845A0C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF2C20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF2C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeLMGbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:31:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbeLMGbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:31:07 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD0883001DAB;
        Thu, 13 Dec 2018 06:31:06 +0000 (UTC)
Received: from [10.72.12.167] (ovpn-12-167.pek2.redhat.com [10.72.12.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0D3B3794;
        Thu, 13 Dec 2018 06:30:55 +0000 (UTC)
Subject: Re: [PATCH] Export mm_update_next_owner function for vhost-net
To:     gchen.guomin@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>,
        guominchen@tencent.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
References: <1544676445-14897-1-git-send-email-gchen.guomin@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <94b66555-64cb-36c5-a5c0-c7256b659a0d@redhat.com>
Date:   Thu, 13 Dec 2018 14:30:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544676445-14897-1-git-send-email-gchen.guomin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 13 Dec 2018 06:31:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/13 下午12:47, gchen.guomin@gmail.com wrote:
> From: guomin chen <gchen.guomin@gmail.com>
>
>   Under normal circumstances,When do_exit exits, mm->owner will
>   be updated on exit_mm(). but when the kernel process calls
>   unuse_mm() and then exits,mm->owner cannot be updated. And it
>   will point to a task that has been released.
>
>   Below is my issue on vhost_net:
>      A, B are two kernel processes(such as vhost_worker),
>      C is a user space process(such as qemu), and all
>      three use the mm of the user process C.
>      Now, because user process C exits abnormally, the owner of this
>      mm becomes A. When A calls unuse_mm and exits, this mm->ower
>      still points to the A that has been released.
>      When B accesses this mm->owner again, A has been released.


Could you describe how you reproduce this issue? I believe vhost process 
should exit before process C?


>
>   Process A             Process B
>   vhost_worker()        vhost_worker()
>    ---------             ---------
>    use_mm()              use_mm()
>     ...
>    unuse_mm()
>       tsk->mm=NULL
>     do_exit()            page fault
>      exit_mm()           access mm->owner
>     can't update owner   kernel Oops
>
>                          unuse_mm()
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: guomin chen <gchen.guomin@gmail.com>
> ---
>   drivers/vhost/vhost.c | 1 +
>   kernel/exit.c         | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 6b98d8e..7c09087 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -368,6 +368,7 @@ static int vhost_worker(void *data)
>   		}
>   	}
>   	unuse_mm(dev->mm);
> +	mm_update_next_owner(dev->mm);


If you analysis is correct, this is still racy isn't it? (E.g page fault 
happen between unuse_mm() and mm_update_next_owner()).

Thanks


>   	set_fs(oldfs);
>   	return 0;
>   }
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 0e21e6d..9e046dd 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -486,6 +486,7 @@ void mm_update_next_owner(struct mm_struct *mm)
>   	task_unlock(c);
>   	put_task_struct(c);
>   }
> +EXPORT_SYMBOL(mm_update_next_owner);
>   #endif /* CONFIG_MEMCG */
>   
>   /*
