Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B060DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBD32150F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H2q/8d/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBD32150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeHXTzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:55:31 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51614 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbeHXTzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:55:31 -0400
Received: by mail-it0-f68.google.com with SMTP id e14-v6so2853292itf.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 09:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXVPfkvGpsowS6Z/9Nt+7K7irqH0Qk0wBCpTsUL8SdA=;
        b=H2q/8d/BdOm9cQVRs1vvWl7NyQempDwJUpbty7Samb1stIpBKimrP1/WCxj2J6Jq0V
         8RURQg7MxDl7rE9M0yeS4s20SsutLkft47AqWUMo46zeT3LkGMxkdWHjg12AHpzPRMMO
         sZLiLh1I0hhC1290u35rEIdlnaynoF38VFIQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXVPfkvGpsowS6Z/9Nt+7K7irqH0Qk0wBCpTsUL8SdA=;
        b=n+anAGLT1ePYSlKwcdODVoiJtl0tgf0+Iig3xrzgvgaG+puz4Py/Clft6OTjwQ1tcE
         7EVChPt7ACLm3q6wXEO2z2YOy3T9wLb6Eg/E0GqGcMWtFuMG2Oty6QZiT1L3V9TuNBK6
         gVpehFBldbXDWdkN6vcbNObZ3/0gUpjOc36YGsdVV8eRSk0TTD2OMYpnKBKWK4UpxlPs
         AophX4fepdicjHNvibHUL+eEMQ87Za2B5RcmWE0p6GJjvHdxZGhnfrqXWjKtOhIbRmf+
         Zjf8mdzxZD4cHxErRSyyKNXWzAuD/mVo3r8G53AX40qhf1Y9Hs8hpgJ7a/tz3gQibFmY
         h7lA==
X-Gm-Message-State: APzg51DzJ0YiWsKT/rbBxg+kq+E9LAosRNJrKvQLSrlU3Flpg6Xo2S8i
        PMT2L/ytqWgQZZ1khY9bdVLXWS3j2Ea11NsIvJtoEA==
X-Google-Smtp-Source: ANB0Vdal+EiBwgiDkCATARsGgEfDsPKLGZHtiYbnbOZPcVvKyhytdsurd72dXhK6/i5SkYcfPmZj5/SjoRiRnr1z/ZY=
X-Received: by 2002:a24:61d2:: with SMTP id s201-v6mr2120317itc.22.1535127610935;
 Fri, 24 Aug 2018 09:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
In-Reply-To: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Aug 2018 09:20:00 -0700
Message-ID: <CA+55aFxNs5B=j_g_OpAd=Xp_iiO_+idT-ogd_WM2EcL_6brbqg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 8:52 AM Will Deacon <will.deacon@arm.com> wrote:
>
> I hacked up this RFC on the back of the recent changes to the mmu_gather
> stuff in mainline. It's had a bit of testing and it looks pretty good so
> far.

Looks good to me.

Apart from the arm64-specific question I had, I wonder whether we need
to have that single "freed_tables" bit at all, since you wanted to
have the four individual bits for the different levels.

Even if somebody doesn't care about the individual bits, it's
generally exactly as cheap to test four bits as it is to test one, so
it seems unnecessary to have that summary bit.

             Linus
