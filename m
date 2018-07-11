Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EB7C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D21208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GGAOafcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D21208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbeGKChe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:37:34 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54482 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732277AbeGKChe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:37:34 -0400
Received: by mail-it0-f65.google.com with SMTP id s7-v6so1546288itb.4;
        Tue, 10 Jul 2018 19:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hSkTdZN7Xmpzr9NJYyRZ147fF8bi/7NCm2Gk9OhkVF0=;
        b=GGAOafcYy92lLN0fgDxQ84UJo/thqE4Z0TD7K121/osecxtkMrS2DTv1W/93e3iQjR
         XqqnvPw4jqeQ032WMFWsyguZ5i1sX4+HEVtTB+T7fDRQyabYvPgkHoxlQlJESfZZNlfH
         MbVhrmexEX2scpT/xpwfPbRb0wNDy/mtxkS/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hSkTdZN7Xmpzr9NJYyRZ147fF8bi/7NCm2Gk9OhkVF0=;
        b=Ih2Tzm71gEgxBJbqEF2w8GZGLcRKdzyeOAF70mQCcRbgGNOMyIkQe/VjeS2vAwYlYJ
         wLSU+owJwmAusFNDTR2EoI4CObAZTKgBCXCCGbxPKIFRzQMF6pvAGyRb06/h5thhLtAm
         +Mk6MXW7QOD+JFQjErqQNXwalC/p1BowTdP7s/qsG348T9Ou9tHGFfT38j0gnAJR5Jqr
         XSsrTwQBJDLDV/UOenFcOj1uvqGRSU4IhEPrz/e3Jpdie4c3Vv2QeK3mvzY6h9fRb8uT
         uqBihMl0jcSH8lAC4TJlxR4zw7C4rGwjPx64sc6jNdylCxz/38vq6jXmWvNkj9k1t36g
         TOYA==
X-Gm-Message-State: AOUpUlFCi1N/FHHJUVXpxfODu7XKsvLNnm8lpCAkPl2NFLHrvNS/oNl0
        Mn9CxJ3e5SMOqB6V6X9jiBWMVYHxyWR3CM+2Ei0wjw==
X-Google-Smtp-Source: AAOMgpfz8i6ozc78ZRhv0OpVpH64ZNM853Q8n+7vb30PrJpKbi1C5XkjDinTsSpXfEzBDD9TOvyHSSGnZ9wvhHuX/H0=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr11047959itb.16.1531276534512;
 Tue, 10 Jul 2018 19:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180711021136.GN30522@ZenIV.linux.org.uk> <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
 <20180711022206.12571-4-viro@ZenIV.linux.org.uk>
In-Reply-To: <20180711022206.12571-4-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Jul 2018 19:35:23 -0700
Message-ID: <CA+55aFwvC4rUW_EQgztd64KeU+5_uQp646m223z7qNY0Fygz9A@mail.gmail.com>
Subject: Re: [RFC][PATCH 04/42] make get_empty_filp() to call file_free_rcu() directly
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one looked odd to me.

Then I saw 5/42, and it made more sense.

I think the explanation is a bit misleading. Technically correct, but
not *why* you did it.

             Linus
