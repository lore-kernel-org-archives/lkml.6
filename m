Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1407DC04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DBB2081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="cEwNvFCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1DBB2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeK3NeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 08:34:19 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36422 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbeK3NeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 08:34:19 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so1819156pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 18:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+7FHqAtEydKJAtAOErtYI4+AY7Co+y9p0FlLZPqwO7Q=;
        b=cEwNvFCYsU0oej7QnkVWSOSM6/pdl1HLyfETlKqcC8eQKbilp6HJJvD9aWmmcZhBC1
         7mUQW0EE93yn7ewQMl+1ZpBGzrNM9OYS8p08KTEUiGf3/zr3rBpt+oFfVUls/4cW1V3n
         1GQEktRtZzpMakMQXgtwBNepe/CgiFIjIyoRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+7FHqAtEydKJAtAOErtYI4+AY7Co+y9p0FlLZPqwO7Q=;
        b=s8yI/64eN3WkDuGTgJYmsefha8/L4yY9fce5fUhpqS7xbsfTtSTuTmhTdq1dGm3HBf
         +46Sl/1QC4ijnLC0WqmM5QZw0jyfPR08BqYoq9bR0B5oYfHhMTXXodfB22jOJIFZECgw
         8BplUMAd4H5gLW567gkbALcgf6IZRFGSV51oqEdB5hKs9e7YHB7EnZlzsaftb3IQ8KWp
         5JoYF43iSu0rj24/kXlBVIzVUhCVc3qtCcaWe6TEi3hTJMqGh14c67pvL1MbC0GuIh8V
         +Xq/86s20+Cq0CaRdx+KYAgGYVb/oEsXCMuMRLCj8OdsHHWixtGtsurdENHqsbqIRmE1
         eGog==
X-Gm-Message-State: AA+aEWYE10GgYCXTeWtlvg/06MAib74EPr6w8GU8AxKLs6bPUgJavh4G
        WSoieod3p6f1aqeiEs0z7HW2p4Pov2Y=
X-Google-Smtp-Source: AFSGD/X/OIrukSY9t4ozwUKduDr4OPbgfliwjCpja1/sG5sBCiM94aI6gcP1FxsxU8MacxKk8TSbMw==
X-Received: by 2002:a63:8441:: with SMTP id k62mr3307027pgd.392.1543544799137;
        Thu, 29 Nov 2018 18:26:39 -0800 (PST)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id g2sm4727234pfi.95.2018.11.29.18.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 18:26:38 -0800 (PST)
Date:   Thu, 29 Nov 2018 18:26:37 -0800
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 2/8] pstore: Do not use crash buffer for decompression
Message-ID: <20181130022637.GA105443@google.com>
References: <20181101235200.28584-1-keescook@chromium.org>
 <20181101235200.28584-3-keescook@chromium.org>
 <20181102182454.GB14942@google.com>
 <CAGXu5jKdO8icx63YDkqDsYP4_pNxRe5zUiVUg2+0mhbHj10zTg@mail.gmail.com>
 <CAGXu5jJdPz70kHUmTxOEo3Kp20HCOpGEX3_ECqN6TV3qBwxjEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJdPz70kHUmTxOEo3Kp20HCOpGEX3_ECqN6TV3qBwxjEA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 02:06:39PM -0800, Kees Cook wrote:
> On Tue, Nov 13, 2018 at 11:56 PM Kees Cook <keescook@chromium.org> wrote:
> > On Fri, Nov 2, 2018 at 1:24 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > > On Thu, Nov 01, 2018 at 04:51:54PM -0700, Kees Cook wrote:
> > >> +     workspace = kmalloc(unzipped_len + record->ecc_notice_size,
> > >
> > > Should tihs be unzipped_len + record->ecc_notice_size + 1. The extra byte
> > > being for the NULL character of the ecc notice?
> > >
> > > This occurred to me when I saw the + 1 in ram.c. It could be better to just
> > > abstract the size as a macro.
> >
> > Ooh, yes, good catch. I'll get this fixed.
> 
> I spent more time looking at this, and it seems that only the initial
> creation of this string needs the +1, since all other operations are
> byte-based not NUL-terminated string based. It's a big odd, and I
> might try to clean it up differently, but as it stands, this is okay.
> (See inode.c which doesn't include the trailing NUL byte.)

Ok. Yes it does seem a bit inconsistent but I agree its not an issue for this
particular patch. Sorry to waste your time, thanks!

 - Joel

