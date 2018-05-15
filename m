Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753540AbeEONlR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 09:41:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752253AbeEONlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 09:41:16 -0400
Subject: Re: [RFC PATCH v4 3/5] ima: differentiate auditing policy rules
 from "audit" actions
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: serge@hallyn.com, sunyuqiong1988@gmail.com, david.safford@ge.com,
        mkayaalp@cs.binghamton.edu, James.Bottomley@HansenPartnership.com,
        ebiederm@xmission.com, john.johansen@canonical.com
Date: Tue, 15 May 2018 09:40:55 -0400
In-Reply-To: <20180511144230.75384-4-stefanb@linux.vnet.ibm.com>
References: <20180511144230.75384-1-stefanb@linux.vnet.ibm.com>
         <20180511144230.75384-4-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18051513-0040-0000-0000-0000043A0484
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051513-0041-0000-0000-0000263F149D
Message-Id: <1526391655.3937.151.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-15_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805150140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Fri, 2018-05-11 at 10:42 -0400, Stefan Berger wrote:
> From: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
> the IMA "audit" policy action.  This patch defines AUDIT_INTEGRITY_POLICY
> to reflect the IMA policy rules.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

We do need to separate out auditing the IMA policy rules from the
"IMA-audit" messages.  Based on the IMA policy rule aspect of the
discussions [1],  I would really appreciate if you could work with
Richard and Steve on the new IMA policy rule audit format.

This change can be upstreamed independently of either the IMA
namespacing or the audit containerid patch sets.  The sooner we make
this change and upstream it, the better.

[1] https://www.redhat.com/archives/linux-audit/2018-March/msg00092.html

thanks,

Mimi

> ---
>  include/uapi/linux/audit.h          | 3 ++-
>  security/integrity/ima/ima_policy.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 4e61a9e05132..8966e7ff1c4c 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -146,7 +146,8 @@
>  #define AUDIT_INTEGRITY_STATUS	    1802 /* Integrity enable status */
>  #define AUDIT_INTEGRITY_HASH	    1803 /* Integrity HASH type */
>  #define AUDIT_INTEGRITY_PCR	    1804 /* PCR invalidation msgs */
> -#define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
> +#define AUDIT_INTEGRITY_RULE	    1805 /* IMA "audit" action policy msgs  */
> +#define AUDIT_INTEGRITY_POLICY	    1806 /* IMA policy rules */
> 
>  #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST. */
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 915f5572c6ff..3a1412db02a3 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -619,7 +619,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  	bool uid_token;
>  	int result = 0;
> 
> -	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_RULE);
> +	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_POLICY);
> 
>  	entry->uid = INVALID_UID;
>  	entry->fowner = INVALID_UID;
