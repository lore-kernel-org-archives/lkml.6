Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F68ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F16320868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kQK+4upo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F16320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeJ0EO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:14:59 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46590 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJ0EO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:14:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id bb7-v6so938073plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RLfbN2Awm/nbZRtKB5rKsnhkaxypfw45GKk2pCoHfbM=;
        b=kQK+4upoNTPt4s5PMuJFIJcKjKAcSKn912G4B//QSM9RlQuTn7e7HlHzB/jNxobmDx
         B1cQgA+Auojy9uniB7DRCsztnOVxAkojAP8RzI7jZHdp1Te2ypfb1KU5AaHoaqutgeRz
         ZDnRVOAEfIUSNMPeXnZpSnBV5VGvk5dZ7u9yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RLfbN2Awm/nbZRtKB5rKsnhkaxypfw45GKk2pCoHfbM=;
        b=Jvb5lT+yUkM9ta80veajdcounYcKjhZgZYoe0Tw5mN5ELNGUh0oEwk3IcS/24QP38R
         Lf317qk7OjxoAIgqWYr1N/3as5au8qQTYIo7UvzH3t867jumHqBiC0/mcAaFgtsi2TXB
         hXm3PehrehQ/M/injqvJ/Shx+LoAmqyET86KuyL4Qnhguf9varB0P88nxE/s5lQj1r0D
         a/+AiNwaVGFuxNGFS8mf+vC56TJ2smrggsaM/Lw0qhJeW7zjcIQL0QzmXpZ8HctDjFxl
         HxYahUr3fKzV6Z55HC/CAJQkVZ7WiVpuaDItCRhDoOyt1Z1mHXYwZ8rKdiXIo9wziFpj
         fc8Q==
X-Gm-Message-State: AGRZ1gK+WIl00yqgIYpOgjedjOYg3G2PQfcSEl23r/HX9+pSbkC/jSHn
        Mk5rZzLo20uAOHnyv6ZPWe6jtA==
X-Google-Smtp-Source: AJdET5dejHkhK6PQojSK3e202V60YxLR+wwirS1N1JwdmIJdHoRNZW8uFCF2/X0ITVPtCLgKIzk6Eg==
X-Received: by 2002:a17:902:5a8b:: with SMTP id r11-v6mr4886766pli.305.1540582600069;
        Fri, 26 Oct 2018 12:36:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id r124-v6sm6821393pfr.151.2018.10.26.12.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 12:36:38 -0700 (PDT)
Date:   Fri, 26 Oct 2018 12:36:37 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [RFC 4/6] pstore: further reduce ramoops_get_next_prz arguments
 by passing record
Message-ID: <20181026193637.GA122104@joelaf.mtv.corp.google.com>
References: <20181026180042.52199-1-joel@joelfernandes.org>
 <20181026180042.52199-4-joel@joelfernandes.org>
 <CAGXu5jJi5M+wfF8X7ud2jTjdJZRE4sCnZgv9OA9ZX-wwpZ5PnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJi5M+wfF8X7ud2jTjdJZRE4sCnZgv9OA9ZX-wwpZ5PnA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 08:32:16PM +0100, Kees Cook wrote:
> On Fri, Oct 26, 2018 at 7:00 PM, Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> > Both the id and type fields of a pstore_record are set by
> > ramoops_get_next_prz. So we can just pass a pointer to the pstore_record
> > instead of passing individual elements. This results in cleaner more
> > readable code and fewer lines.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  fs/pstore/ram.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> > index 3055e05acab1..710c3d30bac0 100644
> > --- a/fs/pstore/ram.c
> > +++ b/fs/pstore/ram.c
> > @@ -125,7 +125,7 @@ static int ramoops_pstore_open(struct pstore_info *psi)
> >
> >  static struct persistent_ram_zone *
> >  ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint *c,
> > -                    u64 *id, enum pstore_type_id *typep, bool update)
> > +                    struct pstore_record *record, bool update)
> >  {
> >         struct persistent_ram_zone *prz;
> >         int i = (*c)++;
> > @@ -145,8 +145,8 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint *c,
> >         if (!persistent_ram_old_size(prz))
> >                 return NULL;
> >
> > -       *typep = prz->type;
> > -       *id = i;
> > +       record->type = prz->type;
> > +       record->id = i;
> 
> Yes yes. I've been meaning to get all this cleaned up after I
> refactored everything to actually HAVE record at all. :P
> 
> >
> >         return prz;
> >  }
> > @@ -254,7 +254,7 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
> >         /* Find the next valid persistent_ram_zone for DMESG */
> >         while (cxt->dump_read_cnt < cxt->max_dump_cnt && !prz) {
> >                 prz = ramoops_get_next_prz(cxt->dprzs, &cxt->dump_read_cnt,
> > -                                          &record->id, &record->type, 1);
> > +                                          record, 1);
> 
> In another patch, I think you could drop the "update" field too, and
> use the record->type instead to determine if update is needed. Like:
> 
> static struct persistent_ram_zone *
> ramoops_get_next_prz(struct persistent_ram_zone *przs[], uint c,
>                                       struct pstore_record *record)
> {
>     bool update = (record->type == PSTORE_TYPE_DMESG);
> ...

Yes, I agree, I'll do that :)

thanks!

 - Joel
