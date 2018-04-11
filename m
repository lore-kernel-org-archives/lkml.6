Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755322AbeDKVLv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 17:11:51 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44580 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754368AbeDKVLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 17:11:46 -0400
X-Google-Smtp-Source: AIpwx48Y2ZHhS6r3CzW7z7++K/rwzQa3oCXQmfGbPjtMd3m5vzadT/TenUV8LlL+m48mltxPgo+iU7XtkgJ9tj2sltQ=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <eb67b174e6a3d0fe174cc738d9109cd7fda96a9b.1523316291.git.rgb@redhat.com>
References: <eb67b174e6a3d0fe174cc738d9109cd7fda96a9b.1523316291.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Apr 2018 17:11:44 -0400
Message-ID: <CAHC9VhTv_2ErGe38u+Z2CGY2BhNqbG0u_tqbMmwOYUsr4jJ3aQ@mail.gmail.com>
Subject: Re: [PATCH ghak47 V1] audit: normalize MAC_POLICY_LOAD record
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@tycho.nsa.gov>,
        Linux Security Module list
        <linux-security-module@vger.kernel.org>,
        Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 9, 2018 at 7:36 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> The audit MAC_POLICY_LOAD record had redundant dangling keywords and was
> missing information about which LSM was responsible and its completion
> status.  While this record is only issued on success, the parser expects
> the res= field to be present.
>
> Old record:
> type=MAC_POLICY_LOAD msg=audit(1479299795.404:43): policy loaded auid=0 ses=1
>
> Delete the redundant dangling keywords, add the lsm= field and the res=
> field.
>
> New record:
> type=MAC_POLICY_LOAD msg=audit(1523293846.204:894): auid=0 ses=1 lsm=selinux res=1
>
> See: https://github.com/linux-audit/audit-kernel/issues/47
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  security/selinux/selinuxfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 00b21b2..496915a 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -531,7 +531,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
>
>  out1:
>         audit_log(current->audit_context, GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
> -               "policy loaded auid=%u ses=%u",
> +               "auid=%u ses=%u lsm=selinux res=1",

This is another case of NACK on principle, but I think we can make an
exception in this particular case.

Also like the other patch, this will need to wait for the merge window
to close before I can merge it.

>                 from_kuid(&init_user_ns, audit_get_loginuid(current)),
>                 audit_get_sessionid(current));
>  out:
> --
> 1.8.3.1
>

-- 
paul moore
www.paul-moore.com
