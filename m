Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D5AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA5D21904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Bc20ARP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfBGRJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:09:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46086 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfBGRJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:09:01 -0500
Received: from zn.tnic (p200300EC2BD188009C13CA0C499330CD.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:8800:9c13:ca0c:4993:30cd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB8251EC014B;
        Thu,  7 Feb 2019 18:08:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549559339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ek1xVHCNXanCVTi3nzLrzlb8Mm9UH/bSEszIlu32D6Q=;
        b=Bc20ARP8sJCfTfHve8fIAl3iqbog0LVwemZpCso2y5OtIWJrqUNwDeq/aESEQQMvS0yub4
        y+ysXIk4HMbuKCIuGkUQy0ISJ92pCkU0aYi4KDmJ1bOpyl0OIWsPXIEUkObynOhCo/QuUq
        r5X0D7XXxHF8AyWqxDwCmamQ8hMtgYQ=
Date:   Thu, 7 Feb 2019 18:08:48 +0100
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
Message-ID: <20190207170848.GG2414@zn.tnic>
References: <cover.1549308412.git.bristot@redhat.com>
 <36237a0ee38d6c98d080d3fee2921501d8788e4d.1549308412.git.bristot@redhat.com>
 <20190205072220.GD21801@zn.tnic>
 <cb65e500-44dd-873c-622f-b49b9336b6a2@redhat.com>
 <20190205211348.GV21801@zn.tnic>
 <30b5ffc9-9794-874b-1544-d05034b55f1b@redhat.com>
 <20190207140819.GF2414@zn.tnic>
 <473c03b3-c5c3-7412-e2ad-3dedb413d165@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <473c03b3-c5c3-7412-e2ad-3dedb413d165@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 06:00:53PM +0100, Daniel Bristot de Oliveira wrote:
> It is taking 95 characters. In this case, wouldn't be better to break?
> 
>         if (!kernel_text_address(jump_entry_code(entry))) {
>                 WARN_ONCE(1, "can't patch jump_label at %pS",
>                           (void *)jump_entry_code(entry));
>                 return false;
>         }
> 
> I agree your suggestion is better... just confirming that 95 is not too long...

Well, current monitors are always > 80 cols unless someone has a tmux
with a gazillion windows in it (yeah, I know of a couple people who do
that :)) and at least to me, breaking the line like that looks less
readable because I need to look at the two lines to parse what's going
on.

Vs when you have one long line, so you look at

	WARN_ONCE(...

and go, oh, ok, we're warning here and nothing else. Without paying too
much attention to the actual arguments of the WARN.

But this is just me.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
