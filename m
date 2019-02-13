Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833AEC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514CA206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bf3T75IX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391177AbfBMPgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:36:53 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40141 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfBMPgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:36:53 -0500
Received: by mail-qk1-f196.google.com with SMTP id y16so1572753qki.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 07:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/wJ/1+0IfXImQLXSkFuPezPDsOxJHo73pRzAKlG1VuE=;
        b=bf3T75IX3Vc0FTdcrcpk1Qi6F+xpQrpNcEiyMakuj/c6LJI4n8SEnOqM4Q3xR8Xhg2
         44oIN1bay94X9D7kN4FOgcO3MLJorYxF2/Ysgp9bQ3C3YbNIyKXUuhfKrDxCDcM3VPqx
         PifNWnUs2yA1TORyDGBF+N4lMCdWa9myRne9kbiNdHFyf505uKPXRVNxBqeACtlj50OX
         oulNWva5sjLWc9A+HoFIGiG81zUOemIzhmpy5qRBXZ+sJOctg9GNpsTB79niN/ZdLpZ+
         hGR2M1kRx1VjQeVVK5utjQFfo3dj1zktZdggh2p+Yyj6tEGka7vkYG4orLL7bC5Dvpku
         DZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/wJ/1+0IfXImQLXSkFuPezPDsOxJHo73pRzAKlG1VuE=;
        b=uhHzFi29jo/fdeaCxbdjOaHoOqgvrdaNFjhpEPJ8qDA6srC+Iq6rc0h5ALWG5rz+Lz
         iP/neamYHLyfPIQNOh7hEKvHB2lruVJuKSNLHyssuA6LyJ1KQ6Cl3U5nG1PIEs9rQEqu
         xaz0syIPU8k4dD8m7VQH/z/RfTD5w2nXjkBd2f+Wly28CRzR7WHwTSyJVuIIQPPAyoyf
         MJmiIdFUqEL0ErY39g4O/i+krv7ETJmxKNgjt3lB/Mty21y/SDioCx5n9u0OwrpoMF+4
         osiEHLgkb2u/Kt1HfGezd1YRfonjR3dnPka19Y0ze082V86gtGRovgVdgBZP6VBCvPpt
         36WQ==
X-Gm-Message-State: AHQUAuY9wXVa1FCm6g5hzt0Z48JlkGyr/XY4XX5RJPbNRz1yIe8kjcWx
        fFrUsGzqdowAQs6XhLTlm7fsdg==
X-Google-Smtp-Source: AHgI3Ia0WyEybXefqqkxuAMhJAMaAQuwapaIVg65W5L7u9GdCaBkKYSU/7AhbbaG+oGvq9oa2ypvmg==
X-Received: by 2002:ae9:dd84:: with SMTP id r126mr818066qkf.217.1550072212365;
        Wed, 13 Feb 2019 07:36:52 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v124sm18898827qkh.46.2019.02.13.07.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 07:36:51 -0800 (PST)
Message-ID: <1550072210.6911.28.camel@lca.pw>
Subject: Re: [PATCH v2 3/5] kmemleak: account for tagged pointers when
 calculating pointer range
From:   Qian Cai <cai@lca.pw>
To:     Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>
Date:   Wed, 13 Feb 2019 10:36:50 -0500
In-Reply-To: <16e887d442986ab87fe87a755815ad92fa431a5f.1550066133.git.andreyknvl@google.com>
References: <cover.1550066133.git.andreyknvl@google.com>
         <16e887d442986ab87fe87a755815ad92fa431a5f.1550066133.git.andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-02-13 at 14:58 +0100, Andrey Konovalov wrote:
> kmemleak keeps two global variables, min_addr and max_addr, which store
> the range of valid (encountered by kmemleak) pointer values, which it
> later uses to speed up pointer lookup when scanning blocks.
> 
> With tagged pointers this range will get bigger than it needs to be.
> This patch makes kmemleak untag pointers before saving them to min_addr
> and max_addr and when performing a lookup.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Tested-by: Qian Cai <cai@lca.pw>
