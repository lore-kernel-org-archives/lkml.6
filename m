Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23114C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCA927A50
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCA927A50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754858AbeF2SDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:03:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752987AbeF2SDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:03:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 477044074459;
        Fri, 29 Jun 2018 18:03:12 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3AE1111CB8C;
        Fri, 29 Jun 2018 18:03:10 +0000 (UTC)
Date:   Fri, 29 Jun 2018 20:03:08 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, shunyong.yang@hxt-semitech.com,
        yu.zheng@hxt-semitech.com, catalin.marinas@arm.com,
        will.deacon@arm.com
Subject: Re: [PATCH] arm64: acpi: reenumerate topology ids
Message-ID: <20180629180308.zdl4taihzv2zwarc@kamzik.brq.redhat.com>
References: <20180628145128.10057-1-drjones@redhat.com>
 <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
 <20180628173243.obydzakh2stfs26w@kamzik.brq.redhat.com>
 <20180629102927.GA18043@e107155-lin>
 <20180629112354.hefdl2pe72frl6x3@kamzik.brq.redhat.com>
 <20180629132934.GA16282@e107155-lin>
 <20180629154608.nqudibf54ti6dpjc@kamzik.brq.redhat.com>
 <30d56d70-6043-0ad7-4530-208fab18c8d4@arm.com>
 <20180629170334.3ab7ngru3abxcobf@kamzik.brq.redhat.com>
 <20180629172252.GA6906@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629172252.GA6906@e107155-lin>
User-Agent: NeoMutt/20180622
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 29 Jun 2018 18:03:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 29 Jun 2018 18:03:12 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'drjones@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 06:23:15PM +0100, Sudeep Holla wrote:
> On Fri, Jun 29, 2018 at 07:03:34PM +0200, Andrew Jones wrote:
> > On Fri, Jun 29, 2018 at 11:48:15AM -0500, Jeremy Linton wrote:
> [..]
> 
> > >
> > > If you want a human readable socket identifier that matches something
> > > stamped above the socket, that is what SMBIOS is for. Queue discussion about
> > > that tables reliability for functional ids. Either way, as the spec is
> > > written today (or any ECRs I've seen), your definitely not going to get both
> > > nice socket1, socket2, and cpu1, cpu2 out of the same PPTT/ACPIid name-space
> > > since the numerical id's conflict.
> > >
> >
> > If we don't expect the ACPI processor ID to be something useful to users,
> > then I'll revert back to lobbying for counters, as those arbitrary numbers
> > can't be less useful than arbitrary offsets and ACPI IDs, and, IMO, are
> > more likely to make users/user apps happy.
> >
> 
> I agree that ACPI processor ID may not be useful to the users, but providing
> some counter based ID which is highly dependent on the ordering the firmware
> table which can change between boots is highly inconsistent and unreliable
> and in some sense break user ABI. So I still NACK the counter based ID.
>

If the firmware tables change order between boots, then so will ACPI table
offsets - unless you mean only the leaf nodes may change order. Leaf nodes
would indeed keep the same ID (by using ACPI processor IDs), but when the
leaves are threads, those IDs aren't visible to the user anyway, as
thread-id is not in sysfs.

Anyway, what would be the harm if PE_x (PE not a thread) was identified by
the pair (1,1) on one boot and (1,2) on the second boot? It's still
clearly in the same package, and I don't believe there's any need nor
desire to allow a user to tell the difference between two peer PEs. Users
should never know that the core-id of a specific physical core changed,
nor should they care.

I'm racking my brain trying to think of scenario, maybe something with
elaborate cpu pinning, that could be affected, but can't see how. Please
provide an example. If you can, then we obviously need to modify how
the DT cpu-map is parsed, as DT boots would be vulnerable to the same
issue.

Thanks,
drew
