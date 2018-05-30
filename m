Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbeE3MuX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:50:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752089AbeE3MuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:50:22 -0400
Date: Wed, 30 May 2018 08:49:20 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: zohar@linux.vnet.ibm.com, sgrubb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] ima: Differentiate auditing policy rules from
 "audit" actions
Message-ID: <20180530124920.g5agxm75x4i6pw6n@madcap2.tricolour.ca>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
 <20180524201105.3179904-9-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524201105.3179904-9-stefanb@linux.vnet.ibm.com>
User-Agent: NeoMutt/20171027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-24 16:11, Stefan Berger wrote:
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
> 
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
> +#define AUDIT_INTEGRITY_RULE	    1805 /* IMA "audit" action policy msgs  */
> +#define AUDIT_INTEGRITY_POLICY_RULE 1806 /* IMA policy rules */
>  
>  #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST. */
>  
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 3aed25a7178a..a8ae47a386b4 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -634,7 +634,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  	int result = 0;
>  
>  	ab = integrity_audit_log_start(NULL, GFP_KERNEL,
> -				       AUDIT_INTEGRITY_RULE);
> +				       AUDIT_INTEGRITY_POLICY_RULE);

Is it possible to connect this record to a syscall by replacing the
first parameter (NULL) by current->context?

>  	entry->uid = INVALID_UID;
>  	entry->fowner = INVALID_UID;
> @@ -926,7 +926,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  		temp_ima_appraise |= IMA_APPRAISE_FIRMWARE;
>  	else if (entry->func == POLICY_CHECK)
>  		temp_ima_appraise |= IMA_APPRAISE_POLICY;
> -	audit_log_format(ab, "res=%d", !result);
> +	integrity_audit_msg_common(ab, NULL, NULL,
> +				   "policy_update", "parse_rule", result);
>  	audit_log_end(ab);
>  	return result;
>  }

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
