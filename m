Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166018AbeBOUmL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:42:11 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43467 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755862AbeBOUmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:42:07 -0500
X-Google-Smtp-Source: AH8x227IXkvnwGugGWCCla5iusOrDGDn7q/ycciQe2pX+1Lnucw2/L8WhmDoQyK2sBkngS9e4mJV2FzHrafVKHqULA4=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <7289e57d94a0a13965e3dbd279cc8cd12dfb29a6.1518435853.git.rgb@redhat.com>
References: <cover.1518435853.git.rgb@redhat.com> <7289e57d94a0a13965e3dbd279cc8cd12dfb29a6.1518435853.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Feb 2018 15:42:04 -0500
Message-ID: <CAHC9VhRv_F=Gqs7EyTR2ZmLtJobyH9B8Cg-iiHE5hacTC-d=Pw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] audit: remove arch_f pointer from struct audit_krule
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 7:29 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> The arch_f pointer was added to the struct audit_krule in commit:
> e54dc2431d740a79a6bd013babade99d71b1714f ("audit signal recipients")
>
> This is only used on addition and deletion of rules which isn't time
> critical and the arch field is likely to be one of the first fields,
> easily found iterating over the field type.  This isn't worth the
> additional complexity and storage.  Delete the field.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h |  1 -
>  kernel/auditfilter.c  | 12 ++++++++----
>  2 files changed, 8 insertions(+), 5 deletions(-)

I haven't decided if I like the removal of arch_f or not, but I think
I might know where your oops/panic is coming from, thoughts below ...

> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index af410d9..64a3b0e 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -58,7 +58,6 @@ struct audit_krule {
>         u32                     field_count;
>         char                    *filterkey; /* ties events to rules */
>         struct audit_field      *fields;
> -       struct audit_field      *arch_f; /* quick access to arch field */
>         struct audit_field      *inode_f; /* quick access to an inode field */
>         struct audit_watch      *watch; /* associated watch */
>         struct audit_tree       *tree;  /* associated watched tree */
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 739a6d2..3343d1c 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -220,7 +220,14 @@ static inline int audit_match_class_bits(int class, u32 *mask)
>
>  static int audit_match_signal(struct audit_entry *entry)
>  {
> -       struct audit_field *arch = entry->rule.arch_f;
> +       int i;
> +       struct audit_field *arch;
> +
> +       for (i = 0; i < entry->rule.field_count; i++)
> +               if (entry->rule.fields[i].type == AUDIT_ARCH) {
> +                       arch = &entry->rule.fields[i];
> +                       break;
> +               }

In the original code arch_f was initialized to NULL via the allocator
so the arch local variable was guaranteed to have a valid value or
NULL.  Unfortunately, in your code if there is no AUDIT_ARCH field
arch could remain uninitialized which I believe could lead to the
oops/panic you are seeing.

>         if (!arch) {
>                 /* When arch is unspecified, we must check both masks on biarch
> @@ -496,9 +503,6 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
>                         if (!gid_valid(f->gid))
>                                 goto exit_free;
>                         break;
> -               case AUDIT_ARCH:
> -                       entry->rule.arch_f = f;
> -                       break;
>                 case AUDIT_SUBJ_USER:
>                 case AUDIT_SUBJ_ROLE:
>                 case AUDIT_SUBJ_TYPE:
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
