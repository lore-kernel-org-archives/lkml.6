Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C6BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66CB20851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YRTMyeTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66CB20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbeLJRvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:51:40 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36205 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbeLJRvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:51:40 -0500
Received: by mail-yb1-f195.google.com with SMTP id 64so2889569ybe.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ujnwl3BsNFQa93BAt9nig1Xuv1MrvR6KHaZTtgjC6ng=;
        b=YRTMyeTss6kEtS8Cn7N0HWSp33lfIVmAFUB+qqUGUjAwO8qtL1rRsIn+b7vL93fgOv
         CMcljSPnX8kTdmIWxCXje2D/yWcckRO5vDsitH28q+y3JIdpLuAlPN7zF/XeIVHWuOQN
         MJ650of5DObqR8TtAC2kJU9YOnolSWbKEdd68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ujnwl3BsNFQa93BAt9nig1Xuv1MrvR6KHaZTtgjC6ng=;
        b=FvvN06UuTzYGNBD5FQ12FN/JJBut8/SFMWlaoKXLDFp2bhdEBpJnmNs1zRkMolREfv
         zr2KzVk+4+/993RmLF8uiT1kegFmtiykeUmQE/eNfTSKOmYEl5nfla6U9GaGYXSRIL4c
         BDyDGevG4G/wBKjH0QSKU8dxVx+l/iJ/IS0NBe7jSUTZTjqmVqLjNbnEf2Eun5iFiElN
         Hbk6VO95/gQZ7lPBLqWECMznpTElZqtUc1nLNDZ6r2wnkuKj32KH6hI/f2F+WRB47/Xi
         JGaQLQeJMM2q3ZIDCLY8pVnZ5XL3Rdvz/7njHo4hwz0LUz8OlRmnvJn68gTRmSQ5gbVp
         dA2A==
X-Gm-Message-State: AA+aEWbxDws7S+BT5SjeRNTxarS3x+89rfnounCCO8zAiDRCQ+oBOeB4
        91rBJELDVxsEZ61cPaU5njjigYyGbxA=
X-Google-Smtp-Source: AFSGD/X7hi+HADzpXYq5E3aFjh4FbqQrDCIF/ZyFeTmMJZEpBufIXbxU+fg0dkfRpKN+kGAO3i5YJw==
X-Received: by 2002:a25:d391:: with SMTP id e139mr7833192ybf.86.1544464298065;
        Mon, 10 Dec 2018 09:51:38 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id h145sm3533470ywc.72.2018.12.10.09.51.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:51:35 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id f4so5008278ybq.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:51:34 -0800 (PST)
X-Received: by 2002:a25:1cc1:: with SMTP id c184-v6mr13103299ybc.421.1544464294266;
 Mon, 10 Dec 2018 09:51:34 -0800 (PST)
MIME-Version: 1.0
References: <20181016223322.16844-1-christian@brauner.io> <20181029145818.4bqmy25itjnqhodg@brauner.io>
 <CAGXu5jJwSRQ3dOgNW_X0Fk+8gT+ACiBZPJ79g-aCfqiWsm=ewg@mail.gmail.com> <CAPP7u0U72jSkT3km-E2imQdOvk-WRaDCH4t--N07mh8my7PvOQ@mail.gmail.com>
In-Reply-To: <CAPP7u0U72jSkT3km-E2imQdOvk-WRaDCH4t--N07mh8my7PvOQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 10 Dec 2018 09:51:22 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+hBRZqqp8JfRxwbPMCFT4YMRdn3djHpb8HyZU2Hh-L=w@mail.gmail.com>
Message-ID: <CAGXu5j+hBRZqqp8JfRxwbPMCFT4YMRdn3djHpb8HyZU2Hh-L=w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] sysctl: handle overflow for file-max
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christian Brauner <christian.brauner@canonical.com>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Can you take this patch for -mm?

-Kees

On Sun, Dec 9, 2018 at 8:41 AM Christian Brauner
<christian.brauner@canonical.com> wrote:
>
> On Mon, Oct 29, 2018 at 10:44 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Oct 29, 2018 at 7:58 AM, Christian Brauner <christian@brauner.io> wrote:
> > > On Wed, Oct 17, 2018 at 12:33:20AM +0200, Christian Brauner wrote:
> > >> Hey,
> > >>
> > >> Here is v3 of this patchset. Changelogs are in the individual commits.
> > >>
> > >> Currently, when writing
> > >>
> > >> echo 18446744073709551616 > /proc/sys/fs/file-max
> > >>
> > >> /proc/sys/fs/file-max will overflow and be set to 0. That quickly
> > >> crashes the system.
> > >>
> > >> The first version of this patch intended to detect the overflow and cap
> > >> at ULONG_MAX. However, we should not do this and rather return EINVAL on
> > >> overflow. The reasons are:
> > >> - this aligns with other sysctl handlers that simply reject overflows
> > >>   (cf. [1], [2], and a bunch of others)
> > >> - we already do a partial fail on overflow right now
> > >>   Namely, when the TMPBUFLEN is exceeded. So we already reject values
> > >>   such as 184467440737095516160 (21 chars) but accept values such as
> > >>   18446744073709551616 (20 chars) but both are overflows. So we should
> > >>   just always reject 64bit overflows and not special-case this based on
> > >>   the number of chars.
> > >>
> > >> (This patchset is in reference to https://lkml.org/lkml/2018/10/11/585.)
> > >
> > > Just so that we don't forget, can we make sure that this gets picked
> > > into linux-next? :)
> >
> > I was hoping akpm would take this? Andrew, does the v3 look okay to you?
>
> gentle ping again :)
>
> Christian



-- 
Kees Cook
