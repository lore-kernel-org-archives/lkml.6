Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609CCC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239F0208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="0KAh+OAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfACULh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:11:37 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34481 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfACULg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:11:36 -0500
Received: by mail-lf1-f68.google.com with SMTP id p6so24061889lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 12:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AuxKHbU9FA81XXd/F2+f249n1iltP9iaImAvKk/KBLo=;
        b=0KAh+OAmbN8yvt0xS91hvxVkI/GT4U+/eNqcFSohWk1CO80gzWSEIdCc6OA9VvrQSO
         ajzz55bAfdPLsdZwIlNf4YcbydC3FNiuX1+fQ9N6nMAkaBSqm+SwKDdAF9PqVGuak7fM
         A57SFO7j3/Oo4FT7396yd8+ZMjHzZvP7IJD5WGV0uQFbgesFzdC8JmlY6jP0AORFBKKD
         t7cDNtEVaDQta03x3WO6522MLw/hrdYS+MvLW4kKlWpvMehW/+CvKvSJpahYiAgwpG75
         4GaIudkMf5GQq3Qc2xWXT8IdSyD05UBYXD0+OH1kf9hGyBnaxARkSXfT3mBTfaVF8aKd
         uVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AuxKHbU9FA81XXd/F2+f249n1iltP9iaImAvKk/KBLo=;
        b=TbhPVRFdTlaEj++d0AfUU5/bNfklGm4Tqrrh8ved6XJ/jNjp4qQC2IDpzk9cGZi/Dl
         mtOoMBdSwss//R7DANbGCt/39iDhqlDmBf0JvS4jXl6ptQI+uM4wjFdJIr//m2PuZOPS
         uzuQxWlh01Yiv4Gq+0YgwGdZgVh0QEcEIhHfJIzJOoQRD0AGecyfGxysl6vwv6cM34Gd
         rXE5cuxPezLsXOZAHB6Zl8y0GxIJWewBjfClUaFT/wl+NW6EYPb34S/1U7bU7GcV/Z4r
         rnLhUv5et0phfllmU23dcDL22jYR/XInBwGqHXkF+dUGfPyz64z7z9xpv3UwfLGbUATO
         TZcw==
X-Gm-Message-State: AA+aEWawDp5RVjm20qo6jD5g4DFVFO+llHGXqI7bJc84SAruAYdQCilC
        2R7SvAwyKAAk+qQciSCon1gF9/uxkFGc4SZ/sj72
X-Google-Smtp-Source: AFSGD/XujYrR0Z2HzjO/sgearvlzpC/w0z30mXtrSTEkWIgDjhggWiM7+IuwSLh+685aWFj2HBi6yz4i1dx5ySEPmhA=
X-Received: by 2002:a19:a7c1:: with SMTP id q184mr22852635lfe.4.1546546293731;
 Thu, 03 Jan 2019 12:11:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1533065887.git.rgb@redhat.com> <e41cb6760a8183c0955c378fce7b500819f9838f.1533065887.git.rgb@redhat.com>
 <CAHC9VhRPMAUsgs2zXkPEFZPQS6dmAO1-kBX1Y-7tRkD-kwGEjw@mail.gmail.com> <20181031211739.6jag6b5qve77qmmu@madcap2.tricolour.ca>
In-Reply-To: <20181031211739.6jag6b5qve77qmmu@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Jan 2019 15:11:22 -0500
Message-ID: <CAHC9VhTnj3Sg9R-XM0U9gqOsNXT+Tn+VVRXJtBTt0A0DPQ0GQg@mail.gmail.com>
Subject: Re: [PATCH ghak90 (was ghak32) V4 06/10] audit: add containerid
 support for tty_audit
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        luto@kernel.org, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 5:17 PM Richard Guy Briggs <rgb@redhat.com> wrote:
&gt; On 2018-10-19 19:17, Paul Moore wrote:
&gt; &gt; On Sun, Aug 5, 2018 at 4:33 AM Richard Guy Briggs
<rgb@redhat.com> wrote:
&gt; &gt; &gt; Add audit container identifier auxiliary record to tty
logging rule
&gt; &gt; &gt; event standalone records.
&gt; &gt; &gt;
&gt; &gt; &gt; Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
&gt; &gt; &gt; Acked-by: Serge Hallyn <serge@hallyn.com>
&gt; &gt; &gt; ---
&gt; &gt; &gt;  drivers/tty/tty_audit.c | 5 ++++-
&gt; &gt; &gt;  1 file changed, 4 insertions(+), 1 deletion(-)
&gt; &gt; &gt;
&gt; &gt; &gt; diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
&gt; &gt; &gt; index 50f567b..3e21477 100644
&gt; &gt; &gt; --- a/drivers/tty/tty_audit.c
&gt; &gt; &gt; +++ b/drivers/tty/tty_audit.c
&gt; &gt; &gt; @@ -66,8 +66,9 @@ static void tty_audit_log(const char
*description, dev_t dev,
&gt; &gt; &gt;         uid_t uid = from_kuid(&amp;init_user_ns, task_uid(tsk));
&gt; &gt; &gt;         uid_t loginuid = from_kuid(&amp;init_user_ns,
audit_get_loginuid(tsk));
&gt; &gt; &gt;         unsigned int sessionid = audit_get_sessionid(tsk);
&gt; &gt; &gt; +       struct audit_context *context =
audit_alloc_local(GFP_KERNEL);
&gt; &gt; &gt;
&gt; &gt; &gt; -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_TTY);
&gt; &gt; &gt; +       ab = audit_log_start(context, GFP_KERNEL, AUDIT_TTY);
&gt; &gt; &gt;         if (ab) {
&gt; &gt; &gt;                 char name[sizeof(tsk-&gt;comm)];
&gt; &gt; &gt;
&gt; &gt; &gt; @@ -80,6 +81,8 @@ static void tty_audit_log(const char
*description, dev_t dev,
&gt; &gt; &gt;                 audit_log_n_hex(ab, data, size);
&gt; &gt; &gt;                 audit_log_end(ab);
&gt; &gt; &gt;         }
&gt; &gt; &gt; +       audit_log_contid(context, "tty", audit_get_contid(tsk));
&gt; &gt; &gt; +       audit_free_context(context);
&gt; &gt; &gt;  }
&gt; &gt;
&gt; &gt; Since I never polished up my task_struct/current fix patch enough to
&gt; &gt; get it past RFC status during this development window (new job, stolen
&gt; &gt; laptop, etc.) *and* it looks like you are going to need at least one
&gt; &gt; more respin of this patchset, go ahead and fix this patch to use
&gt; &gt; current instead of generating a local context.  I'll deal with the
&gt; &gt; merge fallout if/when it happens.
&gt;
&gt; Sure, I will switch it to current in the call to audit_get_contid().
&gt;
&gt; The local context is a distinct issue.  Like USER records, I prefer
&gt; local due to potential record volume, it is already trackable as far as
&gt; Steve is concerned, and if it is to be connected with the syscall
&gt; record, it should be linked to syscall records in a seperate new github
&gt; issue with its own patch.  It accumulates events until the buffer is
&gt; flushed to a record, so the timestamp only represents the flush (usually
&gt; user "CR/enter").

Generally, yes, associating records is a separate issue, but in this
particular case you are changing this record by making it a "local"
record, which as we've discussed before, I view as a necessary evil
and something that must be minimized.  A quick look at the
tty_audit_log() callers shows tty_audit_tiocsti() which is an ioctl
handler (and thus current should be valid and correct), and
tty_audit_buf_push() whose callers all seem have valid and correct
current values; if you find that not to be the case please let me
know.

> > Local contexts are a last resort.  If you ever find yourself writing
> > code that generates a local context, you should first be 100% certain
> > that the event is not the the result of a process initiated action (in
> > which case it should take from the task's context).
>
> Well, I'm 100% certain it is linked to a process, but so are USER
> records that are already being discussed as the exception.  This is
> basically a keystroke logger (that has a flag to omit passwords).

--
paul moore
www.paul-moore.com
