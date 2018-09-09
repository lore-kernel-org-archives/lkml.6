Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B48C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC572064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC572064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeIJIE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:04:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbeIJIE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:04:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AFAFE40203F1;
        Sun,  9 Sep 2018 23:33:13 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 85FB22166BA3;
        Sun,  9 Sep 2018 23:33:12 +0000 (UTC)
Date:   Mon, 10 Sep 2018 07:33:09 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>, x86@kernel.org
Subject: Re: [PATCH 0/3] x86/boot/KASLR: enhance randomness of kernel load
 addr when using GiB hugepage
Message-ID: <20180909233309.GU1740@192.168.1.3>
References: <1536201382-13133-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536201382-13133-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sun, 09 Sep 2018 23:33:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Sun, 09 Sep 2018 23:33:13 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pingfan,

On 09/06/18 at 10:36am, Pingfan Liu wrote:
> commit 747ff6265db4 ("x86/boot/KASLR: Skip specified number of 1GB huge
> pages when doing physical randomization (KASLR)") and commit
> 9b912485e0e7 ("x86/boot/KASLR: Add two new functions for 1GB huge pages
> handling") prevent the physical load addr of kernel from spoiling a good
> candidate of GiB page. But the algorithm deterministicly chooses the most
> front GiB page for hugetlb, and sacrifices the randomness, which
> is the heart of the KASLR. This patch tries to enlarge the randomness in
> the cases where hugepages=X < the num Y of good candidate of GiB
> page.

Better tell how you improve in cover letter or patch log.

> To comparison, taking a typical KVM guest for example, the head 3GiB mem
> can not be used as GiB hugetlb. Denoting the total mem size as Z(GiB), when
> Z=5, then Y=2, assuming X=1, the randomness range before this patch is
> 4GiB, after this patch is 5GiB, and get a 25% improvement of randomness.
> If Z=6, then Y=3, assuming X=2, the improvement equals: 50%( 6/(6-2) - 1);
> assuming X=1, the improvement will be: 20% (6/(6-1) - 1)

Hmm, what if hugepages=1, or 2, even 100, but system owns 1PB memory?

Secondly, even in the case that hugepages=1, system memory is 5G, if no
'movable_node' specified, the last 1G can't be chosen for hugepage.
Because memblock will allocate memory top to down. This is not
improving, but make the code not work.

Lastly, getting better randomness is the heart of KASLR, while
process_mem_region() is the heart of kernel KASLR code. Unless the
current code blocks serious fix, we'd better not touch it. Keeping
it can make the current code logic simple and more readable. It's
like a proved running well machine, we just dig out the unwanted
middle, feed the good head and tail regions into it, then it gives
back good slot for kernel position one by one.

To sum up, I personally think this patchset is not a good idea.

Thanks
Baoquan
