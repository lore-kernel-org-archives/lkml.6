Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF2BECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBFB2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBFB2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeIQTwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:52:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbeIQTwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:52:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C065811A9;
        Mon, 17 Sep 2018 14:24:57 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-40.phx2.redhat.com [10.3.112.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03D0078C1D;
        Mon, 17 Sep 2018 14:24:49 +0000 (UTC)
Date:   Mon, 17 Sep 2018 10:20:00 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ghak10 v5 1/2] audit: Add functions to log time
 adjustments
Message-ID: <20180917142000.akpg7ul4jufujo4o@madcap2.tricolour.ca>
References: <20180824120001.20771-1-omosnace@redhat.com>
 <20180824120001.20771-2-omosnace@redhat.com>
 <CAHC9VhTZkrmgt7rxNYWTgYvm+TVGgRD6iFu9dDtZ7eYNXBKqHQ@mail.gmail.com>
 <CAFqZXNuir-8TE7WUHYhw5t446THO=sCjOXv+WAxNDs79e6OTWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNuir-8TE7WUHYhw5t446THO=sCjOXv+WAxNDs79e6OTWQ@mail.gmail.com>
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 17 Sep 2018 14:24:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-17 14:38, Ondrej Mosnacek wrote:
> On Fri, Sep 14, 2018 at 5:19 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Aug 24, 2018 at 8:00 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > This patch adds two auxiliary record types that will be used to annotate
> > > the adjtimex SYSCALL records with the NTP/timekeeping values that have
> > > been changed.
> > >
> > > Next, it adds two functions to the audit interface:
> > >  - audit_tk_injoffset(), which will be called whenever a timekeeping
> > >    offset is injected by a syscall from userspace,
> > >  - audit_ntp_adjust(), which will be called whenever an NTP internal
> > >    variable is changed by a syscall from userspace.
> > >
> > > Quick reference for the fields of the new records:
> > >     AUDIT_TIME_INJOFFSET
> > >         sec - the 'seconds' part of the offset
> > >         nsec - the 'nanoseconds' part of the offset
> > >     AUDIT_TIME_ADJNTPVAL
> > >         op - which value was adjusted:
> > >             offset - corresponding to the time_offset variable
> > >             freq   - corresponding to the time_freq variable
> > >             status - corresponding to the time_status variable
> > >             adjust - corresponding to the time_adjust variable
> > >             tick   - corresponding to the tick_usec variable
> > >             tai    - corresponding to the timekeeping's TAI offset
> >
> > I understand that reusing "op" is tempting, but the above aren't
> > really operations, they are state variables which are being changed.
> 
> I remember Steve (or was it Richard?) convincing me at one of the
> meetings that "op" is the right filed name to use, despite it not
> being a name for an operation... But I don't really care, I'm okay
> with changing it to e.g. "var" as Richard suggests later in this
> thread.
> 
> > Using the CONFIG_CHANGE record as a basis, I wonder if we are better
> > off with something like the following:
> >
> >  type=TIME_CHANGE <var>=<value_new> old=<value_old>
> >
> > ... you might need to preface the variable names with something like
> > "ntp_" or "offset_".  You'll notice I'm also suggesting we use a
> > single record type here; is there any reason why two records types are
> > required?
> 
> There are actually two reasons:
> 1. The injected offset is a timespec64, so it consists of two integer
> values (and it would be weird to produce two records for it, since IMO
> it is conceptually still a single variable).
> 2. In all other cases the variable is reset to the (possibly
> transformed) input value, while in this case the input value is added
> directly to the system time. This can be viewed as a kind of variable
> too, but it would be weird to report old and new value for it, since
> its value flows with time.
> 
> Plus, when I look at:
> type=TIME_INJOFFSET [...]: sec=-16 nsec=124887145
> 
> I can immediately see that the time was shifted back by 16-something
> seconds, while when I look at something like:
> 
> type=TIME_CHANGE [...]: var=time_sec new=1537185685 old=1537185701
> type=TIME_CHANGE [...]: var=time_nsec new=664373417 old=789260562
> 
> I can just see some big numbers that I need to do math with before I
> get an idea of what is the magnitude (or sign) of the change.
> 
> > >         old - the old value
> > >         new - the new value
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  include/linux/audit.h      | 21 +++++++++++++++++++++
> > >  include/uapi/linux/audit.h |  2 ++
> > >  kernel/auditsc.c           | 15 +++++++++++++++
> > >  3 files changed, 38 insertions(+)
> >
> > A reminder that we need tests for these new records and a RFE page on the wiki:
> >
> > * https://github.com/linux-audit/audit-testsuite
> 
> I was going to start working on this once the format issues are
> settled. (Although I probably should have kept the RFC in the subject
> until then...)

There are more iterative development methods (to which we appear to be
trying to steer) where the test is written first, partly helping clarify
what the goal is.  Refining the test is incremental.

> > * https://github.com/linux-audit/audit-kernel/wiki
> 
> I admit I forgot about this duty, but again I would like to wait for
> the discussions to settle before writing that up.

While tempting to leave it to the end, documenting it initially can help
clarify in your own mind what you are trying to accomplish and can help
others understand what you are trying to do.

> > paul moore

> Ondrej Mosnacek <omosnace at redhat dot com>

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
