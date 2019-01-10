Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F49C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F23213F2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="eTlo852s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfAJVDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:03:54 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:40470 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfAJVDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:03:54 -0500
Received: by mail-qt1-f182.google.com with SMTP id k12so15396266qtf.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 13:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OXxi4LpotewKcbwhtpBFqBYFbJcIWyjKfbxyYrg91F4=;
        b=eTlo852sejUP6PowKTen0wMZLaPZVqcK3KdfyurWNkkhrbN16wwy1sgqt6PgteL6LT
         si0BhzeGhHqfMReEc/5ARGGNpz4MHE1w/z3hkyQKRQEfAS/fs5MSHIGY7nk4sI5Rf5gH
         x2fHDGKbdvpo0hA2oSIC9IpqKEI4Eu5/FuOIpcAICEUwBCftrqy7zMwM/y8Ym5pKVXug
         5gOzDAw92r4ntNAoc70tH/o6YUoliJe99vFUccwhTNupghsLAFKZ0uA+yTz/EnZY9Pjs
         wQISs9iQNBT747tewQ4a60SFxFJptYyX8WjxWIapcd0Nk33mr0W5jPttgNMeBhiJxAOS
         9KiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OXxi4LpotewKcbwhtpBFqBYFbJcIWyjKfbxyYrg91F4=;
        b=Vqt6/N8gadPfSfzgPGGKj8w6k6vWn4/7RB+7VVSQo82kPvYNZDcpWYPhSd7D3CQu2r
         1nVy8Exp2LMPKErj6fdgCnHIW7/Y4Mr+/qJOa2tNV07LZ/2w0Wks/WdFliDlds3gdhrL
         uMuZ5MhoYUt+XAGJCIu5KbEcWI/a9wXrEZgXGMM6LZRq5dx2cRzEQoxQokqMQXQchwQT
         XsX21ai8oQMK26yXYID3XOd8JPxQjnVg8hKajuVMqCHGDD1/iybmYd2NfZQlj94OhCgP
         vw8cpFtEWBVE8W+p7dpJE+jcHVoctZAOfF+QObHvDRKO7yqQybl5AbXVZEaYSEajjZCB
         aOmw==
X-Gm-Message-State: AJcUukfzCo4PFzZIqfKbEkq7oaMcMPlr5G5wTOSZ7xLL0JIrN/AqjA7K
        OxbX56aRq8DMXJ3zZ8t1uUUoFg==
X-Google-Smtp-Source: ALg8bN7cvSwxJRFpdngdfZRrPR0BU1s3uFoVCCtxw21SOF3eVhOHHyI01gXd5eCtcAt4Rp2JLhAd8Q==
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr10531567qkf.330.1547154232628;
        Thu, 10 Jan 2019 13:03:52 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v32sm49325749qta.37.2019.01.10.13.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 13:03:51 -0800 (PST)
Message-ID: <1547154231.6911.10.camel@lca.pw>
Subject: Re: PROBLEM: syzkaller found / pool corruption-overwrite / page in
 user-area or NULL
From:   Qian Cai <cai@lca.pw>
To:     Esme <esploit@protonmail.ch>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Date:   Thu, 10 Jan 2019 16:03:51 -0500
In-Reply-To: <4u36JfbOrbu9CXLDErzQKvorP0gc2CzyGe60rBmZsGAGIw6RacZnIfoSsAF0I0TCnVx0OvcqCZFN6ntbgicJ66cWew9cOXRgcuWxSPdL3ko=@protonmail.ch>
References: <t78EEfgpy3uIwPUvqvmuQEYEWKG9avWzjUD3EyR93Qaf_tfx1gqt4XplrqMgdxR1U9SsrVdA7G9XeUZacgUin0n6lBzoxJHVJ9Ko0yzzrxI=@protonmail.ch>
         <1547150339.2814.9.camel@linux.ibm.com> <1547153074.6911.8.camel@lca.pw>
         <4u36JfbOrbu9CXLDErzQKvorP0gc2CzyGe60rBmZsGAGIw6RacZnIfoSsAF0I0TCnVx0OvcqCZFN6ntbgicJ66cWew9cOXRgcuWxSPdL3ko=@protonmail.ch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-10 at 20:47 +0000, Esme wrote:
> Sure thing;
> 
> cmdline;
> qemu-system-x86_64 -kernel linux//arch/x86/boot/bzImage -append console=ttyS0
> root=/dev/sda debug earlyprintk=serial slub_debug=QUZ -hda stretch.img -net
> user,hostfwd=tcp::10021-:22 -net nic -enable-kvm -nographic -m 2G -smp 2
> -pidfile
> 
> CONFIG_PAGE*; (full file attached);
> 
> # CONFIG_DEBUG_PAGEALLOC is not set
> CONFIG_PAGE_POISONING=y
> CONFIG_PAGE_POISONING_NO_SANITY=y
> # CONFIG_PAGE_POISONING_ZERO is not set
> # CONFIG_DEBUG_PAGE_REF is not set
> CONFIG_FAIL_PAGE_ALLOC=y

Confused.

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1896410.html

It said 5.0.0-rc1+

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1896410/repro.repor
t

It said 4.20.0+, and it also have,

"general protection fault: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI"

which indicated CONFIG_DEBUG_PAGEALLOC=y but your .config said NO.

However, it looks like a mess that KASAN does not play well with all those
SLUB_DEBUG, CONFIG_DEBUG_PAGEALLOC etc, because it essentially step into each
others' toes by redzoning, poisoning in allocate and free pages.
