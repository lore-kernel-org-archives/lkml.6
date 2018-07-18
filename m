Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F64FECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A812075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="UiAGVMNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A812075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbeGRNCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:02:02 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38793 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbeGRNCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:02:01 -0400
Received: by mail-oi0-f65.google.com with SMTP id v8-v6so8381151oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 05:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0ufMvq2HgMpjdghiumyykT+rhPchXo7Gvdsy0CXb+dY=;
        b=UiAGVMNvGRsidlZ0LCsR33VEh71VpNtk5zyAr/h4+lWMpWu+w4eSnLe2GtM5Q+OeaZ
         1dSUlsEgePDOHL13bsZ+bQXTtHuZwoSPctGYhO3apb3OU9iAn7fw5nDxih0hnucTeo9H
         aDUjKiepyvhvDVb32/G56k3Pk4n4ohH2jJp2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0ufMvq2HgMpjdghiumyykT+rhPchXo7Gvdsy0CXb+dY=;
        b=h1u+9PmkAckU5rYqugKm33AJzhe64MWGVhaxOnliJY8fOB8PgHyXaWyBflYQNhYP+q
         Br/VaJN52215GaklTPH/sZyMUKxAU2fWflQMRm6LVl9eTWmV8kwHMdlNCd0IuI5u07uA
         uU1AGnHivGAOx2rzr70vG/8KtTvnQ+/Due7O0OyKV/yjxoNmTFpVJTBtc//Sm2+6Zjw7
         5YgoqZ9WTZriORsrhp1Mur2qIZ9DRf+6mArhprv23lBVEN3ADPJKNTW0kNqSM8tjTTwD
         202K5a2WSXSK0ubwGnFvRwbF8qrY4oRNqF0RO6cs/IoJOaptdKK8tIxEta6bKmvLi2sK
         NG5w==
X-Gm-Message-State: AOUpUlGi7NH4WojFEzi9AFijU2R4bScdzqD65uct7A2ruQFFMJ5r0M9O
        YZXZEkRpmmVyVvA7eGkXQxklQAYVkH02cizPF2od3Q==
X-Google-Smtp-Source: AAOMgpfabEli5DExLAjf7pBP+e4Q7VbyHmF7cuASFVdkCRA7GFRnEDTlfMBDypgwk7RxDtCdZrWJnii/TH20JX3a/YU=
X-Received: by 2002:a54:4406:: with SMTP id k6-v6mr6410644oiw.75.1531916660600;
 Wed, 18 Jul 2018 05:24:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 05:24:19
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <20180718121833.GR30522@ZenIV.linux.org.uk>
References: <20180706204521.29654-1-mszeredi@redhat.com> <CAJfpeguFaaE8i+fAg3HhQm6MPcFzMciY3WLfQUPdnY4xnmC7kg@mail.gmail.com>
 <20180718121833.GR30522@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 18 Jul 2018 14:24:19 +0200
Message-ID: <CAJfpegtun3zwhVAajpTneE2Vu5+Egq6giqCpUo0xeW7ZMTzzFA@mail.gmail.com>
Subject: Re: [PATCH v2 (v4.18 regression fix)] vfs: don't evict uninitialized inode
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 2:18 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:

> BTW, why have you left generic_readlink() sitting around?  AFAICS,
> it could've been folded into the only remaining caller just as
> you've made it static in late 2016...  I'll fold it in;
> just curious what was the reason for not doing that back then...

I don't remember any particular reason.

Thanks,
Miklos
