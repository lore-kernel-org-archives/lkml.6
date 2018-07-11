Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249CFC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D0B20883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D0B20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733111AbeGKO5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732321AbeGKO5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:57:40 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4575220C0D;
        Wed, 11 Jul 2018 14:52:57 +0000 (UTC)
Date:   Wed, 11 Jul 2018 10:52:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where
 applicable
Message-ID: <20180711105255.32803a3c@gandalf.local.home>
In-Reply-To: <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
References: <20180628090351.15581-1-hdegoede@redhat.com>
        <20180628090351.15581-3-hdegoede@redhat.com>
        <717e6337-e7a6-7a92-1c1b-8929a25696b5@suse.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 16:46:11 +0200
Thomas Zimmermann <tzimmermann@suse.de> wrote:

> Hi
> 
> Am 28.06.2018 um 11:03 schrieb Hans de Goede:
> > Replace comments about places where the console lock should be held with
> > calls to WARN_CONSOLE_UNLOCKED() to assert that it is actually held.  
> 
> Debugging fbcon sometimes requires to not take the console lock. This
> patch breaks the debugging workaround provided by
> 'fb.lockless_register_fb'. The dmesg is now filled with warnings about
> the missing lock.
> 

What if you make lockless_register_fb visible to fbcon, and then we can
have a macro:

#define WARN_FB_CONSOLE_UNLOCKED() 			\
	do {						\
		if (unlikely(!lockless_register_fb))	\
			WARN_CONSOLE_UNLOCKED();	\
	} while (0)

And use that instead?

-- Steve


> Best regards
> Thomas
> 
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> > Changes in v3:
> > -New patch in v3 of this patchset
> >
> > Changes in v4:
> > -Keep the comments about which fbcon functions need locks in place
> > ---
> >  drivers/video/fbdev/core/fbcon.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> > index c910e74d46ff..cd8d52a967aa 100644
> > --- a/drivers/video/fbdev/core/fbcon.c
> > +++ b/drivers/video/fbdev/core/fbcon.c
> > @@ -828,6 +828,8 @@ static int set_con2fb_map(int unit, int newidx, int user)
> >  	struct fb_info *oldinfo = NULL;
> >   	int found, err = 0;
> >  
> > +	WARN_CONSOLE_UNLOCKED();
> > +
> >  	if (oldidx == newidx)
> >  		return 0;
> >  
> > @@ -3044,6 +3046,8 @@ static int fbcon_fb_unbind(int idx)
> >  {
> >  	int i, new_idx = -1, ret = 0;
> >  
> > +	WARN_CONSOLE_UNLOCKED();
> > +
> >  	if (!fbcon_has_console_bind)
> >  		return 0;
> >  
> > @@ -3094,6 +3098,8 @@ static int fbcon_fb_unregistered(struct fb_info *info)
> >  {
> >  	int i, idx;
> >  
> > +	WARN_CONSOLE_UNLOCKED();
> > +
> >  	idx = info->node;
> >  	for (i = first_fb_vc; i <= last_fb_vc; i++) {
> >  		if (con2fb_map[i] == idx)
> > @@ -3131,6 +3137,9 @@ static int fbcon_fb_unregistered(struct fb_info *info)
> >  static void fbcon_remap_all(int idx)
> >  {
> >  	int i;
> > +
> > +	WARN_CONSOLE_UNLOCKED();
> > +
> >  	for (i = first_fb_vc; i <= last_fb_vc; i++)
> >  		set_con2fb_map(i, idx, 0);
> >  
> > @@ -3177,6 +3186,8 @@ static int fbcon_fb_registered(struct fb_info *info)
> >  {
> >  	int ret = 0, i, idx;
> >  
> > +	WARN_CONSOLE_UNLOCKED();
> > +
> >  	idx = info->node;
> >  	fbcon_select_primary(info);
> >    
> 

