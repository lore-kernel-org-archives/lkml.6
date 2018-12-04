Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD97C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC1E206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nu+wL9o0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC1E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeLDRX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:23:29 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42643 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeLDRX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:23:29 -0500
Received: by mail-yw1-f67.google.com with SMTP id x2so7285023ywc.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 09:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+H3tcXX7HudC4lfvSsxJOdML2EmfEd5SjlFOJ1OP9z8=;
        b=nu+wL9o0suqqL7YB74rD4BadXA3u6qmLBFuI/T914OPqySbKXJfZHgUydAEQeooS6C
         Kix71uYoBJN8fG9PRSjyRsvc13fnr+9LabYxBIvqA9SzfqN2ABMXPF3nFEyNbHdFsoS9
         hVpeL+pYaJPCst5V7ezzbyI0RsbL/aLrcCnuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+H3tcXX7HudC4lfvSsxJOdML2EmfEd5SjlFOJ1OP9z8=;
        b=RL4yfvdFB8+d70/LeX+87V93eVxKVnUzoNxG6v4ieNqZFippHP3gh6ohSYlUOS4zNR
         RUE5LgChCYMEVAzNWyTBw8Zh3KtPgjha0kg8QLZq+yRgZmjgm+/owoo5UP7yd4iWJWMF
         liFiutlP9oWaSV5S6g0ly8vZ1aklbfpNow8cVuh9qBTG7zW/nKyjV0BDqQPRy2WCrG3P
         NWZpu/T6LNnp2859sKIEeV5pjgsHNiiz2OPPgEG8snDp4BKPoGHpyM+kIcqQt+Dr2I/c
         2hW/mNd2PCW5tejCs0V/oewNpH4Esz1TNWOthRC/adfkV8liCRUlSFgoOpJpAyQBBSB5
         nmeg==
X-Gm-Message-State: AA+aEWbIbsEutgDIz/2fCum2RNtSk8/PQOypsb7gs6mHqPp3v6+qlI2k
        QnHGFFx300EkgksqFslCIVTd0bZoOgA=
X-Google-Smtp-Source: AFSGD/VlKX/MjLuJiOfeu9Mo4V3MMeUhofv9Uh6zKG36dG9QIWxzmouzOkm+AS9Vemw9tVddo8mVhQ==
X-Received: by 2002:a81:b2c3:: with SMTP id q186mr571613ywh.353.1543944207707;
        Tue, 04 Dec 2018 09:23:27 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id y16sm5503074ywg.35.2018.12.04.09.23.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 09:23:26 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id z2-v6so7177148ybj.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 09:23:26 -0800 (PST)
X-Received: by 2002:a25:2347:: with SMTP id j68mr11714616ybj.137.1543944205466;
 Tue, 04 Dec 2018 09:23:25 -0800 (PST)
MIME-Version: 1.0
References: <20181130224736.GA38485@beast> <20181204154056.iyf333bcxqwk3obe@linutronix.de>
In-Reply-To: <20181204154056.iyf333bcxqwk3obe@linutronix.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 4 Dec 2018 09:23:13 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLUMW3cCi1KVdSmOVn3O9BQ6ptYnyJbLHxojgzXd_YUxQ@mail.gmail.com>
Message-ID: <CAGXu5jLUMW3cCi1KVdSmOVn3O9BQ6ptYnyJbLHxojgzXd_YUxQ@mail.gmail.com>
Subject: Re: [PATCH] pstore: Convert buf_lock to semaphore
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 7:41 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2018-11-30 14:47:36 [-0800], Kees Cook wrote:
> > diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
> > index cfe87b465819..0f7d97917197 100644
> > --- a/drivers/firmware/efi/efi-pstore.c
> > +++ b/drivers/firmware/efi/efi-pstore.c
> > @@ -259,8 +259,7 @@ static int efi_pstore_write(struct pstore_record *record)
> >               efi_name[i] = name[i];
> >
> >       ret = efivar_entry_set_safe(efi_name, vendor, PSTORE_EFI_ATTRIBUTES,
> > -                           !pstore_cannot_block_path(record->reason),
> > -                           record->size, record->psi->buf);
> > +                           preemptible(), record->size, record->psi->buf);
>
> Well. Better I think.
> might_sleep() / preempt_count_equals() checks for preemptible() + rcu_preempt_depth().
> kmsg_dump() starts with rcu_read_lock() which means with this patch applied I
> got:

Okay, so, if kmsg_dump() uses rcu_read_lock(), that means efi-pstore
can _never_ sleep, and it's nothing to do with pstore internals. :( I
guess we just hard-code it, then? And efi-pstore should probably only
attach to pstore if it has a nonblock implementation (and warn if one
isn't available).

-Kees

-- 
Kees Cook
