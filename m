Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754018AbeDPH0u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 03:26:50 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42672 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753994AbeDPH0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 03:26:40 -0400
X-Google-Smtp-Source: AIpwx48K3qM/TRaQiOgLfo4E5IHdcaySTe5FVtKBxt/zYRkcPbmJab4MX+uSmCohequQ+RVpBD02tMLse2jofOiC/Ck=
MIME-Version: 1.0
In-Reply-To: <6b939250a519668af109adf877d85ff018b217d7.1523316267.git.rgb@redhat.com>
References: <6b939250a519668af109adf877d85ff018b217d7.1523316267.git.rgb@redhat.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 16 Apr 2018 09:26:23 +0200
Message-ID: <CAFqZXNuEwxp7vThtVH1oYSE5bAisvwNpBH3ry9tyL5BPSwXK=g@mail.gmail.com>
Subject: Re: [PATCH ghak46 V1] audit: normalize MAC_STATUS record
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@tycho.nsa.gov>,
        Linux Security Module list
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-10 1:34 GMT+02:00 Richard Guy Briggs <rgb@redhat.com>:
> There were two formats of the audit MAC_STATUS record, one of which was more
> standard than the other.  One listed enforcing status changes and the
> other listed enabled status changes with a non-standard label.  In
> addition, the record was missing information about which LSM was
> responsible and the operation's completion status.  While this record is
> only issued on success, the parser expects the res= field to be present.
>
> old enforcing/permissive:
> type=MAC_STATUS msg=audit(1523312831.378:24514): enforcing=0 old_enforcing=1 auid=0 ses=1
> old enable/disable:
> type=MAC_STATUS msg=audit(1523312831.378:24514): selinux=0 auid=0 ses=1
>
> List both sets of status and old values and add the lsm= field and the
> res= field.
>
> Here is the new format:
> type=MAC_STATUS msg=audit(1523293828.657:891): enforcing=0 old_enforcing=1 auid=0 ses=1 enabled=1 old-enabled=1 lsm=selinux res=1
>
> This record already accompanied a SYSCALL record.
>
> See: https://github.com/linux-audit/audit-kernel/issues/46
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  security/selinux/selinuxfs.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 00eed84..00b21b2 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -145,10 +145,11 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
>                 if (length)
>                         goto out;
>                 audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_STATUS,
> -                       "enforcing=%d old_enforcing=%d auid=%u ses=%u",
> +                       "enforcing=%d old_enforcing=%d auid=%u ses=%u"
> +                       " enabled=%d old-enabled=%d lsm=selinux res=1",

This is just a tiny nit but why does "old_enforcing" use an underscore
and "old-enabled" a dash? Shouldn't the style be consistent across
fields?

Just my two cents...

>                         new_value, selinux_enforcing,
>                         from_kuid(&init_user_ns, audit_get_loginuid(current)),
> -                       audit_get_sessionid(current));
> +                       audit_get_sessionid(current), selinux_enabled, selinux_enabled);
>                 selinux_enforcing = new_value;
>                 if (selinux_enforcing)
>                         avc_ss_reset(0);
> @@ -272,9 +273,11 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
>                 if (length)
>                         goto out;
>                 audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_STATUS,
> -                       "selinux=0 auid=%u ses=%u",
> +                       "enforcing=%d old_enforcing=%d auid=%u ses=%u"
> +                       " enabled=%d old-enabled=%d lsm=selinux res=1",
> +                       selinux_enforcing, selinux_enforcing,

^ also here

>                         from_kuid(&init_user_ns, audit_get_loginuid(current)),
> -                       audit_get_sessionid(current));
> +                       audit_get_sessionid(current), 0, 1);
>         }
>
>         length = count;
> --
> 1.8.3.1
>
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
