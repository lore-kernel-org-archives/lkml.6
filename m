Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7352EC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF5E20663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfAUKD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:03:56 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40478 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbfAUKDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:03:55 -0500
Received: by mail-it1-f196.google.com with SMTP id h193so14347742ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 02:03:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XEeqscVWGCdHpZMcDyZcIsfpiPlWBKev6BzxbsJ0S6I=;
        b=F5nVfzadmyYM8R+tyypupbFp2216NjSouZvN/87J0hSDBVDzevgfUTzxadEynDNncH
         1D+CLdE2o+perJ6QyyTxY0ynXgm+BiDXjSLOL31TcONuqR/huTKStqPeo0m/MWPdZpPG
         vHridT5BhhbYt9j3tANFtIfYlsvkKK520Qkq6stzfCczZyxbutgwOXQPIJUyPBnS3R7u
         F4RTUXkR4TicmdWlruy6L7vib/Wuu4GSwqDjMtfoXNX3YHZy/aD6sJ4lq9tOlHAuuzT5
         Y6wJ3mE0QTfQipKGkNRONtWRzHCwAQ/qkp3dulsRlcizrZhxnnzE8TZOv1sjvJ3BhslG
         ukyA==
X-Gm-Message-State: AJcUukel/liNRFxql6VhciNF8Ob02QFs8LkBoa42hv9e0vj/Ee1HdCDA
        EYMSjKU8/NJ/cMjoKsbdo+8GtuFPRP/D8vMJwgSRxQ==
X-Google-Smtp-Source: ALg8bN6wXdAWFfIKDeG2VhzwmmF3lttG/N0MUFQwkaiDPpr5NHUQco47PUqBVWfeJ7oAfY1a2ap4vAZ41YHJbEkLaww=
X-Received: by 2002:a24:ce42:: with SMTP id v63mr16205179itg.136.1548065034597;
 Mon, 21 Jan 2019 02:03:54 -0800 (PST)
MIME-Version: 1.0
References: <20190121095929.26915-1-kasong@redhat.com>
In-Reply-To: <20190121095929.26915-1-kasong@redhat.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Mon, 21 Jan 2019 18:03:43 +0800
Message-ID: <CACPcB9c2eJ=Wm8Tb6afgyoAQ5TWuGbuqGXq1i9cN8pRFCwXGrw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] let kexec_file_load use platform keyring to verify
 the kernel image
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        Eric Biggers <ebiggers@google.com>, nayna@linux.ibm.com,
        Dave Young <dyoung@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 6:00 PM Kairui Song <kasong@redhat.com> wrote:
>
> This patch series adds a .platform_trusted_keys in system_keyring as the
> reference to .platform keyring in integrity subsystem, when platform
> keyring is being initialized it will be updated, so it will be
> accessable for verifying PE signed kernel image.
>
> This patch series let kexec_file_load use platform keyring as fall
> back if it failed to verify the image against secondary keyring,
> so the actually PE signature verify process will use keys provides
> by firmware.
>
> After this patch kexec_file_load will be able to verify a signed PE
> bzImage using keys in platform keyring.
>
> Tested in a VM with locally signed kernel with pesign and imported the
> cert to EFI's MokList variable.
>
> To test this patch series on latest kernel, you need to ensure this commit
> is applied as there is an regression bug in sanity_check_segment_list():
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=993a110319a4a60aadbd02f6defdebe048f7773b
>
> Update from V4:
>   - Drop ifdef in security/integrity/digsig.c to make code clearer
>   - Fix a potential issue, set_platform_trusted_keys should not be
>     called when keyring initialization failed
>
> Update from V3:
>   - Tweak and simplify commit message as suggested by Mimi Zohar
>
> Update from V2:
>   - Use IS_ENABLED in kexec_file_load to judge if platform_trusted_keys
>     should be used for verifying image as suggested by Mimi Zohar
>
> Update from V1:
>   - Make platform_trusted_keys static, and update commit message as suggested
>     by Mimi Zohar
>   - Always check if platform keyring is initialized before use it
>
> Kairui Song (2):
>   integrity, KEYS: add a reference to platform keyring
>   kexec, KEYS: Make use of platform keyring for signature verify
>
>  arch/x86/kernel/kexec-bzimage64.c | 13 ++++++++++---
>  certs/system_keyring.c            | 22 +++++++++++++++++++++-
>  include/keys/system_keyring.h     |  9 +++++++++
>  include/linux/verification.h      |  1 +
>  security/integrity/digsig.c       |  3 +++
>  5 files changed, 44 insertions(+), 4 deletions(-)
>
> --
> 2.20.1
>

Hi Mimi,

I've updated the patch series again and as the code changed a bit I
didn't include previous Reviewd-by / Tested-by, it worked with no
problem, could you help have a review again? Thank you.

-- 
Best Regards,
Kairui Song
