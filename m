Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5462ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763992084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="XI8Zc1xF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763992084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387890AbeGTQbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:31:01 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:32844 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387846AbeGTQbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:31:00 -0400
Received: by mail-it0-f65.google.com with SMTP id y124-v6so5530264itc.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 08:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=momoV2Csm6uwI0ZNQ9oSHqa+k44ZyKDlI/pysCJ0o/s=;
        b=XI8Zc1xFENHzciKuJUsongsFWLxgBGni4vb2Dr6eHTaZI8uL1GYkpaqT2x1I4wlf/u
         WGGuC4sTv4jCVdZtd/zvGPp9K4EYll2C3GptpHPCXIMbBWEkDzoh94DBfbrPD5uw7ZpI
         7gg//tDtxn7db9lQBSrTqXBut8kxNB0YTZlQLwQWOaj2EIgA5VTe+qbeSKyh0YgZvsue
         VkuYUxKEdmgYvkaScytD8k6Dc3eykRcxQqy9zKRS+25iJ8jNL5fxrZls4haDBXkgsX0v
         z0tBuUFZVVcIFL2ERrNpit1TrxxC8aQfZc3cdkwTxruP/d1UhUF2m8Sb7UXdg4M5E89f
         yKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=momoV2Csm6uwI0ZNQ9oSHqa+k44ZyKDlI/pysCJ0o/s=;
        b=DBm0S+pPSLF4ibi9fEsv6hDB61s/GWttQm03f8qxyUgX270JtFT/W666pHSkEzZ+MG
         nbiS3kIvJxZ8qKSdYvlL2ujmfum1RAZqdUGJsfZCtjAuIjfeVbqFtO4p/w2QA3GbXbE+
         0ybcrAFQ0byb5MgFGbmp9gd0YK6ogZRwMrv8umkalKshg9wb3+Wa6rxKBOVxm6VylCbQ
         HbuuXCuNi0TjLV0x0e2JJoc/qpGJ8/7BzLEAWpKIo4TxsImamEoOV/208yGA8EsOaO3W
         rabJ3YlT12IDbVoT+tRA7zm7KMhCErk2diOsV8V0KIzbK0rrR6qZ33M73lW9oM3qfzuS
         p4ow==
X-Gm-Message-State: AOUpUlHtl8KqtPrrfvXip7Z5h7Km6BXqwXCh+lMP/F6STtDAZdTEukVm
        +Y9ebwIyTz3o+eTY9POPsgu0oRqCVLwL8j1sIqC+aA==
X-Google-Smtp-Source: AAOMgpd34uQ1WPIUpsNHTMt4knTIlOUh/rKpZsZ2cP2jPmveqT8jiU2K6XSFHWSSB7u5ZVL9gcwvktDJ9q4o50vst1Y=
X-Received: by 2002:a24:2e88:: with SMTP id i130-v6mr2189984ita.123.1532101327784;
 Fri, 20 Jul 2018 08:42:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:bb58:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 08:42:07
 -0700 (PDT)
In-Reply-To: <20180720144916.fyqpmrtgt23sax6n@linux-8ccs>
References: <20180716122125.175792-1-maco@android.com> <20180716122125.175792-3-maco@android.com>
 <20180719163208.5xvrafugpcbhh7kj@linux-8ccs> <CAB0TPYFVSWtJ6RPRUZ1bpS-rBaV7YyPR-4B2Ogxs+FNAbiScNw@mail.gmail.com>
 <20180720144916.fyqpmrtgt23sax6n@linux-8ccs>
From:   Martijn Coenen <maco@android.com>
Date:   Fri, 20 Jul 2018 17:42:07 +0200
Message-ID: <CAB0TPYFQvkTsMvfJCTSFSJAoCbmOUJz7mCQGoORs6nRcC3Fhdg@mail.gmail.com>
Subject: Re: [PATCH 2/6] module: add support for symbol namespaces.
To:     Jessica Yu <jeyu@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        USB list <linux-usb@vger.kernel.org>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>,
        linux-scsi@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Iliyan Malchev <malchev@google.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 4:49 PM, Jessica Yu <jeyu@kernel.org> wrote:
> Thanks. Also, it looks like we're currently just warning (in both
> modpost and on module load) if a module uses symbols from a namespace
> it doesn't import. Are you also planning to eventually introduce
> namespace enforcement?

This is something I've definitely been thinking about, and was curious
what others would think. My main concern with enforcement is that it
will start failing to load out-of-tree modules that use newly
namespaced symbols. On the other hand, I think those modules will need
to be rebuilt anyway to be able to load, because the changes to struct
kernel_symbol make them incompatible with the current kernel. That
could be another reason for having these symbols in a special section
(with its own struct namespaced_kernel_symbol); but on the other hand,
it would make the module loader more complex just to facilitate
out-of-tree drivers, and I'm not sure where the trade-off between
those two falls.

> It'd be trivial to fail the module build in
> modpost as well as reject the module on load if it uses an exported
> symbol belonging to a namespace it doesn't import. Although, I'd go
> with the warnings for a development cycle or two, to gently introduce
> the change in API and let other subsystems as well as out-of-tree
> module developers catch up.

An approach like that makes sense to me. Another alternative would be
to make it a CONFIG_ option, and let distros/etc. decide what they are
comfortable with.

Thanks,
Martijn

>
>
> Jessica
>
>
>>> Also, this would get rid of the extra __knsimport section, the extra
>>> ns_dependencies field in struct module, and all those helper functions
>>> that
>>> manage it. In addition, having the modinfo tag may potentially help with
>>> debugging as we have the namespace imports clearly listed if we don't
>>> have
>>> the source code for a module. We'd probably need to modify get_modinfo()
>>> to
>>> handle multiple import: tags though. Luis [1] had written some code a
>>> while
>>> ago to handle multiple (of the same) modinfo tags.
>>>
>>> Thoughts on this?
>>>
>>> Thanks,
>>>
>>> Jessica
>>>
>>> [1] https://lkml.kernel.org/r/20171130023605.29568-3-mcgrof@kernel.org
>>>
>>>
>>>> getname:
>>>>         /* We must make copy under the lock if we failed to get ref. */
>>>>         strncpy(ownername, module_name(owner), MODULE_NAME_LEN);
>>>> @@ -3061,6 +3118,11 @@ static int find_module_sections(struct module
>>>> *mod,
>>>> struct load_info *info)
>>>>                                      sizeof(*mod->gpl_syms),
>>>>                                      &mod->num_gpl_syms);
>>>>         mod->gpl_crcs = section_addr(info, "__kcrctab_gpl");
>>>> +
>>>> +       mod->ns_imports = section_objs(info, "__knsimport",
>>>> +                                      sizeof(*mod->ns_imports),
>>>> +                                      &mod->num_ns_imports);
>>>> +
>>>>         mod->gpl_future_syms = section_objs(info,
>>>>                                             "__ksymtab_gpl_future",
>>>>
>>>> sizeof(*mod->gpl_future_syms),
>>>> @@ -3381,6 +3443,19 @@ static int post_relocation(struct module *mod,
>>>> const struct load_info *info)
>>>>         return module_finalize(info->hdr, info->sechdrs, mod);
>>>> }
>>>>
>>>> +static void verify_namespace_dependencies(struct module *mod)
>>>> +{
>>>> +       struct module_ns_dep *ns_dep;
>>>> +
>>>> +       list_for_each_entry(ns_dep, &mod->ns_dependencies, ns_dep) {
>>>> +               if (!module_imports_ns(mod, ns_dep->namespace)) {
>>>> +                       pr_warn("%s: module uses symbols from namespace
>>>> %s,"
>>>> +                               " but does not import it.\n",
>>>> +                               mod->name, ns_dep->namespace);
>>>> +               }
>>>> +       }
>>>> +}
>>>> +
>>>> /* Is this module of this name done loading?  No locks held. */
>>>> static bool finished_loading(const char *name)
>>>> {
>>>> @@ -3682,6 +3757,8 @@ static int load_module(struct load_info *info,
>>>> const
>>>> char __user *uargs,
>>>>         if (err)
>>>>                 goto free_module;
>>>>
>>>> +       INIT_LIST_HEAD(&mod->ns_dependencies);
>>>> +
>>>> #ifdef CONFIG_MODULE_SIG
>>>>         mod->sig_ok = info->sig_ok;
>>>>         if (!mod->sig_ok) {
>>>> @@ -3730,6 +3807,8 @@ static int load_module(struct load_info *info,
>>>> const
>>>> char __user *uargs,
>>>>         if (err < 0)
>>>>                 goto free_modinfo;
>>>>
>>>> +       verify_namespace_dependencies(mod);
>>>> +
>>>>         flush_module_icache(mod);
>>>>
>>>>         /* Now copy in args */
>>>> --
>>>> 2.18.0.203.gfac676dfb9-goog
>>>>
>>>
>
