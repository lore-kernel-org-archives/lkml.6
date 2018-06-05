Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbeFEOP0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:15:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2069 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751695AbeFEOPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:15:24 -0400
Subject: Re: [PATCH v3 4/4] ima: Differentiate auditing policy rules from
 "audit" actions
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Paul Moore <paul@paul-moore.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        sgrubb@redhat.com, linux-kernel@vger.kernel.org
Date: Tue, 05 Jun 2018 10:15:05 -0400
In-Reply-To: <CAHC9VhRkkQ74tvqGrSuNX2RdeHz5N7eU03-yHmVsZg47TxFD0g@mail.gmail.com>
References: <20180604205455.2325754-1-stefanb@linux.vnet.ibm.com>
         <20180604205455.2325754-5-stefanb@linux.vnet.ibm.com>
         <CAHC9VhRkkQ74tvqGrSuNX2RdeHz5N7eU03-yHmVsZg47TxFD0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18060514-0028-0000-0000-000002CD6249
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060514-0029-0000-0000-0000238467B7
Message-Id: <1528208105.3237.155.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806050164
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Mon, 2018-06-04 at 20:21 -0400, Paul Moore wrote:
> On Mon, Jun 4, 2018 at 4:54 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
> > The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
> > the IMA "audit" policy action.  This patch defines
> > AUDIT_INTEGRITY_POLICY_RULE to reflect the IMA policy rules.
> >
> > Since we defined a new message type we can now also pass the
> > audit_context and get an associated SYSCALL record. This now produces
> > the following records when parsing IMA policy's rules:
> 
> Aaand now I see you included the current->audit_context pointer I
> mentioned in my comments for 3/4 ;)
> 
> So basically this should be fine, although I should point out that you
> do not need to define a new message type to associate records
> together.  The fact that we don't associate all connected records is
> basically a bug.
> 
> Anyway, patches 3/4 and 4/4 look good to me.  Considering this is
> likely going in during the *next* merge window, I would ask that you
> convert from "current->audit_context" to "audit_context()" as soon as
> this merge window closes.
> 
> Thanks!

Thanks, Paul.  I'd like to start queueing patches for the next open
window now, instead of scrambling later.  Can I add your Ack now, and
remember to make this change when rebasing?

Mimi

> 
> > type=UNKNOWN[1807] msg=audit(1527888965.738:320): action=audit \
> >   func=MMAP_CHECK mask=MAY_EXEC res=1
> > type=UNKNOWN[1807] msg=audit(1527888965.738:320): action=audit \
> >   func=FILE_CHECK mask=MAY_READ res=1
> > type=SYSCALL msg=audit(1527888965.738:320): arch=c000003e syscall=1 \
> >   success=yes exit=17 a0=1 a1=55bcfcca9030 a2=11 a3=7fcc1b55fb38 \
> >   items=0 ppid=1567 pid=1601 auid=0 uid=0 gid=0 euid=0 suid=0 \
> >   fsuid=0 egid=0 sgid=0 fsgid=0 tty=tty2 ses=2 comm="echo" \
> >   exe="/usr/bin/echo" \
> >   subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> >
> > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > ---
> >  include/uapi/linux/audit.h          | 1 +
> >  security/integrity/ima/ima_policy.c | 4 ++--
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index 65d9293f1fb8..cb358551376b 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -148,6 +148,7 @@
> >  #define AUDIT_INTEGRITY_PCR        1804 /* PCR invalidation msgs */
> >  #define AUDIT_INTEGRITY_RULE       1805 /* policy rule */
> >  #define AUDIT_INTEGRITY_EVM_XATTR   1806 /* New EVM-covered xattr */
> > +#define AUDIT_INTEGRITY_POLICY_RULE 1807 /* IMA policy rules */
> >
> >  #define AUDIT_KERNEL           2000    /* Asynchronous audit record. NOT A REQUEST. */
> >
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > index bc99713dfe57..f7230db217a7 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -652,8 +652,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
> >         bool uid_token;
> >         int result = 0;
> >
> > -       ab = integrity_audit_log_start(NULL, GFP_KERNEL,
> > -                                      AUDIT_INTEGRITY_RULE);
> > +       ab = integrity_audit_log_start(current->audit_context, GFP_KERNEL,
> > +                                      AUDIT_INTEGRITY_POLICY_RULE);
> >
> >         entry->uid = INVALID_UID;
> >         entry->fowner = INVALID_UID;
> > --
> > 2.13.6
> >
> 
