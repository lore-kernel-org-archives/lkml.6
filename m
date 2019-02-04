Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897CFC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC1620844
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549319435;
	bh=uqfAAJNvTF8TMUEqeFpVxpZBmKU1zbs/Ov+X3It9DwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aPjpFulul3TOld0klQJV8Pba5PC36a0/4zsFDbaso0ZhmWdWpkWuMOPatWiD2Jno2
	 13UX4wLSc7b0KuOM6ZwbgCw2AU+mmG0A9mjuFf2ymh1YNg2jopLSyc3hM9lnplhzy/
	 mPPGqEwZ10/EBuheUWgSlGQoTiFlTgP8CIv+qmII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfBDWad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:30:33 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36513 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfBDWac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:30:32 -0500
Received: by mail-yw1-f68.google.com with SMTP id x65so982578ywg.3;
        Mon, 04 Feb 2019 14:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uY3yXN+xNddVYKpd6S1PrG5wFrsb5mhRKWMVJfJc1Ho=;
        b=VyVUp6poDI0s/qUfRuAL5AO7wMyPjPLD1uMhkYNhM/AgvXqp5/ap/X+4NsJIrv53WC
         3z3NZGdVl3MRqAD3+kGnAy9StfbZQxF231fZ+DDrsNIWhGsrxutRjpwqEtYO3AalaEKW
         bvhjqakWPGjPJezCdT+AnuM38428zKnzERAVqdaGBtK8SvKmtl33DOYh9kU6EimULueu
         ZelDfP6pnTq0FQowFDG47EFGk4GnQX1uv1t4IC4MZg3d3MQN5+2jt7nh1+3cge1VuLrI
         yLZu3+KCpgmw9wGZmduyU2rSmO3gn0nCOcJ9ttfb96CmmrmyKSV/fX20+kdA/VZqcE36
         FZJA==
X-Gm-Message-State: AHQUAuZ3681VmoHqOpnuMr9PwhmUeQxmRRrHqaQf4FlHckpqWtUoMrlt
        eFcpSTbdpFRV6zxCcCLzhdjra4akJAc=
X-Google-Smtp-Source: AHgI3IZBYhQh9lESjMVy/d2JlEqxcbL/qT7suNJb42i78iQCWWUPzGIO6o57HGcbvuNdgUgE8iodAA==
X-Received: by 2002:a81:b243:: with SMTP id q64mr1422837ywh.351.1549319431360;
        Mon, 04 Feb 2019 14:30:31 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id 137sm436785ywv.108.2019.02.04.14.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 14:30:29 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Mon, 04 Feb 2019 14:30:26 -0800
Date:   Mon, 4 Feb 2019 14:30:26 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Justin Forbes <jforbes@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] x86/ima: require signed kernel modules
Message-ID: <20190204223026.GR11489@garbanzo.do-not-panic.com>
References: <1548962339-10681-1-git-send-email-zohar@linux.ibm.com>
 <1548962339-10681-2-git-send-email-zohar@linux.ibm.com>
 <20190204203850.GP11489@garbanzo.do-not-panic.com>
 <1549317910.4146.124.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1549317910.4146.124.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 05:05:10PM -0500, Mimi Zohar wrote:
> On Mon, 2019-02-04 at 12:38 -0800, Luis Chamberlain wrote:
> > On Thu, Jan 31, 2019 at 02:18:59PM -0500, Mimi Zohar wrote:
> > > diff --git a/kernel/module.c b/kernel/module.c
> > > index 2ad1b5239910..70a9709d19eb 100644
> > > --- a/kernel/module.c
> > > +++ b/kernel/module.c
> > > @@ -275,16 +275,23 @@ static void module_assert_mutex_or_preempt(void)
> > >  
> > >  static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
> > >  module_param(sig_enforce, bool_enable_only, 0644);
> > > +static bool sig_required;
> > >  
> > >  /*
> > >   * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
> > >   * on that instead of directly to CONFIG_MODULE_SIG_FORCE config.
> > 
> > But the docs were't updated.
> 
> Neither "CONFIG_MODULE_SIG_FORCE" nor "module.sig_enforce" has
> changed.  Which docs are you referring to? 

You renamed is_module_sig_enforced() to is_module_sig_enforced_or_required()
and left the above doc which only justifies the enforced path.

> > >   */
> > > -bool is_module_sig_enforced(void)
> > > +bool is_module_sig_enforced_or_required(void)
> > >  {
> > > -	return sig_enforce;
> > > +	return sig_enforce || sig_required;
> > >  }
> > > -EXPORT_SYMBOL(is_module_sig_enforced);
> > > +EXPORT_SYMBOL(is_module_sig_enforced_or_required);
> > 
> > Meh, this is getting sloppy, the module signing infrastructure should
> > just be LSM'ified now that we have stacked LSMs. That would
> > compartamentaliz that code and make this much easier to read / understand
> > and mantain.
> > 
> > Can you take a look at doing it that way instead?
> 
> This patch is about coordinating the existing methods of verifying
> kernel module signatures.

I understand.

> > 
> > >  /* Block module loading/unloading? */
> > >  int modules_disabled = 0;
> > > @@ -2789,7 +2796,7 @@ static int module_sig_check(struct load_info *info, int flags)
> > >  	}
> > >  
> > >  	/* Not having a signature is only an error if we're strict. */
> > > -	if (err == -ENOKEY && !is_module_sig_enforced())
> > > +	if (err == -ENOKEY && !is_module_sig_enforced_or_required())
> > 
> > This is where I think a proper LSM hook would make sense. I think
> > that these "questions" model for signing don't work well on the LSM
> > hook model, perhaps just:
> > 
> > kernel_module_signed()
> > 
> > Suffices, therefore if not enforced or required its signed. If its
> > enforced or required and really signed, then it signed.
> > 
> > >  		err = 0;
> > >  
> > >  	return err;
> > > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > > index 357edd140c09..bbaf87f688be 100644
> > > --- a/security/integrity/ima/ima_main.c
> > > +++ b/security/integrity/ima/ima_main.c
> > > @@ -563,7 +563,7 @@ int ima_load_data(enum kernel_load_data_id id)
> > >  		}
> > >  		break;
> > >  	case LOADING_MODULE:
> > > -		sig_enforce = is_module_sig_enforced();
> > > +		sig_enforce = is_module_sig_enforced_or_required();
> > 
> > Yet another user.
> > 
> > >  		if (ima_enforce && (!sig_enforce
> > >  				    && (ima_appraise & IMA_APPRAISE_MODULES))) {
> > > -- 
> > > 2.7.5
> > 
> > Plus I think LSM'ifying module signing may help cleaning up some of the
> > #ifdery and config options around module signing. I'm suggestin this now 
> > as this has been on my mental TODO list for a while, and just not sure
> > when we'd get to it, if not you, not sure when it'd get done.
> > 
> > Then, do we have proper unit tests for the mixture of options to ensure
> > we can easily ensure we don't regress?
> > 
> 
> There are already two methods  - appended signatures and IMA xattrs -
> for validating kernel modules.
> 
> Kernel modules shouldn't be treated any differently than any other
> file.

The good 'ol kernel module signing code *does* treat it as such.

> Based on the IMA policy, the kernel module signature can be
> verified.  Also based on the IMA policy, the file hash added to the
> measurement list, and the file hash used to extend the TPM PCR.
>  Lastly, based on policy the file hash can be added to the audit log.

Sure...

> I don't see a need for an additional LSM just for verifying kernel
> module signatures.

But it is one, module signing was just spawned pre the boom of LSMs.

I do believe that treating the code as such would help with its reading
and long term maintenance.

Anyway, I had to try to convince you.

 Luis
