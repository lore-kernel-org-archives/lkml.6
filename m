Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934378AbeE2N1q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:27:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934320AbeE2N1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:27:42 -0400
Date: Tue, 29 May 2018 09:27:37 -0400
From: Luiz Capitulino <lcapitulino@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        keescook@chromium.org, tglx@linutronix.de, x86@kernel.org,
        hpa@zytor.com, fanc.fnst@cn.fujitsu.com, yasu.isimatu@gmail.com,
        indou.takao@jp.fujitsu.com, douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH 0/2] x86/boot/KASLR: Skip specified number of 1GB huge
 pages when do physical randomization
Message-ID: <20180529092737.10a8138b@doriath>
In-Reply-To: <20180528095418.GD31261@MiWiFi-R3L-srv>
References: <20180516100532.14083-1-bhe@redhat.com>
        <20180518070046.GA18660@gmail.com>
        <20180518074359.GR24627@MiWiFi-R3L-srv>
        <20180518081919.GB11379@gmail.com>
        <20180518112836.GS24627@MiWiFi-R3L-srv>
        <20180523151022.102e3565@doriath>
        <20180528095418.GD31261@MiWiFi-R3L-srv>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2018 17:54:18 +0800
Baoquan He <bhe@redhat.com> wrote:

> On 05/23/18 at 03:10pm, Luiz Capitulino wrote:
> > On Fri, 18 May 2018 19:28:36 +0800
> > Baoquan He <bhe@redhat.com> wrote:
> >   
> > > > Note that it's not KASLR specific: if we had some other kernel feature that tried 
> > > > to allocate a piece of memory from what appears to be perfectly usable generic RAM 
> > > > we'd have the same problems!    
> > > 
> > > Hmm, this may not be the situation for 1GB huge pages. For 1GB huge
> > > pages, the bug is that on KVM guest with 4GB ram, when user adds
> > > 'default_hugepagesz=1G hugepagesz=1G hugepages=1' to kernel
> > > command-line, if 'nokaslr' is specified, they can get 1GB huge page
> > > allocated successfully. If remove 'nokaslr', namely KASLR is enabled,
> > > the 1GB huge page allocation failed.  
> > 
> > Let me clarify that this issue is not specific to KVM in any way. The same
> > issue happens on bare-metal, but if you have lots of memory you'll hardly
> > notice it. On the other hand, it's common to create KVM guests with a few
> > GBs of memory. In those guests, you may not be able to get a 1GB hugepage
> > at all if kaslr is enabled.
> > 
> > This series is a simple fix for this bug. It hooks up into already existing
> > KASLR code that scans memory regions to be avoided. The memory hotplug
> > issue is left for another day.  
> 
> Exactly. 
> 
> This issue is about kernel being randomized into good 1GB huge pages to
> break later huge page allocation, and we can only scan memory to know
> where 1GB huge page is located and avoid them.
> 
> The memory hotplug issue is about kernel being randomized into movable
> memory regions, and we need read ACPI SRAT table to retrieve the
> attribute of memory regions to know if it's movable, then avoid it if
> yes.

Makes sense. Since the KASLR code already scans memory regions looking
for regions to skip and since this series just uses that, I think this
is a good solution to the problem:

Reviewed-and-Tested-by: Luiz Capitulino <lcapitulino@redhat.com>

> 
> > 
> > Now, if I understand what Ingo is saying is that he wants to see all problems
> > solved with a generic solution vs. a specific solution for each problem.  
> 
> Hmm, if we understand Ingo's words correctly, for these two issues,
> seems there isn't a generic solution to solve both of them. We can only
> fix them separately.
> 
> Hi Ingo,
> 
> Ping!
> 
> Not sure if my above understanding is correct. Could you confirm if I
> have understood your comments and if the solution of this patchset is
> right?
> 
> Thanks
> Baoquan
> 
