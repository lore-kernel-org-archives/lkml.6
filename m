Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E4AECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C642087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="j+WIqOOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C642087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeJTBhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:37:18 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38328 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeJTBhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:37:18 -0400
Received: by mail-it1-f195.google.com with SMTP id i76-v6so5382213ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 10:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u96BddKAYiZe8VzrG4NtO6GUS8HvDnOgQ7yqKU2D5j4=;
        b=j+WIqOOSPUDuLiHYe+4popSx+VeoOIQ0GQw5zY7BewhbCnScj4iHAJQP54yfm8LAgs
         i7ctR5k28+ctx8x38imBZVUXwm4G9EMBZT/m0ErvuCSS+wlgC++/q9/OZaGX6Y9DRRtB
         94KaUb2Aw3a++s7B/c3tTmLlcjtSzzon1yaMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u96BddKAYiZe8VzrG4NtO6GUS8HvDnOgQ7yqKU2D5j4=;
        b=VWH5fQQAQRCICrfflommpIMp6FuoeYawOmviJXuIqMth3v1Y05f46aiClPAR1Ca87W
         29OHfX5JHSgsslIRvGCW/I+LYM57O373uHSNG36bSOnvTzjhn2GRGz1Usjo35PZ2kqCA
         UIBkzuxD8kjYsSSKWkZR262ZyTVX+eHt3cUlh7JG2ZAaKUkv5yvSddRUL+PQxF2cFrsG
         fIGeRdtce8AydVCOlo1uxzvN39+ctUbv5jl0D88W3PgCs4gNYyYM/7ntjCq7WCm+gKC3
         M0XePV7DD03YAUYAFSwQCRC9e35zuMz0m9FfyvLjUEdPWwrnHjSxQlTSrpQxPz6/XPx+
         xyvQ==
X-Gm-Message-State: ABuFfoi24yEGq5CvYi2cy9u6u97vzXd+3IBZQvEWvrAKJFA2YDcTd3z/
        APNXu7Cv7m8gMNUV7NXE8F6KYZttb0ASGnf9UXll3w==
X-Google-Smtp-Source: ACcGV62xSY1CPwiPdGS6Dkgrj55gQEyJ77jPenxL577P5ing63vq9ajb9HXFgHWXx+BR1YfUm2pXNmMveM0p6uETs18=
X-Received: by 2002:a24:75d6:: with SMTP id y205-v6mr3942181itc.1.1539970215970;
 Fri, 19 Oct 2018 10:30:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Fri, 19 Oct 2018 10:30:15
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <17323.1539964061@warthog.procyon.org.uk>
References: <20181019122049.27121-1-mszeredi@redhat.com> <20181019122049.27121-2-mszeredi@redhat.com>
 <16382.1539963322@warthog.procyon.org.uk> <CAJfpegviiy=9fru3zButbqLnhshH85srH3qyZO2zf-_RPqSs=g@mail.gmail.com>
 <17323.1539964061@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 19 Oct 2018 19:30:15 +0200
Message-ID: <CAJfpegut_rcnssaaN2duCJruJOAJ+tzDsA0uUSEiNwS-QddArQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] uapi: deprecate STATX_ALL
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 5:47 PM, David Howells <dhowells@redhat.com> wrote:
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
>> What is misleading about this?
>
> The manpage says:
>
>            STATX_ALL           [All currently available fields]

Ah, the manpage needs to be fixed, obviously.

>
>> If you feel confused by this comment, then maybe I should just drop that part.
>
> I think that would be better.  Don't try to give it a definition.

Okay.

Thanks,
Miklos
