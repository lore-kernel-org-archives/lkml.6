Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F96C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DA220850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YpwJuLID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DA220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeLEBG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:06:27 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45514 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeLEBG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:06:27 -0500
Received: by mail-yb1-f195.google.com with SMTP id f6-v6so7702808ybg.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 17:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r5TNJp2wKYH4m2pZA22/AbeeXpQmAxWVL7kp77B9RHU=;
        b=YpwJuLIDUn7PMHScb3HLy1RhaMb5Kh28v9C8GQ8a+/Dm1X1GhBvUBuqAdDy1dBSe82
         YYZRWETp+Rpo11bcWOgHv4bqUyagFMExSKjS67a5c9Nb7RTntB05Z+teo0idk3P6OnhX
         HtJ5Sxtqr97fDvmNtPSD4oa7Bbm8fss6ya46A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r5TNJp2wKYH4m2pZA22/AbeeXpQmAxWVL7kp77B9RHU=;
        b=QUcv8hgv1uCzDV8J1VxmGtx9WWqslbSTQFqkZIF7gdlykt9or2jCkRV/DSoijLvI1q
         L1zlhxRZIUZUp6ruXh9wcpTjAHlpBxj1lkJ6pUUIt/hMaZs1dUifFL5a2gLSz8pf7XTE
         c8akW9N46p11U04yl4LLPT4E1nAYX3OACRNjgKlUfgMJcgi36x+1+ikzYK+qYtkLhIRG
         RVaoUA2RNFFEDrhjhh/td+me112zsPOOoniOMbk0j+SC8nZhDJAoEnVqZgrK6OL5gUYY
         EZv/MKoECtBw38Pd/OV45pqYyv+gt9+F8D6aQsu02Qf2zSPko6rhDtTxJlnnyp1kRjfi
         Z8jg==
X-Gm-Message-State: AA+aEWYH3/Mly08hT8hDvy+AX4vQcD8hJK+f1z0cqpEQtv0IXkbBr+sh
        C8WsE7Z7gCKiQtsB3HO6JhiZpa3vnFU=
X-Google-Smtp-Source: AFSGD/WflhVwgOJlC3Zez211ceuC7VioQ3jff3g9SlmbNFkJQO8OZaXfQo8B2Z6xL72adY7dhbufng==
X-Received: by 2002:a25:5b03:: with SMTP id p3-v6mr21354023ybb.385.1543971986266;
        Tue, 04 Dec 2018 17:06:26 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id n16sm7523277ywn.31.2018.12.04.17.06.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 17:06:26 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id x144so3548512ybg.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 17:06:25 -0800 (PST)
X-Received: by 2002:a25:2347:: with SMTP id j68mr13250519ybj.137.1543971984874;
 Tue, 04 Dec 2018 17:06:24 -0800 (PST)
MIME-Version: 1.0
References: <1510754620-27088-1-git-send-email-elena.reshetova@intel.com>
In-Reply-To: <1510754620-27088-1-git-send-email-elena.reshetova@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 4 Dec 2018 17:06:13 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKsX=0HE17JRiK-agq7R6RWg+03Ww_CaB9BzL4odLnZjA@mail.gmail.com>
Message-ID: <CAGXu5jKsX=0HE17JRiK-agq7R6RWg+03Ww_CaB9BzL4odLnZjA@mail.gmail.com>
Subject: Re: [PATCH 00/16] v6 kernel core pieces refcount conversions
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Eric Paris <eparis@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux-MM <linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2017 at 6:07 AM Elena Reshetova
<elena.reshetova@intel.com> wrote:
> Changes in v6:
>  * memory ordering differences are outlined in each patch
>    together with potential problematic areas.
>   Note: I didn't include any statements in individual patches
>   on why I think the memory ordering changes do not matter
>   in that particular case since ultimately these are only
>   known by maintainers (unless explicitly documented) and
>   very hard to figure out reliably from the code.
>   Therefore maintainers are expected to double check the
>   specific pointed functions and make the end decision.
>  * rebase on top of today's linux-next/master

*thread resurrection*

Was there a v7 for this series? I'd like to finish off any of the
known outstanding refcount_t conversions.

Thanks!

-- 
Kees Cook
