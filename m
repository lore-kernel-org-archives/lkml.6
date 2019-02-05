Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B09FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 07:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6316320811
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 07:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="g+aJ0teJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfBEHde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 02:33:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34320 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfBEHde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 02:33:34 -0500
Received: from zn.tnic (p200300EC2BCB6B008896F3D5E1C66173.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:6b00:8896:f3d5:e1c6:6173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7EE0E1EC0253;
        Tue,  5 Feb 2019 08:33:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549352012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qn/yW1NbotSx+eUihKG4EjD0AG4eEUQpicapNJfaqQ4=;
        b=g+aJ0teJm4hSzoBIQfcXqarDMILXESvCwER+BLaWlsfOYGs34gO0BBjV1vPIq+pq5GXLQn
        8PDGUBDZ8jvFT4tFNofa6fkIYKZRUv0cO8Ua2FFvljmpV50Tr8GR/qiPcd3gWDYxMQVyk8
        Dz/FZ9I2G6Rei00ut2zupE1d/+n0iWc=
Date:   Tue, 5 Feb 2019 08:33:21 +0100
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
Subject: Re: [PATCH V4 3/9] x86/jump_label: Move checking code away from
 __jump_label_transform()
Message-ID: <20190205073321.GE21801@zn.tnic>
References: <cover.1549308412.git.bristot@redhat.com>
 <10e6ab5f9481a5a51bd6dd6c818453908ea60777.1549308412.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10e6ab5f9481a5a51bd6dd6c818453908ea60777.1549308412.git.bristot@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 08:58:56PM +0100, Daniel Bristot de Oliveira wrote:
> Move the check of the current code, before updating an entry, to specialized
> functions. No changes in the method, only code relocation.
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Chris von Recklinghausen <crecklin@redhat.com>
> Cc: Jason Baron <jbaron@akamai.com>
> Cc: Scott Wood <swood@redhat.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/kernel/jump_label.c | 60 +++++++++++++++++++++++++-----------
>  1 file changed, 42 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
> index f99bd26bd3f1..e443c43478eb 100644
> --- a/arch/x86/kernel/jump_label.c
> +++ b/arch/x86/kernel/jump_label.c
> @@ -35,16 +35,53 @@ static void bug_at(unsigned char *ip, int line)
>  	BUG();
>  }
>  
> +static inline void __jump_label_trans_check_enable(struct jump_entry *entry,
> +						   enum jump_label_type type,
> +						   const unsigned char *ideal_nop,
> +						   int init)
> +{
> +	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
> +	const void *expect;
> +	int line;
> +
> +	if (init) {
> +		expect = default_nop; line = __LINE__;
> +	} else {
> +		expect = ideal_nop; line = __LINE__;
> +	}
> +
> +	if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
> +		bug_at((void *)jump_entry_code(entry), line);
> +}
> +
> +static inline void __jump_label_trans_check_disable(struct jump_entry *entry,
> +						    enum jump_label_type type,
> +						    union jump_code_union *jmp,
> +						    int init)
> +{
> +	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
> +	const void *expect;
> +	int line;
> +
> +	if (init) {
> +		expect = default_nop; line = __LINE__;
> +	} else {
> +		expect = jmp->code; line = __LINE__;
> +	}
> +
> +	if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
> +		bug_at((void *)jump_entry_code(entry), line);
> +}

Why the carve out?

The next patch is adding __jump_label_set_jump_code() which calls them
so you could just as well keep the functionality all in that function without
having too many helpers which are called only once...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
