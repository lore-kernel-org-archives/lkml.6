Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D367ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B6620834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aar8VF0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B6620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeJ0Cyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:54:36 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43382 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeJ0Cyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:54:35 -0400
Received: by mail-yw1-f68.google.com with SMTP id j75-v6so817456ywj.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 11:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yf7DqgBDjc5eKjcfXpp44fPgr0t6IX2VVgWR7XrQPzk=;
        b=aar8VF0mXWazgpilcLVzVswKwj7nXcoSl1bUCJTrM4RxDiG5x2XbW+xeQ9BDfquCt/
         RDs9pPklzfhJJZZM/WXXJT7JAu1pePaylvbhJ3Hm+asXcOn3gGgnhLYVaDzhkeOog+15
         0/ZzyRIYl4BV8Nw+Oz2djLbGrYVk63v2Y0d64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yf7DqgBDjc5eKjcfXpp44fPgr0t6IX2VVgWR7XrQPzk=;
        b=Xuk0lrpx5Z+a1KqJXb4a1VB1/UP4E+sRTWdQq5fwNR5ERE/hPUWQ6pxgzI4HpVap2C
         PrJ6C1vl06+kdX0+S+0W+TMnTBj+DGPCNBNe3XBzFnzE9B3rq3pbHJrf9BDGbDE4VcPS
         C0wPVbeuo5ty+M8v3zdEjQ+hdZDgSuYFnmQVXiHM1jGRpD8RUx7hsj3W+C5TCNO7U6PR
         z0vmUfmS3xWFXgk5o6/eXDp3W8MeZsj2wIAblG0XaRVOFgUX1qsqLGco/UiKKmZwFrdq
         7RdOLXXo2y15J3oc4gsRTAWls76gMugMFvwUEqcEC6qncJA3ogcDndLUgi22AxiKrhrr
         mieg==
X-Gm-Message-State: AGRZ1gJsYet5WaVHSR3M3u59bagwwbyJ5Hz7ZZL+DH4sJJ3UJ31hZ9ne
        X2sfYGEtX1WRETqiKOJHntGE4BqAFc5JWQ==
X-Google-Smtp-Source: AJdET5dUNbPxxO3Mr8uE1l6mYru5obFgWmCYGCgbW0Uga1l56FgwFKKGG3EhBJhWdIb4VU/a/ytjWg==
X-Received: by 2002:a0d:fa47:: with SMTP id k68-v6mr2573725ywf.468.1540577792402;
        Fri, 26 Oct 2018 11:16:32 -0700 (PDT)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id g5-v6sm521794ywa.39.2018.10.26.11.16.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 11:16:31 -0700 (PDT)
Received: by mail-yw1-f51.google.com with SMTP id v199-v6so830586ywg.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 11:16:30 -0700 (PDT)
X-Received: by 2002:a81:2953:: with SMTP id p80-v6mr4731276ywp.407.1540577790204;
 Fri, 26 Oct 2018 11:16:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 11:16:28
 -0700 (PDT)
In-Reply-To: <20181026180042.52199-6-joel@joelfernandes.org>
References: <20181026180042.52199-1-joel@joelfernandes.org> <20181026180042.52199-6-joel@joelfernandes.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 26 Oct 2018 19:16:28 +0100
X-Gmail-Original-Message-ID: <CAGXu5jLoMhBKuxhSqbgitfOYkO0gU34L4asn9iQEdHqJPxfDSA@mail.gmail.com>
Message-ID: <CAGXu5jLoMhBKuxhSqbgitfOYkO0gU34L4asn9iQEdHqJPxfDSA@mail.gmail.com>
Subject: Re: [RFC 6/6] Revert "pstore/ram_core: Do not reset restored zone's
 position and size"
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 7:00 PM, Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
> This reverts commit 25b63da64708212985c06c7f8b089d356efdd9cf.
>
> Due to the commit which is being reverted here, it is not possible to
> know if pstore's messages were from a previous boot, or from very old
> boots. This creates an awkard situation where its unclear if crash or
> other logs are from the previous boot or from very old boots. Also
> typically we dump the pstore buffers after one reboot and are interested
> in only the previous boot's crash so let us reset the buffer after we
> save them.
>
> Lastly, if we don't zap them, then I think it is possible that part of
> the buffer will be from this boot and the other parts will be from
> previous boots. So this revert fixes all of this by calling
> persistent_ram_zap always.

I like the other patches (comments coming), but not this one: it's
very intentional to keep all crashes around until they're explicitly
unlinked from the pstore filesystem from userspace. Especially true
for catching chains of kernel crashes, or a failed log collection,
etc. Surviving multiple reboots is the expected behavior on Chrome OS
too.

-- 
Kees Cook
