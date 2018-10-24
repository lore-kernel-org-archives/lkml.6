Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA47C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F5C2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e04+LULP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F5C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeJXSyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:54:06 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:45187 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbeJXSyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 14:54:05 -0400
Received: by mail-lj1-f182.google.com with SMTP id j4-v6so4221425ljc.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 03:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YqIeKmXFbT56iW22+CaVBASlVJG/ts5+fOmyhJt2SDo=;
        b=e04+LULP7LFykO0l4VxggMsQnyyn98i91AD29Y6Km8MFQyYoO2Rsq2AKN4W685jjNB
         oy7t2uvQp5iEmolV/j+8Vg21q6pRH1WsQdOUL2ws4Hy2hKjWp7CWtRW9/IOFrFBLaw8e
         Fz6rs3wi1yw13pzjeDLXXbt9SQXfdZgYs/lnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YqIeKmXFbT56iW22+CaVBASlVJG/ts5+fOmyhJt2SDo=;
        b=VrJ05g2znGMNi7vLBzwHwscHy3m8DKfTyGCFgo6voWouJkIxJyaWZQTo6Be8xUKj6Z
         W0wLv8OkJLpuigyotGYNCf/VuF8GoKAf02i7HDV7+y8RCZBw0h8oH5Prh6rP0kdJV/ZS
         1ul29PuRguzWY/AO2vPiWHyPqAaweu5M+3ZmvW+hW1phkTr0/cjW9395wlop2OdUEkmd
         D1tYasJwc9Tgcvvob+13sIjTzbbzZdU+2dsCFGddC51fHD1xPQPGh8A74XUHMA1M77Sf
         PW9L7TuBgO3cK+YiMPkGXOfiDGyrzvrz4KU2VuAgjH2jZlK0QD4Cr4T11A3auNtlMjYg
         sm9A==
X-Gm-Message-State: AGRZ1gIYQUyYKhFmmUfjOcnIInt6dqXaLwz5CrxNAT8DpCaor0Y6GnYa
        wtbRVtlztsohKnEePPVW7FA21w5Q9urBNxU2
X-Google-Smtp-Source: AJdET5fRTGWFVt687/hk8+Qtm/gVXezl43R5AFmGVQWkM7T0dnk6A6rHypyOkuzpzPrZwWtWo3laAw==
X-Received: by 2002:a2e:240b:: with SMTP id k11-v6mr1477197ljk.139.1540376791995;
        Wed, 24 Oct 2018 03:26:31 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id s4-v6sm594797ljh.14.2018.10.24.03.26.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 03:26:31 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id n26-v6so3549370lfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 03:26:30 -0700 (PDT)
X-Received: by 2002:a19:cb94:: with SMTP id b142mr15249054lfg.117.1540376790555;
 Wed, 24 Oct 2018 03:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <87h8hdzajh.fsf@xmission.com>
In-Reply-To: <87h8hdzajh.fsf@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Oct 2018 11:26:14 +0100
X-Gmail-Original-Message-ID: <CAHk-=whEtcDUxjJCKV4g+uB7fCRVJYvgyH5KXdfA-HRCTHvs1w@mail.gmail.com>
Message-ID: <CAHk-=whEtcDUxjJCKV4g+uB7fCRVJYvgyH5KXdfA-HRCTHvs1w@mail.gmail.com>
Subject: Re: [GIT PULL] siginfo updates for 4.20-rc1
To:     ebiederm@xmission.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 3:01 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Please pull the siginfo-linus branch from the git tree:

Pulled.

                Linus
