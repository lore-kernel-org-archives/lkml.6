Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeERPwG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:52:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751418AbeERPwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:52:03 -0400
Date: Fri, 18 May 2018 11:51:25 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, paul@paul-moore.com,
        sgrubb@redhat.com
Subject: Re: [PATCH] audit: add containerid support for IMA-audit
Message-ID: <20180518155125.ebj33f2xo2p2n4q4@madcap2.tricolour.ca>
References: <1520257393.10396.291.camel@linux.vnet.ibm.com>
 <20180305135008.po6lheqnmkqqo6q4@madcap2.tricolour.ca>
 <1520259854.10396.313.camel@linux.vnet.ibm.com>
 <20180308112104.z67wohdvjqemy7wy@madcap2.tricolour.ca>
 <efb6c164-febe-67bb-43a9-795476c4902f@linux.vnet.ibm.com>
 <20180517213001.62caslkjwv575xgl@madcap2.tricolour.ca>
 <86df5c2c-9db3-21b9-b91b-30a4f53f9504@linux.vnet.ibm.com>
 <1526647996.3632.164.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526647996.3632.164.camel@linux.vnet.ibm.com>
User-Agent: NeoMutt/20171027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-18 08:53, Mimi Zohar wrote:
> On Fri, 2018-05-18 at 07:49 -0400, Stefan Berger wrote:
> > On 05/17/2018 05:30 PM, Richard Guy Briggs wrote:
> 
> [...]
> 
> > >>> auxiliary record either by being converted to a syscall auxiliary record
> > >>> by using current->audit_context rather than NULL when calling
> > >>> audit_log_start(), or creating a local audit_context and calling
> > >> ima_parse_rule() is invoked when setting a policy by writing it into
> > >> /sys/kernel/security/ima/policy. We unfortunately don't have the
> > >> current->audit_context in this case.
> > > Sure you do.  What process writes to that file?  That's the one we care
> > > about, unless it is somehow handed off to a queue and processed later in
> > > a different context.
> > 
> > I just printk'd it again. current->audit_context is NULL in this case.
> 
> The builtin policy rules are loaded at __init.  Subsequently a custom
> policy can replace the builtin policy rules by writing to the
> securityfs file.  Is the audit_context NULL in both cases?

I wondered the same.

> > >> If so, which ones? We could probably refactor the current
> > >> integrity_audit_message() and have ima_parse_rule() call into it to get
> > >> those fields as well. I suppose adding new fields to it wouldn't be
> > >> considered breaking user space?
> > > Changing the order of existing fields or inserting fields could break
> > > stuff and is strongly discouraged without a good reason, but appending
> > > fields is usually the right way to add information.
> > >
> > > There are exceptions, and in this case, I'd pick the "more standard" of
> > > the formats for AUDIT_INTEGRITY_RULE (ima_audit_measurement?) and stick
> > > with that, abandoning the other format, renaming the less standard
> > > version of the record (ima_parse_rule?) and perhpas adopting that
> > > abandonned format for the new record type while using
> > > current->audit_context.
> 
> This sounds right, other than "type=INTEGRITY_RULE" (1805) for
> ima_audit_measurement().  Could we rename type=1805 to be
> INTEGRITY_AUDIT or INTEGRITY_IMA_AUDIT?  The new type=1806 audit
> message could be named INTEGRITY_RULE or, if that would be confusing,
> INTEGRITY_POLICY_RULE.

I'm reluctant to change the macro/value.  Just use the existing
AUDIT_INTEGRITY_RULE        1805 as appropriate and create a new
AUDIT_INTEGRITY_AUDIT       1806.

> > 1806 would be in sync with INTEGRITY_RULE now for process related info. 
> > If this looks good, I'll remove the dependency on your local context 
> > creation and post the series.
> > 
> > The justification for the change is that the INTEGRITY_RULE, as produced 
> > by ima_parse_rule(), is broken.
> 
> Post which series?  The IMA namespacing patch set?  This change should
> be upstreamed independently of IMA namespacing.
> 
> Mimi
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
