Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE16C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0688327426
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0688327426
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755253AbeF2QDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:03:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753435AbeF2QDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:03:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8BCF140201C7;
        Fri, 29 Jun 2018 16:03:10 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D9B0A1D081;
        Fri, 29 Jun 2018 16:03:08 +0000 (UTC)
Date:   Fri, 29 Jun 2018 18:03:06 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, shunyong.yang@hxt-semitech.com,
        yu.zheng@hxt-semitech.com, catalin.marinas@arm.com,
        will.deacon@arm.com
Subject: Re: [PATCH] arm64: acpi: reenumerate topology ids
Message-ID: <20180629160306.zdticyqs4rqvzw2g@kamzik.brq.redhat.com>
References: <20180628145128.10057-1-drjones@redhat.com>
 <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
 <d797ebc5-bd7b-4f72-d4fc-840ba7345a15@arm.com>
 <20180629105334.GB18043@e107155-lin>
 <20180629114227.4noje2kx3lcjbcpd@kamzik.brq.redhat.com>
 <20180629133849.GB16282@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629133849.GB16282@e107155-lin>
User-Agent: NeoMutt/20180622
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 29 Jun 2018 16:03:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 29 Jun 2018 16:03:10 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'drjones@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 02:38:49PM +0100, Sudeep Holla wrote:
> On Fri, Jun 29, 2018 at 01:42:27PM +0200, Andrew Jones wrote:
> > On Fri, Jun 29, 2018 at 11:53:34AM +0100, Sudeep Holla wrote:
> > > On Thu, Jun 28, 2018 at 12:12:00PM -0500, Jeremy Linton wrote:
> > > > Hi,
> > > > 
> > > > On 06/28/2018 11:30 AM, Sudeep Holla wrote:
> > > 
> > > [...]
> > > 
> > > > >I am not sure if we can ever guarantee that DT and ACPI will get the
> > > > >same ids whatever counter we use as it depends on the order presented in
> > > > >the firmware(DT or ACPI). So I am not for generating ids for core and
> > > > >threads in that way.
> > > > >
> > > > >So I would like to keep it simple and just have this counters for
> > > > >package ids as demonstrated in Shunyong's patch.
> > > >
> > > > So, currently on a non threaded system, the core id's look nice because they
> > > > are just the ACPI ids. Its the package id's that look strange, we could just
> > > > fix the package ids, but on threaded machines the threads have the nice acpi
> > > > ids, and the core ids are then funny numbers. So, I suspect that is driving
> > > > this as much as the strange package ids.
> > > >
> > > 
> > > Yes, I know that and that's what made be look at topology_get_acpi_cpu_tag
> > > For me, if the PPTT has valid ID, we should use that. Just becuase DT lacks
> > > it and uses counter doesn't mean ACPI also needs to follow that.
> > 
> > AFAIK, a valid ACPI UID doesn't need to be something derivable directly
> > from the hardware, so it's just as arbitrary as the CPU phandle that is
> > in the DT cpu-map, i.e. DT *does* have an analogous leaf node integer.
> >
> 
> Its platform specific, left to vendors to identify that. Are you referring
> to reg property in DT for leaf nodes ? If so, that's MPIDR and is present
> in ACPI MADT.

No, I'm referring to the 'cpu' node in the cpu-map, which is a phandle
pointing to a cpu node. The cpu node contains the reg with the MPIDR.
A phandle links one DT node to another, thus it's analogous to an ACPI
ID linkage.

However, after reading your last mail that indicates these "ACPI processor
IDs" may actually be derived from hardware - I guess by implementing the
_UID method and having that method extract it in some vendor-specific way,
then the analogy breaks down. A phandle is just a DT construct, while an
ID from an ACPI method may actually be a useful hardware locator address.

> 
> > >
> > > I am sure some vendor will put valid UID and expect that to be in the
> > > sysfs.
> >
> > I can't think of any reason that would be useful, especially when the
> > UID is for a thread, which isn't even displayed by sysfs.
> >
> 
> You are mixing MPIDR and UID here.

I wasn't talking about MPIDR at all. As I said above, I was was under the
impression the UID was not derived from hardware, i.e. only an ACPI
construct. If that's not the case, then it has more value than what I was
giving it before, but only when the valid flag is set.

And, since we have a [good?] chance that the valid flag won't be set,
then I still think we're better off with counters to keep the user API
consistent and unambiguous across systems. We should also keep a mapping
to these UIDs, though, when we have something valid to map to.

Thanks,
drew
