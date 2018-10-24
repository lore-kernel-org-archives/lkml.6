Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2432C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5B52082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OWDckJRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5B52082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbeJXWQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:16:00 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:46830 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbeJXWQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:16:00 -0400
Received: by mail-lf1-f54.google.com with SMTP id o2-v6so4011570lfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 06:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yK3ryyfYHQWdJ3Ac5lOYjftM7sPKHdyI4i1q2adyf6A=;
        b=OWDckJRszx9fRhp70KbL7YH/fJT08Oml8gwEEmtx9lkZ1GtQFG3VYDFtJadplOgiCs
         rx2PH38uVcUy7+nRVfz35uj9vYXw/6LvNEPIcDTOkmccz9Ru4CJbBDgZ6RscqazpyRcz
         iymrl4dhXSTpyrEzkIbOYvccqNCQRlfc34kP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yK3ryyfYHQWdJ3Ac5lOYjftM7sPKHdyI4i1q2adyf6A=;
        b=nFJkEx+i+hTl5CWl4hFWyka14S5hVpA8cZIaQxyBksZk3Ly6eS5blze3K88himcchT
         4ME5m13Sk+dfuXPlxzLQBW9R/rxqeZkWQc8DrwNYuIASaA50W37j1KFQpRSWVJ+eAwjX
         JVkgZgFqvm8tLMx0aJ6b6MK6mnT44G1SNWE4QB4VxhyK+fjgAn0PtT00qAXZhTc4oQhU
         iXFDxDSgzftkdvWtw6PzSl9+yIeOyvZF7IIG4I4AVwcmzRHUCztJV4WvJbgqLbY89D4k
         9NKZ3evnroGuWXIYTFVzRu4R4b5jSxFW4w7UFzxoBs1vgI+KSU7Itw1nvRehDbjGSWk/
         t4SQ==
X-Gm-Message-State: ABuFfohPP2RD1ofeMHfKF5oOQx1sK/1Ehe+mk0Yggix46SDjU7hcmM1u
        FiqlgWFlQQ2lXZqsrsGQUIeDVd4n5jeV4Wge
X-Google-Smtp-Source: ACcGV61IncX4fpH0gkn5wdTuWusOD/O4tKx82qTMbDVcsyMJbqRi/CYoseJ+6mxkdU4f5FZhb1Zviw==
X-Received: by 2002:a19:1f46:: with SMTP id f67mr14766361lff.1.1540388866720;
        Wed, 24 Oct 2018 06:47:46 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id z5-v6sm654889lji.65.2018.10.24.06.47.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 06:47:45 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id c4-v6so4841187lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 06:47:45 -0700 (PDT)
X-Received: by 2002:a2e:980f:: with SMTP id a15-v6mr2021693ljj.6.1540388865206;
 Wed, 24 Oct 2018 06:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20181022142440.GA10225@beast>
In-Reply-To: <20181022142440.GA10225@beast>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Oct 2018 14:47:29 +0100
X-Gmail-Original-Message-ID: <CAHk-=whSd8_Ofjhs=vbB7-U6Di29540HfoGX=O-0UMc1320n0g@mail.gmail.com>
Message-ID: <CAHk-=whSd8_Ofjhs=vbB7-U6Di29540HfoGX=O-0UMc1320n0g@mail.gmail.com>
Subject: Re: [GIT PULL] pstore updates for v4.20-rc1
To:     keescook@chromium.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        groeck@chromium.org, joel@joelfernandes.org,
        saiprakash.ranjan@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 3:24 PM Kees Cook <keescook@chromium.org> wrote:
>
> Please pull these pstore changes for v4.20-rc1.

Pulled,

              Linus
