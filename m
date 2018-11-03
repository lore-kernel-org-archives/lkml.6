Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66E4C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6762081B
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FifNW8sw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6762081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbeKDCu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 22:50:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35263 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbeKDCu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 22:50:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so4461476ljb.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 10:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+/+g4luQm6RfZa0/eBbUTefC1Dt0e0naEh+hHQg5zZ0=;
        b=FifNW8swyHjXrENNA/GchZSGhv6yFoyecQlOXU1k++vyHK3tidEWRSt0M5N4WV+E9U
         lsc+tMmIVDaLvgD7ib3r8CaClg12CX4GGkzBo6CpL64XTYVDHRSNqZns2w383p/G0Wix
         H+eJODU1AAkVtsCA/Ybf1KmBPB/BuQKVF83/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+/+g4luQm6RfZa0/eBbUTefC1Dt0e0naEh+hHQg5zZ0=;
        b=InudK2niuIUr7vxq7uBhcLi/i4M4d45z8B0p6o8LW6wt0YlJ41QCEWqnLG8AcLmPAY
         02ZH+5vtL9nzOoutZBlMSQVoKC3jgMX2cnkgbqlT0czgkJ32CUtKUZZLVI3NLBPrAk0Y
         HI9wqe9KlBQ9i/4c7bxcuULSCDHXDH+3yjK+7nEr/CIfSh3OIS7IkOa4SeE/5RyEW5A4
         0fCH4nItPOFlaavV8F1O2Qat3JpkHIT5kJkxohQ6uaJSuFswgEFduSM2LX0fsFsnPfDK
         dSX+l3sk0Ki32eY5eYacVGL259roRmBGNsbGeANwTf9JSbasOfNMFJdnZch1B5d+njVK
         xkXg==
X-Gm-Message-State: AGRZ1gK4woYPUZbnILuSgBwKehXlf0cHYwrJyR/OcB671av1uwazCSDl
        Kt39mujeCFnzIQSnHMgBMwuZrRPuRnDSPg==
X-Google-Smtp-Source: AJdET5fww9HSXEkLQtGU2NbmVp+WDi7l6DxsbPFtyPVlYeQo6YXXuAjSUsPCa/Bl5IaOqZacjfxRzg==
X-Received: by 2002:a2e:2d01:: with SMTP id t1-v6mr9113489ljt.99.1541266711808;
        Sat, 03 Nov 2018 10:38:31 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id m14-v6sm2555332lji.29.2018.11.03.10.38.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 10:38:31 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id d7-v6so3412404lfi.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 10:38:30 -0700 (PDT)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr9003743lfa.106.1541266710229;
 Sat, 03 Nov 2018 10:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <1541194863.2824.2.camel@HansenPartnership.com>
In-Reply-To: <1541194863.2824.2.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 3 Nov 2018 10:38:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiCAvnC3vfoieXCqtXZuO5-sVgx+xovHHbHyJ-5EPinGA@mail.gmail.com>
Message-ID: <CAHk-=wiCAvnC3vfoieXCqtXZuO5-sVgx+xovHHbHyJ-5EPinGA@mail.gmail.com>
Subject: Re: [GIT PULL] final round of SCSI updates for the 4.19+ merge window
To:     James.Bottomley@hansenpartnership.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 2:41 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> This is a set of minor small (and safe changes) that didn't make the
> initial pull request plus some bug fixes.

Pulled,

                 Linus
