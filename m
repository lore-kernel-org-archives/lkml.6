Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BB4C28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 02:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C8120835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 02:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xlpir7NG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C8120835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeJLJtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 05:49:03 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43651 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbeJLJtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 05:49:03 -0400
Received: by mail-yw1-f67.google.com with SMTP id j75-v6so4397911ywj.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 19:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FidesO42OXUlebVkxC9uGTl/Eawu56dVrXjbo9u3kFA=;
        b=Xlpir7NG95D+oCljTO1Qb0uPLLNRg5II0VugTQ5g2NNqGRPon9qgQ0iKhNcn5RRtee
         rqwZC47PJyZ9p3A/344Y2UXyZZSOkyD1GiHIyTEax3x6G0JtC2Mogz4H5nchefyXFR+/
         5/4aD9tuyA2YPriKZ9abvLBSUqM/vpn8VmzUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FidesO42OXUlebVkxC9uGTl/Eawu56dVrXjbo9u3kFA=;
        b=SHmQW6DbRKmmoF0iT+XOoHDlYvcR8+IPgeVZtWZBXG9b+74lti5C1HsNZFReNlLfA9
         laULhBeuvsMXz8ArWdBqYtmvkSSaYKyiAKmlQfzkz/pUd4iiqUzLFcYPRBbRUnfAqGNx
         g3nazjb32QqAayWcj4ZXe7f6x0oo2zrqWF4ft8OwEDhiNUukaDvuU4o2qTa+EAJgZpRv
         8KzU01kLtkHJVFBuX9W+V4um9lrdlxNbeMA1R0RXqTHBJFqjLG6zQFyXp1qJqo5bzaa1
         6w855bVW8DldnYAqAOAkSV6u/RAu0UfD+lY7RXgfj2qD5p8qYcdwnhKSKBO6QqLaOnAJ
         p5Xw==
X-Gm-Message-State: ABuFfoiCUq80mL0JxEdHGL57BB+lWzaolVreO3d/Ot/jQRGwF30ffkqA
        /AcQ9MOQCR2j8voFcahtMIcC7eYLm3Y=
X-Google-Smtp-Source: ACcGV61RWtyfxTEd7wc14zcAtm9qe2W5f6IbvYtyyHl5iC1H4fQv0jiAidbQCS/UwwIH+wO++I6XCw==
X-Received: by 2002:a81:304a:: with SMTP id w71-v6mr2382290yww.344.1539310738962;
        Thu, 11 Oct 2018 19:18:58 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id n186-v6sm14034291ywn.16.2018.10.11.19.18.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 19:18:57 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id d9-v6so4391347ybr.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 19:18:57 -0700 (PDT)
X-Received: by 2002:a25:396:: with SMTP id 144-v6mr2301266ybd.403.1539310736910;
 Thu, 11 Oct 2018 19:18:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 19:18:55
 -0700 (PDT)
In-Reply-To: <20181012131444.605564b5@canb.auug.org.au>
References: <20181012131444.605564b5@canb.auug.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 11 Oct 2018 19:18:55 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKVnDhu5sv+K+W=AWg0BqtTfoK9=1m6u-0dpDxP9ow74Q@mail.gmail.com>
Message-ID: <CAGXu5jKVnDhu5sv+K+W=AWg0BqtTfoK9=1m6u-0dpDxP9ow74Q@mail.gmail.com>
Subject: Re: linux-next: manual merge of the tip tree with Linus' tree
To:     Ingo Molnar <mingo@elte.hu>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 7:14 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Today's linux-next merge of the tip tree got a conflict in:
>
>   arch/x86/mm/pgtable.c
>
> between commit:
>
>   184d47f0fd36 ("x86/mm: Avoid VLA in pgd_alloc()")
>
> from Linus' tree and commit:
>
>   1be3f247c288 ("x86/mm: Avoid VLA in pgd_alloc()")
>
> from the tip tree.
>
> I fixed it up (I used the version from Linus' tree) and can carry the
> fix as necessary. This is now fixed as far as linux-next is concerned,
> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.

Ingo, it looks like that commit needs to be split up again ... Linus's
tree still needs the fix for the fix?

-Kees

>
> --
> Cheers,
> Stephen Rothwell



-- 
Kees Cook
Pixel Security
