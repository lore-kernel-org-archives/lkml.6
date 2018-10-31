Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87607ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6392081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CpmS07Ky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6392081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbeKAGxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:53:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43998 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbeKAGxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:53:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id g26-v6so15001435lja.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lOpEqA6JMjEvJ/uw9yy9HBEYs4UynNsAVgr6d+I7PAg=;
        b=CpmS07KyOdjy+Rm6F12NJSw2/dBjv+uB2Z0N5BXo0Neq1dQprSrpOwH6Mm2Yka2Oe5
         62obFvA3ydFiJyDEKkOJalYH+gpEuNccqx/bHojG/uTnzAaNlvov29EZQnAI2MvcEcXX
         h6Q6tF0cdV/ZvDL/vFGp7LihsH4c+l87OawdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOpEqA6JMjEvJ/uw9yy9HBEYs4UynNsAVgr6d+I7PAg=;
        b=jEbf3Lh9p/le3pdmQaIUck9B2BTKN8OaWUPZoq9icrSB9OOsyKm3VWnYQkZpquuznd
         T/Sjo/O9BARD9OmmQHItHDualH81oojDXlIhHa+Rguizd/UBkruLhmJtR/ta16G+W+ZY
         NvQ4muMBQ3ep6MGCCATcQr61N2EoOS9dkYXFzadevxSVI4HoOCsJVbBP3+sp6JwiJWTQ
         6Rxi+1VN3ONK+2AsoqZhQ1qK6YJnzKI7AioavGeo2HQgqc4LT5uBh87xSso+WGAhYGxu
         8iPNDOHarsioeYUr2SAdGqdupJXaNf4B+i5zqSkbvPuTB7mOHpXbYFY9qNmwYzRNilJi
         Rqtw==
X-Gm-Message-State: AGRZ1gIsyHTdwTK0BgQWyWYQhpDOcKADJo6ACtMdFBg2rYzx4bG7i+Lf
        mmDSj4e1YTcBcMWCVvhnuPKa9EirjGihhA==
X-Google-Smtp-Source: AJdET5cyrvs6NV6aXGi8uiBJ/nwQK8eY9HTp9N4uuye1dmgo1UpecSU13VG+xS5RjXXTKXQmsUr7Bg==
X-Received: by 2002:a2e:86ca:: with SMTP id n10-v6mr3525603ljj.90.1541022789428;
        Wed, 31 Oct 2018 14:53:09 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id o72sm4441611lfg.33.2018.10.31.14.53.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 14:53:08 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id d7-v6so12829932lfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:53:08 -0700 (PDT)
X-Received: by 2002:a19:288c:: with SMTP id o134-v6mr3111443lfo.124.1541022787906;
 Wed, 31 Oct 2018 14:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181031203142.GG23439@veci.piliscsaba.redhat.com>
In-Reply-To: <20181031203142.GG23439@veci.piliscsaba.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 Oct 2018 14:52:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQULOGvU0Tc254rhAM+NTv62PQxqBYQpkrg_i5VdGnBw@mail.gmail.com>
Message-ID: <CAHk-=wiQULOGvU0Tc254rhAM+NTv62PQxqBYQpkrg_i5VdGnBw@mail.gmail.com>
Subject: Re: [GIT PULL] fuse update for 4.20
To:     miklos@szeredi.hu
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 1:31 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> As well as the usual bug fixes, this adds the following new features:
> [...]

Pulled,

                        Linus
