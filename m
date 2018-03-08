Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936078AbeCHSC5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 13:02:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752193AbeCHSCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 13:02:55 -0500
Subject: Re: [PATCH] audit: add containerid support for IMA-audit
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, paul@paul-moore.com,
        sgrubb@redhat.com, Matthew Garrett <mjg59@google.com>,
        Peter Moody <peter@hda3.com>
Date: Thu, 08 Mar 2018 13:02:45 -0500
In-Reply-To: <20180308112104.z67wohdvjqemy7wy@madcap2.tricolour.ca>
References: <1520257393.10396.291.camel@linux.vnet.ibm.com>
         <20180305135008.po6lheqnmkqqo6q4@madcap2.tricolour.ca>
         <1520259854.10396.313.camel@linux.vnet.ibm.com>
         <20180308112104.z67wohdvjqemy7wy@madcap2.tricolour.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18030818-0020-0000-0000-0000040068A1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030818-0021-0000-0000-00004294AF30
Message-Id: <1520532165.3605.51.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803080204
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-08 at 06:21 -0500, Richard Guy Briggs wrote:
> On 2018-03-05 09:24, Mimi Zohar wrote:
> > On Mon, 2018-03-05 at 08:50 -0500, Richard Guy Briggs wrote:
> > > On 2018-03-05 08:43, Mimi Zohar wrote:
> > > > Hi Richard,
> > > > 
> > > > This patch has been compiled, but not runtime tested.
> > > 
> > > Ok, great, thank you.  I assume you are offering this patch to be
> > > included in this patchset?
> > 
> > Yes, thank you.
> > 
> > > I'll have a look to see where it fits in the
> > > IMA record.  It might be better if it were an AUDIT_CONTAINER_INFO
> > > auxiliary record, but I'll have a look at the circumstances of the
> > > event.  
> 
> I had a look at the context of this record to see if adding the contid
> field to it made sense.  I think the only records for which the contid
> field makes sense are the two newly proposed records, AUDIT_CONTAINER
> which introduces the container ID and the and AUDIT_CONTAINER_INFO which
> documents the presence of the container ID in a process event (or
> process-less network event).  All others should use the auxiliary record
> AUDIT_CONTAINER_INFO rather than include the contid field directly
> itself.  There are several reasons for this including record length, the
> ability to filter unwanted records, the difficulty of changing the order
> of or removing fields in the future.
> 
> Syscalls get this information automatically if the container ID is set
> for a task via the AUDIT_CONTAINER_INFO auxiliary record.  Generally a
> syscall event is one that uses the task's audit_context while a
> standalone event uses NULL or builds a local audit_context that is
> discarded immediately after the local use.
> 
> Looking at the two cases of AUDIT_INTEGRITY_RULE record generation, it
> appears that they should be split into two distinct audit record types.
> 
> The record created in ima_audit_measurement() is a syscall record that
> could possibly stand on its own since the subject attributes are
> present.  If it remains a syscall auxiliary record it will automatically
> have the AUDIT_CONTAINER_INFO record accompany it anyways.  If it is
> decided to detach it (which would save cpu/netlink/disk bandwidth but is
> not recommended due to not wanting to throw away any other syscall
> information or other involved records (PATH, CWD, etc...) then a local
> audit_context would be created for the AUDIT_INTEGRITY_RULE and
> AUDIT_CONTAINERID_INFO records only and immediately discarded.
> 
> The record created in ima_parse_rule() is not currently a syscall record
> since it is passed an audit_context of NULL and it has a very different
> format that does not include any subject attributes (except subj_*=).
> At first glance it appears this one should be a syscall accompanied
> auxiliary record.  Either way it should have an AUDIT_CONTAINER_INFO
> auxiliary record either by being converted to a syscall auxiliary record
> by using current->audit_context rather than NULL when calling
> audit_log_start(), or creating a local audit_context and calling
> audit_log_container_info() then releasing the local context.  This
> version of the record has additional concerns covered here:
> https://github.com/linux-audit/audit-kernel/issues/52
> 
> Can you briefly describe the circumstances under which these two
> different identically-numbered records are produced as a first step
> towards splitting them into two distict records?

Agreed, the two uses should really be separated.  ima_parse_rule()
generates audit messages, when the IMA policy is initially loaded,
replaced, or extended, the policy rules are included in the audit log.
When IMA is namespaced, there will be a host policy and namespace
policies.  We'll need to be able differentiate between the host policy
rules and IMA namespaced policy rules, and between IMA namespaced
policy rules.

The audit messages produced by ima_audit_measurement() were originally
upstreamed for forensics, and as seen by the FireEye blog are now used
to augment existing security analytics.  These records are probably
being used independently of any other audit records.  A single record
is generated per file, per system.  With IMA namespacing, these
records need to be generated once per file, per namespace as well.  In
order to differentiate the records between the host and namespace, and
between namespaces, these records should include the container id.

To disambiguate between these audit messages and the policy rule
messages, we could rename these audit messages to AUDIT_INTEGRITY_IMA.

> The four AUDIT_INTEGRITY _METADATA, _PCR, _DATA and _STATUS records
> appear to be already properly covered for AUDIT_CONTAINER_INFO records
> by being syscall auxiliary records.  The AUDIT_INTEGRITY_HASH record
> appears to be unused.

Ok

Mimi
