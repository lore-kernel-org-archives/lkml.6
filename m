Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D65DC64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A5B20892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A5B20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbeLBUoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:44:14 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41303 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbeLBUoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:44:14 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so11590394qto.8;
        Sun, 02 Dec 2018 12:44:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBCjz3/bTZN3xwkD9xF12upGO3yCqSrBbulx5aakBH0=;
        b=o1Aty3Q7FIpC/x44fE8F6rjJ0ZfXi/UHaB3llwRkze9HqVRkpXmWuBzfWFeOraHgJx
         WJq11ghiSpwtDvq7qoIqdmAz/CQ/XYcuJDHjcFWXIJJGcAGlAFIedZq54bIEhelS7XHP
         9cTAdcMVTL6LW9QTzDK1baZ87VLL935I2QTSYVJi1KiX9UgGan3QFcg0R4JH/wwl+xha
         eVP7kHHaUUuNexPvNGLwUDpoNIO92BOAqMsgnzFEeKoIzvaroSdDetmmGlPVHmh55U1b
         E+4uNkEBftMtKLGI3bYj9udBJ8sgPtfzYb80cDhEAOK5CSCULHhbBtqa2NB4S6+7Xgg+
         Uz4A==
X-Gm-Message-State: AA+aEWbhjMWMLSjuXcqt4Jm7pMTpjenOx7UzhClz3pqbsQdEo0x5Cv0i
        EVyhiBq1Bmh0y6pD+bGiHUHW3xywWbXh9uNBz4w=
X-Google-Smtp-Source: AFSGD/UflW2xXt0KYwZTzl0byMeubG2gwd5tHVLWr45nB0VdV3i1ndx53wEvmOhk5C8/qcqm9MSCx94uCLR8eyQFlXY=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr12870920qtl.343.1543783450915;
 Sun, 02 Dec 2018 12:44:10 -0800 (PST)
MIME-Version: 1.0
References: <20181202134538.GA18886@gfm-note>
In-Reply-To: <20181202134538.GA18886@gfm-note>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 2 Dec 2018 21:43:53 +0100
Message-ID: <CAK8P3a2of9sZ5BGCKshCjFkpt8q6s-KD-9XC4SGYP2Ppj7fjEw@mail.gmail.com>
Subject: Re: [PATCH v4] media: vivid: Improve timestamping
To:     gfmandaji@gmail.com
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkcamp@lists.libreplanetbr.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 2, 2018 at 2:47 PM Gabriel Francisco Mandaji
<gfmandaji@gmail.com> wrote:

> @@ -667,10 +653,28 @@ static void vivid_overlay(struct vivid_dev *dev, struct vivid_buffer *buf)
>         }
>  }
>
> +static void vivid_cap_update_frame_period(struct vivid_dev *dev)
> +{
> +       u64 f_period;
> +
> +       f_period = (u64)dev->timeperframe_vid_cap.numerator * 1000000000;
> +       do_div(f_period, dev->timeperframe_vid_cap.denominator);
> +       if (dev->field_cap == V4L2_FIELD_ALTERNATE)
> +               do_div(f_period, 2);
> +       /*
> +        * If "End of Frame", then offset the exposure time by 0.9
> +        * of the frame period.
> +        */
> +       dev->cap_frame_eof_offset = f_period * 9;
> +       do_div(dev->cap_frame_eof_offset, 10);
> +       dev->cap_frame_period = f_period;
> +}

Doing two or three do_div() operations is going to make this rather
expensive on 32-bit architectures, and it looks like this happens for
each frame?

Since each one is a multiplication followed by a division, could this
be changed to using a different factor followed by a bit shift?

      Arnd
