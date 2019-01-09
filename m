Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20118C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E496E20645
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbfAICCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:02:55 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40964 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbfAICCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 21:02:53 -0500
Received: by mail-io1-f66.google.com with SMTP id s22so4806215ioc.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 18:02:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZzljEILvlpakQlXy+M1GQHzlPojI4ZdNWtszc0WhKLc=;
        b=R9e9DGuR6mxz0G1DC7CLaXtxP5XDPwpWLmLvnbLr1NYDhEh65yQwqNlDvhXcaFgRRl
         k0NrfXvXHA0OaPYBrj8R9H1bGpO4y7xEblaAAXs1GdwqeswfI8J9NxtSryQjMgrvH17Q
         X6cNJ8JhPbuiD/Iyo2skC9SJkAbh6uY9Cckk07vALBtDgOlT0jBMlJdmXnE8rHd0ujDo
         mteIAik9PZsl0mqUQyDoZfa5dMYqv75oQvMZ0YjfPbXYtjPZBqg7TRY4rlDq4QLsW79o
         fIv41FvQvULzbOlDz6UuHf3mvz1+YTF9BAxDD06Rdy/3zCIgHPg+VyqPHEFSA7GMt0R0
         u/2w==
X-Gm-Message-State: AJcUukcNtN70njgFtdZEXBNijGpdmXHqssPHstBWvekFO2VqpZoDj0pk
        WecVsqI7VCU4uOM1mVHpE9gOUTpdmG0U1gk7GUr0sg==
X-Google-Smtp-Source: ALg8bN5JJFcEmV5GwPF0Et3f2grKdznSu8pH3S+zR4c5kN+wtR/ZGo9sVE6EEMwLm/Igt7HsQ4smI2vfZjWGLZz/7P8=
X-Received: by 2002:a5d:8889:: with SMTP id d9mr2889441ioo.68.1546999372490;
 Tue, 08 Jan 2019 18:02:52 -0800 (PST)
MIME-Version: 1.0
References: <20190108081247.2266-1-kasong@redhat.com> <20190108081247.2266-2-kasong@redhat.com>
 <1546960680.19931.114.camel@linux.ibm.com> <20190109013356.GA2610@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190109013356.GA2610@dhcp-128-65.nay.redhat.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Wed, 9 Jan 2019 10:02:41 +0800
Message-ID: <CACPcB9e_1aom8hb2Xqd6u-QUmh=y+cni3YxrM09Mro2q_A5-gw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] KEYS, integrity: Link .platform keyring to .secondary_trusted_keys
To:     Dave Young <dyoung@redhat.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>, dwmw2@infradead.org,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        ebiggers@google.com, nayna@linux.ibm.com,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the explanation Dave, my second thought is to let kexec use
the platform keyring directly, that is let kexec verify the image with
secondary/builtin keyring first then try platform keyring. And better
to make platform keyring independent of integrity subsystem, so kexec
could verify the image and don't depend on integrity. Any thought?

On Wed, Jan 9, 2019 at 9:34 AM Dave Young <dyoung@redhat.com> wrote:
>
> CC kexec list
> On 01/08/19 at 10:18am, Mimi Zohar wrote:
> > [Cc'ing the LSM and integrity mailing lists]
> >
> > Repeating my comment on PATCH 0/1 here with the expanded set of
> > mailing lists.
> >
> > The builtin and secondary keyrings have a signature change of trust
> > rooted in the signed kernel image.  Adding the pre-boot keys to the
> > secondary keyring breaks that signature chain of trust.
> >
> > Please do NOT add the pre-boot "platform" keys to the secondary
> > keyring.
>
> If we regard kexec as a bootloader, it sounds natural to use the
> platform key to verify the signature with kexec_file_load syscall.
>
> It will be hard for user to manually sign a kernel and import the key
> then to reuse kexec_file_load.
>
> I think we do not care if platform key can be added to secondary or not,
> any suggestions how can kexec_file to use the platform key?
>
> >
> > Mimi
> >
> >
> > On Tue, 2019-01-08 at 16:12 +0800, Kairui Song wrote:
> > > Currently kexec may need to verify the kerne image, and the kernel image
> > > could be signed with third part keys which are provided by paltform or
> > > firmware (eg. stored in MokListRT EFI variable). And the same time,
> > > kexec_file_load will only verify the image agains .builtin_trusted_keys
> > > or .secondary_trusted_keys according to configuration, but there is no
> > > way for kexec_file_load to verify the image against any third part keys
> > > mentioned above.
> > >
> > > In ea93102f3224 ('integrity: Define a trusted platform keyring') a
> > > .platform keyring is introduced to store the keys provided by platform
> > > or firmware. And with a few following commits including 15ea0e1e3e185
> > > ('efi: Import certificates from UEFI Secure Boot'), now keys required to
> > > verify the image is being imported to .paltform keyring, and later
> > > IMA-appraisal could access the keyring and verify the image.
> > >
> > > This patch links the .platform keyring to .secondary_trusted_keys so
> > > kexec_file_load could also leverage the .platform keyring to verify the
> > > kernel image.
> > >
> > > Signed-off-by: Kairui Song <kasong@redhat.com>
> > > ---
> > >  certs/system_keyring.c          | 30 ++++++++++++++++++++++++++++++
> > >  include/keys/platform_keyring.h | 12 ++++++++++++
> > >  security/integrity/digsig.c     |  7 +++++++
> > >  3 files changed, 49 insertions(+)
> > >  create mode 100644 include/keys/platform_keyring.h
> > >
> > > diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> > > index 81728717523d..dcef0259e149 100644
> > > --- a/certs/system_keyring.c
> > > +++ b/certs/system_keyring.c
> > > @@ -18,12 +18,14 @@
> > >  #include <linux/verification.h>
> > >  #include <keys/asymmetric-type.h>
> > >  #include <keys/system_keyring.h>
> > > +#include <keys/platform_keyring.h>
> > >  #include <crypto/pkcs7.h>
> > >
> > >  static struct key *builtin_trusted_keys;
> > >  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
> > >  static struct key *secondary_trusted_keys;
> > >  #endif
> > > +static struct key *platform_keys = NULL;
> > >
> > >  extern __initconst const u8 system_certificate_list[];
> > >  extern __initconst const unsigned long system_certificate_list_size;
> > > @@ -67,6 +69,12 @@ int restrict_link_by_builtin_and_secondary_trusted(
> > >             /* Allow the builtin keyring to be added to the secondary */
> > >             return 0;
> > >
> > > +   if (type == &key_type_keyring &&
> > > +       dest_keyring == secondary_trusted_keys &&
> > > +       payload == &platform_keys->payload)
> > > +           /* Allow the platform keyring to be added to the secondary */
> > > +           return 0;
> > > +
> > >     return restrict_link_by_signature(dest_keyring, type, payload,
> > >                                       secondary_trusted_keys);
> > >  }
> > > @@ -188,6 +196,28 @@ static __init int load_system_certificate_list(void)
> > >  }
> > >  late_initcall(load_system_certificate_list);
> > >
> > > +#if defined(CONFIG_INTEGRITY_PLATFORM_KEYRING) && defined(CONFIG_SECONDARY_TRUSTED_KEYRING)
> > > +
> > > +/*
> > > + * Link .platform keyring to .secondary_trusted_key keyring
> > > + */
> > > +static __init int load_platform_certificate_list(void)
> > > +{
> > > +   int ret = 0;
> > > +   platform_keys = integrity_get_platform_keyring();
> > > +   if (!platform_keys) {
> > > +           return 0;
> > > +   }
> > > +   ret = key_link(secondary_trusted_keys, platform_keys);
> > > +   if (ret < 0) {
> > > +           pr_err("Failed to link platform keyring: %d", ret);
> > > +   }
> > > +   return 0;
> > > +}
> > > +late_initcall(load_platform_certificate_list);
> > > +
> > > +#endif
> > > +
> > >  #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> > >
> > >  /**
> > > diff --git a/include/keys/platform_keyring.h b/include/keys/platform_keyring.h
> > > new file mode 100644
> > > index 000000000000..4f92ed6c0b42
> > > --- /dev/null
> > > +++ b/include/keys/platform_keyring.h
> > > @@ -0,0 +1,12 @@
> > > +#ifndef _KEYS_PLATFORM_KEYRING_H
> > > +#define _KEYS_PLATFORM_KEYRING_H
> > > +
> > > +#include <linux/key.h>
> > > +
> > > +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> > > +
> > > +extern const struct key* __init integrity_get_platform_keyring(void);
> > > +
> > > +#endif /* CONFIG_INTEGRITY_PLATFORM_KEYRING */
> > > +
> > > +#endif /* _KEYS_SYSTEM_KEYRING_H */
> > > diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> > > index f45d6edecf99..397758d4f12d 100644
> > > --- a/security/integrity/digsig.c
> > > +++ b/security/integrity/digsig.c
> > > @@ -176,3 +176,10 @@ int __init integrity_load_cert(const unsigned int id, const char *source,
> > >     pr_info("Loading X.509 certificate: %s\n", source);
> > >     return integrity_add_key(id, data, len, perm);
> > >  }
> > > +
> > > +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> > > +struct key* __init integrity_get_platform_keyring(void)
> > > +{
> > > +   return keyring[INTEGRITY_KEYRING_PLATFORM];
> > > +}
> > > +#endif
> >
>
> Thanks
> Dave



-- 
Best Regards,
Kairui Song
