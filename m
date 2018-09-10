Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0C7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEFF20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EuMQdFwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEFF20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbeIJS2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:28:04 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38979 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbeIJS2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:28:04 -0400
Received: by mail-it0-f66.google.com with SMTP id h1-v6so28636746itj.4;
        Mon, 10 Sep 2018 06:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bh5U0I+0qe/wFcmtzKXoeENnuTdVyuIHEMrUAFh8Tcw=;
        b=EuMQdFwabP3iLwEPVMlTPcjgT4suW0EL8N3SKv0sSSS/mXNLu0Xgw4pYaBNiTLM/k5
         R1JurLMSD7Yn9Oq/0b1UoEDRKvCviGAmqpe66lfP8PwduUZrq2MfLwcjjsSVMyvQRTHq
         peP/DaUk3CZprFDFUypZb0Q94UkIylIOf2EyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bh5U0I+0qe/wFcmtzKXoeENnuTdVyuIHEMrUAFh8Tcw=;
        b=iOylxWO3aT0vveYglqTA8b7a+y1cctN3cWY06yz6NbjgG4OpfFQodCFq8rX7/gmwdj
         uOkZ8MjbtjhYzyb4f0Pl+5pJje7/92noU/aOq1OHu5y7pv5xyvnaVUuCk8199oFGlkYe
         K6/OXrbDAMkhvr92T8muNT/najTdgg2nqwANsTzJcuA4+1u8s2hrUi+JVXGOYXa2I5e0
         j457JgXy76tbrh+CHHpejYC3AVmEvTHtOkbSrcLFB23Z+uI+DxldOEIiS10GBr6bb4vz
         ZD6P/t55qjQ0K4hKufiFy6lHybSadOyrZSJYHZNM1E3OQhVf1mxyigoY9x54VvYGLqPM
         27jQ==
X-Gm-Message-State: APzg51DjqlFbNy2i7QVoV6mcxBjypQHW1WlNFAS/xJDHZ0jMEPYb5L1N
        HrXzAKJknBjZX9yid8sS4UK3W9QM+RdbIVTPsag=
X-Google-Smtp-Source: ANB0Vdap58hnNiYPfupy1OYk87vOI6nz5CTiiuXMqOXlHYO4Iq2+2DjcTjBPAQzCr/r6QrIqu9O8vGdByDyNoiSvn9Q=
X-Received: by 2002:a24:61d2:: with SMTP id s201-v6mr19520478itc.22.1536586436255;
 Mon, 10 Sep 2018 06:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180910044937.GJ19965@ZenIV.linux.org.uk> <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
 <20180910045227.9895-8-viro@ZenIV.linux.org.uk>
In-Reply-To: <20180910045227.9895-8-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Sep 2018 03:33:45 -1000
Message-ID: <CA+55aFyzNWJJfHRMiEF8=Nto=O=jF6iuFTQEzEqF7rr6v_j8oQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 8/8] really consolidate INIT_C_CC definitions
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 9, 2018 at 6:52 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>  */
> +#ifndef INIT_C_CC_VDISCARD
> +#define INIT_C_CC_VDISCARD 'O'-0x40
> +#endif

Just change everybody to do the same, nobody cares about VDISCARD.

We can change the value of VDISCARD because it doesn't actually have
anything connected to it, so don't worry about "we used to have odd
different values for it".

            Linus
