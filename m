Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbeERP5i (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:57:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752221AbeERP5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:57:36 -0400
Date: Fri, 18 May 2018 11:56:59 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, paul@paul-moore.com,
        sgrubb@redhat.com
Subject: Re: [PATCH] audit: add containerid support for IMA-audit
Message-ID: <20180518155659.porewd6moctumkys@madcap2.tricolour.ca>
References: <1520257393.10396.291.camel@linux.vnet.ibm.com>
 <20180305135008.po6lheqnmkqqo6q4@madcap2.tricolour.ca>
 <1520259854.10396.313.camel@linux.vnet.ibm.com>
 <20180308112104.z67wohdvjqemy7wy@madcap2.tricolour.ca>
 <efb6c164-febe-67bb-43a9-795476c4902f@linux.vnet.ibm.com>
 <20180517213001.62caslkjwv575xgl@madcap2.tricolour.ca>
 <86df5c2c-9db3-21b9-b91b-30a4f53f9504@linux.vnet.ibm.com>
 <1526647996.3632.164.camel@linux.vnet.ibm.com>
 <ef567d60-42f7-0a87-8597-1ef381e15be0@linux.vnet.ibm.com>
 <1526654395.3632.196.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526654395.3632.196.camel@linux.vnet.ibm.com>
User-Agent: NeoMutt/20171027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-18 10:39, Mimi Zohar wrote:
> On Fri, 2018-05-18 at 09:54 -0400, Stefan Berger wrote:
> > On 05/18/2018 08:53 AM, Mimi Zohar wrote:
> 
> [..]
> 
> > >>>> If so, which ones? We could probably refactor the current
> > >>>> integrity_audit_message() and have ima_parse_rule() call into it to get
> > >>>> those fields as well. I suppose adding new fields to it wouldn't be
> > >>>> considered breaking user space?
> > >>> Changing the order of existing fields or inserting fields could break
> > >>> stuff and is strongly discouraged without a good reason, but appending
> > >>> fields is usually the right way to add information.
> > >>>
> > >>> There are exceptions, and in this case, I'd pick the "more standard" of
> > >>> the formats for AUDIT_INTEGRITY_RULE (ima_audit_measurement?) and stick
> > >>> with that, abandoning the other format, renaming the less standard
> > >>> version of the record (ima_parse_rule?) and perhpas adopting that
> > >>> abandonned format for the new record type while using
> > >>> current->audit_context.
> > > This sounds right, other than "type=INTEGRITY_RULE" (1805) for
> > > ima_audit_measurement().  Could we rename type=1805 to be
> > 
> > So do we want to change both? I thought that what 
> > ima_audit_measurement() produces looks ok but may not have a good name 
> > for the 'type'. Now in this case I would not want to 'break user space'.
> > The only change I was going to make was to what ima_parse_rule() produces.
> 
> The only change for now is separating the IMA policy rules from the
> IMA-audit messages.
> 
> Richard, when the containerid is appended to the IMA-audit messages,
> would we make the audit type name change then?

No, go ahead and make the change now.  I'm expecting that the
containerid record will just be another auxiliary record and should not
affect you folks.

> > > INTEGRITY_AUDIT or INTEGRITY_IMA_AUDIT?  The new type=1806 audit
> > > message could be named INTEGRITY_RULE or, if that would be confusing,
> > > INTEGRITY_POLICY_RULE.
> > 
> > For 1806, as we would use it in ima_parse_rule(), we could change that 
> > in your patch to INTEGRITY_POLICY_RULE. IMA_POLICY_RULE may be better 
> > for IMA to produce but that's inconsistent then.
> 
> Ok
> 
> > 
> > >
> > >> 1806 would be in sync with INTEGRITY_RULE now for process related info.
> > >> If this looks good, I'll remove the dependency on your local context
> > >> creation and post the series.
> > >>
> > >> The justification for the change is that the INTEGRITY_RULE, as produced
> > >> by ima_parse_rule(), is broken.
> > > Post which series?  The IMA namespacing patch set?  This change should
> > > be upstreamed independently of IMA namespacing.
> > 
> > Without Richard's local context patch it may just be one or two patches.
> 
> Richard, if we separate the ima_parse_rules() audit messages, changing
> the audit rule number now, without the call to audit_log_task_info(),
> would adding the call later be breaking userspace?

Userspace is arguably already broken due to two formats and one usage
that isn't an auxiliary record.  All that should be necessary for now is
to use a different record number and pass it current->audit_context
instead of NULL.

> Mimi

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
