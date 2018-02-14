Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031670AbeBNVkx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:40:53 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34096 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031406AbeBNVkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:40:51 -0500
X-Google-Smtp-Source: AH8x224iCtHtF+Njyn8Rx/ksQgfRQBQPGZIyyCnpLRZTMdiCFaqCdh3uFbPt0njWnF3ObeQSh43KPGZ+yq9PZjW8VTA=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <8bd4cb1d24af27d9ace70f03300d5033e38e5a48.1518429770.git.rgb@redhat.com>
References: <8bd4cb1d24af27d9ace70f03300d5033e38e5a48.1518429770.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 14 Feb 2018 16:40:49 -0500
Message-ID: <CAHC9VhQgG3X4w2XpUD6zwv1TnZAL6C6KarcUqk9XgEfJN47yrw@mail.gmail.com>
Subject: Re: [PATCH] audit: session ID should not set arch quick field pointer
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 5:04 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> A bug was introduced in 8fae47705685fcaa75a1fe4c8c3e18300a702979
> ("audit: add support for session ID user filter")
> See: https://github.com/linux-audit/audit-kernel/issues/4
>
> When setting a session ID filter, the session ID filter field overwrote
> the quick pointer reference to the arch field, potentially causing the
> arch field to be misinterpreted.
>
> Passes audit-testsuite.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditfilter.c | 1 -
>  1 file changed, 1 deletion(-)

Good catch.  Merged.

Looking at the original patch and audit_field_valid(), I think we
should probably look into tightening up what constitutes "valid"
fields.  For example, does it make sense to allow anything but
equal/not-equal when comparing AUDIT_SUBJ_TYPE? (note well: this is
just one example, there are many more)

* https://github.com/linux-audit/audit-kernel/issues/73

> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 4a1758a..739a6d2 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -496,7 +496,6 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
>                         if (!gid_valid(f->gid))
>                                 goto exit_free;
>                         break;
> -               case AUDIT_SESSIONID:
>                 case AUDIT_ARCH:
>                         entry->rule.arch_f = f;
>                         break;
> --
> 1.8.3.1
>

-- 
paul moore
www.paul-moore.com
