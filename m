Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935755AbeCHLZw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:25:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755324AbeCHLZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:25:42 -0500
Date: Thu, 8 Mar 2018 06:21:04 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, paul@paul-moore.com,
        sgrubb@redhat.com
Subject: Re: [PATCH] audit: add containerid support for IMA-audit
Message-ID: <20180308112104.z67wohdvjqemy7wy@madcap2.tricolour.ca>
References: <1520257393.10396.291.camel@linux.vnet.ibm.com>
 <20180305135008.po6lheqnmkqqo6q4@madcap2.tricolour.ca>
 <1520259854.10396.313.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520259854.10396.313.camel@linux.vnet.ibm.com>
User-Agent: NeoMutt/20171027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-05 09:24, Mimi Zohar wrote:
> On Mon, 2018-03-05 at 08:50 -0500, Richard Guy Briggs wrote:
> > On 2018-03-05 08:43, Mimi Zohar wrote:
> > > Hi Richard,
> > > 
> > > This patch has been compiled, but not runtime tested.
> > 
> > Ok, great, thank you.  I assume you are offering this patch to be
> > included in this patchset?
> 
> Yes, thank you.
> 
> > I'll have a look to see where it fits in the
> > IMA record.  It might be better if it were an AUDIT_CONTAINER_INFO
> > auxiliary record, but I'll have a look at the circumstances of the
> > event.  

I had a look at the context of this record to see if adding the contid
field to it made sense.  I think the only records for which the contid
field makes sense are the two newly proposed records, AUDIT_CONTAINER
which introduces the container ID and the and AUDIT_CONTAINER_INFO which
documents the presence of the container ID in a process event (or
process-less network event).  All others should use the auxiliary record
AUDIT_CONTAINER_INFO rather than include the contid field directly
itself.  There are several reasons for this including record length, the
ability to filter unwanted records, the difficulty of changing the order
of or removing fields in the future.

Syscalls get this information automatically if the container ID is set
for a task via the AUDIT_CONTAINER_INFO auxiliary record.  Generally a
syscall event is one that uses the task's audit_context while a
standalone event uses NULL or builds a local audit_context that is
discarded immediately after the local use.

Looking at the two cases of AUDIT_INTEGRITY_RULE record generation, it
appears that they should be split into two distinct audit record types.

The record created in ima_audit_measurement() is a syscall record that
could possibly stand on its own since the subject attributes are
present.  If it remains a syscall auxiliary record it will automatically
have the AUDIT_CONTAINER_INFO record accompany it anyways.  If it is
decided to detach it (which would save cpu/netlink/disk bandwidth but is
not recommended due to not wanting to throw away any other syscall
information or other involved records (PATH, CWD, etc...) then a local
audit_context would be created for the AUDIT_INTEGRITY_RULE and
AUDIT_CONTAINERID_INFO records only and immediately discarded.

The record created in ima_parse_rule() is not currently a syscall record
since it is passed an audit_context of NULL and it has a very different
format that does not include any subject attributes (except subj_*=).
At first glance it appears this one should be a syscall accompanied
auxiliary record.  Either way it should have an AUDIT_CONTAINER_INFO
auxiliary record either by being converted to a syscall auxiliary record
by using current->audit_context rather than NULL when calling
audit_log_start(), or creating a local audit_context and calling
audit_log_container_info() then releasing the local context.  This
version of the record has additional concerns covered here:
https://github.com/linux-audit/audit-kernel/issues/52

Can you briefly describe the circumstances under which these two
different identically-numbered records are produced as a first step
towards splitting them into two distict records?

The four AUDIT_INTEGRITY _METADATA, _PCR, _DATA and _STATUS records
appear to be already properly covered for AUDIT_CONTAINER_INFO records
by being syscall auxiliary records.  The AUDIT_INTEGRITY_HASH record
appears to be unused.

> > Can you suggest a procedure to test it?
> 
> Like IMA-measurement and IMA-appraisal, IMA-audit is enabled based on
> policy. The example IMA policy, below, includes IMA-audit messages for
> files executed. 'cat' the policy to /sys/kernel/security/ima/policy.
> 
> /etc/ima/ima-policy:
> audit func=BPRM_CHECK
> 
> There's a FireEye blog titled "Extending Linux Executable Logging With
> The Integrity Measurement Architecture"* that explains how to augment
> their existing system security analytics with file hashes.
> 
> * https://www.fireeye.com/blog/threat-research/2016/11/extending_linux
> _exec.html
> 
> 
> Mimi
> 
> > > If the containerid is defined, include it in the IMA-audit record.
> > > 
> > > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > > ---
> > >  security/integrity/ima/ima_api.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> > > index 33b4458cdbef..41d29a06f28f 100644
> > > --- a/security/integrity/ima/ima_api.c
> > > +++ b/security/integrity/ima/ima_api.c
> > > @@ -335,6 +335,9 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
> > >  	audit_log_untrustedstring(ab, algo_hash);
> > >  
> > >  	audit_log_task_info(ab, current);
> > > +	if (audit_containerid_set(current))
> > > +		audit_log_format(ab, " contid=%llu",
> > > +				 audit_get_containerid(current));
> > >  	audit_log_end(ab);
> > >  
> > >  	iint->flags |= IMA_AUDITED;
> > > -- 
> > > 2.7.5
> > > 
> > 
> > - RGB

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
