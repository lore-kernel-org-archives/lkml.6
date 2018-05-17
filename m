Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeEQHv3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:51:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36704 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbeEQHv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:51:28 -0400
X-Google-Smtp-Source: AB8JxZoAnRA5T3Hugx/lHb51AjAZ+J0lTKbwf6NePicrRCJ2oSDeSVET6MC8Jjig+i5G1qUgdWuJNw==
Date: Thu, 17 May 2018 10:51:24 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Fw: [PATCHSET] workqueue: Show the latest workqueue name in
 /proc/PID/{comm,stat,status}
Message-ID: <20180517075124.GA2057@avx2>
References: <20180516214750.82710e21075ad1461dd4c04b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180516214750.82710e21075ad1461dd4c04b@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 09:47:50PM -0700, Andrew Morton wrote:
> Alexey, can you please review the proc bits of this series?
> 
> Thanks.
> 
> Begin forwarded message:
> 
> Date: Wed, 16 May 2018 21:34:42 -0700
> From: Tejun Heo <tj@kernel.org>
> To: torvalds@linux-foundation.org, jiangshanlai@gmail.com, akpm@linux-foundation.org
> Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, kernel-team@fb.com, csmall@enc.com.au
> Subject: [PATCHSET] workqueue: Show the latest workqueue name in /proc/PID/{comm,stat,status}
> 
> 
> There can be a lot of workqueue workers and they all show up with the
> cryptic kworker/* names making it difficult to understand which is
> doing what and how they came to be.
> 
>  # ps -ef | grep kworker
>  root           4       2  0 Feb25 ?        00:00:00 [kworker/0:0H]
>  root           6       2  0 Feb25 ?        00:00:00 [kworker/u112:0]
>  root          19       2  0 Feb25 ?        00:00:00 [kworker/1:0H]
>  root          25       2  0 Feb25 ?        00:00:00 [kworker/2:0H]
>  root          31       2  0 Feb25 ?        00:00:00 [kworker/3:0H]
>  ...
> 
> This patchset makes workqueue workers report the latest workqueue it
> was executing for through /proc/PID/{comm,stat,status}.  The extra
> information is appended to the kthread name with intervening '+' if
> currently executing, otherwise '-'.
> 
>  # cat /proc/25/comm
>  kworker/2:0-events_power_efficient
>  # cat /proc/25/stat
>  25 (kworker/2:0-events_power_efficient) I 2 0 0 0 -1 69238880 0 0...
>  # grep Name /proc/25/status
>  Name:   kworker/2:0-events_power_efficient

I'd say anything that extends ->comm past 16 charactes is no-no.
The reason is that userspace may do something stupid like:

	char comm[16];

	start = strchr(s, '(');
	end   = strrchr(s, ')');
	// 16 bytes tops.
	memcpy(comm, s + start + 1, end - start);

I think procps-ng does strdup, but there is an infinite amount of
monitoring tools written.

Add /proc/*/wq for kernel threads which is A SYMBOLIC LINK,
and instantiate it only for kernel threads so it doesn't pollute icache
and dcache much. 4KB realink limit should be enough for kthreads.

Now I'm probably obligated to find such a broken userspace tool...
