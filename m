Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3972DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA4020831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA4020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJYUzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 16:55:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56805 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbeJYUzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 16:55:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63E4785362;
        Thu, 25 Oct 2018 12:23:09 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D188D5C1B5;
        Thu, 25 Oct 2018 12:22:55 +0000 (UTC)
Date:   Thu, 25 Oct 2018 08:22:52 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        luto@kernel.org, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH ghak90 (was ghak32) V4 03/10] audit: log container info
 of syscalls
Message-ID: <20181025122252.dsqcmkguuro3krzg@madcap2.tricolour.ca>
References: <cover.1533065887.git.rgb@redhat.com>
 <34017c395d03a213d6b0d49b9964429bd32b283d.1533065887.git.rgb@redhat.com>
 <CAHC9VhSv4hWGHiaaOfuBrRQKdp2YG5RtqXQbFXg7j7LNEhO2XQ@mail.gmail.com>
 <20181024151439.lavhanabsyxdrdvo@madcap2.tricolour.ca>
 <CAHC9VhRF1vsxM-k0Lw-9NqS9b9rgXRRBu0tq4ajdFpMqUxiH4A@mail.gmail.com>
 <20181025004255.zl7p7j6gztouh2hh@madcap2.tricolour.ca>
 <166a9dae538.280e.85c95baa4474aabc7814e68940a78392@paul-moore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166a9dae538.280e.85c95baa4474aabc7814e68940a78392@paul-moore.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 25 Oct 2018 12:23:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-25 07:13, Paul Moore wrote:
> On October 25, 2018 1:43:16 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2018-10-24 16:55, Paul Moore wrote:
> >> On Wed, Oct 24, 2018 at 11:15 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> >>> On 2018-10-19 19:16, Paul Moore wrote:
> >>>> On Sun, Aug 5, 2018 at 4:32 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> 
> ...
> 
> >
> >>>> However, I do care about the "op" field in this record.  It just
> >>>> doesn't make any sense; the way you are using it it is more of a
> >>>> context field than an operations field, and even then why is the
> >>>> context important from a logging and/or security perspective?  Drop it
> >>>> please.
> >>>
> >>> I'll rename it to whatever you like.  I'd suggest "ref=".  The reason I
> >>> think it is important is there are multiple sources that aren't always
> >>> obvious from the other records to which it is associated.  In the case
> >>> of ptrace and signals, there can be many target tasks listed (OBJ_PID)
> >>> with no other way to distinguish the matching audit container identifier
> >>> records all for one event.  This is in addition to the default syscall
> >>> container identifier record.  I'm not currently happy with the text
> >>> content to link the two, but that should be solvable (most obvious is
> >>> taret PID).  Throwing away this information seems shortsighted.
> >>
> >> It would be helpful if you could generate real audit events
> >> demonstrating the problems you are describing, as well as a more
> >> standard syscall event, so we can discuss some possible solutions.
> >
> > If the auditted process is in a container and it ptraces or signals
> > another process in a container, there will be two AUDIT_CONTAINER
> > records for the same event that won't be identified as to which record
> > belongs to which process or other record (SYSCALL vs 1+ OBJ_PID
> > records).  There could be many signals recorded, each with their own
> > OBJ_PID record.  The first is stored in the audit context and additional
> > ones are stored in a chained struct that can accommodate 16 entries each.
> >
> > (See audit_signal_info(), __audit_ptrace().)
> >
> > (As a side note, on code inspection it appears that a signal target
> > would get overwritten by a ptrace action if they were to happen in that
> > order.)
> 
> As requested above, please respond with real audit events generated by
> this patchset so that we can discuss possible solutions.

Ok, then we should be developping a test to test ptrace and signal
auditting in general since we don't have current experience/evidence
that those even work (or rip them out if not).

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
