Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AD8C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07FB2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfAUJJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:09:11 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40074 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfAUJJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:09:11 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so14169520ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:09:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yTNFTtUEmdaeSLKSRslSVpn0/SB0pum0nXBnhqYSft8=;
        b=AoYNh1x3w3I4uH1kzSP69Z/wQDWovrokIncffOP/fsGigrXFin3lNHrJeTUzazzV+f
         1+9AI2vDvITt3n0IQBXYY4bGU6K1qnHPpEKdNxscOuvRntj24V1vKJUMWbx1Y727DARl
         gCwja7fDnezKUf9OqVy3LhaA8qF5AYoWxfQt+aa7WoW64LqBpoS57zTtfQjpsyA0JrHM
         LdouSqOvBSI7h5zRk7POnR6/UzlpCNf3KM7Ch4cdKWxZYk1uQVidyZL0SG9hLAJhZpJS
         TGKZTvIvtB8FD/JpjezZX1JP0c2zUzolU4Ip+sAQfIzJ/HYw69IX4fHJBFqdmRw9xUcq
         jIPw==
X-Gm-Message-State: AJcUukd25W6uDjdmyE1LNqZ6ZjerTC3heq8Ren5YzCIrF1WXarERgTue
        9cYBqNqbMOcOX95TJ5cELrheir4V7UKbwddoEFpPkQ==
X-Google-Smtp-Source: ALg8bN4vSS7fzT15L73z4tPy4QYwQ0HslU9ppF9VlMEKbRHwXt5xTtvtjITkwv8GH/Dh2MtA/a7fdUTGGlqedTIFybA=
X-Received: by 2002:a24:ce42:: with SMTP id v63mr16129333itg.136.1548061750125;
 Mon, 21 Jan 2019 01:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20190118091733.29940-1-kasong@redhat.com> <1547812432.3982.55.camel@linux.ibm.com>
 <20190118123437.GA30929@dhcp-128-65.nay.redhat.com> <20190118123745.GA31072@dhcp-128-65.nay.redhat.com>
 <CACPcB9fiVUCfSBe05FOkKuMbzYnMjjKj50L3ydotSFSp5iL+kg@mail.gmail.com> <CACPcB9egBRmP82-NKCRFyJ6b8=CNkn9fuCjCFw0m-VU_vk3z8A@mail.gmail.com>
In-Reply-To: <CACPcB9egBRmP82-NKCRFyJ6b8=CNkn9fuCjCFw0m-VU_vk3z8A@mail.gmail.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Mon, 21 Jan 2019 17:08:59 +0800
Message-ID: <CACPcB9eLmUyaivmq5Ma3wXqzTk6RiqR8PE2=u69L=zjp682_kg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] let kexec_file_load use platform keyring to verify
 the kernel image
To:     Dave Young <dyoung@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        Eric Biggers <ebiggers@google.com>, nayna@linux.ibm.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 10:28 PM Kairui Song <kasong@redhat.com> wrote:
>
> On Fri, Jan 18, 2019 at 9:42 PM Kairui Song <kasong@redhat.com> wrote:
> >
> > On Fri, Jan 18, 2019 at 8:37 PM Dave Young <dyoung@redhat.com> wrote:
> > >
> > > On 01/18/19 at 08:34pm, Dave Young wrote:
> > > > On 01/18/19 at 06:53am, Mimi Zohar wrote:
> > > > > On Fri, 2019-01-18 at 17:17 +0800, Kairui Song wrote:
> > > > > > This patch series adds a .platform_trusted_keys in system_keyring as the
> > > > > > reference to .platform keyring in integrity subsystem, when platform
> > > > > > keyring is being initialized it will be updated. So other component could
> > > > > > use this keyring as well.
> > > > >
> > > > > Kairui, when people review patches, the comments could be specific,
> > > > > but are normally generic.  My review included a couple of generic
> > > > > suggestions - not to use "#ifdef" in C code (eg. is_enabled), use the
> > > > > term "preboot" keys, and remove any references to "other components".
> > > > >
> > > > > After all the wording suggestions I've made, you are still saying, "So
> > > > > other components could use this keyring as well".  Really?!  How the
> > > > > platform keyring will be used in the future, is up to you and others
> > > > > to convince Linus.  At least for now, please limit its usage to
> > > > > verifying the PE signed kernel image.  If this patch set needs to be
> > > > > reposted, please remove all references to "other components".
> > > > >
> > > > > Dave/David, are you ok with Kairui's usage of "#ifdef's"?  Dave, you
> > > > > Acked the original post.  Can I include it?  Can we get some
> > > > > additional Ack's on these patches?
> > > >
> > > > It is better to update patch to use IS_ENABLED in patch 1/2 as well.
> > >
> > > Hmm, not only for patch 1/2, patch 2/2 also need an update
> > >
> > > > Other than that, for kexec part I'm fine with an ack.
> > > >
> > > > Thanks
> > > > Dave
> >
> > Thanks for the review again, will update the patch using IS_ENABLED
> > along with update the cover letter shortly.
> >
> > --
> > Best Regards,
> > Kairui Song
>
> Hi, before I update it again, most part of the new
> platform_trusted_keyring related code is following how
> secondary_trusted_keyring is implemented (surrounded by ifdefs). I
> thought this could reduce unused code when the keyring is not enabled.
> Else, all ifdef could be simply removed, when platform_keyring is not
> enabled, the platform_trusted_keys will always be NULL, and
> verify_pkcs7_signature will simply return NOKEY if anyone try to use
> platform keyring.
>
> Any suggestions? Or I can just remove the ifdef in
> security/integrity/digsig.c and make set_platform_trusted_keys a
> inline empty function in system_keyring.h.
>
> --
> Best Regards,
> Kairui Song

Hi, after a second thought I'll drop the #ifdef in
security/integrity/digsig.c in PATCH 1/2, and make the
set_platform_trusted_keys function a empty inline function when
CONFIG_INTEGRITY_PLATFORM_KEYRING is undefined.
But for other ifdefs in certs/system_keyring.c I think maybe just keep
then untouched. They were used to strip out the
platform_trusted_keyring variable and related function when
CONFIG_INTEGRITY_PLATFORM_KEYRING is not used, this should help reduce
unused code and prevent compile error, also make code style aligns
with existing code in system_keyring.c.

Will sent v5 with above updates and fix a potential problem found by Nayna.


--
Best Regards,
Kairui Song
