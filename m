Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E83ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC572085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FFaxvHtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC572085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeJ0FNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:13:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40969 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeJ0FNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:13:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id a19-v6so1085801pfo.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 13:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZYvWW3PQ+FgPo6QV3gbZppa5ayRu9AOzKQY1d7rNZMo=;
        b=FFaxvHtCgecH1+XxWQN6SpSB3TWLPWafCd1lKeYeKvMFXAco0YDcbbrTNX85VROK07
         NjgPiMU/jihSVh2VVb5ewTma1PZSyNZwvUAStHYadpfCJC2wUCfA7udssSgiZClUiyma
         x5m6zUewkFzQ45nE2dXuuURxM0WM9ODXpGuSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZYvWW3PQ+FgPo6QV3gbZppa5ayRu9AOzKQY1d7rNZMo=;
        b=E8Ys3NbMCm2DlXQfnV8/bNjHlsSrJxU2AX4M6PfhukEqj/S7+eD0XrZLArg97WH/+Z
         pyM5WP4D3iVSKWfYxUPJhsqL4rmsyjTo1tq/kjcXTz33yimoPVbkmN4n1gqwHyQ+p70y
         5a3tx5QLAnGcgfN8Ao7noGVDbH0cjzb8tx2WSEItZZ24vL4FKXtwbUEBZGxJl79ig4Uo
         iIXUytRo0c33CyU6QyAA708S0u8hTnive9OPBYgvBgGVuC3JP5xdtGbXDm8fs+AqGvsq
         J1Z81mlLTzSSRn6wb4qji51jUFl1fEG2iwp6bzZ4BInfe/ZwrbRrqfrmSdDxhREVRfdd
         n9tw==
X-Gm-Message-State: AGRZ1gIHhWoSfP6/a5NHwDtxwgh2HI5sNAajqdtlc2C2pBKPL5MaMFGj
        dETyzG/sUbpiXj0O6np44c1JBQ==
X-Google-Smtp-Source: AJdET5dy+JbilkEZGczxTaQCSWQCvcJ7CIEuKkVUeCXC3gd0q1OwmDa0eiuOVTdPtoji3ybMitrN6A==
X-Received: by 2002:a62:b87:: with SMTP id 7-v6mr5273296pfl.67.1540586116943;
        Fri, 26 Oct 2018 13:35:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id i80-v6sm18865581pfi.87.2018.10.26.13.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 13:35:15 -0700 (PDT)
Date:   Fri, 26 Oct 2018 13:35:14 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [RFC 1/6] pstore: map pstore types to names
Message-ID: <20181026203514.GC129228@joelaf.mtv.corp.google.com>
References: <20181026180042.52199-1-joel@joelfernandes.org>
 <CAGXu5jLKLKDwVgRoMx57Y76V9FVJqQ+EeTHB2CnxAN5CnC2Jmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLKLKDwVgRoMx57Y76V9FVJqQ+EeTHB2CnxAN5CnC2Jmw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 08:04:24PM +0100, Kees Cook wrote:
> On Fri, Oct 26, 2018 at 7:00 PM, Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> > In later patches we will need to map types to names, so create a table
> > for that which can also be used and reused in different parts of old and
> > new code. Also use it to save the type in the PRZ which will be useful
> > in later patches.
> 
> Yes, I like it. :) Comments below...

I'm glad, thanks, my replies are below:

> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  fs/pstore/inode.c          | 44 ++++++++++++++++++++------------------
> >  fs/pstore/ram.c            |  4 +++-
> >  include/linux/pstore.h     | 29 +++++++++++++++++++++++++
> >  include/linux/pstore_ram.h |  2 ++
> >  4 files changed, 57 insertions(+), 22 deletions(-)
> >
> > diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> > index 5fcb845b9fec..43757049d384 100644
> > --- a/fs/pstore/inode.c
> > +++ b/fs/pstore/inode.c
> > @@ -304,6 +304,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
> >         struct dentry           *dentry;
> >         struct inode            *inode;
> >         int                     rc = 0;
> > +       enum pstore_type_id     type;
> >         char                    name[PSTORE_NAMELEN];
> >         struct pstore_private   *private, *pos;
> >         unsigned long           flags;
> > @@ -335,43 +336,44 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
> >                 goto fail_alloc;
> >         private->record = record;
> >
> > -       switch (record->type) {
> > +       type = record->type;
> 
> Let's rename PSTORE_TYPE_UNKNOWN in the enum to be PSTORE_TYPE_MAX and
> != 255 (just leave it at the end). The value is never exposed to
> userspace (nor to backend storage), so we can instead use it as the
> bounds-check for doing type -> name mappings. (The one use in erst can
> just be renamed.)
> 
> Then we can add a function to do the bounds checking and mapping
> (instead of using a bare array lookup).
> 
> > +       switch (type) {
> >         case PSTORE_TYPE_DMESG:
> > -               scnprintf(name, sizeof(name), "dmesg-%s-%llu%s",
> > -                         record->psi->name, record->id,
> > -                         record->compressed ? ".enc.z" : "");
> > +               scnprintf(name, sizeof(name), "%s-%s-%llu%s",
> > +                        pstore_names[type], record->psi->name, record->id,
> > +                        record->compressed ? ".enc.z" : "");
> >                 break;
> >         case PSTORE_TYPE_CONSOLE:
> > -               scnprintf(name, sizeof(name), "console-%s-%llu",
> > -                         record->psi->name, record->id);
> > +               scnprintf(name, sizeof(name), "%s-%s-%llu",
> > +                         pstore_names[type], record->psi->name, record->id);
> >                 break;
> >         case PSTORE_TYPE_FTRACE:
> > -               scnprintf(name, sizeof(name), "ftrace-%s-%llu",
> > -                         record->psi->name, record->id);
> > +               scnprintf(name, sizeof(name), "%s-%s-%llu",
> > +                         pstore_names[type], record->psi->name, record->id);
> >                 break;
> >         case PSTORE_TYPE_MCE:
> > -               scnprintf(name, sizeof(name), "mce-%s-%llu",
> > -                         record->psi->name, record->id);
> > +               scnprintf(name, sizeof(name), "%s-%s-%llu",
> > +                         pstore_names[type], record->psi->name, record->id);
> >                 break;
> >         case PSTORE_TYPE_PPC_RTAS:
> > -               scnprintf(name, sizeof(name), "rtas-%s-%llu",
> > -                         record->psi->name, record->id);
> > +               scnprintf(name, sizeof(name), "%s-%s-%llu",
> > +                         pstore_names[type], record->psi->name, record->id);
> >                 break;
> >         case PSTORE_TYPE_PPC_OF:
> > -               scnprintf(name, sizeof(name), "powerpc-ofw-%s-%llu",
> > -                         record->psi->name, record->id);
> > +               scnprintf(name, sizeof(name), "%s-%s-%llu",
> > +                         pstore_names[type], record->psi->name, record->id);
> >                 break;
> >         case PSTORE_TYPE_PPC_COMMON:
> > -               scnprintf(name, sizeof(name), "powerpc-common-%s-%llu",
> > -                         record->psi->name, record->id);
> > +               scnprintf(name, sizeof(name), "%s-%s-%llu",
> > +                         pstore_names[type], record->psi->name, record->id);
> >                 break;
> >         case PSTORE_TYPE_PMSG:
> > -               scnprintf(name, sizeof(name), "pmsg-%s-%llu",
> > -                         record->psi->name, record->id);
> > +               scnprintf(name, sizeof(name), "%s-%s-%llu",
> > +                         pstore_names[type], record->psi->name, record->id);
> >                 break;
> >         case PSTORE_TYPE_PPC_OPAL:
> > -               scnprintf(name, sizeof(name), "powerpc-opal-%s-%llu",
> > -                         record->psi->name, record->id);
> > +               scnprintf(name, sizeof(name), "%s-%s-%llu",
> > +                         pstore_names[type], record->psi->name, record->id);
> >                 break;
> >         case PSTORE_TYPE_UNKNOWN:
> >                 scnprintf(name, sizeof(name), "unknown-%s-%llu",
> 
> All of these, including PSTORE_TYPE_UNKNOWN are now identical (you can
> include the .enc.z logic in for all of them. I think the entire switch
> can be dropped, yes?
> 
> scnprintf(name, sizeof(name), "%s-%s-%llu%s",
>                pstore_name(record->type), record->psi->name, record->id,
>                record->compressed ? ".enc.z" : "")

True! I'll just do that. Sounds good! The PSTORE_TYPE_UNKNOWN and the below
"default:" case could be combined I guessed. Its a great idea and lesser
lines, thanks!


> >                                 dump_mem_sz, cxt->record_size,
> >                                 &cxt->max_dump_cnt, 0, 0);
> >         if (err)
> > diff --git a/include/linux/pstore.h b/include/linux/pstore.h
> > index a15bc4d48752..4a3dbdffd8d3 100644
> > --- a/include/linux/pstore.h
> > +++ b/include/linux/pstore.h
> > @@ -47,6 +47,21 @@ enum pstore_type_id {
> >         PSTORE_TYPE_UNKNOWN     = 255
> >  };
> >
> > +/* names should be in the same order as the above table */
> > +static char __maybe_unused *pstore_names[] = {
> 
> This should be static const char * const pstore_names[], I think?

Sure, I'll add the const(s) to it.

> > +       "dmesg",
> > +       "mce",
> > +       "console",
> > +       "ftrace",
> > +       "rtas",
> > +       "powerpc-ofw",
> > +       "powerpc-common",
> > +       "pmsg",
> > +       "powerpc-opal",
> > +       "event",
> > +       "unknown", /* unknown should be the last string */
> 
> End this with a NULL for a cheaper compare below.

Agreed, I am wondering if we need the unknown string though if we
terminate the type enum table with a MAX. I'll look more into that.

> > +};
> > +
> >  struct pstore_info;
> >  /**
> >   * struct pstore_record - details of a pstore record entry
> > @@ -274,4 +289,18 @@ pstore_ftrace_write_timestamp(struct pstore_ftrace_record *rec, u64 val)
> >  }
> >  #endif
> >
> > +static inline enum pstore_type_id pstore_name_to_type(const char *name)
> > +{
> > +       char *str;
> > +       int i = 0;
> > +
> > +       for (; strncmp(pstore_names[i], "unknown", 7); i++) {
> char **ptr;
> 
> for (ptr = pstores_names; *ptr; ptr++) {
> 
> > +               str = pstore_names[i];
> > +               if (!strncmp(name, str, strlen(str)))
> 
> "n" version not needed: the LHS is controlled and we want full matching:
> 
>     if (!strcmp(*ptr, name))

Sounds good, but now that we are adding PSTORE_TYPE_MAX, I think it would be
cleaner and safer if I iterated until PSTORE_TYPE_MAX, so I'll use that to
terminate the loop?

> > +                       return (enum pstore_type_id)i;
> 
> I don't think this cast is needed?
> 
>         return (ptr - pstores_names);

But I have the index variable, so it would be cleaner to just return that? I
believe I can just drop the cast and do that.

thanks,

 - Joel
