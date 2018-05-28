Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754379AbeE1JyY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:54:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754173AbeE1JyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:54:23 -0400
Date: Mon, 28 May 2018 17:54:18 +0800
From: Baoquan He <bhe@redhat.com>
To: Ingo Molnar <mingo@kernel.org>,
        Luiz Capitulino <lcapitulino@redhat.com>
Cc: linux-kernel@vger.kernel.org, keescook@chromium.org,
        tglx@linutronix.de, x86@kernel.org, hpa@zytor.com,
        fanc.fnst@cn.fujitsu.com, yasu.isimatu@gmail.com,
        indou.takao@jp.fujitsu.com, douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH 0/2] x86/boot/KASLR: Skip specified number of 1GB huge
 pages when do physical randomization
Message-ID: <20180528095418.GD31261@MiWiFi-R3L-srv>
References: <20180516100532.14083-1-bhe@redhat.com>
 <20180518070046.GA18660@gmail.com>
 <20180518074359.GR24627@MiWiFi-R3L-srv>
 <20180518081919.GB11379@gmail.com>
 <20180518112836.GS24627@MiWiFi-R3L-srv>
 <20180523151022.102e3565@doriath>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523151022.102e3565@doriath>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/23/18 at 03:10pm, Luiz Capitulino wrote:
> On Fri, 18 May 2018 19:28:36 +0800
> Baoquan He <bhe@redhat.com> wrote:
> 
> > > Note that it's not KASLR specific: if we had some other kernel feature that tried 
> > > to allocate a piece of memory from what appears to be perfectly usable generic RAM 
> > > we'd have the same problems!  
> > 
> > Hmm, this may not be the situation for 1GB huge pages. For 1GB huge
> > pages, the bug is that on KVM guest with 4GB ram, when user adds
> > 'default_hugepagesz=1G hugepagesz=1G hugepages=1' to kernel
> > command-line, if 'nokaslr' is specified, they can get 1GB huge page
> > allocated successfully. If remove 'nokaslr', namely KASLR is enabled,
> > the 1GB huge page allocation failed.
> 
> Let me clarify that this issue is not specific to KVM in any way. The same
> issue happens on bare-metal, but if you have lots of memory you'll hardly
> notice it. On the other hand, it's common to create KVM guests with a few
> GBs of memory. In those guests, you may not be able to get a 1GB hugepage
> at all if kaslr is enabled.
> 
> This series is a simple fix for this bug. It hooks up into already existing
> KASLR code that scans memory regions to be avoided. The memory hotplug
> issue is left for another day.

Exactly. 

This issue is about kernel being randomized into good 1GB huge pages to
break later huge page allocation, and we can only scan memory to know
where 1GB huge page is located and avoid them.

The memory hotplug issue is about kernel being randomized into movable
memory regions, and we need read ACPI SRAT table to retrieve the
attribute of memory regions to know if it's movable, then avoid it if
yes.

> 
> Now, if I understand what Ingo is saying is that he wants to see all problems
> solved with a generic solution vs. a specific solution for each problem.

Hmm, if we understand Ingo's words correctly, for these two issues,
seems there isn't a generic solution to solve both of them. We can only
fix them separately.

Hi Ingo,

Ping!

Not sure if my above understanding is correct. Could you confirm if I
have understood your comments and if the solution of this patchset is
right?

Thanks
Baoquan
