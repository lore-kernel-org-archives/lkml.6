Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C510C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1621F20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbfAOPrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:47:52 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39715 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731155AbfAOPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:47:51 -0500
Received: by mail-io1-f68.google.com with SMTP id k7so2403778iob.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 07:47:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63qAqn9+8knOzrpJzAgh/hypu9BmGLnvogVKxHDPq6A=;
        b=b9mk5DPM1MbX6wknbcTAgYLIFC5Gi2JLo4mU+DB1Gj0oyKQesrqFi4yeeepvmoVb2a
         lPQwNyBAju3twy6hksFA0VWHVzY33cPlBphf4uuj09A3RxkKml9p/sNLJQIZuwkuLxFP
         y7WFgp3pKNDxdopX5N6FJyuW/Aw30/241PPbSHxrS3XawuUjucNiiETto5jUNMgVmp0r
         qrNMXn+T+zhkmV1apJ2FhQIh8BJWMiV9THullPkfcKUkV5PwxAFy43TWHKcxTy+992Cx
         60uVT5TIBkUQdrHrE6c0KKiobRS5+aKFLx54wC7lmwsA7dy324ahZ/hy54jG8WWnZSU1
         OmfQ==
X-Gm-Message-State: AJcUukd1qeTUE1QNUJnqUUy8BcFd4FqCwrLEmUhCyCI7exn+Yljw/iBk
        yZtHNgaPchL/8tH1EGLo80StSiLB8yCRB/FtcN9Pyw==
X-Google-Smtp-Source: ALg8bN4WJuGrxOHRSezcEWLtO1Y1typgGd1LD5dX6Xw96Rsk7r61Fr4MImLRM8qfYRsr/bC8+8Gytd8fgrS5deJnNMg=
X-Received: by 2002:a5e:de01:: with SMTP id e1mr2352082iok.137.1547567270976;
 Tue, 15 Jan 2019 07:47:50 -0800 (PST)
MIME-Version: 1.0
References: <20190115094542.17129-1-kasong@redhat.com> <20190115094542.17129-2-kasong@redhat.com>
 <1547566455.4156.283.camel@linux.ibm.com>
In-Reply-To: <1547566455.4156.283.camel@linux.ibm.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Tue, 15 Jan 2019 23:47:39 +0800
Message-ID: <CACPcB9fQUNiD8UEVDa+bU67PZSOkckwhwD00Qvu4m3G0JmqqHQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] integrity, KEYS: add a reference to platform keyring
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
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

On Tue, Jan 15, 2019 at 11:34 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2019-01-15 at 17:45 +0800, Kairui Song wrote:
> [snip]
>
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
> > +             set_platform_trusted_keys(keyring[id]);
> > +     }
> > +#endif
> > +
> >       return err;
> >  }
> >
>
> Any reason for setting it here as opposed to in the caller
> platform_keyring_init()?
>
> Mimi
>

Yes, "keyring" is static so unless I expose it to other files, it is
only accessible here. And I think there should be no problem to put
the set_platform_trusted_keys here.

-- 
Best Regards,
Kairui Song
