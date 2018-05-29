Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967276AbeE2VaJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:30:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966989AbeE2VaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:30:08 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: zohar@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com
Subject: Re: [PATCH 8/8] ima: Differentiate auditing policy rules from "audit" actions
Date: Tue, 29 May 2018 17:30:06 -0400
Message-ID: <1569841.KfYyxMilWs@x2>
Organization: Red Hat
In-Reply-To: <20180524201105.3179904-9-stefanb@linux.vnet.ibm.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com> <20180524201105.3179904-9-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


On Thursday, May 24, 2018 4:11:05 PM EDT Stefan Berger wrote:
> The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
> the IMA "audit" policy action.  This patch defines
> AUDIT_INTEGRITY_POLICY_RULE to reflect the IMA policy rules.
> 
> With this change we now call integrity_audit_msg_common() to get
> common integrity auditing fields. This now produces the following
> record when parsing an IMA policy rule:
> 
> type=UNKNOWN[1806] msg=audit(1527004216.690:311): action=dont_measure \
>   fsmagic=0x9fa0 pid=1613 uid=0 auid=0 ses=2 \
>   subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 \
>   op=policy_update cause=parse_rule comm="echo" exe="/usr/bin/echo" \
>   tty=tty2 res=1

Since this is a new event, do you mind moving the tty field to be between 
auid= and ses=  ?   That is the more natural place for it. 

Also, it might be more natural for the op= and cause= fields to be before the 
pid= portion. This doesn't matter as much to me because those are not 
searchable fields and they are skipped right over. But moving the tty field 
is the main comment from me.

Thanks,
-Steve

> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  include/uapi/linux/audit.h          | 3 ++-
>  security/integrity/ima/ima_policy.c | 5 +++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 4e61a9e05132..776e0abd35cf 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -146,7 +146,8 @@
>  #define AUDIT_INTEGRITY_STATUS	    1802 /* Integrity enable status */
>  #define AUDIT_INTEGRITY_HASH	    1803 /* Integrity HASH type */
>  #define AUDIT_INTEGRITY_PCR	    1804 /* PCR invalidation msgs */
> -#define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
> +#define AUDIT_INTEGRITY_RULE	    1805 /* IMA "audit" action policy msgs 
> */ +#define AUDIT_INTEGRITY_POLICY_RULE 1806 /* IMA policy rules */
> 
>  #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A 
REQUEST. */
> 
> diff --git a/security/integrity/ima/ima_policy.c
> b/security/integrity/ima/ima_policy.c index 3aed25a7178a..a8ae47a386b4
> 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -634,7 +634,7 @@ static int ima_parse_rule(char *rule, struct
> ima_rule_entry *entry) int result = 0;
> 
>  	ab = integrity_audit_log_start(NULL, GFP_KERNEL,
> -				       AUDIT_INTEGRITY_RULE);
> +				       AUDIT_INTEGRITY_POLICY_RULE);
> 
>  	entry->uid = INVALID_UID;
>  	entry->fowner = INVALID_UID;
> @@ -926,7 +926,8 @@ static int ima_parse_rule(char *rule, struct
> ima_rule_entry *entry) temp_ima_appraise |= IMA_APPRAISE_FIRMWARE;
>  	else if (entry->func == POLICY_CHECK)
>  		temp_ima_appraise |= IMA_APPRAISE_POLICY;
> -	audit_log_format(ab, "res=%d", !result);
> +	integrity_audit_msg_common(ab, NULL, NULL,
> +				   "policy_update", "parse_rule", result);
>  	audit_log_end(ab);
>  	return result;
>  }
