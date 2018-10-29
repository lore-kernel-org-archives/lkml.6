Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C24C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6CE2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IwtTdHWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6CE2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbeJ3Ceg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:34:36 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38300 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbeJ3Ceg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:34:36 -0400
Received: by mail-lf1-f65.google.com with SMTP id p86so4520564lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 10:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lzsb/vw9eg9BJv14xvjB2TjRsMYNxq3xtvm6hSrjKS8=;
        b=IwtTdHWhpKteuQu5s1UxGUH8xKT4Xr+Rvw2CSJ6HGkYGwAwfeU64Eqn+fy6BMEasn6
         RA+smMhpaJ8yacwjCjnm66rXIF+IJ/NUikfiRF/glnovXZz3dyg4Kufpv1meOaEkb/zJ
         FRD3UAdX/UnerWZjhfSIvcgRKhGOG1Vtfjv08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lzsb/vw9eg9BJv14xvjB2TjRsMYNxq3xtvm6hSrjKS8=;
        b=stOmJbDII/y17LeTEsKYFtcoUsSlpgJ+vITgBJohX+EowImIrxZ4ScoM6xG3woi8zK
         sXAiS9tIv3yGcZDaVi71GSJtWjPX7NG3TATQSLoRIaAQuxsMkcD6Pmc3+atJC7ng5NHJ
         cha2be70hjahbnHh9GUFAH3Gyv4fQ7vw13rsAkKJNu7wyAE+pia4dtvubqxfARYRaqAc
         /19dJ7QxDV6HJQQrI4QqIPOUVMXFhTvBAupfKvZwfDq2Mh26TF+LA0Nj6XRd1mGCtloH
         iQ86lhuD7VZJVwcZpYNBT4qcAUE16Br/0m+guW5pcXIV2U29jH+uPbA/0JQiRhi0n8OB
         Vn7w==
X-Gm-Message-State: AGRZ1gLPyl8ToqQ4UpCwSNPjMDJKGoopfqLNolTivumxGggKPJP5Y7IR
        zbWjQVGAlsuOKusize68eIWazHflAyshAw==
X-Google-Smtp-Source: AJdET5edudMjTfcKzSUrpyKON4btx3Up1ovFrXW13GiJrvhXPLwubL+GEOgheF9rPVhdAfwtp5AGVw==
X-Received: by 2002:a19:59d3:: with SMTP id n202-v6mr8721980lfb.125.1540835096856;
        Mon, 29 Oct 2018 10:44:56 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id v64sm218958lfa.48.2018.10.29.10.44.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 10:44:56 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id k19-v6so151514lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 10:44:55 -0700 (PDT)
X-Received: by 2002:a2e:7801:: with SMTP id t1-v6mr4675854ljc.120.1540835095285;
 Mon, 29 Oct 2018 10:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181029144432.GA2127@kroah.com>
In-Reply-To: <20181029144432.GA2127@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Oct 2018 10:44:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiWzKQKCVZ9Er8JJfURYndpHpdLRVTxrKRvZ2obRvdYQQ@mail.gmail.com>
Message-ID: <CAHk-=wiWzKQKCVZ9Er8JJfURYndpHpdLRVTxrKRvZ2obRvdYQQ@mail.gmail.com>
Subject: Re: [GIT PULL] TTY/Serial fixes for 4.20-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.cz, sfr@canb.auug.org.au,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 7:44 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Here is the big tty and serial pull request for 4.20-rc1

Pulled,

                            Linus
