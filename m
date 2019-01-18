Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A05CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80B42087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfARMHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:07:42 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38782 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfARMHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:07:42 -0500
Received: by mail-it1-f196.google.com with SMTP id h65so5464226ith.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 04:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=efRhbMu40jc01doE6dk+XxasVG9OQ61RtTN2y4dxMGQ=;
        b=kHXvPGwK+IhrJ6bNQ/zPtoZMm9Wz6y2gt8YjasNb1+WzjvnG4ItcaWj/ZE/mrD35B1
         BN1JMkClsU0PPq7zqAEkqeJVoS9MkB+0T1hX8TOu+xMoXinmnndd374QCyYTuCTg1lLk
         dsXm83nnYeQxOqX15egSaor7Lu2JLiSODlUvmhdt/g1sudyqAashDO3VkCkliucBrEy2
         NoDdD9HsqU8NmyE9HkiCo+9jcz+OA3EjHTnRb9Jyu402M1fbR+jkkI7kpUULgWD+DDXe
         5SofT0jcPss9Tg0quOKGRFcIojSv7aOafsDisIaH3PXAWGHAd5wnGFotvScn9xOB01Tc
         vaRw==
X-Gm-Message-State: AJcUukd8/Ab4NcT/RyRK5Qyz9j76jsrsx6ZeHJbiFeYQ6piP/K2jfPJT
        NnuxXKch2Ny/5RTE51tii9NpnkfHdNw0J35oRAIzI1pa7VLVXA==
X-Google-Smtp-Source: ALg8bN5J65+Ihu7aY1kAKgQaZTBLwQP8ulIODQPgSeQYaurblGVCeTIyGO6GDKFds4RlkK7pIFec9pyqEmYV94riBWc=
X-Received: by 2002:a24:4d05:: with SMTP id l5mr2029393itb.147.1547813261576;
 Fri, 18 Jan 2019 04:07:41 -0800 (PST)
MIME-Version: 1.0
References: <20190118091733.29940-1-kasong@redhat.com> <1547812432.3982.55.camel@linux.ibm.com>
In-Reply-To: <1547812432.3982.55.camel@linux.ibm.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 18 Jan 2019 20:07:30 +0800
Message-ID: <CACPcB9ffvpHbGdp5xz4R5cwXxERsVwzkQEKO9C50c+_hj+n_0g@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] let kexec_file_load use platform keyring to verify
 the kernel image
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        Eric Biggers <ebiggers@google.com>, nayna@linux.ibm.com,
        Dave Young <dyoung@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019, 19:54 Mimi Zohar <zohar@linux.ibm.com wrote:
>
> On Fri, 2019-01-18 at 17:17 +0800, Kairui Song wrote:
> > This patch series adds a .platform_trusted_keys in system_keyring as the
> > reference to .platform keyring in integrity subsystem, when platform
> > keyring is being initialized it will be updated. So other component could
> > use this keyring as well.
>
> Kairui, when people review patches, the comments could be specific,
> but are normally generic.  My review included a couple of generic
> suggestions - not to use "#ifdef" in C code (eg. is_enabled), use the
> term "preboot" keys, and remove any references to "other components".
>
> After all the wording suggestions I've made, you are still saying, "So
> other components could use this keyring as well".  Really?!  How the
> platform keyring will be used in the future, is up to you and others
> to convince Linus.  At least for now, please limit its usage to
> verifying the PE signed kernel image.  If this patch set needs to be
> reposted, please remove all references to "other components".
>
> Dave/David, are you ok with Kairui's usage of "#ifdef's"?  Dave, you
> Acked the original post.  Can I include it?  Can we get some
> additional Ack's on these patches?
>
> thanks!
>
> Mimi
>

Hi, Mimi, thanks for your feedback. My bad I reused the old cover
letter without checking it carefully, hopefully, the commit messages
should have a proper wording now. If the cover letter needs to be
updated I can resend the patch, let me just hold a while before update
again.
