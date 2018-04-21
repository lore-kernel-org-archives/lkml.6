Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AIpwx4+gmpCONw98Das2xFb2wgPqmlv/SOLP8vSypvLLPBcmyTahs7yMR7zDG2l6mPzCWcGWRxS7
ARC-Seal: i=1; a=rsa-sha256; t=1524322154; cv=none;
        d=google.com; s=arc-20160816;
        b=wl8V8x9IXPNq0wn62itmodrTZtvvY3aeF0+X6dtN3LNROP5gguq4xY3EIwLHlu7w3t
         TI8Vp9gjoiBu1Ry5JgvrD0Vwgw6G4PlovTmrIHGXyLzlxajkZselD6wir72SUIS9RmRn
         AvJbHh98bMdIhtW9k55+iyHbMOQUaeOqb9AsNW+DSXIlG+pwNhOksFlhwMPysCqR9MEs
         9C5hlPikHWmTOStska7cZa69j4YooJxpCB1YIfDjXpZdnlYObSx212VGTa57fz3DZ1Yk
         Hhxf5VqekSrILRm1wfDEha0M4gltfzMnqXQM7xJFoKHkdAmUCci48reGAqb8naoDBJ5e
         v2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Z7fRnUAVgujKO6NzZoEeu+f2aVz8PQ/5CqkRfpznDXs=;
        b=ahJFbCgR7LFKR+9s7wBfWHyf/dRyj+D0WBcYuEnxnQZDjdCbEJLNMu+Nr7V0qisRsp
         dQBVPAem8oVM3XXl5TOoNDL6cGu9khEmH9YpoNlYblJXtD67C77WpudeYZ5IG0t6LWmv
         LtS8b05yMaaoxpmKLkgk4u44WzLRRa9S4KwA/S5xdyfvfGOcBLOR+GtTm2KE4vjbJlnz
         CPolj9le/kaICvB+7ZegbEHofLm1QnQJGQqS/JIU6CVMd77G4+iDTpLqODO5Cy7/ltNq
         gFBnR6vluKHYacGSQ6qTfnyEpSQhq4xeTmDrWA6gDn8zJByxv948isTPynulsXxunXF4
         HI5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Sat, 21 Apr 2018 16:49:11 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Andres Rodriguez <andresx7@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
	alexdeucher@gmail.com, ckoenig.leichtzumerken@gmail.com,
	kvalo@codeaurora.org, arend.vanspriel@broadcom.com
Subject: Re: [PATCH 5/9] firmware: add functions to load firmware without
 warnings v4
Message-ID: <20180421144911.GV14440@wotan.suse.de>
References: <20180417153307.3693-1-andresx7@gmail.com>
 <20180417153307.3693-6-andresx7@gmail.com>
 <20180421143206.GQ14440@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180421143206.GQ14440@wotan.suse.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008015463324966?=
X-GMAIL-MSGID: =?utf-8?q?1598367627684898678?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 21, 2018 at 04:32:06PM +0200, Luis R. Rodriguez wrote:
> On Tue, Apr 17, 2018 at 11:33:03AM -0400, Andres Rodriguez wrote:
> > @@ -755,10 +779,11 @@ static void firmware_request_work_func(struct work_struct *work)
> >  }
> >  
> >  /**
> > - * firmware_request_nowait() - asynchronous version of firmware_request
> > + * firmware_request_nowait2() - asynchronous version of firmware_request
> >   * @module: module requesting the firmware
> >   * @uevent: sends uevent to copy the firmware image if this flag
> >   *	is non-zero else the firmware copy must be done manually.
> > + * @warn: enable warnings
> >   * @name: name of firmware file
> >   * @device: device for which firmware is being loaded
> >   * @gfp: allocation flags
> > @@ -778,8 +803,8 @@ static void firmware_request_work_func(struct work_struct *work)
> >   *		- can't sleep at all if @gfp is GFP_ATOMIC.
> >   **/
> >  int
> > -firmware_request_nowait(
> > -	struct module *module, bool uevent,
> > +firmware_request_nowait2(
> > +	struct module *module, bool uevent, bool warn,
> >  	const char *name, struct device *device, gfp_t gfp, void *context,
> >  	void (*cont)(const struct firmware *fw, void *context))
> >  {
> > @@ -799,7 +824,8 @@ firmware_request_nowait(
> >  	fw_work->context = context;
> >  	fw_work->cont = cont;
> >  	fw_work->opt_flags = FW_OPT_NOWAIT |
> > -		(uevent ? FW_OPT_UEVENT : FW_OPT_USERHELPER);
> > +		(uevent ? FW_OPT_UEVENT : FW_OPT_USERHELPER) |
> > +		(warn ? 0 : FW_OPT_NO_WARN);
> >  
> >  	if (!uevent && fw_cache_is_setup(device, name)) {
> >  		kfree_const(fw_work->name);
> > @@ -818,6 +844,24 @@ firmware_request_nowait(
> >  	schedule_work(&fw_work->work);
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL_GPL(firmware_request_nowait2);
> > +
> > +/**
> > + * firmware_request_nowait() - compatibility version of firmware_request_nowait2
> > + *
> > + * This is equivalent to calling firmware_request_nowait2 with warnings enabled.
> > + *
> > + * Refer to firmware_request_nowait2 for further details.
> > + **/
> > +int
> > +firmware_request_nowait(
> > +	struct module *module, bool uevent,
> > +	const char *name, struct device *device, gfp_t gfp, void *context,
> > +	void (*cont)(const struct firmware *fw, void *context))
> > +{
> > +	return firmware_request_nowait2(module, uevent, true, name, device,
> > +					gfp, context, cont);
> > +}
> >  EXPORT_SYMBOL(firmware_request_nowait);
> >  
> >  #ifdef CONFIG_PM_SLEEP
> 
> Ugh this is precisely the type of naming issue I predicted *years ago*
> about the unflexibility of the naming scheme we used. Greg, since you had
> sent us this rabbit hole, any name preference here? Please review what is
> proposed and also suggest a scheme which you do prefer. I'm done with
> the bikeshedding and just want to move on, but in a way that scales.

I'll side for now with Kalle's suggestion of having:

firmware_request_nowait_nowarn()

as nasty as it may seem. And this is just because we embarked on
the path to not have parameters passed to modify the calls site.

  Luis
