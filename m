Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934163AbeEWTK2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:10:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933928AbeEWTK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:10:27 -0400
Date: Wed, 23 May 2018 15:10:22 -0400
From: Luiz Capitulino <lcapitulino@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        keescook@chromium.org, tglx@linutronix.de, x86@kernel.org,
        hpa@zytor.com, fanc.fnst@cn.fujitsu.com, yasu.isimatu@gmail.com,
        indou.takao@jp.fujitsu.com, douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH 0/2] x86/boot/KASLR: Skip specified number of 1GB huge
 pages when do physical randomization
Message-ID: <20180523151022.102e3565@doriath>
In-Reply-To: <20180518112836.GS24627@MiWiFi-R3L-srv>
References: <20180516100532.14083-1-bhe@redhat.com>
        <20180518070046.GA18660@gmail.com>
        <20180518074359.GR24627@MiWiFi-R3L-srv>
        <20180518081919.GB11379@gmail.com>
        <20180518112836.GS24627@MiWiFi-R3L-srv>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2018 19:28:36 +0800
Baoquan He <bhe@redhat.com> wrote:

> > Note that it's not KASLR specific: if we had some other kernel feature that tried 
> > to allocate a piece of memory from what appears to be perfectly usable generic RAM 
> > we'd have the same problems!  
> 
> Hmm, this may not be the situation for 1GB huge pages. For 1GB huge
> pages, the bug is that on KVM guest with 4GB ram, when user adds
> 'default_hugepagesz=1G hugepagesz=1G hugepages=1' to kernel
> command-line, if 'nokaslr' is specified, they can get 1GB huge page
> allocated successfully. If remove 'nokaslr', namely KASLR is enabled,
> the 1GB huge page allocation failed.

Let me clarify that this issue is not specific to KVM in any way. The same
issue happens on bare-metal, but if you have lots of memory you'll hardly
notice it. On the other hand, it's common to create KVM guests with a few
GBs of memory. In those guests, you may not be able to get a 1GB hugepage
at all if kaslr is enabled.

This series is a simple fix for this bug. It hooks up into already existing
KASLR code that scans memory regions to be avoided. The memory hotplug
issue is left for another day.

Now, if I understand what Ingo is saying is that he wants to see all problems
solved with a generic solution vs. a specific solution for each problem.
