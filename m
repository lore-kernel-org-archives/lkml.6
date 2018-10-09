Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0463BECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A022C214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="vy+xthHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A022C214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeJJCkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 22:40:45 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39042 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeJJCko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 22:40:44 -0400
Received: by mail-yw1-f66.google.com with SMTP id v1-v6so1151385ywv.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 12:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z8fjDur924+p0Ux3QKeMa15DHjtPOjFrB9HLwWWynPs=;
        b=vy+xthHC48GglWiUhMkYsq34TVG7tXHnbuKZZbnW6VonbH8X6Md6Am1XVxR0C1bKyW
         i2IzBP76b0NPINiy+MOhYuLED6TRF4N5YsSVymzDhGZm4HiobsIz+xz15KtGwIFAFEIV
         hIS3U37xGb+G6KiNX6eLvEWAtUEPK2phNnzB4aBn0A3Kt0dBPg2W0gk2kyQLuyDyTPMW
         bVTBV00cOR8ZsiYeyKnYGKPb4Pp4OfZDHrVuWY86qbGOu/4ME/vCOIpSUHop1NnoUO6J
         U7fwmPkNbCRcXIFJgfBvBbCSUd/RAbscu7VCEgz+ZfwX43eygIZ1nHC3kvkLQGheBYKI
         sZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z8fjDur924+p0Ux3QKeMa15DHjtPOjFrB9HLwWWynPs=;
        b=ZZFnyR8GW+VBRS+YMAyIPOmIvAWk+yvvViQ8wWWU4bFnqwLJx9pIo/Af7RcdIIvsf/
         tKgaqKkQbxeDNzDWIbYigFKL11OwheXc2tPs3xP+1CX9Dhrnz54ThUc5sfhrdwwLQfKx
         SpKcuXoIWERxkFMlMlxGsKeHfWREfyr7PKsSmRt4MAB62KKAno3nBsF10g47GQ3ryW8F
         cfNTPIrkXJ53UbXLVGxkGjAS1Pl7x3NdMw+PeneQU4WWFm9leZEOMwoeeAZTGPlwzLIx
         9jcHEYFy/oAcPh4LFcaWUHdBvB5gkopEw/3F7HVYcXYmwZTRaDOI51FwlhvxVuw2FGfU
         7WEg==
X-Gm-Message-State: ABuFfojmyeNCnHQqphlJMgYy52KbinPYKmdftdug+1TW1lujvIjDggY6
        EDFakxpia3Lw2LpDnIsDtfF5yIVh6Xl+Aailff/uwg==
X-Google-Smtp-Source: ACcGV61LeJxjuiaTvT8Bn683QXzzWkasxEOb4julDfHGlaEWL5Wn86k8IyHvsGsjHjllpEb+6bG8YSDqE+U4in5io5M=
X-Received: by 2002:a81:838e:: with SMTP id t136-v6mr16516105ywf.165.1539112936993;
 Tue, 09 Oct 2018 12:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20181005014952.255266-1-joel@joelfernandes.org>
In-Reply-To: <20181005014952.255266-1-joel@joelfernandes.org>
From:   Todd Kjos <tkjos@android.com>
Date:   Tue, 9 Oct 2018 12:22:06 -0700
Message-ID: <CAD0t5oMaetXqAyaete=BDifCk-6ksa6D2tsMO6b6L86mkvLn5w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add me to Android drivers
To:     joel@joelfernandes.org
Cc:     LKML <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 6:50 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> I am one of the main engineers working on ashmem. I have been fixing
> bugs in the driver and have been involved in the memfd conversion
> discussions and sending patches about that. I also have an understanding
> of the binder driver and was involved with some of the development on
> finer grained locking. So I would like to be added to the MAINTAINERS
> file for android drivers for review and maintenance of ashmem and other
> Android drivers.
>
> Cc: tkjos@google.com
> Cc: gregkh@linuxfoundation.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 544cac829cf4..d639c4d04438 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -894,6 +894,7 @@ M:  Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  M:     Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
>  M:     Todd Kjos <tkjos@android.com>
>  M:     Martijn Coenen <maco@android.com>
> +M:     Joel Fernandes <joel@joelfernandes.org>
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.=
git
>  L:     devel@driverdev.osuosl.org
>  S:     Supported
> --
> 2.19.0.605.g01d371f741-goog
>

Nice to have someone focused on ashmem maintenance!

Acked-by: Todd Kjos <tkjos@android.com>
