Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755995AbeDZNWQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:22:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755074AbeDZNWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:22:13 -0400
Date: Thu, 26 Apr 2018 21:22:04 +0800
From: Baoquan He <bhe@redhat.com>
To: Borislav Petkov <bp@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        robh+dt@kernel.org, dan.j.williams@intel.com, nicolas.pitre@linaro.org,
        josh@joshtriplett.org, Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v3 2/3] resource: add walk_system_ram_res_rev()
Message-ID: <20180426132204.GF19030@localhost.localdomain>
References: <20180419001848.3041-1-bhe@redhat.com>
 <20180419001848.3041-3-bhe@redhat.com>
 <20180419100745.GC3896@pd.tnic>
 <20180426085649.GC18395@localhost.localdomain>
 <20180426110905.GH15043@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426110905.GH15043@pd.tnic>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/18 at 01:09pm, Borislav Petkov wrote:
> On Thu, Apr 26, 2018 at 04:56:49PM +0800, Baoquan He wrote:
> > Sorry for that, I just ran scripts/get_maintainer.pl to get expert's
> > name and added them into each patch. The reason this change is made is
> > in patch 3/3. Test robot reported a code bug on the latest kernel, will
> > repost and CC everyone in all patches.
> > 
> > 
> > Rob Herring asked the same question in v2, I explained to him. The
> > discussion can be found here:
> > https://lkml.org/lkml/2018/4/10/484
> 
> ... and when I open that link, the first paragraph says:
> 
> "This is the explanation I made when Andrew helped to review the v1 post:
> https://lkml.org/lkml/2018/3/23/78"
> 
> Do you see the absurdity of the link chasing of your explanation?!
> 
> Instead, the explanation *WHY* should be in the commit message of the
> patch - not in mail replies when people ask you about it.

It is in patch 3/3 and cover-letter. I often received one or several
patches of a big patchset. As I said, I used ./scripts/get_maintainer.pl
to each patch's reviewers, and will add all people in CC list.

> 
> Also, do not use lkml.org when referencing a mail on lkml but
> use the Message-ID of the header. We have a proper redirector at
> https://lkml.kernel.org/r/<Message-ID>

I noticed maintainers merged patches with this Message-ID, could you
tell how to get this Message-ID?

> 
> Now lemme read the reason finally...
> 
> "We need unify these two interfaces on behaviour since they are the same
> on essense from the users' point of view... "
> 
> That's not a good enough reason for me to cause code churn. If the only
> reason is: because the one does it top-down and the other bottom-up, I'm
> not convinced.

We have been using this top-down way for x86 64 since earlier 2013 in
the KEXEC loading with command:

	'kexec -l bzImage --initrd initramfs-xx.img'

Two years later, Vivek added a new KEXEC_FILE loading, and most of job
is done in kernel because we need do kernel image sinature verification.
The KEXEC_FILE loading mostly is used in secure boot machine. Although
more and more users like to take secure boot machine, system using KEXEC
loading are still much more. I ever asked our kernel QE who takes care
of kernel and kdump testing, they said in their testing systems, the
proportion of legacy system vs system with secure boot is 10:1.

Before long I pinged hpa, Vivek and Yinghai who discussed and wrote the
code for KEXEC loading in x86 64, asked them about the reaon they chose
top-down, no reply from them. I guess they probably worried that low
memory under 4G are mostly reserved by system or firmware, even though
kexec/kdump have tried very hard to avoid each of them if recognized,
any missed one will cause loading and booting failure. Just a guess.

In fact, there's no spec or doc to tell which one is right or not.
So I finally decide to take the same top-down way for KEXEC_FILE loading
because on statistics KEXEC loading is used longer and wider.

This is not a thing that one is top down, the other is bottom up. For
us, they might be so different on details of code, for customers, they
just think them as a same thing. They may say I just get a new machine,
and still do kexec loading, why these top-down, bottom-up things come
up.

And this is not causing code churn. You can see that by replacing
pointer operation with list_head, code in kernel/resource.c related to
child list iteration is much easier to read, e.g __request_resource(),
__release_resource(). As Rob said in v2 reviewing, they have put
the same replacing in DT struct device_node in todo list, and ACPI tree
function in drivers/acpi/acpica/pstree.c too. I think this is why Andrew
asked to try this way and see what the patches looks like.

Thanks
Baoquan
