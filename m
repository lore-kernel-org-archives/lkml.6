Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936629AbeE2PIA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:08:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42412 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935285AbeE2PHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:07:55 -0400
Date: Tue, 29 May 2018 16:08:23 +0100
From: Will Deacon <will.deacon@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>, austinwc@codeaurora.org,
        tnowicki@caviumnetworks.com, Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, Morten.Rasmussen@arm.com,
        vkilari@codeaurora.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        jhugo@codeaurora.org, Al Stone <ahs3@redhat.com>,
        Len Brown <lenb@kernel.org>, John Garry <john.garry@huawei.com>,
        wangxiongfeng2@huawei.com, Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v9 00/12] Support PPTT for ARM64
Message-ID: <20180529150823.GD17159@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180517170523.h7tuvbzdfluuidcz@armageddon.cambridge.arm.com>
 <CAMuHMdWJWj3a0MZgEi7VJTUJRNoeR+X3eoN8A-sW6fwimEr6Fg@mail.gmail.com>
 <09fb3fe7-d703-43f1-74f7-f8cb5ff1f67a@arm.com>
 <CAMuHMdXgiMeD4uF+j8W+CpNwYYK2W_8xqk_=vGBiW=bUvKeq7w@mail.gmail.com>
 <551905a6-eaa8-97df-06ec-1ceedfbc164f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <551905a6-eaa8-97df-06ec-1ceedfbc164f@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 02:18:40PM +0100, Sudeep Holla wrote:
> On 29/05/18 12:56, Geert Uytterhoeven wrote:
> > On Tue, May 29, 2018 at 1:14 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >> On 29/05/18 11:48, Geert Uytterhoeven wrote:
> >>> System supend still works fine on systems with big cores only:
> >>>
> >>>     R-Car H3 ES1.0 (4xCA57 (4xCA53 disabled in firmware))
> >>>     R-Car M3-N (2xCA57)
> >>>
> >>> Reverting this commit fixes the issue for me.
> >>
> >> I can't find anything that relates to system suspend in these patches
> >> unless they are messing with something during CPU hot plug-in back
> >> during resume.
> > 
> > It's only the last patch that introduces the breakage.
> > 
> 
> As specified in the commit log, it won't change any behavior for DT
> systems if it's non-NUMA or single node system. So I am still wondering
> what could trigger this regression.

I wonder if we're somehow giving an uninitialised/invalid NUMA configuration
to the scheduler, although I can't see how this would happen.

Geert -- if you enable CONFIG_DEBUG_PER_CPU_MAPS=y and apply the diff below
do you see anything shouting in dmesg?

Will

--->8

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index dad128ba98bf..e3de033339b4 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -58,7 +58,7 @@ EXPORT_SYMBOL(node_to_cpumask_map);
  */
 const struct cpumask *cpumask_of_node(int node)
 {
-	if (WARN_ON(node >= nr_node_ids))
+	if (WARN_ON((unsigned)node >= nr_node_ids))
 		return cpu_none_mask;
 
 	if (WARN_ON(node_to_cpumask_map[node] == NULL))
