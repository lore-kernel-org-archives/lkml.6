Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966771AbeE2UbO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 16:31:14 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40204 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966721AbeE2UbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 16:31:11 -0400
X-Google-Smtp-Source: ADUXVKLw9RRzsCmTaqoJbRVU5UatdOhuFvEEIpnY/iVp16vyccSZL0q5Acy/G+qTMJlaevxX0paxbbRt/HaT7VK9XOw=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180524201105.3179904-3-stefanb@linux.vnet.ibm.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com> <20180524201105.3179904-3-stefanb@linux.vnet.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 May 2018 16:31:09 -0400
Message-ID: <CAHC9VhTy+7Cdb65bZBp9w1_TbOtdcKk_Ejv53ud+ag2WFqaQ5A@mail.gmail.com>
Subject: Re: [PATCH 2/8] ima: Use audit_log_format() rather than audit_log_string()
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: zohar@linux.vnet.ibm.com, sgrubb@redhat.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 4:10 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Remove the usage of audit_log_string() and replace it with
> audit_log_format().
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  security/integrity/ima/ima_policy.c  | 3 +--
>  security/integrity/integrity_audit.c | 6 +-----
>  2 files changed, 2 insertions(+), 7 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index a823f11a3e6b..7297450b813c 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -615,8 +615,7 @@ static void ima_log_string_op(struct audit_buffer *ab, char *key, char *value,
>                 audit_log_format(ab, "%s<", key);
>         else
>                 audit_log_format(ab, "%s=", key);
> -       audit_log_string(ab, value);
> -       audit_log_format(ab, " ");
> +       audit_log_format(ab, "%s ", value);
>  }
>  static void ima_log_string(struct audit_buffer *ab, char *key, char *value)
>  {
> diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
> index 90987d15b6fe..db30763d5525 100644
> --- a/security/integrity/integrity_audit.c
> +++ b/security/integrity/integrity_audit.c
> @@ -45,11 +45,7 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
>                          from_kuid(&init_user_ns, audit_get_loginuid(current)),
>                          audit_get_sessionid(current));
>         audit_log_task_context(ab);
> -       audit_log_format(ab, " op=");
> -       audit_log_string(ab, op);
> -       audit_log_format(ab, " cause=");
> -       audit_log_string(ab, cause);
> -       audit_log_format(ab, " comm=");
> +       audit_log_format(ab, " op=%s cause=%s comm=", op, cause);
>         audit_log_untrustedstring(ab, get_task_comm(name, current));
>         if (fname) {
>                 audit_log_format(ab, " name=");
> --
> 2.13.6
>
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit



-- 
paul moore
www.paul-moore.com
