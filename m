Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753916AbeE3Q1T (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:27:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753560AbeE3Q1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:27:17 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Paul Moore <paul@paul-moore.com>, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
Subject: Re: [PATCH 8/8] ima: Differentiate auditing policy rules from "audit" actions
Date: Wed, 30 May 2018 12:27:14 -0400
Message-ID: <3607733.4k8ofLVAdP@x2>
Organization: Red Hat
In-Reply-To: <00f66ee1-7494-8249-f148-688616deca0c@linux.vnet.ibm.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com> <15281606.YptaXzsEVL@x2> <00f66ee1-7494-8249-f148-688616deca0c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 30, 2018 11:25:05 AM EDT Stefan Berger wrote:
> On 05/30/2018 11:15 AM, Steve Grubb wrote:
> > On Wednesday, May 30, 2018 9:54:00 AM EDT Stefan Berger wrote:
> >> On 05/29/2018 05:30 PM, Steve Grubb wrote:
> >>> Hello,
> >>> 
> >>> On Thursday, May 24, 2018 4:11:05 PM EDT Stefan Berger wrote:
> >>>> The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
> >>>> the IMA "audit" policy action.  This patch defines
> >>>> AUDIT_INTEGRITY_POLICY_RULE to reflect the IMA policy rules.
> >>>> 
> >>>> With this change we now call integrity_audit_msg_common() to get
> >>>> common integrity auditing fields. This now produces the following
> >>>> record when parsing an IMA policy rule:
> >>>> 
> >>>> type=UNKNOWN[1806] msg=audit(1527004216.690:311): action=dont_measure
> >>>> \
> >>>> 
> >>>> fsmagic=0x9fa0 pid=1613 uid=0 auid=0 ses=2 \
> >>>> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 \
> >>>> op=policy_update cause=parse_rule comm="echo" exe="/usr/bin/echo" \
> >>>> tty=tty2 res=1
> >>> 
> >>> Since this is a new event, do you mind moving the tty field to be
> >>> between
> >>> auid= and ses=  ?   That is the more natural place for it.
> >> 
> >> 6/8 refactors the code so that the integrity audit records produced by
> >> IMA follow one format in terms of ordering of the fields, with fields
> >> like inode optional, though, and AUDIT_INTEGRITY_RULE in the end being
> >> the only one with a different format. Do we really want to change that
> >> order just for 1806?
> >> 
> >> 5/8 now produces the following:
> >> 
> >> type=INTEGRITY_PCR msg=audit(1527685075.941:502): pid=2431 \
> >> uid=0 auid=1000 ses=5 \
> >> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 \
> >> op=invalid_pcr cause=open_writers comm="grep" \
> >> name="/var/log/audit/audit.log" dev="dm-0" ino=1962494 \
> >> exe="/usr/bin/grep" tty=pts0 res=1
> >> 
> >> Comparing the two:
> >> 
> >> 1806:          action, fsmagic, pid, uid, auid, ses, subj, op, cause,
> >> comm,    exe, tty, res
> >> INTEGRITY_PCR:                  pid, uid, auid, ses, subj, op, cause,
> >> comm, name, dev, ino, exe, tty, res
> > 
> > OK. I guess go with it as is. It passes testing.
> 
> What about the position of 'res' field relative to the two new fields
> 'exe' and 'tty'?

res (results) is always the last field for every event. We have no events 
where it is not the last field. I'd prefer to go with it as is. The events 
pass my testing the way they are.

> Do we want to keep them as shown or strictly append the
> two new fields 'exe' and 'tty'? 

I'd prefer the first option to keep things as expected.

> Paul seems to request that they appear after 'res'.

I'd rather see them dropped, as useful as they could be, than to malform the 
events.

-Steve
