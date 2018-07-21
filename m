Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ED8ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1649520858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 20:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1649520858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbeGUV0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 17:26:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727838AbeGUV0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 17:26:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF90A81663C8;
        Sat, 21 Jul 2018 20:32:20 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-54.rdu2.redhat.com [10.10.112.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 923D52026D68;
        Sat, 21 Jul 2018 20:32:17 +0000 (UTC)
Date:   Sat, 21 Jul 2018 16:29:30 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>
Cc:     cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        carlos@redhat.com, dhowells@redhat.com, viro@zeniv.linux.org.uk,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        serge@hallyn.com
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 02/10] audit: log container
 info of syscalls
Message-ID: <20180721202930.a7rypxc5rxi3hyiv@madcap2.tricolour.ca>
References: <cover.1528304203.git.rgb@redhat.com>
 <b839dc7fb29aae226b2a4602e7ef3c2a406ee90a.1528304203.git.rgb@redhat.com>
 <CAHC9VhS0-4XSEFFPLrOvAiSYv-XDLG-yGyB4ULRGz=AnwE6diQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhS0-4XSEFFPLrOvAiSYv-XDLG-yGyB4ULRGz=AnwE6diQ@mail.gmail.com>
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 21 Jul 2018 20:32:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 21 Jul 2018 20:32:20 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rgb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-20 18:13, Paul Moore wrote:
> On Wed, Jun 6, 2018 at 1:00 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > Create a new audit record AUDIT_CONTAINER to document the audit
> > container identifier of a process if it is present.
> >
> > Called from audit_log_exit(), syscalls are covered.
> >
> > A sample raw event:
> > type=SYSCALL msg=audit(1519924845.499:257): arch=c000003e syscall=257 success=yes exit=3 a0=ffffff9c a1=56374e1cef30 a2=241 a3=1b6 items=2 ppid=606 pid=635 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=3 comm="bash" exe="/usr/bin/bash" subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key="tmpcontainerid"
> > type=CWD msg=audit(1519924845.499:257): cwd="/root"
> > type=PATH msg=audit(1519924845.499:257): item=0 name="/tmp/" inode=13863 dev=00:27 mode=041777 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:tmp_t:s0 nametype= PARENT cap_fp=0000000000000000 cap_fi=0000000000000000 cap_fe=0 cap_fver=0
> > type=PATH msg=audit(1519924845.499:257): item=1 name="/tmp/tmpcontainerid" inode=17729 dev=00:27 mode=0100644 ouid=0 ogid=0 rdev=00:00 obj=unconfined_u:object_r:user_tmp_t:s0 nametype=CREATE cap_fp=0000000000000000 cap_fi=0000000000000000 cap_fe=0 cap_fver=0
> > type=PROCTITLE msg=audit(1519924845.499:257): proctitle=62617368002D6300736C65657020313B206563686F2074657374203E202F746D702F746D70636F6E7461696E65726964
> > type=CONTAINER msg=audit(1519924845.499:257): op=task contid=123458
> >
> > See: https://github.com/linux-audit/audit-kernel/issues/90
> > See: https://github.com/linux-audit/audit-userspace/issues/51
> > See: https://github.com/linux-audit/audit-testsuite/issues/64
> > See: https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  include/linux/audit.h      |  7 +++++++
> >  include/uapi/linux/audit.h |  1 +
> >  kernel/audit.c             | 23 +++++++++++++++++++++++
> >  kernel/auditsc.c           |  3 +++
> >  4 files changed, 34 insertions(+)
> 
> ...
> 
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -115,6 +115,7 @@
> >  #define AUDIT_REPLACE          1329    /* Replace auditd if this packet unanswerd */
> >  #define AUDIT_KERN_MODULE      1330    /* Kernel Module events */
> >  #define AUDIT_FANOTIFY         1331    /* Fanotify access decision */
> > +#define AUDIT_CONTAINER                1332    /* Container ID */
> 
> I'm not sure I'm completely sold on the AUDIT_CONTAINER_ID and
> AUDIT_CONTAINER record type names.  From what I can tell
> AUDIT_CONTAINER_ID seems to be used for audit container ID management
> operations, e.g. setting the ID, whereas the AUDIT_CONTAINER is used
> to tag events with the corresponding audit container ID.  Assuming
> that is correct, it seems like AUDIT_CONTAINER might be better served
> if it was named AUDIT_CONTAINER_ID and if we could change
> AUDIT_CONTAINER_ID to AUDIT_CONTAINER_OP/MGMT/etc.  Thoughts?

Please see discussion at:
	https://www.redhat.com/archives/linux-audit/2018-May/msg00101.html

I'm fine with changing AUDIT_CONTAINER_ID to AUDIT_CONTAINER_OP/MGMT/etc.

> >  #define AUDIT_AVC              1400    /* SE Linux avc denial or grant */
> >  #define AUDIT_SELINUX_ERR      1401    /* Internal SE Linux Errors */
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index e7478cb..5e150c6 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -2048,6 +2048,29 @@ void audit_log_session_info(struct audit_buffer *ab)
> >         audit_log_format(ab, " auid=%u ses=%u", auid, sessionid);
> >  }
> >
> > +/*
> > + * audit_log_contid - report container info
> > + * @tsk: task to be recorded
> > + * @context: task or local context for record
> > + * @op: contid string description
> > + */
> > +int audit_log_contid(struct task_struct *tsk,
> > +                            struct audit_context *context, char *op)
> > +{
> > +       struct audit_buffer *ab;
> > +
> > +       if (!audit_contid_set(tsk))
> > +               return 0;
> > +       /* Generate AUDIT_CONTAINER record with container ID */
> > +       ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONTAINER);
> > +       if (!ab)
> > +               return -ENOMEM;
> > +       audit_log_format(ab, "op=%s contid=%llu",
> > +                        op, audit_get_contid(tsk));
> 
> Can you explain your reason for including an "op" field in this record
> type?  I've been looking at the rest of the patches in this patchset
> and it seems to be used more as an indicator of the record's
> generating context rather than any sort of audit container ID
> operation.

"action" might work, but that's netfilter and numeric... "kind"?
Nothing else really seems to fit from a field name, type or lack of
searchability perspective.

Steve, do you have an opinion?

> > +       audit_log_end(ab);
> > +       return 0;
> > +}
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
