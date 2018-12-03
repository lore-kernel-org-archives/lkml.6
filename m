Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2072C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A540E2146D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AS8Intvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A540E2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeLCSUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:20:22 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:46568 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeLCSUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:20:22 -0500
Received: by mail-lj1-f180.google.com with SMTP id v15-v6so12304947ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgX0uCmV6M6fcY4GpA4dGEwbNwbI0b2kzyzeet+6EJI=;
        b=AS8Intvv66lih4F6aTY/AcTxZnF2gXsZtnEGzjWMOccpF2a9ot6+3KZqRsCcB0nFEP
         Vd6UqLETA8QZZHXhRQda83kmMmR35IRb4xbU3Hw4EDpTCOaMmDbdLushY37SmM4pBSap
         jAMJiU7qWVnewH5mHMSq69aXTxaWj4tphuPFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgX0uCmV6M6fcY4GpA4dGEwbNwbI0b2kzyzeet+6EJI=;
        b=fKzH+UNSv1lcBYh5kXfmRT4PV7H6T9AOZd5gLFWTdM6Lh1ueCWASXqUGeMMKfSbbzI
         FJI7g8CmZBhfnoZX8N1+EcOyeSbM9zswp3+O/4SycyoyqKSLAo7w0gJkMob5oCTH6GhJ
         Kcd07jCyGr0kiOc5uuAkRfxbPmV1abIELmV06B2/ujtk9NsYmq23eSppcJkK1rIOI0iC
         rlF49oJ/IphOx16KcKIWuBQAA6qUz6/uLq/O1qtSvyIPRtSFXXAsBMnHlk5uzatFHGA1
         OA2Zn4lphv0g4dGhEVNYoczs6ZZ3tHxkyzoKpXC5vRWym0Rrhr1hxBW0tF1u2N7hA3ID
         GV4A==
X-Gm-Message-State: AA+aEWbyPs7yq1uuLPHYURkd0Ydse6xfo0QTqqXxH1iZUJhPdSQmUyyc
        xcYh9CJhQYLyPO+J+ZxDK+mSbQl4sTg=
X-Google-Smtp-Source: AFSGD/Uo13zN1WkBJDnyt9K6GCB3KDIfguZBfxUKdi6jQ0N1cVQrD5RxkCYDH0Ht3y7WQ1bADhOfmA==
X-Received: by 2002:a2e:841:: with SMTP id g1-v6mr11598298ljd.21.1543861215292;
        Mon, 03 Dec 2018 10:20:15 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id n16sm2449444lfl.35.2018.12.03.10.20.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 10:20:14 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id x85-v6so12340568ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:20:14 -0800 (PST)
X-Received: by 2002:a2e:994:: with SMTP id 142-v6mr9519399ljj.120.1543861211867;
 Mon, 03 Dec 2018 10:20:11 -0800 (PST)
MIME-Version: 1.0
References: <20181127062503.GH6163@shao2-debian> <CAHk-=wiq9eTzenOPh9srdB=Y8NcP6NJxh7o8Y5SfSjfqZ20-RA@mail.gmail.com>
 <20181127205737.GI16136@redhat.com> <87tvk1yjkp.fsf@yhuang-dev.intel.com>
 <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com>
 <CAHk-=wjgpWOA7zQ9H5=Zj6KQijm5CBXZc7J=it6C5gdEV0hb5Q@mail.gmail.com> <20181203181456.GK31738@dhcp22.suse.cz>
In-Reply-To: <20181203181456.GK31738@dhcp22.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Dec 2018 10:19:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com>
Message-ID: <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3% regression
To:     mhocko@kernel.org
Cc:     ying.huang@intel.com, Andrea Arcangeli <aarcange@redhat.com>,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org,
        David Rientjes <rientjes@google.com>, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 10:15 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> The thing is that there is no universal win here. There are two
> different types of workloads and we cannot satisfy both.

Ok, if that's the case, then I'll just revert the commit.

Michal, our rules are very simple: we don't generate regressions. It's
better to have old reliable behavior than to start creating *new*
problems.

                 Linus
