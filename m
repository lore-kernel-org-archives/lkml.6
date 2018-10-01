Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E76BC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 04:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65FF2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 04:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0pmRQYt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D65FF2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbeJALVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 07:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728555AbeJALVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 07:21:49 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 775242084C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Oct 2018 04:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538369157;
        bh=Oz4MD9ulqgiPpBV4N6UJT6EIyCAPxpMNroxld2O3ViY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0pmRQYt3sqQ0X1M8SR8awWaejILf746CPihCUPxyVFEdoWQfthpA1dIitVN8GLovB
         IoSvjEJTr7ZsHxApnKUyDzRsezQ2qFjPk6DQe+Z9PQn+96et3rSpBDbzdDrB50ef7i
         hdMs1No5yV53OWhPVM7EeBG+pzEqHH+bDJOCLzbg=
Received: by mail-wm1-f43.google.com with SMTP id n23-v6so7245752wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 21:45:57 -0700 (PDT)
X-Gm-Message-State: ABuFfohgNjWkOKGQwMwY64k8Vodi9Px1SZPlNNFALwST3pOqTcALY7Ph
        ScmLHFxjhXIilwoMogoDbZkdK6Epib23JKCCdWtO0w==
X-Google-Smtp-Source: ACcGV60lbbgQmoa4r/7+A+WzlhaSBaZjpSlJqo4jkEagf2bWaaGFPGXV9xm3Xt71jA2/TNO10YqmyGmPH3We/uxnXpM=
X-Received: by 2002:a1c:9355:: with SMTP id v82-v6mr7613505wmd.128.1538369155896;
 Sun, 30 Sep 2018 21:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180930234628.25528-1-laurent@vivier.eu>
In-Reply-To: <20180930234628.25528-1-laurent@vivier.eu>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 30 Sep 2018 21:45:44 -0700
X-Gmail-Original-Message-ID: <CALCETrWcQtLTVJU14ytWxu_gqoLuAYZJpyAvRsKwwgYZz7FEFg@mail.gmail.com>
Message-ID: <CALCETrWcQtLTVJU14ytWxu_gqoLuAYZJpyAvRsKwwgYZz7FEFg@mail.gmail.com>
Subject: Re: [RFC 0/2] ns: introduce binfmt_misc namespace
To:     laurent@vivier.eu
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrey Vagin <avagin@openvz.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 4:47 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> This series introduces a new namespace for binfmt_misc.
>

This seems conceptually quite reasonable, but I'm wondering if the
number of namespace types is getting out of hand given the current
API.  Should we be considering whether we need a new set of namespace
creation APIs that scale better to larger numbers of namespace types?
