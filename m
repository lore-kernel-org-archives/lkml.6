Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AACBC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E572081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TbM1++vk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E572081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeJaBLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:11:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42471 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbeJaBLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:11:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id q6-v6so9321644lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 09:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m9fGloHoWaMj+IQmJorx7HhZy2ftLkI21zdu25d6nGY=;
        b=TbM1++vkl3Y2Kfk4Bi2lG4bhKASo0kHT8dB8jDrLDTpa16Oo7U5T6j4yOds2XShmwo
         XgdV0xyD9BSzKUgOGbi8iffxyAsa0mFC+eXLXV+xwA4K4YeeWFUWgdrvKYB28La/9nVY
         o5oHcbOUFqsEsBuAv/IJJE8A82H5YB3DpgP3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m9fGloHoWaMj+IQmJorx7HhZy2ftLkI21zdu25d6nGY=;
        b=obvyUm8jSTTmyz63Y832u49V5EmKIa+9k9ifCRPksOu5glyE0V1iSXYgDj1OYKGn79
         bDLumWmMN5tmx48/bMu1n8QqCPNaRLBhlZ1+pYZzLmzaBthUAeLtA6zOLi1ZfbWuuYkV
         /cVe1xbUZu4bPAmK6LcuMQCidG9nLMAHxxH09ab5zDZ7Y+TwzDqX6lmuMZ/9OS2P0Gye
         BdF3Mu/FvxDl7tEW9+rFI/L7P/nQR/2E35q2AWJLTXNRKQba03LmSm6hwNhIoc+4e/Pb
         dqFNTA9B+v8MZPslKZBd5qZrpxWZn86ne3avytBil31qkq2Rhzq1q7+iNEYJ8HRAYhfU
         VVLw==
X-Gm-Message-State: AGRZ1gLFMYAeKzOpow7AX4TkirIE4RHBH9u5zZ0l4ybLBQF73+aGW0wX
        HQY3cEsVUgC3nlaE+/wLn+OtA7PdZEoNnw==
X-Google-Smtp-Source: AJdET5flbOBrpHFC4XJ3LhGLbOxxbs+42tW7cR8+2fczTG6mK/wc+Md5VJccszAGVnMFxbmJJShusw==
X-Received: by 2002:a19:ae03:: with SMTP id f3mr2508586lfc.86.1540916213349;
        Tue, 30 Oct 2018 09:16:53 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id y17-v6sm2492889lfb.60.2018.10.30.09.16.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 09:16:52 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id z21-v6so11963035ljz.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 09:16:52 -0700 (PDT)
X-Received: by 2002:a2e:7801:: with SMTP id t1-v6mr7168807ljc.120.1540916211948;
 Tue, 30 Oct 2018 09:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0ihPs+sU+s357sYNYBVmqd1CC2JH6_XvRsJQx1A_J7wJw@mail.gmail.com>
In-Reply-To: <CAJZ5v0ihPs+sU+s357sYNYBVmqd1CC2JH6_XvRsJQx1A_J7wJw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Oct 2018 09:16:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh9Nr_GcPL=PckizP-3-uvZXjm_M0HKQPeMjB+_GWJKiQ@mail.gmail.com>
Message-ID: <CAHk-=wh9Nr_GcPL=PckizP-3-uvZXjm_M0HKQPeMjB+_GWJKiQ@mail.gmail.com>
Subject: Re: [GIT PULL] More ACPI updates for v4.20-rc1
To:     Rafael Wysocki <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 1:30 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> These rework the handling of the P-unit semaphore on Intel
> Baytrail and Cherrytrail systems to avoid race conditions and
> excessive overhead related to it (Hans de Goede).

Pulled,

                    Linus
