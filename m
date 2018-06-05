Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbeFEAV7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 20:21:59 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44151 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbeFEAV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 20:21:57 -0400
X-Google-Smtp-Source: ADUXVKKNSKfHHEAZL4uqMKkrjnN7gDKGE72p3bVP2zDEWKDbRafxH0RirXTOBhAgbH0XOdU5tqdmA7b2vRpmi1A3rQo=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180604205455.2325754-5-stefanb@linux.vnet.ibm.com>
References: <20180604205455.2325754-1-stefanb@linux.vnet.ibm.com> <20180604205455.2325754-5-stefanb@linux.vnet.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 Jun 2018 20:21:55 -0400
Message-ID: <CAHC9VhRkkQ74tvqGrSuNX2RdeHz5N7eU03-yHmVsZg47TxFD0g@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ima: Differentiate auditing policy rules from
 "audit" actions
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: zohar@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        linux-audit@redhat.com, sgrubb@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 4:54 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
> the IMA "audit" policy action.  This patch defines
> AUDIT_INTEGRITY_POLICY_RULE to reflect the IMA policy rules.
>
> Since we defined a new message type we can now also pass the
> audit_context and get an associated SYSCALL record. This now produces
> the following records when parsing IMA policy's rules:

Aaand now I see you included the current->audit_context pointer I
mentioned in my comments for 3/4 ;)

So basically this should be fine, although I should point out that you
do not need to define a new message type to associate records
together.  The fact that we don't associate all connected records is
basically a bug.

Anyway, patches 3/4 and 4/4 look good to me.  Considering this is
likely going in during the *next* merge window, I would ask that you
convert from "current->audit_context" to "audit_context()" as soon as
this merge window closes.

Thanks!

> type=UNKNOWN[1807] msg=audit(1527888965.738:320): action=audit \
>   func=MMAP_CHECK mask=MAY_EXEC res=1
> type=UNKNOWN[1807] msg=audit(1527888965.738:320): action=audit \
>   func=FILE_CHECK mask=MAY_READ res=1
> type=SYSCALL msg=audit(1527888965.738:320): arch=c000003e syscall=1 \
>   success=yes exit=17 a0=1 a1=55bcfcca9030 a2=11 a3=7fcc1b55fb38 \
>   items=0 ppid=1567 pid=1601 auid=0 uid=0 gid=0 euid=0 suid=0 \
>   fsuid=0 egid=0 sgid=0 fsgid=0 tty=tty2 ses=2 comm="echo" \
>   exe="/usr/bin/echo" \
>   subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  include/uapi/linux/audit.h          | 1 +
>  security/integrity/ima/ima_policy.c | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 65d9293f1fb8..cb358551376b 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -148,6 +148,7 @@
>  #define AUDIT_INTEGRITY_PCR        1804 /* PCR invalidation msgs */
>  #define AUDIT_INTEGRITY_RULE       1805 /* policy rule */
>  #define AUDIT_INTEGRITY_EVM_XATTR   1806 /* New EVM-covered xattr */
> +#define AUDIT_INTEGRITY_POLICY_RULE 1807 /* IMA policy rules */
>
>  #define AUDIT_KERNEL           2000    /* Asynchronous audit record. NOT A REQUEST. */
>
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index bc99713dfe57..f7230db217a7 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -652,8 +652,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>         bool uid_token;
>         int result = 0;
>
> -       ab = integrity_audit_log_start(NULL, GFP_KERNEL,
> -                                      AUDIT_INTEGRITY_RULE);
> +       ab = integrity_audit_log_start(current->audit_context, GFP_KERNEL,
> +                                      AUDIT_INTEGRITY_POLICY_RULE);
>
>         entry->uid = INVALID_UID;
>         entry->fowner = INVALID_UID;
> --
> 2.13.6
>

-- 
paul moore
www.paul-moore.com
