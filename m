Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA93ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D73207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ee+/8k7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D73207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbeJYAuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:50:06 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:34843 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeJYAuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 20:50:05 -0400
Received: by mail-lf1-f44.google.com with SMTP id d7-v6so4470443lfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DptqEy+nciugpvcVHLeYgvMSwp5WzQ5f/6btEMV4eHA=;
        b=ee+/8k7RVjsl6mU8FyU5knAK/EJ1e9w1tLXbZo02aYNJBKl55aTp0gV07BJG1fhDeS
         MKn5rJK4+jzywcxG3SlgoB445XSsS9MaT2vVCnW40DMzYcGRO76QA0lXHNoK46m1Mtki
         wHQpQqkQ8vbgeLFQ8Ay3OjFw2ArFOQWuMHBN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DptqEy+nciugpvcVHLeYgvMSwp5WzQ5f/6btEMV4eHA=;
        b=K+ryn3TnjE/VU+uVvj3zmZUiAvmUAR4K6Y49pLmZi50fgfW5XtWSlSmNggBLyAOFqP
         t3ggWcw2YS3YBPDk8JeHdvHlGt6g9gHyPB2XIkWr1BmKba3lIYyz+3XJPtjp6LaMbW8h
         IxozCDtTG024I3thtEehbZ34jWyf6Q9WU0iIa9XfkfsYR4OLpTxT1nFOPCM0D1uMD1sv
         xm5JpGzQ3FINZeT5JoxqtgvUmuwdsxmHJuieAytWdvtKrzLiWBHxhk3ca+h7LmS49sYE
         xH/LrYR1mvj9h6lLKO4wcrXB4sJYiO5ar1faREJ78CcCOaodOoeWCDPr34StaYmRwm9R
         UIVg==
X-Gm-Message-State: ABuFfogWVf9nO1sDFFbOEBeo+edpTHaCgtMk7749wWjFUKU+kaIQXis6
        8UKyf4nkMGtMR81CHA7GiceKn1/s+STlGSah
X-Google-Smtp-Source: ACcGV60X17sCkj8iAMIvQdCoyjClk4Nqf+lfxg6CyOcrHXqHijoLsPXexxBg4YF4orF/rOE4hMcYGA==
X-Received: by 2002:a19:18cf:: with SMTP id 76mr11093195lfy.36.1540398080822;
        Wed, 24 Oct 2018 09:21:20 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id a4-v6sm788306lfa.91.2018.10.24.09.21.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 09:21:20 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id p34-v6so4436559lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 09:21:19 -0700 (PDT)
X-Received: by 2002:a19:1cc3:: with SMTP id c186-v6mr14579756lfc.16.1540398079344;
 Wed, 24 Oct 2018 09:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1540227161.git.dsterba@suse.com>
In-Reply-To: <cover.1540227161.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Oct 2018 17:21:02 +0100
X-Gmail-Original-Message-ID: <CAHk-=whSRV1vtR5TbOPW0TH0-y7ZKQ3kdew1AwtKLXztR8004g@mail.gmail.com>
Message-ID: <CAHk-=whSRV1vtR5TbOPW0TH0-y7ZKQ3kdew1AwtKLXztR8004g@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 4.20, part 1
To:     dsterba@suse.com
Cc:     Chris Mason <clm@fb.com>, linux-btrfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 6:22 PM David Sterba <dsterba@suse.com> wrote:
>
> this is the first batch with fixes and some nice performance improvements.

Pulled (at 30,000 ft, somewhere between Ireland and Iceland),

              Linus
