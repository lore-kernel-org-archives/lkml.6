Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753080AbeDQWG2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 18:06:28 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33236 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752939AbeDQWG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 18:06:27 -0400
X-Google-Smtp-Source: AIpwx48FMCWjPcB1hFmB9FKrHvHdlAomIzr8aEt/5CSIu06/vckrt/kW+CDG0qg9CTsYIq+lYJ9iRSfq9657ux55zCw=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <08bd08ee9bc70f6e98b9e298ba6a2c0f4dcadb4b.1523372093.git.rgb@redhat.com>
References: <08bd08ee9bc70f6e98b9e298ba6a2c0f4dcadb4b.1523372093.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Apr 2018 18:06:24 -0400
Message-ID: <CAHC9VhSxjEKNcdE2Mm-Vwef6RvTG2ykGFFmeAtVypAaPRvddmg@mail.gmail.com>
Subject: Re: [PATCH ghak80 V1] audit: add syscall information to
 FEATURE_CHANGE records
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 8:46 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Tie syscall information to FEATURE_CHANGE calls since it is a result of
> user action.
>
> See: https://github.com/linux-audit/audit-kernel/issues/80
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 8da24ef..23f125b 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1103,10 +1103,9 @@ static void audit_log_feature_change(int which, u32 old_feature, u32 new_feature
>  {
>         struct audit_buffer *ab;
>
> -       if (audit_enabled == AUDIT_OFF)
> +       if (!audit_enabled)

Sooo, this is an unrelated style change, why?  Looking at the rest of
kernel/audit.c we seem to use a mix of "(!x)" and "(x == 0/CONST)" so
why are you adding noise to this patch?

>                 return;
> -
> -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_FEATURE_CHANGE);
> +       ab = audit_log_start(current->audit_context, GFP_KERNEL, AUDIT_FEATURE_CHANGE);

This is the important part, and the Right Thing To Do.

>         if (!ab)
>                 return;
>         audit_log_task_info(ab, current);
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
