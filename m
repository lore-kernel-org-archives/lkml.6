Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C370DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AACB2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfARPCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:02:05 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54942 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfARPCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:02:05 -0500
Received: by mail-it1-f193.google.com with SMTP id i145so7060408ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 07:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpdAAlhA+pBh1vzs4xOSMuaE1OIhf/our8llKb6cg0g=;
        b=JpAmi59MoOu4F4myy6c1BkrwbXS3OW2ZhdZODs7Nsc8u334C7OjF2yc7MTIwcLEJhf
         Lj5PrrGQRY18FQ79usU4IbI/ViI33b3BJo7Lrq1P2pIUSHf0mDq0TIHs4swF+xQDF0Fu
         Kt0Ls5C444SdEJJOYcDGSudWbLs4Tph+7wHr/GfSZerDjNmc3AYB1r2srtWJGRf4OamZ
         H/CIi22upXTJ31ztTMHIXrkWnushSOe3g16Qss5WDuEMshK4dhnuVfVFxAIP/E3fHHlG
         MtCqC+t9hUJhbwT18F+Jlf6R1M4kCHaBrDpy8Pe7WmEroPwGysSCIsRO5oq1+uNq0CT+
         AdBA==
X-Gm-Message-State: AJcUukcD6pWjRulmGFi0lC00H/BH1UFcoLvsJiJuCaE/nLyZqb7BmelU
        4GmyUUm3/BMdJEkGkQaJurQdXoq1W0HQkwEqrjxyCA==
X-Google-Smtp-Source: ALg8bN40lcPsCJ4lqLw3U8S5LwSuJ7/U8dzNcTwNmoB7SnJ0QzwFJ+kBwmtpu4MD5iwyh5nxrMMPB4u5N2gHJdirNdc=
X-Received: by 2002:a02:93c2:: with SMTP id z60mr10224649jah.51.1547823724112;
 Fri, 18 Jan 2019 07:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20190118091733.29940-1-kasong@redhat.com> <20190118091733.29940-2-kasong@redhat.com>
 <3c7fa625-e77c-d6b4-35a4-8f8e9af60864@linux.vnet.ibm.com>
In-Reply-To: <3c7fa625-e77c-d6b4-35a4-8f8e9af60864@linux.vnet.ibm.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 18 Jan 2019 23:01:52 +0800
Message-ID: <CACPcB9dJ2L8k=jmT23Q72YHjsjzK79ywgU+ASLSe3tkQnosOCQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] integrity, KEYS: add a reference to platform keyring
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     jwboyer@fedoraproject.org, Eric Biggers <ebiggers@google.com>,
        Dave Young <dyoung@redhat.com>, nayna@linux.ibm.com,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, jmorris@namei.org,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>, bauerman@linux.ibm.com,
        serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 10:36 PM Nayna <nayna@linux.vnet.ibm.com> wrote:
> On 01/18/2019 04:17 AM, Kairui Song wrote:
> > commit 9dc92c45177a ('integrity: Define a trusted platform keyring')
> > introduced a .platform keyring for storing preboot keys, used for
> > verifying kernel images' signature. Currently only IMA-appraisal is able
> > to use the keyring to verify kernel images that have their signature
> > stored in xattr.
> >
> > This patch exposes the .platform keyring, making it accessible for
> > verifying PE signed kernel images as well.
> >
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Kairui Song <kasong@redhat.com>
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > Tested-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >   certs/system_keyring.c        | 9 +++++++++
> >   include/keys/system_keyring.h | 5 +++++
> >   security/integrity/digsig.c   | 6 ++++++
> >   3 files changed, 20 insertions(+)
> >
> > diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> > index 81728717523d..4690ef9cda8a 100644
> > --- a/certs/system_keyring.c
> > +++ b/certs/system_keyring.c
> > @@ -24,6 +24,9 @@ static struct key *builtin_trusted_keys;
> >   #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
> >   static struct key *secondary_trusted_keys;
> >   #endif
> > +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> > +static struct key *platform_trusted_keys;
> > +#endif
> >
> >   extern __initconst const u8 system_certificate_list[];
> >   extern __initconst const unsigned long system_certificate_list_size;
> > @@ -265,4 +268,10 @@ int verify_pkcs7_signature(const void *data, size_t len,
> >   }
> >   EXPORT_SYMBOL_GPL(verify_pkcs7_signature);
> >
> > +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> > +void __init set_platform_trusted_keys(struct key *keyring) {
> > +     platform_trusted_keys = keyring;
> > +}
> > +#endif
> > +
> >   #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
> > diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
> > index 359c2f936004..9e1b7849b6aa 100644
> > --- a/include/keys/system_keyring.h
> > +++ b/include/keys/system_keyring.h
> > @@ -61,5 +61,10 @@ static inline struct key *get_ima_blacklist_keyring(void)
> >   }
> >   #endif /* CONFIG_IMA_BLACKLIST_KEYRING */
> >
> > +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> > +
> > +extern void __init set_platform_trusted_keys(struct key* keyring);
> > +
> > +#endif /* CONFIG_INTEGRITY_PLATFORM_KEYRING */
> >
> >   #endif /* _KEYS_SYSTEM_KEYRING_H */
> > diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> > index f45d6edecf99..bfabc2a8111d 100644
> > --- a/security/integrity/digsig.c
> > +++ b/security/integrity/digsig.c
> > @@ -89,6 +89,12 @@ static int __integrity_init_keyring(const unsigned int id, key_perm_t perm,
> >               keyring[id] = NULL;
> >       }
> >
> > +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> > +     if (id == INTEGRITY_KEYRING_PLATFORM) {
>
> Shouldn't it also check that keyring[id] is not NULL ?

Good catch, if it's NULL then platform_trusted_keyring will be set to
NULL as well, which will work just fine as in this case
platform_trusted_keyring is still considered not initialized. I'll add
a sanity check here to check err value just in case.
Thanks for your suggestion!

>
> Thanks & Regards,
>      - Nayna
>
> > +             set_platform_trusted_keys(keyring[id]);
> > +     }
> > +#endif
> > +
> >       return err;
> >   }
> >
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec



-- 
Best Regards,
Kairui Song
