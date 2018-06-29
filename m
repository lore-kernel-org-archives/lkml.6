Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2327AC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE444275BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE444275BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966645AbeF2PqO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:46:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753159AbeF2PqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:46:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 68CF6401EF0C;
        Fri, 29 Jun 2018 15:46:12 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D0A081D081;
        Fri, 29 Jun 2018 15:46:10 +0000 (UTC)
Date:   Fri, 29 Jun 2018 17:46:08 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeremy.linton@arm.com, ard.biesheuvel@linaro.org,
        shunyong.yang@hxt-semitech.com, yu.zheng@hxt-semitech.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Subject: Re: [PATCH] arm64: acpi: reenumerate topology ids
Message-ID: <20180629154608.nqudibf54ti6dpjc@kamzik.brq.redhat.com>
References: <20180628145128.10057-1-drjones@redhat.com>
 <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
 <20180628173243.obydzakh2stfs26w@kamzik.brq.redhat.com>
 <20180629102927.GA18043@e107155-lin>
 <20180629112354.hefdl2pe72frl6x3@kamzik.brq.redhat.com>
 <20180629132934.GA16282@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629132934.GA16282@e107155-lin>
User-Agent: NeoMutt/20180622
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 29 Jun 2018 15:46:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 29 Jun 2018 15:46:12 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'drjones@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 02:29:34PM +0100, Sudeep Holla wrote:
> If it matters a lot, vendors must use UID for consistency. Since OS doesn't
> use those IDs for any particular reason, OS must not care.

That depends. If you look at how topology_logical_package_id() is used in
x86 code you'll see it gets used as an index to an array in a couple
places. If we don't remap arbitrary IDs to counters than we may miss out
on some opportunities to avoid lists.

Also, we're talking about what's visible to users. I think it's much more
likely to break a user app by exposing topology IDs that have values
greater than the linear CPU numbers (even though properly written apps
shouldn't expect them to be strictly <=), than the opposite.

> 
> > > 
> > > > >
> > > > > So I would like to keep it simple and just have this counters for
> > > > > package ids as demonstrated in Shunyong's patch.
> > > > >
> > > >
> > > > If we don't also handle cores when there are threads, then the cores
> > > > will also end up having weird IDs.
> > > >
> > > 
> > > Yes, but if PPTT says it has valid ID, I would prefer that over DT like
> > > generated.
> > 
> > Valid *ACPI* ID, which just means it's a guaranteed unique ACPI UID,
> > which isn't likely going to be anything useful to a user.
> > 
> 
> How is that different from OS generated one from user's perspective ?
> Vendors might assign sockets UID and he may help them to replace one.
> Having some generated counter based id is not helpful.

I agree with this. It's a good argument for maintaining a mapping of
package-id to id-physically-printed-on-a-package somewhere. To avoid
maintaining a mapping it could just be stored directly in
cpu_topology[cpu].package_id, but then how can we tell the difference
between a valid printed-on-package-id and an ACPI offset? We'd still
have to maintain additional state to determine if it's valid or not,
so we could just maintain a mapping instead.

Thanks,
drew
