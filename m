Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KQWzASxuHlsZWAAAmS7hNA
	; Mon, 11 Jun 2018 12:43:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 85D1760792; Mon, 11 Jun 2018 12:43:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0AA48601C3;
	Mon, 11 Jun 2018 12:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0AA48601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933079AbeFKMnF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 08:43:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:47323 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932882AbeFKMnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 08:43:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 82F7EAF2D;
        Mon, 11 Jun 2018 12:43:02 +0000 (UTC)
Date: Mon, 11 Jun 2018 14:43:01 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: jikos@kernel.org, jpoimboe@redhat.com, jeyu@kernel.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] livepatch: Deny the patched modules to be removed
In-Reply-To: <20180611114121.2u7wt6d6xu2cm6it@pathway.suse.cz>
Message-ID: <alpine.LSU.2.21.1806111429580.1279@pobox.suse.cz>
References: <20180607092949.1706-1-mbenes@suse.cz> <20180607092949.1706-3-mbenes@suse.cz> <20180611114121.2u7wt6d6xu2cm6it@pathway.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2018, Petr Mladek wrote:

> On Thu 2018-06-07 11:29:48, Miroslav Benes wrote:
> > We decided to deny the patched modules to be removed. If it proves to be
> > a major drawback for users, we can still implement a different approach.
> > 
> > The reference of a patched module has to be taken regardless of a
> > patch's state. Thus it is not taken and dropped in enable/disable paths,
> > but in register/unregister paths.
> 
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -739,6 +746,14 @@ static int klp_init_object_loaded(struct klp_patch *patch,
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * Do not allow patched modules to be removed.
> > +	 *
> > +	 * All callers of klp_init_object_loaded() set obj->mod.
> > +	 */
> > +	if (klp_is_module(obj) && !try_module_get(obj->mod))
> > +		return -ENODEV;
> > +
> >  	return 0;
> >  }
> 
> This looks strange. We try to take the reference after we do all
> actions needed for a loaded module. There is nothing that would
> prevent obj->mod to get into the going state.

Yes, there was an intention to keep the number of necessary modifications 
of the error paths as low as possible.
 
> Note that it was safe (except for the relocated symbols) because
> the module was not able to really go until it called
> klp_module_going(). But you removed this last break
> by the 3rd patch.

Yes, try_module_get() would return an error here.
 
> I suggest another approach:
> 
> I would rename klp_find_object_module() to klp_get_object_module()
> and get the reference there. Note that it should be fine to call
> it later in klp_init_object() (before klp_init_object_loaded()).
> This would solve klp_init_patch().
> 
> We will also need to get the reference in klp_module_coming().
> It can be called anywhere there. If it fails, we will block
> loading the module.

I can as well move the above hunk up in klp_init_object_loaded(), no? Not 
that I'm seeing a problem to have it in klp_find_object_module().
 
> Note that the mod->klp_alive logic will still be necessary.
> It solves various races when both the patch and the patched
> module are loaded in parallel.
>
> Sigh, this also means that we still could call klp_init_object_loaded()
> and apply reloacations even when the patched module fails to loaded
> later from other reasons. This means that this approach does not
> solve the original problem completely.

That would be in klp_module_coming(). Hm, you're right.
 
> I wonder how complicated would be the arch-specific part that
> would clean up relocations when the module is unloaded.

I don't think it would be complicated. We just want to avoid it, because 
it is arch-specific. It is more difficult to maintain such code.

Regards,
Miroslav
