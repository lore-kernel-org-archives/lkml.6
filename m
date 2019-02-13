Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1075C0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E464222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Oa6aKfGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394735AbfBMVMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:12:14 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42038 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfBMVMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:12:12 -0500
Received: by mail-qt1-f195.google.com with SMTP id b8so4371758qtr.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MiwKzC4imTfd9YcBKHOMCvIKJMLvOZ3tgWAcHt8ruuY=;
        b=Oa6aKfGJV49VQzZRz7eGabgXeocEDhQI2NULInrB7+KIlp0w0iUKai+8Ot9Up2sguP
         2GL2gtQYS74J5pq15ULP+A/blFvHnKCYpZ2efsq7eb3W/nR0m9lhfATbjXm49n3Org6P
         U4VOoCYjel7aU6c9pYjbLCgQNLokCjI104tu5mjHNUXPJTfxvGIHKgth7TIH2Xpsbptu
         kb9yVwCDC9fc1UCC5VoZ2XNN5BokGqsFK/FJPuTtvu1kcHRJHCX8SaR/ry4fU4zajL7f
         rrIgKl3n+Sgo/260TrHTEe2fk5SMkTn8FWuOOfhtll2cKd6CEhkm3kHfSoR75qQdz/Qw
         zBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MiwKzC4imTfd9YcBKHOMCvIKJMLvOZ3tgWAcHt8ruuY=;
        b=iwCo1rluGgKv8Cpltjatwb7quVHAULJicwfLsFzHjyG561bGM1AynhdMIJByuRFPq+
         PDKVEzeBVigjjciZulSYcRtEeDOcoZ+3hIg1gMTUONKNk5ljNfYTvge2k3Rp0CKLRzqS
         YcS7jKRV/xq/YjbemqccnJgKL9zw5z4FYL15gEn0FAXLks308UFh0VRa3hurJPdrbAHg
         ayTWmu8fhjT6vnWIhODeDCwD9NKRPj+BiFg0r1SN7ktOmLI1NHsthqhSLjV3tyjidjNU
         2IXeuKAi1Ti22qbb+ZqNw/DUl5QZf9aj6mz7pHetg4Aq3YrKwyHzsJdN56zw0rFmIjY4
         /Nhw==
X-Gm-Message-State: AHQUAuYyCEv9jJy3pVI40ALE7/VF4Nlz38xMun/yimcY/Pcv42Y3CBXp
        slbufKlTzWRq20zpHMNwmMVhRQ==
X-Google-Smtp-Source: AHgI3Ib3MgeYUD0kj0bVIyGhAzcL8goNj/KR85py2uRk370sl0TzokE3P694GevZS8gTbhoZfKeLbg==
X-Received: by 2002:a0c:b068:: with SMTP id l37mr148913qvc.21.1550092331303;
        Wed, 13 Feb 2019 13:12:11 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t2sm234914qkh.60.2019.02.13.13.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:12:10 -0800 (PST)
Message-ID: <1550092329.6911.35.camel@lca.pw>
Subject: Re: [PATCH] slub: untag object before slab end
From:   Qian Cai <cai@lca.pw>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 13 Feb 2019 16:12:09 -0500
In-Reply-To: <CAAeHK+w-EWDivYTNiUAeSUVZVGOpUyxbbcC8_nMM1=CcpsJ9Ug@mail.gmail.com>
References: <20190213020550.82453-1-cai@lca.pw>
         <CAAeHK+w-EWDivYTNiUAeSUVZVGOpUyxbbcC8_nMM1=CcpsJ9Ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-02-13 at 11:31 +0100, Andrey Konovalov wrote:
> On Wed, Feb 13, 2019 at 3:06 AM Qian Cai <cai@lca.pw> wrote:
> > 
> > get_freepointer() could return NULL if there is no more free objects in
> > the slab. However, it could return a tagged pointer (like
> > 0x2200000000000000) with KASAN_SW_TAGS which would escape the NULL
> > object checking in check_valid_pointer() and trigger errors below, so
> > untag the object before checking for a NULL object there.
> 
> I think this solution is just masking the issue. get_freepointer()
> shouldn't return tagged NULLs. Apparently when we save a freelist
> pointer, the object where the pointer gets written is tagged
> differently, than this same object when the pointer gets read. I found
> one case where this happens (the last patch out my 5 patch series),
> but apparently there are more.

Well, the problem is that,

__free_slab
  for_each_object(p, s, page_address(page) [1]
    check_object(s, page, p ...)
      get_freepointer(s, p)

[1]: p += s->size

page_address() tags the address using page_kasan_tag(page), so each "p" here has
that tag.

However, at beginning in allocate_slab(), it tags each object with a random tag,
and then calls set_freepointer(s, p, NULL)

As the result, get_freepointer() returns a tagged NULL because it never be able
to obtain the original tag of the object anymore, and this calculation is now
wrong.

return (void *)((unsigned long)ptr ^ s->random ^ ptr_addr);

This also explain why this patch also works, as it unifies the tags.

https://marc.info/?l=linux-mm&m=154955366113951&w=2

 
