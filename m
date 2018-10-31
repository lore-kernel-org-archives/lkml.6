Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC96C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DEA20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HvCpSHwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64DEA20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbeKABRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:17:21 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:37429 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbeKABRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:17:20 -0400
Received: by mail-lf1-f54.google.com with SMTP id p17so5645189lfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CR1Ps4OwEtIo9xDCXtkvbfjru+RLtf0a5lbKdsWMEPU=;
        b=HvCpSHwa5h+H87DC9NFh9k3piIP2kusVXX72VjwhuJLVRCyb6/Qybkjccv3lbWMesC
         rJLVV6XfIjrh/DLc93sbtYYG068Ya3FDxedMSX67SjiZpZACI3Py9ub2d/dnxLMpgL1c
         3OSYA7uK75oFOPtrTGxscIDLEqoH6lSbVHklI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CR1Ps4OwEtIo9xDCXtkvbfjru+RLtf0a5lbKdsWMEPU=;
        b=nNA8tEzRUk+iFUgDwFj2b9L/wnFD5xyz0uXjcScgll4SuV2etCHTWVTlQh7cy7nxKU
         knPJHROcrev8ampHhcTTCrhnm4Z9hvAp4tBN/6/BMQJTiE6WoioLgS/ebCX2YsPiDAnu
         H37Y/Yn/7KfKqUxLMyUACSDD2b9kz9UiovRTGVbAUmE4G3lCLTEHu+5g65sc7ReJKlV5
         +tVvvSbZiQpW+NjSXYUfVcw8kjTRfiEdfqGdn8yUbumqdkn9zCJcT+WluAD9xTZoyLoX
         mVppDXiAFwDHDt4NvSwf8tCupCp1n+4SFVxSy7JGcPAZBnOJ0DNVP5q+2sdsvJ1lZXNO
         YVtg==
X-Gm-Message-State: AGRZ1gIlouTOGfNThaGeDVrP/wUi+hMTunNMpzrnV1AdiVJdcnywzgvk
        Y+dmpCkkJfKYzg8vADOwUyBmoiE/R7rYew==
X-Google-Smtp-Source: AJdET5ejT2LukaRQmNLhCka//ZJTSmPiKC9YNVU7HSPlQeI7kDQdHoyUUAsq+2rkAK6CpkedlUl1tw==
X-Received: by 2002:a19:d70f:: with SMTP id o15mr2390813lfg.134.1541002717019;
        Wed, 31 Oct 2018 09:18:37 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id b22sm3179129lfg.32.2018.10.31.09.18.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 09:18:36 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id j4-v6so15367042ljc.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 09:18:35 -0700 (PDT)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr2726540ljj.6.1541002715476;
 Wed, 31 Oct 2018 09:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181031053355.GQ32577@ZenIV.linux.org.uk>
In-Reply-To: <20181031053355.GQ32577@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 Oct 2018 09:18:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAE6gVi18=u4sSWe1m2RWPh19YCkKQmW4Kx+NQX1mg8w@mail.gmail.com>
Message-ID: <CAHk-=whAE6gVi18=u4sSWe1m2RWPh19YCkKQmW4Kx+NQX1mg8w@mail.gmail.com>
Subject: Re: [git pull] mount API series
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 10:34 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         mount API series from David Howells.  Last cycle's objections
> had been of the "I'd do it differently" variety and with no such
> differently done variants having ever materialized over several
> cycles...

Having just lurked on the discussions about the bugs in here, I don't
think this is ready. Maybe they got fixed, but if so, it was recent
and it was pretty fundamental.

The stated aim of the series is to make the mount API _better_, not
worse. And right now it looks like a "two steps back, one theoretical
step forwards" kind of better.

              Linus
