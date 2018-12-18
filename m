Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B24C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68BE21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="poVT3E9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeLRVTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:19:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48950 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbeLRVTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:19:31 -0500
Received: from zn.tnic (p200300EC2BD17800FDD9DE8D86B90B01.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:7800:fdd9:de8d:86b9:b01])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F1C5F1EC0B8E;
        Tue, 18 Dec 2018 22:19:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545167970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qVsEdEQe6SpUpZ61Q1gnk31TrKNcUhTZfS/0SaRLK/E=;
        b=poVT3E9VK0phzgUfCef9I3vWy9AyB2PIeVZrPt3NJ9XfbJLMaopeSY0LQpkVqY7AWIaUMA
        YjSwemA9wcfUKw24YVaIZ8ry/LgfqQZb7KuzVTnJwQoCcnse53177MVwJJ0l0hi0MyUOip
        1Fu5IhfBFOD4Sq1XqHauPiWGdxrE44Q=
Date:   Tue, 18 Dec 2018 22:19:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Zhou Chengming <zhouchengming1@huawei.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V2 1/9] jump_label: Add for_each_label_entry helper
Message-ID: <20181218211923.GM7485@zn.tnic>
References: <cover.1545149539.git.bristot@redhat.com>
 <c1b514e312238c0fe4e22500d1d41c0f565cae28.1545149539.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1b514e312238c0fe4e22500d1d41c0f565cae28.1545149539.git.bristot@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 05:46:30PM +0100, Daniel Bristot de Oliveira wrote:
> This patch adds the helper:
> 	for_each_label_entry(key, entry, stop)
> 
> For the "for each jump label entry" for defined as:
> 	for (; (entry < stop) && (jump_entry_key(entry) == key); entry++)
> 
> Simplifying the reading and usage.

Please avoid writing "This patch" in a commit message and also what it
does - that should be obvious. Instead say something like:

"Add a helper macro to make jump entry iteration code more readable."

or so.

But then, IINM, this macro is being used only once. Isn't that a bit too
much? I mean, you could just as well do:

	# iterate over each jump entry
	for (; (entry < stop) && (jump_entry_key(entry) == key); entry++) {

and have it even more readable without introducing macro which is not
going to be used elsewhere. Or is it going to...?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
