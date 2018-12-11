Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A6CC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A802084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="eU1xFEzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A802084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbeLKV7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:59:36 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42926 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLKV7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:59:35 -0500
Received: by mail-qt1-f193.google.com with SMTP id d19so18289406qtq.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GRkTp6DzEHsoz7ooKDEy7qLkmsIpSQz4SxdvDjr70wY=;
        b=eU1xFEzZtzX80lJ+0uys80CmdKIio8IE4GxubE/pvY5DNyf3P6YwccasJu3ziBiYUA
         azwqT6FMzbZLZgFBRZUYgE53BhDqzUcnv6d9rPVI1MLRCT4GkIZp83bNa3SqT+AwdooZ
         nZNsbpejttbnwB67r1WVI/iGMBrbbamvlvStajISMWBdHmU0aDy1fpGVQIKbmief56mr
         viRJAzLeYz/UUYcL8111JzHn5iz0MvEFcL6YBwfNaCCs4ux46F7tdUrD6TocafyrnDRy
         bryKEdsrW5IdT+RRx5HexTSchEZUHwgOUdpjOXT18Qfk2QSyHqwSl5Gzizu2Qn/rddFG
         aZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GRkTp6DzEHsoz7ooKDEy7qLkmsIpSQz4SxdvDjr70wY=;
        b=oxkdRnSxm3tz/dUM6pFU97Grt2pODzEZQxfwWZ//QJQpOdYZ+qaQeP24Ly5e72qpit
         MTiEOUbHwAwejvTYR4SV77xljNVIFbtWKTCkgAA72ZrfbygB4MWShTFGzoqQGiq5p4hn
         mQJ7g8nqDoDfLmZXxN6thiD58++rBJZjkd0C91MPIn9xQ87KjS9LAsNsXSQ67Cf47is5
         v9Sd7dOrtdu/Ye3oAha8x9t56KdiMQqZkg2qK0Y4ytFfpQOdzwWpGfq5nyJRCShkpy91
         oJ8hzqVxEnG8cxj2Kysqo8of1gEuyOoBkIL0dl7teAc9TCpwAQubUN0N5xsMX51wfTE4
         L1OQ==
X-Gm-Message-State: AA+aEWbljQvt3din0xjC9igLzM6oauhlkwMD9xAeFsZ7sbV/lKtuUyy5
        br/BjpRMImiecRrFxTQ6J3oTqw==
X-Google-Smtp-Source: AFSGD/XkzT4kSJ496Phc9I32fOTTuvXY84tCZK273W9ldQiiG7v2N3f9B/NCcbu+YkAw+GcZJzNuuQ==
X-Received: by 2002:ac8:366a:: with SMTP id n39mr17335844qtb.133.1544565574384;
        Tue, 11 Dec 2018 13:59:34 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 126sm7759426qkj.70.2018.12.11.13.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 13:59:34 -0800 (PST)
Message-ID: <1544565572.18411.7.camel@lca.pw>
Subject: Re: [PATCH] arm64: increase stack size for KASAN_EXTRA
From:   Qian Cai <cai@lca.pw>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 11 Dec 2018 16:59:32 -0500
In-Reply-To: <CAK8P3a0DiaeHtUKhWGniXQfrx3DOk9goSXp_d2-dcMunY8jRyg@mail.gmail.com>
References: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us>
         <20181207223449.38808-1-cai@lca.pw>
         <CAK8P3a20kRDrkS1YFLp6cYeKcUoC9s+O_tnYNbKEMWGukia1Tg@mail.gmail.com>
         <1544548707.18411.3.camel@lca.pw>
         <CAK8P3a3ghizoj5xwkQayuwu2Z1HppSqHLwHGPp97dUG4upv+LA@mail.gmail.com>
         <1544565158.18411.5.camel@lca.pw>
         <CAK8P3a0DiaeHtUKhWGniXQfrx3DOk9goSXp_d2-dcMunY8jRyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-11 at 22:56 +0100, Arnd Bergmann wrote:
> On Tue, Dec 11, 2018 at 10:52 PM Qian Cai <cai@lca.pw> wrote:
> > On Tue, 2018-12-11 at 22:43 +0100, Arnd Bergmann wrote:
> > > On Tue, Dec 11, 2018 at 6:18 PM Qian Cai <cai@lca.pw> wrote:
> > I am not too keen to do the version-check considering some LTS versions
> > could
> > just back-port those patches and the render the version-check incorrectly.
> 
> I'm not following what the problem is. Do you mean distro versions gcc
> with the compiler bugfix, or LTS kernel versions?
> 

I mean distro versions of GCC where the version is still 8 but keep back-porting 
tons of patches.
