Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E0CC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1834020846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQZ4qZua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1834020846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeGZDSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:18:25 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46263 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbeGZDSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:18:25 -0400
Received: by mail-pl0-f66.google.com with SMTP id t17-v6so65250ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2uIQwqz4sB9vNaQrv3GLNxBcdFu/6MR+wE4FHfmcsTU=;
        b=kQZ4qZuaKUf108W/L2lHT6U9zhCZFJqs5Z0dmltWstsDq8qT43amfR/jHVbEYBjMld
         6d6XiFTj6G3ZNUapZp3ekM+AdCeTJ5qBV2gK3eq0KDEH++EB5MA4r0A3Bz68fLu4XmLh
         5vJiQE9wy3wzfbbNVClkyg5zK+Tev5FfKBtw2cqbnh1Zy+NMD+befOtiesUQnMOkzMY4
         /6qHosAsnIJF2/92PjP4lM89SC05bEqoDZGe0JEZZv7puQ170NpHlM0dl5NuaoQcqTmH
         JJmsa0jvzoD98GnnIN7KO9OgnTnPgEyRMnO4FOcH1JMCq4p2yPscf1MzFmwCQteC00Vj
         aUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2uIQwqz4sB9vNaQrv3GLNxBcdFu/6MR+wE4FHfmcsTU=;
        b=ORJgc1i+wdRrIFriOl0g8xDttX2J9EcyaShxo3EJc5b+8OoX0hYnMydQSpojBhRRsi
         4050S8bwrmIFpsnbi5c0PQf4J0esEiVfOfuUU+WSTJ1B6nHyZ7d1YkWKAUlAyEg7ZMjB
         UukAR57qkBYnNNFV5pKIOEdZ8MVw4tiSiwUDwsH5fo8XNPgs8ZEw9GPTUEDLtYDrl+x1
         GHZ86Bxb8OPeUtB8uUhWz6tlDnM8rkd0xTS4jKS9zEXhwlVEfLNL1UwbALpG1HImWGrf
         IU+dxcKQubXdVXvkK/ulYD9Y5sLxjJ9g0pjGBRcBsuz9MblrENc6wUd6PKyblHM7tKFS
         +LuQ==
X-Gm-Message-State: AOUpUlEBBf92L4jIR8hVaAsN1qA6QFBMlyin3CBMhVr18sAGHQAQjvEe
        ICBvwT50NqamyFf8Ulzkwhc=
X-Google-Smtp-Source: AAOMgpek3fB93tqElUWWTsuY+F4sTz9OJL2Nrr9y1VR8ISGoAMp/5TJsq6dZLIiEvtP8Swql4QHMUw==
X-Received: by 2002:a17:902:7795:: with SMTP id o21-v6mr41627pll.2.1532570637104;
        Wed, 25 Jul 2018 19:03:57 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id t78-v6sm34327pfa.160.2018.07.25.19.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 19:03:55 -0700 (PDT)
Date:   Thu, 26 Jul 2018 11:03:51 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Tino Lehnig <tino.lehnig@contabo.de>
Cc:     ngupta@vflare.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Zram writeback feature unstable with heavy swap utilization -
 BUG: Bad page state in process...
Message-ID: <20180726020351.GA221405@rodete-desktop-imager.corp.google.com>
References: <0516ae2d-b0fd-92c5-aa92-112ba7bd32fc@contabo.de>
 <20180724010342.GA195675@rodete-desktop-imager.corp.google.com>
 <d4f4b5a1-9e31-375d-0599-b6d8b0ebc9df@contabo.de>
 <20180725132126.GA2893@rodete-laptop-imager.corp.google.com>
 <d07348bb-3102-30f0-d138-de23449e23df@contabo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d07348bb-3102-30f0-d138-de23449e23df@contabo.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tino,

On Wed, Jul 25, 2018 at 05:12:13PM +0200, Tino Lehnig wrote:
> Hi,
> 
> On 07/25/2018 03:21 PM, Minchan Kim wrote:
> > It would be much helpful if you could check more versions with git-bisect.
> 
> I started bisecting today, but my results are not conclusive yet. It is
> certain that the problem started with 4.15 though. I have not encountered

A thing I could imagine is 
[0bcac06f27d75, skip swapcache for swapin of synchronous device]
It was merged into v4.15. Could you check it by bisecting?

With enabling writeback feature of zram, it's no more synchonous device
so it could affect the unresponsive symptom you are seeing now.
I should disable synchronous flag when the zram works with writeback feature.

However, I should still see why the PG_uptodate WARN turning on.
I guess there are some places where assume all of anonymous pages have
PG_swapbacked and !PG_dirty are in swapcache so reference accounting could
be corrupted.

> the bug message in 4.15-rc1 so far, but the kvm processes always became
> unresponsive after hitting swap and could not be killed there. I saw the
> same behavior in rc2, rc3, and other builds in between, but the bad state
> bug would only trigger occasionally there. The behavior in 4.15.18 is the
> same as in newer kernels.
> 
> > I also want to reproduce it.
> > 
> > Today, I downloaded one window iso and execute it as cdrom with my owned
> > compiled kernel on KVM but I couldn't reproduce.
> > I also tested some heavy swap workload(kernel build with multiple CPU
> > on small memory) but I failed to reproduce, too.
> > 
> > Please could you told me your method more detail?
> 
> I found that running Windows in KVM really is the only reliable method,
> maybe because the zero pages are easily compressible. There is actually not
> a lot of disk utilization on the backing device when running this test.

Hmm, my testing was creating a tons of disk IO on backing device.
Maybe, that's why I couldn't reproduce a lot.
zero pages could never go to the writeback into the device so I don't
understand how such kinds of testing reprodcue the problem.
Anyway, I will try it again with zero pages with a few of random pages.

> 
> My operating system is a minimal install of Debian 9. I took the kernel
> configuration from the default Debian kernel and built my own kernel with
> "make oldconfig" leaving all settings at their defaults. The only thing I
> changed in the configuration was enabling the zram writeback feature.

You mean you changed host kernel configuration?

> 
> All my tests were done on bare-metal hardware with Xeon processors and lots
> of RAM. I encounter the bug quite quickly, but it still takes several GBs of
> swap usage. Below is my /proc/meminfo with enough KVM instances running (3
> in my case) to trigger the bug on my test machine.

Aha.. you did writeback feature into your bare-metal host machine and execute
kvm with window images as a guest. So, PG_uptodate warning happens on host side,
not guest? Right?

Thanks!

> 
> I will also try to reproduce the problem on some different hardware next.
> 
> --
> 
> MemTotal:       264033384 kB
> MemFree:         1232968 kB
> MemAvailable:          0 kB
> Buffers:            1152 kB
> Cached:             5036 kB
> SwapCached:        49200 kB
> Active:         249955744 kB
> Inactive:        5096148 kB
> Active(anon):   249953396 kB
> Inactive(anon):  5093084 kB
> Active(file):       2348 kB
> Inactive(file):     3064 kB
> Unevictable:           0 kB
> Mlocked:               0 kB
> SwapTotal:      1073741820 kB
> SwapFree:       938603260 kB
> Dirty:                68 kB
> Writeback:             0 kB
> AnonPages:      255007752 kB
> Mapped:             4708 kB
> Shmem:              1212 kB
> Slab:              88500 kB
> SReclaimable:      16096 kB
> SUnreclaim:        72404 kB
> KernelStack:        5040 kB
> PageTables:       765560 kB
> NFS_Unstable:          0 kB
> Bounce:                0 kB
> WritebackTmp:          0 kB
> CommitLimit:    1205758512 kB
> Committed_AS:   403586176 kB
> VmallocTotal:   34359738367 kB
> VmallocUsed:           0 kB
> VmallocChunk:          0 kB
> HardwareCorrupted:     0 kB
> AnonHugePages:  254799872 kB
> ShmemHugePages:        0 kB
> ShmemPmdMapped:        0 kB
> HugePages_Total:       0
> HugePages_Free:        0
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> Hugepagesize:       2048 kB
> DirectMap4k:       75136 kB
> DirectMap2M:    10295296 kB
> DirectMap1G:    260046848 kB
> 
> -- 
> Kind regards,
> 
> Tino Lehnig
