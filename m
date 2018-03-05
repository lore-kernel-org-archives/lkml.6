Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeCEOY2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:24:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751294AbeCEOY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:24:26 -0500
Subject: Re: [PATCH] audit: add containerid support for IMA-audit
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Mon, 05 Mar 2018 09:24:14 -0500
In-Reply-To: <20180305135008.po6lheqnmkqqo6q4@madcap2.tricolour.ca>
References: <1520257393.10396.291.camel@linux.vnet.ibm.com>
         <20180305135008.po6lheqnmkqqo6q4@madcap2.tricolour.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18030514-0012-0000-0000-000005B8EFCE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030514-0013-0000-0000-00001935024E
Message-Id: <1520259854.10396.313.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803050171
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-05 at 08:50 -0500, Richard Guy Briggs wrote:
> On 2018-03-05 08:43, Mimi Zohar wrote:
> > Hi Richard,
> > 
> > This patch has been compiled, but not runtime tested.
> 
> Ok, great, thank you.  I assume you are offering this patch to be
> included in this patchset?

Yes, thank you.

> I'll have a look to see where it fits in the
> IMA record.  It might be better if it were an AUDIT_CONTAINER_INFO
> auxiliary record, but I'll have a look at the circumstances of the
> event.  Can you suggest a procedure to test it?

Like IMA-measurement and IMA-appraisal, IMA-audit is enabled based on
policy. The example IMA policy, below, includes IMA-audit messages for
files executed. 'cat' the policy to /sys/kernel/security/ima/policy.

/etc/ima/ima-policy:
audit func=BPRM_CHECK

There's a FireEye blog titled "Extending Linux Executable Logging With
The Integrity Measurement Architecture"* that explains how to augment
their existing system security analytics with file hashes.

* https://www.fireeye.com/blog/threat-research/2016/11/extending_linux
_exec.html


Mimi

> 
> > ---
> > 
> > If the containerid is defined, include it in the IMA-audit record.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > ---
> >  security/integrity/ima/ima_api.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> > index 33b4458cdbef..41d29a06f28f 100644
> > --- a/security/integrity/ima/ima_api.c
> > +++ b/security/integrity/ima/ima_api.c
> > @@ -335,6 +335,9 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
> >  	audit_log_untrustedstring(ab, algo_hash);
> >  
> >  	audit_log_task_info(ab, current);
> > +	if (audit_containerid_set(current))
> > +		audit_log_format(ab, " contid=%llu",
> > +				 audit_get_containerid(current));
> >  	audit_log_end(ab);
> >  
> >  	iint->flags |= IMA_AUDITED;
> > -- 
> > 2.7.5
> > 
> 
> - RGB
> 
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635
> 
