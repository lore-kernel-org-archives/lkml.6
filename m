Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161524AbeBNRvX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:51:23 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:45691 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161472AbeBNRvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:51:21 -0500
X-Google-Smtp-Source: AH8x227n9pVdVKvUxtgYKcLlo3a24M5FaBQTkR/XE0QRy+ZPn/4dxSOLFEJ64FK4Z5wlSygScbOduIQ6Dc/jz8iJ0vQ=
MIME-Version: 1.0
In-Reply-To: <3a9542b261d93bc4eaecfaf359affbba152cf965.1518603831.git.rgb@redhat.com>
References: <cover.1518603831.git.rgb@redhat.com> <3a9542b261d93bc4eaecfaf359affbba152cf965.1518603831.git.rgb@redhat.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 14 Feb 2018 09:51:17 -0800
X-Google-Sender-Auth: qERgHePw_1hH8yJTUy7B_C8Qh0s
Message-ID: <CAGXu5jKtEv-W3R-uakY9S9=OFmjY3ZqxQJFa3YxGd4RWyUEGgQ@mail.gmail.com>
Subject: Re: [RFC PATCH ghak21 1/4] audit: make ANOM_LINK obey audit_enabled
 and audit_dummy_context
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 8:18 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Audit link denied events emit disjointed records when audit is disabled.
> No records should be emitted when audit is disabled.
>
> See: https://github.com/linux-audit/audit-kernel/issues/21
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 227db99..4c3fd24 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2261,6 +2261,9 @@ void audit_log_link_denied(const char *operation, const struct path *link)
>         struct audit_buffer *ab;
>         struct audit_names *name;
>
> +       if (!audit_enabled || audit_dummy_context())
> +               return;
> +
>         name = kzalloc(sizeof(*name), GFP_NOFS);
>         if (!name)
>                 return;

Doesn't this means errors here would be silent if audit isn't enabled?
I don't that; sysadmins should see this notification regardless of the
audit state...

-Kees

-- 
Kees Cook
Pixel Security
