Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F91EC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A518120880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A518120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389015AbeGXXsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388945AbeGXXsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:48:11 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9EB220852;
        Tue, 24 Jul 2018 22:39:31 +0000 (UTC)
Date:   Tue, 24 Jul 2018 18:39:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Zubin Mithra <zsm@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] tracefs: Annotate tracefs_ops with __ro_after_init
Message-ID: <20180724183930.1ac4bcd0@gandalf.local.home>
In-Reply-To: <CAGXu5jJ7jS=ChfVF1oRJsGu-bSXK_WvTs94f_dQ9ud9Bt81-WA@mail.gmail.com>
References: <20180724200214.95975-1-zsm@chromium.org>
        <CAGXu5jJ7jS=ChfVF1oRJsGu-bSXK_WvTs94f_dQ9ud9Bt81-WA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 15:07:18 -0700
Kees Cook <keescook@chromium.org> wrote:

> Adding Steven (maintainer) and Al (fs) to CC...

Thanks, first I've seen of this.

> 
> On Tue, Jul 24, 2018 at 1:02 PM, Zubin Mithra <zsm@chromium.org> wrote:
> > tracefs_ops is initialized inside tracefs_create_instance_dir and not
> > modified after. tracefs_create_instance_dir allows for initialization
> > only once, and is called from create_trace_instances(marked __init),
> > which is called from tracer_init_tracefs(marked __init).

Then, especially with this change, we should mark
tracefs_create_instance_dir() as init, as it would fail any other time.

> >
> > Signed-off-by: Zubin Mithra <zsm@chromium.org>
> > Reviewed-by: Kees Cook <keescook@chromium.org>  
> 
> Who's tree should this go through?

I can take it or someone else can, and I'll ack it if need be.

-- Steve


> 
> Thanks!
> 
> -Kees
> 
> > ---
> >  fs/tracefs/inode.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> > index bea8ad876bf9..20e965873f27 100644
> > --- a/fs/tracefs/inode.c
> > +++ b/fs/tracefs/inode.c
> > @@ -53,7 +53,7 @@ static const struct file_operations tracefs_file_operations = {
> >  static struct tracefs_dir_ops {
> >         int (*mkdir)(const char *name);
> >         int (*rmdir)(const char *name);
> > -} tracefs_ops;
> > +} tracefs_ops __ro_after_init;
> >
> >  static char *get_dname(struct dentry *dentry)
> >  {
> > --
> > 2.18.0.233.g985f88cf7e-goog
> >  
> 
> 
> 

