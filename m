Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965387AbeBMRe6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:34:58 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:38198 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965099AbeBMRe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:34:56 -0500
X-Google-Smtp-Source: AH8x226cSlHDDhm/Zyh3yTLyl8aVHoyHudG5Kdxa3dXcmk+vS7STdNyj1/Yk5/rvDfVn16lLQ298Tg==
Date: Tue, 13 Feb 2018 11:34:38 -0600
From: Dennis Zhou <dennisszhou@gmail.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+adb03f3f0bb57ce3acda@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com
Subject: Re: lost connection to test machine (4)
Message-ID: <20180213173438.GA60641@localhost.uwnet.wisc.edu>
References: <001a113f8734783e94056505f8fd@google.com>
 <CACT4Y+ZBHw7VZBFOeqLmrpmzgn4owW88qvP5v=xnr9966hbM_Q@mail.gmail.com>
 <00c45ca8-305d-1818-e974-a9903c8494b8@iogearbox.net>
 <20180212170325.GW695913@devbig577.frc2.facebook.com>
 <20180212200548.GG695913@devbig577.frc2.facebook.com>
 <1518528926.3715.173.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518528926.3715.173.camel@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Tue, Feb 13, 2018 at 05:35:26AM -0800, Eric Dumazet wrote:
> 
> Also I would consider using this fix as I had warnings of cpus being
> stuck there for more than 50 ms :
> 
> 
> diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
> index 9158e5a81391ced4e268e3d5dd9879c2bc7280ce..6309b01ceb357be01e857e5f899429403836f41f 100644
> --- a/mm/percpu-vm.c
> +++ b/mm/percpu-vm.c
> @@ -92,6 +92,7 @@ static int pcpu_alloc_pages(struct pcpu_chunk *chunk,
>  			*pagep = alloc_pages_node(cpu_to_node(cpu), gfp, 0);
>  			if (!*pagep)
>  				goto err;
> +			cond_resched();
>  		}
>  	}
>  	return 0;
> 
> 

This function gets called from pcpu_populate_chunk while holding the
pcpu_alloc_mutex and is called from two scenarios. First, when an
allocation occurs to a place without backing pages, and second when the
workqueue item is scheduled to replenish the number of empty pages. So,
I don't think this is a good idea.

My understanding is if we're seeing warnings here, that means we're
struggling to find backing pages. I believe adding __GFP_NORETRY on the
workqueue path as Tejun mentioned above would help with warnings as
well, but not if they are caused by the allocation path.

Thanks,
Dennis
