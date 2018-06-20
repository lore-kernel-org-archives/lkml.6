Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E44EC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5597720846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5597720846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754075AbeFTKrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:47:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:39663 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750793AbeFTKrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:47:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7F9C8AC2E;
        Wed, 20 Jun 2018 10:47:18 +0000 (UTC)
Date:   Wed, 20 Jun 2018 12:47:15 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Aaron Wu <Aaron.Wu@analog.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt," <rostedt@goodmis.org>,
        Laura Abbott <lauraa@codeaurora.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Baoquan He <bhe@redhat.com>,
        Ilya Matveychikov <matvejchikov@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/5] Kernel parameter parser cleanup/enhancement
Message-ID: <20180620124715.58680ad5@kitsune.suse.cz>
In-Reply-To: <20180619163647.23c8a5d7370258c9e43141c3@linux-foundation.org>
References: <cover.1528215659.git.msuchanek@suse.de>
        <20180619163647.23c8a5d7370258c9e43141c3@linux-foundation.org>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018 16:36:47 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue,  5 Jun 2018 18:43:07 +0200 Michal Suchanek
> <msuchanek@suse.de> wrote:
> 
> > due to work on the fadump_extra_args I looked at the kernel
> > parameter parser and found its grammar rather curious.
> > 
> > It supports double quotes but not any other quoting characters so
> > double quotes cannot be quoted. What's more, the quotes can be
> > anywhere in the parameter name or value and are interpteted but are
> > removed only from start and end of the parameter value.
> > 
> > These are the patches not specific to fadump which somewhat
> > straighten the qouting grammar to make it on par with common shell
> > interpreters.
> > 
> > Specifically double and single quotes can be used for quoting as
> > well as backslashes with the usual shell semantic. All quoting
> > characters are removed while the parameters are parsed.  
> 
> Well.  It's nice.  I guess.  Is there any demand for these
> capabilities?  I don't recall ever having seen a complaint - kernel
> parameters tend to be pretty simple things.

Yes, the complaint came with the nested arguments which are now not
pursued anymore. The grammar is really not very nice as it is, though.

> Also, the break_arg_end() and squash_char() macros make me want to
> cry. A macro which changes control flow hidden inside another macro!
> Are they reeeealy necessary?  

Seems better than repeating the same code 3 times.

> Can't be done with some C helpers?

You could not change the control flow then, could you?

Technically you could return something and decide based on that I
suppose.

> Maybe put inquote, backslash, args, i into a new struct parser_state
> and pass a pointer to that around the place?  At the very least,
> those macros should be apologetically documented :(

Yes, some description can be added, too.

Thanks

Michal
