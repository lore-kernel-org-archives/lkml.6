Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D9DC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24962084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JA8ZNjSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24962084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeJ3CYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:24:31 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:38095 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbeJ3CYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:24:31 -0400
Received: by mail-lf1-f48.google.com with SMTP id p86so4495323lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 10:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8/qE7R01Ronp0iowG0hPYxqhhqqtu6Mbo4e3HFywjU=;
        b=JA8ZNjSFQW1wPrNGYjAcGTXoJkGmHImxGQtkJfX/yMFANxZedw5desm8Q1vGtXZY6L
         uB1sTgPX+B8JwC+wpbj2gRfxo9Pbp0MUw9cWZ7Rsfi8OrK7kI6fBcnmyBgkOFOlTgFsZ
         jt4vo3/sbD3gK5ETGC5G+PPiCn9xtb//2RP9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8/qE7R01Ronp0iowG0hPYxqhhqqtu6Mbo4e3HFywjU=;
        b=QDXJUwjJzZCa61Gr4YwlUyVWraVe2paPPlaG8otxUTK6dyuYUw0FWrxSjoBI4OaNJS
         Ff9YIrNHlmnB8hulFnO9P9FRigPt929TP04hgNAt7x83eOeRo9P/kyXLcOgGLI6i17H9
         ceBwGUDjBgKAxfDB+xtoKTVoXse/gAgDzsmUpNHKkf3TXp4JnC0S3lbGh2EQkzX8RM+8
         vnetdqqXvX8y7Y1o6bx8DwmJxgthVTtUo2EI3yzPrdUCrNgbOaxbQOfhrrcEE/GAi4H4
         KkNF0BxYMqnV3fO5Tudy7LAIZjRUitzfL3CTVH8IU1pC1sZ/nw2CkPNtfH+RIxkU4qo8
         PyGw==
X-Gm-Message-State: AGRZ1gJ0n+qA05bc2/Vwrp9WWSMCNYxUBIEKM6pPaGBRCT/LvLLyHHkv
        DQi15rnhveheUdMR7BO/zqyVWTDtULPBMA==
X-Google-Smtp-Source: AJdET5eTPKpLuSwUS8Dh4l7W2LiirmFNax6Y8pxFm90CQ9LDGfu9OdBTqTHk0T+iIyS2JKJniA/MMw==
X-Received: by 2002:a19:5611:: with SMTP id k17-v6mr8484852lfb.78.1540834494331;
        Mon, 29 Oct 2018 10:34:54 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id t11-v6sm1008334ljg.29.2018.10.29.10.34.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 10:34:53 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id q6-v6so6693128lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 10:34:53 -0700 (PDT)
X-Received: by 2002:a19:cb94:: with SMTP id b142mr9206272lfg.117.1540834492732;
 Mon, 29 Oct 2018 10:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <CABb+yY3Qwkr-kJS81eQqxk6-udwdy9fFHzefdNLbJc6=UhFoTw@mail.gmail.com>
In-Reply-To: <CABb+yY3Qwkr-kJS81eQqxk6-udwdy9fFHzefdNLbJc6=UhFoTw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Oct 2018 10:34:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjotOGHQuHmL3V+b9b1f9qcvpP5QAbWcU4ki69dFnKVGA@mail.gmail.com>
Message-ID: <CAHk-=wjotOGHQuHmL3V+b9b1f9qcvpP5QAbWcU4ki69dFnKVGA@mail.gmail.com>
Subject: Re: [GIT PULL] Mailbox changes for v4.20
To:     jassisinghbrar@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 11:02 PM Jassi Brar <jassisinghbrar@gmail.com> wrote:
>
>   git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v4.20

Pulled,

              Linus
