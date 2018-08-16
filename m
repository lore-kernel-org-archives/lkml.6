Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B88FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136C520C51
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocm5hnpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136C520C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392049AbeHPSlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:41:49 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:45393 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeHPSlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:41:49 -0400
Received: by mail-wr1-f44.google.com with SMTP id f12-v6so4552235wrv.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 08:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZeOpssipWt4A0KAhARiWlYfPbosSBvyE4w+JqR5UzY=;
        b=ocm5hnpniE3+0nDNmjd0pN413EVOqEmQVDzZpPZevNusTsfUn9BWn3khpYNHYRSwen
         xKNxWI/pDdPoMR0NznJQpSDml5NSh53nzYZ4weISTZIR5ZWL/L985DEym2HyXepwkR3u
         8irFqvW+74uS7CB1S0OnNbqbI2gvqg/NaQ+CQsgkXbd5p7qpJik71gZdXV3DbF9vlvSi
         l0Fd0jQnalmyEh+fJKUNyJzqpV9tIw9GeECHepgu+hjUp1gnN0QuoTd0eCGKcOGfmHhW
         +Pgz4pIfRV8Hq4L8hAg6nJ2ssapPz+no5vWm8GB3QDFFQuG/XX7trIBvfV97773ASFTX
         X9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZeOpssipWt4A0KAhARiWlYfPbosSBvyE4w+JqR5UzY=;
        b=AjEIyT/ROXPd5eDALMW/x/lDjnsFcT9AOpLcm82GNIJYiRcYRd6PwhwtrgW6a8zGvo
         msR7aBEQy57cT1wQ8LUecdAZlmKETvMPJpShY8zCrpd0hNunKbF2PbjmhPubnxyNDEKT
         k0tGkD9LdBawk2KamnwYaxrpRsT8wGssvPVEBnz8nxvlTISg3/RiTpAqAjdg+Zh7NVOc
         xpriBO84w2i7KehKAXHj0XuriRggmZn76+RhOGHTHVamvaIgKabaDzJ+JosXuAslNfgT
         GScbjYfQLiAeUBrSk3kcnvaegq5qt5FG/W1QWTQWGGe5IPBdrSY7cvGCEDik0uGkyjnD
         daJA==
X-Gm-Message-State: AOUpUlHk70SHO6gV2Nio+xBRk8GQ8sx3j5HS5DIaDuRvfvxCbwNeds0k
        OM64nz6EpTheDN48uFJ4QfDniU9jn5CkLdiru+YrKCQC
X-Google-Smtp-Source: AA+uWPwr8Yb642gHoTJOyFRMlJGEaKBkaVxtieihs6TOOleSMNkILZNGMVbAXxuN6XUW/ttEHn5E2Tzz0YQIk7GKvDA=
X-Received: by 2002:a5d:62c7:: with SMTP id o7-v6mr21186647wrv.83.1534434152661;
 Thu, 16 Aug 2018 08:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUW9Cg0G41ZSwjUBaJ+F9qCc23GGMp8aCgfNQejstKJmmQ@mail.gmail.com>
In-Reply-To: <CA+icZUW9Cg0G41ZSwjUBaJ+F9qCc23GGMp8aCgfNQejstKJmmQ@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 16 Aug 2018 17:42:21 +0200
Message-ID: <CAFLxGvxhUyqs3_esJwBjHrTY0Ba=bPB=425hWr0rz-BySTjzoA@mail.gmail.com>
Subject: Re: Merge branch 'l1tf-final' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
To:     sedat.dilek@gmail.com
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 2:58 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> Hi Linus,
>
> I am here on Linux v4.18 and tried first to merge the l1tf-final Git-branch.
> Unfortunately, this is no more available in the tip Git-tree.
>
> Then I saw Linux v4.18.1 which includes all the above stuff.
>
> I tried to 'git cherry-pick -m 1 958f338e96f874a0d29442396d6adf9c1e17aa2d'.
> I know the commit-id is the hash of a merge.
> Luckily, I could get the "diff" and applied it.
> But the history misses.
>
> How can I get the history and subjects of all commits in your tree to
> cherry-pick the single commits?
>
> Do you happen to know another solution to get easily all L1TF commits
> with any other tricks?

That should help:
git log --oneline
958f338e96f874a0d29442396d6adf9c1e17aa2d^..958f338e96f874a0d29442396d6adf9c1e17aa2d

-- 
Thanks,
//richard
