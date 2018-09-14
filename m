Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F385FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4320B20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4320B20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeINUg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:36:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbeINUg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:36:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1937307CF58;
        Fri, 14 Sep 2018 15:21:29 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-40.phx2.redhat.com [10.3.112.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B6B26531A;
        Fri, 14 Sep 2018 15:21:26 +0000 (UTC)
Date:   Fri, 14 Sep 2018 11:16:43 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     omosnace@redhat.com, linux-audit@redhat.com, sgrubb@redhat.com,
        mlichvar@redhat.com, john.stultz@linaro.org, tglx@linutronix.de,
        sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ghak10 v5 1/2] audit: Add functions to log time
 adjustments
Message-ID: <20180914151643.gwvm5te4nvion5ex@madcap2.tricolour.ca>
References: <20180824120001.20771-1-omosnace@redhat.com>
 <20180824120001.20771-2-omosnace@redhat.com>
 <CAHC9VhTZkrmgt7rxNYWTgYvm+TVGgRD6iFu9dDtZ7eYNXBKqHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTZkrmgt7rxNYWTgYvm+TVGgRD6iFu9dDtZ7eYNXBKqHQ@mail.gmail.com>
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 14 Sep 2018 15:21:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-13 23:18, Paul Moore wrote:
> On Fri, Aug 24, 2018 at 8:00 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > This patch adds two auxiliary record types that will be used to annotate
> > the adjtimex SYSCALL records with the NTP/timekeeping values that have
> > been changed.
> >
> > Next, it adds two functions to the audit interface:
> >  - audit_tk_injoffset(), which will be called whenever a timekeeping
> >    offset is injected by a syscall from userspace,
> >  - audit_ntp_adjust(), which will be called whenever an NTP internal
> >    variable is changed by a syscall from userspace.
> >
> > Quick reference for the fields of the new records:
> >     AUDIT_TIME_INJOFFSET
> >         sec - the 'seconds' part of the offset
> >         nsec - the 'nanoseconds' part of the offset
> >     AUDIT_TIME_ADJNTPVAL
> >         op - which value was adjusted:
> >             offset - corresponding to the time_offset variable
> >             freq   - corresponding to the time_freq variable
> >             status - corresponding to the time_status variable
> >             adjust - corresponding to the time_adjust variable
> >             tick   - corresponding to the tick_usec variable
> >             tai    - corresponding to the timekeeping's TAI offset
> 
> I understand that reusing "op" is tempting, but the above aren't
> really operations, they are state variables which are being changed.
> Using the CONFIG_CHANGE record as a basis, I wonder if we are better
> off with something like the following:
> 
>  type=TIME_CHANGE <var>=<value_new> old=<value_old>
> 
> ... you might need to preface the variable names with something like
> "ntp_" or "offset_".  You'll notice I'm also suggesting we use a
> single record type here; is there any reason why two records types are
> required?

Why not do something like:

	 type=TIME_CHANGE var=<var> new=<value_new> old=<value_old>

So that we don't pollute the field namespace *and* create 8 variants on
the same record format?  This shouldn't be much of a concern with binary
record formats, but we're stuck with the current parsing scheme for now.

> >         old - the old value
> >         new - the new value
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  include/linux/audit.h      | 21 +++++++++++++++++++++
> >  include/uapi/linux/audit.h |  2 ++
> >  kernel/auditsc.c           | 15 +++++++++++++++
> >  3 files changed, 38 insertions(+)
> 
> A reminder that we need tests for these new records and a RFE page on the wiki:
> 
> * https://github.com/linux-audit/audit-testsuite
> * https://github.com/linux-audit/audit-kernel/wiki
> 
> -- 
> paul moore
> www.paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
