Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE3FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 07:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9A82083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 07:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="IW5nDyJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfBEHWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 02:22:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:32838 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfBEHWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 02:22:31 -0500
Received: from zn.tnic (p200300EC2BCB6B008896F3D5E1C66173.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:6b00:8896:f3d5:e1c6:6173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B36B1EC0253;
        Tue,  5 Feb 2019 08:22:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549351350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zyCZyAsfCf0VuCetINl8zwDIlPBxx8sFM245CaTzOHI=;
        b=IW5nDyJChJ5CE7LHp+i21eycoP7q1JjiGRMmrIxLeY3NnhrCrJp0yv1GdJTsAFu3gGrdfn
        HKKDdOAcR25CKj4ht7PGmVCRyAz5YDRpOyoBYR08Zit5OK+N/MV0mQhcjUQ6Gf1+Aq3q1z
        sNCia70bBph8uxo8DyAHYA/majHonGg=
Date:   Tue, 5 Feb 2019 08:22:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V4 2/9] jump_label: Add the jump_label_can_update_check()
 helper
Message-ID: <20190205072220.GD21801@zn.tnic>
References: <cover.1549308412.git.bristot@redhat.com>
 <36237a0ee38d6c98d080d3fee2921501d8788e4d.1549308412.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36237a0ee38d6c98d080d3fee2921501d8788e4d.1549308412.git.bristot@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V4 2/9] jump_label: Add the jump_label_can_update_check() helper

s/the/a/

On Mon, Feb 04, 2019 at 08:58:55PM +0100, Daniel Bristot de Oliveira wrote:
> Move the check of if a jump_entry is valid to a function.

s/of //

> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index 288d630da22d..456c0d7cbb5b 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -374,22 +374,32 @@ static enum jump_label_type jump_label_type(struct jump_entry *entry)
>  	return enabled ^ branch;
>  }
>  
> +bool jump_label_can_update_check(struct jump_entry *entry, bool init)

static.

Also, "jump_label_can_update" is sufficient for a name AFAICT.

> +{
> +	/*
> +	 * An entry->code of 0 indicates an entry which has been
> +	 * disabled because it was in an init text area.
> +	 */
> +	if (init || !jump_entry_is_init(entry)) {
> +		if (!kernel_text_address(jump_entry_code(entry))) {
> +			WARN_ONCE(1, "can't patch jump_label at %pS",
> +				  (void *)jump_entry_code(entry));
> +			return 0;
> +		}
> +		return 1;
> +	}
> +	return 0;

Those should be bools which it returns, no?

Also, I'd do the function this way, to make it more readable and not
have three returns back-to-back. :)

/*
 * An entry->code of 0 indicates an entry which has been disabled because it
 * was in an init text area.
 */
bool jump_label_can_update(struct jump_entry *entry, bool init)
{
        if (!init && jump_entry_is_init(entry))
                return false;

        if (WARN_ON_ONCE(!kernel_text_address(jump_entry_code(entry))),
                         "can't patch jump_label at %pS", (void *)jump_entry_code(entry))
                return false;

        return true;
}

That second check could be even:

        if (WARN_ON_ONCE(!kernel_text_address(jump_entry_code(entry))),
                         "can't patch jump_label at %pS", (void *)jump_entry_code(entry))
                return false;

but that's not more readable than above, I'd say.

>  static void __jump_label_update(struct static_key *key,
>  				struct jump_entry *entry,
>  				struct jump_entry *stop,
>  				bool init)
>  {
>  	for_each_label_entry(key, entry, stop) {
> -		/*
> -		 * An entry->code of 0 indicates an entry which has been
> -		 * disabled because it was in an init text area.
> -		 */
> -		if (init || !jump_entry_is_init(entry)) {
> -			if (kernel_text_address(jump_entry_code(entry)))
> -				arch_jump_label_transform(entry, jump_label_type(entry));
> -			else
> -				WARN_ONCE(1, "can't patch jump_label at %pS",
> -					  (void *)jump_entry_code(entry));
> +		if (jump_label_can_update_check(entry, init)) {
> +			arch_jump_label_transform(entry,
> +						  jump_label_type(entry));

Yeah, let that one stick out.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
