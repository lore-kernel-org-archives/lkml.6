Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A0DC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90622086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfARNmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:42:51 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43277 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfARNmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:42:50 -0500
Received: by mail-io1-f67.google.com with SMTP id b23so10691639ios.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 05:42:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r1wVl6QPDlhM/57aEphiYxQWDYjyZOJOK+G0Wz63l3M=;
        b=fbznnZJJAORcWbmJY82Em1oddRwr9gRgchEX4y9/hSCnuhkZ87+0NRo9hdU3Mjd2jP
         v7H9EbmBAsScoZPT45aREPYTEM7lh6eWdbBsoqYzqa2fovW90//M/js80vgxflPcNSIA
         +3ibzbUWXDaUs2mlMjbI/OnBCoylHBX1KdaaFxVqTZdH7RuXhEb/geM0PbD/j3YKVyRm
         2ZWXdPh3KcKApy1fFvRQ2L+3ZeGdedXfpbOraVAN7bQzIR2tplnPbbeIT1YMqDL0rehR
         2eoMxQBzUiRrfzSg+DRSaHYRC4WcvkQ0FzbfN0f57MDWw5pONcEM/LklBhe2BEQ63VH9
         GN3Q==
X-Gm-Message-State: AJcUukcj+o+3RbywUo6Y+o4PSRqavBmZY91etU1wUMPnBRLXX0+0noDJ
        nfeP+113kvT91cmuOMRDxuS5mRmeE+swDVfCDMXV8w==
X-Google-Smtp-Source: ALg8bN4NrWwqu+DDOiw4rnkBuJRXLm8zCZC1/SSir5wdWH7W7vkWFFFB4vPYtCUfTVk1eVaNNtHFnLEbgZw6oAl/v3Q=
X-Received: by 2002:a6b:b502:: with SMTP id e2mr9475079iof.43.1547818969774;
 Fri, 18 Jan 2019 05:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20190118091733.29940-1-kasong@redhat.com> <1547812432.3982.55.camel@linux.ibm.com>
 <20190118123437.GA30929@dhcp-128-65.nay.redhat.com> <20190118123745.GA31072@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190118123745.GA31072@dhcp-128-65.nay.redhat.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 18 Jan 2019 21:42:38 +0800
Message-ID: <CACPcB9fiVUCfSBe05FOkKuMbzYnMjjKj50L3ydotSFSp5iL+kg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] let kexec_file_load use platform keyring to verify
 the kernel image
To:     Dave Young <dyoung@redhat.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
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

On Fri, Jan 18, 2019 at 8:37 PM Dave Young <dyoung@redhat.com> wrote:
>
> On 01/18/19 at 08:34pm, Dave Young wrote:
> > On 01/18/19 at 06:53am, Mimi Zohar wrote:
> > > On Fri, 2019-01-18 at 17:17 +0800, Kairui Song wrote:
> > > > This patch series adds a .platform_trusted_keys in system_keyring as the
> > > > reference to .platform keyring in integrity subsystem, when platform
> > > > keyring is being initialized it will be updated. So other component could
> > > > use this keyring as well.
> > >
> > > Kairui, when people review patches, the comments could be specific,
> > > but are normally generic.  My review included a couple of generic
> > > suggestions - not to use "#ifdef" in C code (eg. is_enabled), use the
> > > term "preboot" keys, and remove any references to "other components".
> > >
> > > After all the wording suggestions I've made, you are still saying, "So
> > > other components could use this keyring as well".  Really?!  How the
> > > platform keyring will be used in the future, is up to you and others
> > > to convince Linus.  At least for now, please limit its usage to
> > > verifying the PE signed kernel image.  If this patch set needs to be
> > > reposted, please remove all references to "other components".
> > >
> > > Dave/David, are you ok with Kairui's usage of "#ifdef's"?  Dave, you
> > > Acked the original post.  Can I include it?  Can we get some
> > > additional Ack's on these patches?
> >
> > It is better to update patch to use IS_ENABLED in patch 1/2 as well.
>
> Hmm, not only for patch 1/2, patch 2/2 also need an update
>
> > Other than that, for kexec part I'm fine with an ack.
> >
> > Thanks
> > Dave

Thanks for the review again, will update the patch using IS_ENABLED
along with update the cover letter shortly.

-- 
Best Regards,
Kairui Song
