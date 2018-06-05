Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeFEAQq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 20:16:46 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36339 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbeFEAQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 20:16:45 -0400
X-Google-Smtp-Source: ADUXVKKQZ624J0LsYIQ12gkopcX0GMSJhZUJj0cfGxI4KyiIIlWdcjal+g5eG8jDRBY9Z8ahlzlwnGe1Noc8lyH5tQk=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180604205455.2325754-4-stefanb@linux.vnet.ibm.com>
References: <20180604205455.2325754-1-stefanb@linux.vnet.ibm.com> <20180604205455.2325754-4-stefanb@linux.vnet.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 Jun 2018 20:16:42 -0400
Message-ID: <CAHC9VhSRZJVUdyCCp9YtVofyKYy60qXQZD5z2OqQKQ-h4s9fCQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] ima: Do not audit if CONFIG_INTEGRITY_AUDIT is not set
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
> If Integrity is not auditing, IMA shouldn't audit, either.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  security/integrity/ima/Kconfig      |  1 +
>  security/integrity/ima/ima_policy.c |  6 +++++-
>  security/integrity/integrity.h      | 15 +++++++++++++++
>  3 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 6a8f67714c83..94c2151331aa 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -12,6 +12,7 @@ config IMA
>         select TCG_TIS if TCG_TPM && X86
>         select TCG_CRB if TCG_TPM && ACPI
>         select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES
> +       select INTEGRITY_AUDIT if AUDIT
>         help
>           The Trusted Computing Group(TCG) runtime Integrity
>           Measurement Architecture(IMA) maintains a list of hash
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 3fcf0935468c..bc99713dfe57 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -628,6 +628,9 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
>  static void ima_log_string_op(struct audit_buffer *ab, char *key, char *value,
>                               bool (*rule_operator)(kuid_t, kuid_t))
>  {
> +       if (!ab)
> +               return;
> +
>         if (rule_operator == &uid_gt)
>                 audit_log_format(ab, "%s>", key);
>         else if (rule_operator == &uid_lt)
> @@ -649,7 +652,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>         bool uid_token;
>         int result = 0;
>
> -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_RULE);
> +       ab = integrity_audit_log_start(NULL, GFP_KERNEL,
> +                                      AUDIT_INTEGRITY_RULE);

There was a lot of confusion here, so this is understandable, but you
should pass "audit_context()"[1] as the first parameter instead of
NULL.  Other than that this patch looks fine.

[1] In Linus' tree at the moment you would need to use
current->audit_context, but the audit PR heading to Linus during this
merge window will introduce the "audit_context()" function which is
preferable as we may need to change things around a bit in the near
future.

>         entry->uid = INVALID_UID;
>         entry->fowner = INVALID_UID;
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 0bb372eed62a..e60473b13a8d 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -15,6 +15,7 @@
>  #include <linux/integrity.h>
>  #include <crypto/sha.h>
>  #include <linux/key.h>
> +#include <linux/audit.h>
>
>  /* iint action cache flags */
>  #define IMA_MEASURE            0x00000001
> @@ -199,6 +200,13 @@ static inline void evm_load_x509(void)
>  void integrity_audit_msg(int audit_msgno, struct inode *inode,
>                          const unsigned char *fname, const char *op,
>                          const char *cause, int result, int info);
> +
> +static inline struct audit_buffer *
> +integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
> +{
> +       return audit_log_start(ctx, gfp_mask, type);
> +}
> +
>  #else
>  static inline void integrity_audit_msg(int audit_msgno, struct inode *inode,
>                                        const unsigned char *fname,
> @@ -206,4 +214,11 @@ static inline void integrity_audit_msg(int audit_msgno, struct inode *inode,
>                                        int result, int info)
>  {
>  }
> +
> +static inline struct audit_buffer *
> +integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
> +{
> +       return NULL;
> +}
> +
>  #endif
> --
> 2.13.6

-- 
paul moore
www.paul-moore.com
