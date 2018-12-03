Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BFAC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA4B2146D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qk2cF7u+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA4B2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbeLCSqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:46:02 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35000 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeLCSqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:46:02 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so12416905ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6KIlQjAqF0ozKgjQePbTy2uj3vHmuUQ0WI6HBneVUec=;
        b=Qk2cF7u+4AEeu7eJQErfzfnIthN7En1GdAGPigsy71nypbznIVbM1Znkg7D8vNMs2A
         3qZqNMksYgHHtBfExXWkrMy8yxIKwZP1Ij7Oggh9ZmiQaN5DRklVzNv3g4ZR4d5wv+WV
         xSu7PsuHmMXBOF8EDRu63wT8ya9iwADcE7JWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KIlQjAqF0ozKgjQePbTy2uj3vHmuUQ0WI6HBneVUec=;
        b=BTH/rRRxL1ncg9/rvMTCv/19nZNTKKFPPf6I76QCLwJNASa6lXc0hjVKoEjdashwgA
         zFO2MR203eczAludk3jgPmbZZ+5qVJhNifuOVmj8Oaao71HjzOnsViBkqmBwTHDCIZMM
         3/I6Eb2kzMLwdDN/PNpsPTBLp5xyJt7QtlqgRw2pyES7boae6R8x0nVEtnT9t6x0yXLi
         QBLRogPZ67YOEaw/sL+GIRaPJX5lHd8W35aft86aWBKgi+fxzX4/g7Rg7gnq7eMkCeCr
         P0hbKh53N4NZYJ72oAbZC6Nb5+D+6E5d0gPdRrqNL28Qb14vKg5jPyvdrseWbSNgokr8
         nNjw==
X-Gm-Message-State: AA+aEWZRL7CxanloqEbFmMYiOkKZzn3Nwcrrhxxuf569wDEpPPhvC0l/
        TrahCXdqh34E6uJeG5wc2+IFN7D0GKI=
X-Google-Smtp-Source: AFSGD/WBqB2H77u1GxhQ8yHI2sTybPWvjNvwqAzyzliJ2UQVkIpRd2qQGJdfCCpaRCX2c8YJCMJHJw==
X-Received: by 2002:a2e:8347:: with SMTP id l7-v6mr7624307ljh.152.1543862755105;
        Mon, 03 Dec 2018 10:45:55 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id i127-v6sm2616724lji.3.2018.12.03.10.45.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 10:45:53 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id z13so9952836lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:45:52 -0800 (PST)
X-Received: by 2002:a19:4287:: with SMTP id p129mr10423849lfa.135.1543862751988;
 Mon, 03 Dec 2018 10:45:51 -0800 (PST)
MIME-Version: 1.0
References: <20181127062503.GH6163@shao2-debian> <CAHk-=wiq9eTzenOPh9srdB=Y8NcP6NJxh7o8Y5SfSjfqZ20-RA@mail.gmail.com>
 <20181127205737.GI16136@redhat.com> <87tvk1yjkp.fsf@yhuang-dev.intel.com>
 <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com>
 <CAHk-=wjgpWOA7zQ9H5=Zj6KQijm5CBXZc7J=it6C5gdEV0hb5Q@mail.gmail.com>
 <20181203181456.GK31738@dhcp22.suse.cz> <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com>
 <20181203183050.GL31738@dhcp22.suse.cz>
In-Reply-To: <20181203183050.GL31738@dhcp22.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Dec 2018 10:45:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
Message-ID: <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
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

On Mon, Dec 3, 2018 at 10:30 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> I do not get it. 5265047ac301 which this patch effectively reverts has
> regressed kvm workloads. People started to notice only later because
> they were not running on kernels with that commit until later. We have
> 4.4 based kernels reports. What do you propose to do for those people?

We have at least two patches that others claim to fix things.

You dismissed them and said "can't be done".

As a result, I'm not really interested in this discussion.

                Linus
