Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932690AbeEaChK convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 22:37:10 -0400
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:33074 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932620AbeEaChI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 22:37:08 -0400
X-Iguazu-Qid: 2wGqoE3kiwjayAECJ7
X-Iguazu-QSIG: v=1; s=0; t=1527734209; q=2wGqoE3kiwjayAECJ7; m=2XfrqkSImq9DPsvxyRae1Mtg8YVpeAeJPZjBiHmR0xI=
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Cc: <stable@vger.kernel.org>, "'Davidlohr Bueso'" <dbueso@suse.de>,
        "'Joe Lawrence'" <joe.lawrence@redhat.com>,
        "'Andrea Arcangeli'" <aarcange@redhat.com>,
        "'Manfred Spraul'" <manfred@colorfullife.com>,
        "'Andrew Morton'" <akpm@linux-foundation.org>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>
References: <20180528100202.045206534@linuxfoundation.org> <20180528100203.357731085@linuxfoundation.org>
In-Reply-To: <20180528100203.357731085@linuxfoundation.org>
Subject: RE: [PATCH 4.4 011/268] Revert "ipc/shm: Fix shmat mmap nil-page protection"
Date: Thu, 31 May 2018 11:36:46 +0900
X-TSB-HOP: ON
Message-ID: <005601d3f888$37f266f0$a7d734d0$@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIIWZ/WGnaRCO8XjPKf6QObGDbsxQGPOkpho9PiK/A=
Content-Language: ja
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: stable-owner@vger.kernel.org [mailto:stable-owner@vger.kernel.org] On
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Davidlohr Bueso <dave@stgolabs.net>
> 
> commit a73ab244f0dad8fffb3291b905f73e2d3eaa7c00 upstream.
> 
> Patch series "ipc/shm: shmat() fixes around nil-page".

Sorry for being a bit late (the pace is really fast here).

I have found a regression from 4.4.133-rc1 to 4.4.134-rc1 using Fuego LTP wrapper.

4.4.134-rc1
	tst_test.c:982: INFO: Timeout per run is 0h 05m 00s
	cve-2017-5669.c:62: INFO: Attempting to attach shared memory to null page
	cve-2017-5669.c:74: INFO: Mapped shared memory to (nil)
	cve-2017-5669.c:78: FAIL: We have mapped a VM address within the first 64Kb
	cve-2017-5669.c:84: INFO: Touching shared memory to see if anything strange happens

4.4.133-rc1:
	tst_test.c:982: INFO: Timeout per run is 0h 05m 00s
	cve-2017-5669.c:62: INFO: Attempting to attach shared memory to null page
	cve-2017-5669.c:67: PASS: shmat returned EINVAL

The culprits should be one or both of the two last commits to ipc/shm (one of them a revert).

- ipc/shm: fix shmat() nil address after round-down when remapping
- Revert "ipc/shm: Fix shmat mmap nil-page protection"

I need to investigate the concrete reason, but for now I just wanted to report it.

Thanks,
Daniel









> 
> These patches fix two issues reported[1] a while back by Joe and Andrea
> around how shmat(2) behaves with nil-page.
> 
> The first reverts a commit that it was incorrectly thought that mapping
> nil-page (address=0) was a no no with MAP_FIXED.  This is not the case,
> with the exception of SHM_REMAP; which is address in the second patch.
> 
> I chose two patches because it is easier to backport and it explicitly
> reverts bogus behaviour.  Both patches ought to be in -stable and ltp
> testcases need updated (the added testcase around the cve can be
> modified to just test for SHM_RND|SHM_REMAP).
> 
> [1] lkml.kernel.org/r/20180430172152.nfa564pvgpk3ut7p@linux-n805
> 
> This patch (of 2):
> 
> Commit 95e91b831f87 ("ipc/shm: Fix shmat mmap nil-page protection")
> worked on the idea that we should not be mapping as root addr=0 and
> MAP_FIXED.  However, it was reported that this scenario is in fact
> valid, thus making the patch both bogus and breaks userspace as well.
> 
> For example X11's libint10.so relies on shmat(1, SHM_RND) for lowmem
> initialization[1].
> 
> [1]
> https://cgit.freedesktop.org/xorg/xserver/tree/hw/xfree86/os-support/linux/int1
> 0/linux.c#n347
> Link: http://lkml.kernel.org/r/20180503203243.15045-2-dave@stgolabs.net
> Fixes: 95e91b831f87 ("ipc/shm: Fix shmat mmap nil-page protection")
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
> Reported-by: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Manfred Spraul <manfred@colorfullife.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  ipc/shm.c |    9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -1113,13 +1113,8 @@ long do_shmat(int shmid, char __user *sh
>  		goto out;
>  	else if ((addr = (ulong)shmaddr)) {
>  		if (addr & (shmlba - 1)) {
> -			/*
> -			 * Round down to the nearest multiple of shmlba.
> -			 * For sane do_mmap_pgoff() parameters, avoid
> -			 * round downs that trigger nil-page and MAP_FIXED.
> -			 */
> -			if ((shmflg & SHM_RND) && addr >= shmlba)
> -				addr &= ~(shmlba - 1);
> +			if (shmflg & SHM_RND)
> +				addr &= ~(shmlba - 1);  /* round down */
>  			else
>  #ifndef __ARCH_FORCE_SHMLBA
>  				if (addr & ~PAGE_MASK)
> 
> 
