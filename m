Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607ABC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB9A2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ptYWA1bI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB9A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbeJaHLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:11:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37395 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeJaHLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:11:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id c10-v6so6353172pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 15:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wbi/94E9+yBQLnsGt7GlxRFYHp/cmVPB0k1mrDveYek=;
        b=ptYWA1bIG8WN/w0H3c01UgIZ9gN613D6IyKnM3t9OPEjc/nsxFIXAtg0d3zQ87IXpL
         RENV7Xw6YYDBkqlN9ZL21gk1yL2UZ+drdT5bOBGM3NqxcAsCdRxGeUXYOb74C92xYzYa
         Lu+iNvlQiFsHwtJVpoevznfjmXpgra0Cat3Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wbi/94E9+yBQLnsGt7GlxRFYHp/cmVPB0k1mrDveYek=;
        b=PmNfIQ8pFjz1LltRe5OXCuZb6Ckhgxwi/dZj5oiH3RIjbLm60YBKNEtU5eU9R0vkaw
         dtik83J4qGZ8jjK2bT96jLDAaU4W6oCC7uqoQ+92JIXrdoBBLJLic954nG4DM3FYhfcC
         GeQ7nzHbYZUbM3QqTct3UpgZRIWr09Lr2qe4TEsSKYj8/fCorozXzAHxarh49XbdCB0O
         D05rfh1vNV9wCqJMqOeOK0YaMAMqc+AeLzbZQ/8L0utarcU7ATZO53P6Sx8aD1Q4hZB7
         M01kLUo6ApyaoPMyQaruxYsU5Mq0TD6gkwjJoMY2OrTCr8xPWINyz7KlB4kbn0BmIlw+
         spRA==
X-Gm-Message-State: AGRZ1gIA73dNduImGKqOqOjh/3hv1iKF84av6qkt8v7OLfwyqdJXKyfO
        Cs+pERHq7bL0YmaTHOODFEYxGg==
X-Google-Smtp-Source: AJdET5cqOniB/xuasOINm091WZ8cefeKetNPg7qtZlGFWuxKyBcV6Ir6sY4dpsDFYkHY/kT9P3HG2A==
X-Received: by 2002:a63:2507:: with SMTP id l7mr520354pgl.22.1540937767603;
        Tue, 30 Oct 2018 15:16:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id g123-v6sm54815837pfc.67.2018.10.30.15.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 15:16:06 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:16:05 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peng Wang <wangpeng15@xiaomi.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, vipwangerxiao@gmail.com
Subject: Re: [PATCH v4] pstore: Avoid duplicate call of persistent_ram_zap()
Message-ID: <20181030221605.GA44036@joelaf.mtv.corp.google.com>
References: <20181030075234.21137-1-wangpeng15@xiaomi.com>
 <20181030213818.GA32621@google.com>
 <CAGXu5j+tRWseaecob04U5iXHa-P_z=Hvj3PmhE5YWFUO=LT7Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+tRWseaecob04U5iXHa-P_z=Hvj3PmhE5YWFUO=LT7Sw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 02:52:43PM -0700, Kees Cook wrote:
> On Tue, Oct 30, 2018 at 2:38 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > On Tue, Oct 30, 2018 at 03:52:34PM +0800, Peng Wang wrote:
> >> When initialing prz with invalid data in buffer(no PERSISTENT_RAM_SIG),
> >> function call path is like this:
> >>
> >> ramoops_init_prz ->
> >> |
> >> |-> persistent_ram_new -> persistent_ram_post_init -> persistent_ram_zap
> >> |
> >> |-> persistent_ram_zap
> >>
> >> As we can see, persistent_ram_zap() is called twice.
> >> We can avoid this by adding an option to persistent_ram_new(), and
> >> only call persistent_ram_zap() when it is needed.
> >>
> >> Signed-off-by: Peng Wang <wangpeng15@xiaomi.com>
> >> ---
> >>  fs/pstore/ram.c            | 4 +---
> >>  fs/pstore/ram_core.c       | 5 +++--
> >>  include/linux/pstore_ram.h | 1 +
> >>  3 files changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> >> index ffcff6516e89..b51901f97dc2 100644
> >> --- a/fs/pstore/ram.c
> >> +++ b/fs/pstore/ram.c
> >> @@ -640,7 +640,7 @@ static int ramoops_init_prz(const char *name,
> >>
> >>       label = kasprintf(GFP_KERNEL, "ramoops:%s", name);
> >>       *prz = persistent_ram_new(*paddr, sz, sig, &cxt->ecc_info,
> >> -                               cxt->memtype, 0, label);
> >> +                               cxt->memtype, PRZ_FLAG_ZAP_OLD, label);
> >>       if (IS_ERR(*prz)) {
> >>               int err = PTR_ERR(*prz);
> >
> > Looks good to me except the minor comment below:
> >
> >>
> >> @@ -649,8 +649,6 @@ static int ramoops_init_prz(const char *name,
> >>               return err;
> >>       }
> >>
> >> -     persistent_ram_zap(*prz);
> >> -
> >>       *paddr += sz;
> >>
> >>       return 0;
> >> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> >> index 12e21f789194..2ededd1ea1c2 100644
> >> --- a/fs/pstore/ram_core.c
> >> +++ b/fs/pstore/ram_core.c
> >> @@ -505,15 +505,16 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
> >>                       pr_debug("found existing buffer, size %zu, start %zu\n",
> >>                                buffer_size(prz), buffer_start(prz));
> >>                       persistent_ram_save_old(prz);
> >> -                     return 0;
> >> +                     if (!(prz->flags & PRZ_FLAG_ZAP_OLD))
> >> +                             return 0;
> >
> > This could be written differently.
> >
> > We could just do:
> >
> > if (prz->flags & PRZ_FLAG_ZAP_OLD)
> >         persistent_ram_zap(prz);
> >
> > And remove the zap from below below.
> 
> I actually rearranged things a little to avoid additional round-trips
> on the mailing list. :)
> 
> > Since Kees already took this patch, I can just patch this in my series if
> > Kees and you are Ok with this suggestion.
> 
> I've put it up here:
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=pstore/devel&id=ac564e023248e3f4d87917b91d12376ddfca5000

Cool, it LGTM :)

- Joel

