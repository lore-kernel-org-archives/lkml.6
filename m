Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BDFC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 17:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1B42085B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 17:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P/QgTGrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1B42085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbeJ1CDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 22:03:40 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:35471 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbeJ1CDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 22:03:40 -0400
Received: by mail-lj1-f178.google.com with SMTP id o14-v6so4021751ljj.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NkyAJYwQEZBj22f1cBkKh8WwnR6FeJUq1r6gjd/R6IM=;
        b=P/QgTGrK1KCRfe1LDxvexIHd/vN99HRoP3IPASvikEsEE2FlMStPUEpGh0cgcBZ1rw
         Kv9mKNwVqaCfsCwVQm9NQgpJwYl4YNuSko0iiHPzY9XvigEFSuNvojSYRasf02TbcjVR
         kPwbGXkvO8PjTG8VLRKLhCHIU5B3g4RhhJL5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NkyAJYwQEZBj22f1cBkKh8WwnR6FeJUq1r6gjd/R6IM=;
        b=ctTE4DFFTpfeDHjckbcazJ1bRD9VE5H//HQzZzX+wIXLPJJEfZSziCbf+gNLmo4quP
         6wksNQTmjMkAmMVWRtcP2u/F3xyqBTKa9G7jb5qpRAvW84Tq9uwXreBp6ZdQewvGShO6
         C0mc4KFu1blSBkELawXs66AzVT3fojw6PN9i13tjlefhEUNlBDr5gXuhS8T5MvsSEFP7
         xCRpiRwRCA46gz06VEDbVsbNKt1dduH1H3h7EFmYPHVwJvK3SNXQQZdKp+WKcEV6SjRy
         7CchSQD2m4Lj6AxtfGvrG45VJMx5NmSiERQpt9Z1ipACrT4J8QR1/JrNZ4K5MIftb+1C
         TSKA==
X-Gm-Message-State: AGRZ1gJOXTjqnfLWLW7inGMtCbW/zAPe+9tjJTFSrZqeeNNbG+X473+U
        /aKuMMsmB72sAEhai56Pr+yPz0tYRCb4rg==
X-Google-Smtp-Source: AJdET5cMo3HQzbvmEh7zk9VkykMBOQVFdiajKoiBZ7FpwEa9Dx5fWwu8cn4LGJXzmMFZB06e4B8N0Q==
X-Received: by 2002:a2e:d11:: with SMTP id 17-v6mr5794183ljn.18.1540660919109;
        Sat, 27 Oct 2018 10:21:59 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id c6-v6sm356615lfj.73.2018.10.27.10.21.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 10:21:58 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id o2-v6so3135346lfl.13
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 10:21:58 -0700 (PDT)
X-Received: by 2002:ac2:41d8:: with SMTP id d24-v6mr4589430lfi.138.1540660917483;
 Sat, 27 Oct 2018 10:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181026234917.GA196749@dtor-ws>
In-Reply-To: <20181026234917.GA196749@dtor-ws>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Oct 2018 10:21:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_KrcgwU=Beeu4fqbY5PoRa_=EUmvVxFFceMFvnvcZYw@mail.gmail.com>
Message-ID: <CAHk-=wh_KrcgwU=Beeu4fqbY5PoRa_=EUmvVxFFceMFvnvcZYw@mail.gmail.com>
Subject: Re: [git pull] Input updates for v4.20-rc0
To:     dmitry.torokhov@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 4:49 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
>     updates for the input subsystem. Just random driver fixups,
> nothing exiting.

Pulled,
             Linus
