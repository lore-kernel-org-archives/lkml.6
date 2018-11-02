Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E843AC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26722081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1B+dXv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26722081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeKCCta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:49:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38648 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeKCCta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:49:30 -0400
Received: by mail-oi1-f195.google.com with SMTP id v83-v6so2234829oia.5;
        Fri, 02 Nov 2018 10:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWO+4p+aOwAMpO0SqeyGYBcY8UjCWkDwEN8US0idvpI=;
        b=C1B+dXv4hS1xYvJ2aFUVynbiOkWKl5lFa5gk7CFJtkezpk4JJX+3zQ4tbgSo8O7mgX
         k04nNoI8KOnyKU7RrdfAUp7MM7lPe92h5pv1OxU+s0HKq/KtHnZnM14e2bVROkSlpLkC
         sSQXFLmj8wQMfWTkLPngr3+HtdWSPCLA/TfibBRg7cQZAGyB4NDFGMA1U7oeQgBg0bSm
         KmuGhU7LtwYFCMX70ixkAUexkywkJD1Dq7f+XU9Y7g0lyv9kA45EELapkmLuQpzTjw6K
         xKxOLsHy50qzOMHG1KbiEl1E5tS1isP8O+foPbaWlwAAJgmQ/Ou+f8o0XQPQDWVnqzd3
         RUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWO+4p+aOwAMpO0SqeyGYBcY8UjCWkDwEN8US0idvpI=;
        b=FnrF4kA81d0VjA7s5l6jAJvu75WZBF4oW7WePIiH+JRGtoh4yVz9HD6q6K962c9Z8+
         pO3RLqkp7wLodWTnSPvHvaZttCkcT89HZOgLEaEEeuWKC/byu+yrlaZVtBK+foGahNyx
         uomAWbW+eteXJsgF7/pEkB1Alyvnv8OMaYezfXQOx2WLcIem5tdTpIcxwsjZWBIn7BZC
         IaYo2S7LxjC0o7OmqIUOEC36j+zjM/JyQYNf1kfv4kISuV52AqvAv11QLBs9pdPy57rt
         5xHsTQTGF2C1XVDL2M+TRQROmtCEV6IWSfXzeQI+qyoATmeQ119CxrBqvq97PTYSg3r0
         k+yQ==
X-Gm-Message-State: AGRZ1gIwM3NVHGufcWflk7kjhmqtzWHmRmifQMnrb7Pv/0UHsNgHZaey
        yErIxI5/gzM5PDRbM4IRlNr3KdC3kgoiGGTI7lI=
X-Google-Smtp-Source: AJdET5fBooPLF4SmD4TfuWuhW8meq8NnuoxGzivWYcD0QQFsvBwdAx5Mn8Pv4DaAnR7nKygrmiCzNDHhb30GO1h1sxE=
X-Received: by 2002:aca:b389:: with SMTP id c131-v6mr6849937oif.330.1541180493029;
 Fri, 02 Nov 2018 10:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181102171208.29658-1-TheSven73@googlemail.com>
In-Reply-To: <20181102171208.29658-1-TheSven73@googlemail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 2 Nov 2018 13:41:21 -0400
Message-ID: <CAGngYiVadfdAFZXRsRndt=g4i6UmQ36AF4hPg0NW33woOrPQ-w@mail.gmail.com>
Subject: Re: [PATCH v1] regulator: pfuze100-regulator: add coin support for pfuze100
To:     Sven Van Asbroeck <svendev@arcx.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>, mark.rutland@arm.com,
        George McCollister <george.mccollister@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 1:12 PM <thesven73@gmail.com> wrote:
>
> Add support for PF0100 coin cell/super capacitor charger which works as

Cancel this. A patch for this has already been submitted by Adam Ford:
https://patchwork.kernel.org/patch/10661227/

Not sure why it didn't show up in my search.

Sven
