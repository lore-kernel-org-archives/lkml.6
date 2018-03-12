Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeCLKKh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:10:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752096AbeCLKKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:10:36 -0400
Date: Mon, 12 Mar 2018 18:10:31 +0800
From: Baoquan He <bhe@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com,
        keescook@chromium.org, yasu.isimatu@gmail.com,
        indou.takao@jp.fujitsu.com, lcapitulino@redhat.com
Subject: Re: [PATCH v9 0/5] x86/KASLR: Add parameter
 kaslr_boot_mem=nn[KMG]@ss[KMG]
Message-ID: <20180312101031.GH18656@localhost.localdomain>
References: <20180228105105.11487-1-fanc.fnst@cn.fujitsu.com>
 <20180312093557.gxypr66vrbftz3v3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312093557.gxypr66vrbftz3v3@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On 03/12/18 at 10:35am, Ingo Molnar wrote:
> 
> * Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
> 
> > Long time no reply, rebase the patchset, change the parameter name
> > from 'kaslr_mem' to 'kaslr_boot_mem'. There's no more code change.
> > 
> > ***Background:
> > People reported that kaslr may randomly chooses some positions
> > which are located in movable memory regions. This will break memory
> > hotplug feature.
> 
> [...]
> 
> > ***Solutions:
> > Introduce a new kernel parameter 'kaslr_boot_mem=nn@ss' to let users to
> > specify the memory regions where kernel can be allowed to randomize
> > safely.
> 
> Manual solutions like that are pretty suboptimal to users, aren't they?
> 
> In what way does memory hotplug feature 'break'? Does it crash or misbehave? Or 
> simply does it not allow the movement of the affected memory region, while still 
> allowing the rest to be moved?

AFAIT, if kernel is randomized into the movable memory region, the
affected memory region can not be hot added/removed since it has kernel
data. Surely, the system can still work, the unaffected part still can
be moved. Still it will cause regression on memory hotplug.

Mainly we parse SRAT table to get the ranges of memory provided by
hot-added memory devices in initmem_init(), that's very late. During boot,
we don't know it. Chao ever posted patches to grab SRAT at decompressing
stage, the code is very complicated and not elegant, ACPI maintainer
NACKed that.

Thanks
Baoquan
