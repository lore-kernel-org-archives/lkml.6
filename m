Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732D3C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287312082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bamSEz4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287312082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeJ3Gyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:54:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35615 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbeJ3Gyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:54:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id d7-v6so7310294lfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 15:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G06dLr6ZeQRlZGxeF8Z/TkYMOP3PM6ct4qfaQVsETvI=;
        b=bamSEz4AEJqqllLkpZ08ZUeZDA3gutcV+4Kv8g7MnenjuWULpOabSpd3f7q8yuVx/m
         7/9QTTMsXFN+vSMD8kGOHb136xQDx7NPOHMeKi87E/0gY8cuVNpQRsJ5frStVWol0ZvX
         CNsOabmKxt9FiLMeAY1znVj4MK8zicZKNTO3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G06dLr6ZeQRlZGxeF8Z/TkYMOP3PM6ct4qfaQVsETvI=;
        b=J8KnXtjQQ2MUTrZQDRNTg0VGlney6Nh0l4ixy89fd4GxHr1PR54xeQ3pg9/DOCY0CM
         HFmzU6Vt6PO9jvnvlcyHvrw/i855hZHQIknTdYCPBprMuNc707SKB/jkAP037zsupshS
         xTzLyxfsobknlIbv+er26URuIxgxtFtIZz7j/2qWgc55f4J6pppatU+7wPpZUHswVawK
         r7IKsxdifFT8fbCg+Ef1paH7s8yVrjrGnYj4w3Xmv6i6T7F7HylLPkcCnfkhZMqnGxIK
         tvFht6wQ0jGAXOM8Z0105YSL+UqAii1+eKJj9Dyj6w5vsTWID/sKeLmG2j+Fz+rFndmh
         AfxA==
X-Gm-Message-State: AGRZ1gKkmExzjz5KY6zO4XRl56aRIF7tJI0XKUvWA0LkiVZ1zBdUjBKg
        Pg/OMzElo3Xcj49FAKMS4xs0rFfJVGkTxg==
X-Google-Smtp-Source: AJdET5dCXGhZHqb/g8ZrfGYFXF3LL1tC/Ih1z7bGkYAJu5NUySmyzlQwYxMuFTTMRhWvUgfRvcxS8Q==
X-Received: by 2002:a19:1365:: with SMTP id j98mr273728lfi.55.1540850653984;
        Mon, 29 Oct 2018 15:04:13 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id o2-v6sm854983lfl.2.2018.10.29.15.04.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 15:04:13 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id k11-v6so9401859lja.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 15:04:12 -0700 (PDT)
X-Received: by 2002:a2e:7f14:: with SMTP id a20-v6mr10307297ljd.148.1540850652473;
 Mon, 29 Oct 2018 15:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181029210447.GA17383@ls3530.fritz.box>
In-Reply-To: <20181029210447.GA17383@ls3530.fritz.box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Oct 2018 15:03:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi8-RRjYP5DxKUuv5LEwaA=JDvBiO=u8aS43_fzypEu1g@mail.gmail.com>
Message-ID: <CAHk-=wi8-RRjYP5DxKUuv5LEwaA=JDvBiO=u8aS43_fzypEu1g@mail.gmail.com>
Subject: Re: [GIT PULL] parisc architecture fixes for kernel v4.20
To:     deller@gmx.de
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, dave.anglin@bell.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 2:04 PM Helge Deller <deller@gmx.de> wrote:
>
> Three small patches:

Pulled,

                  Linus
