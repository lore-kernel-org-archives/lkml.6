Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942F1ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FFB2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="F8IzLuYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FFB2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbeINXBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:01:21 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:35031 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbeINXBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:01:20 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 97cec5e7;
        Fri, 14 Sep 2018 17:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=F4od+g2uUE7skfneZs4SE6ivRPs=; b=F8IzLu
        YRanBYzdzvA4+RvZwXGL/dhaC701TDg4jlekLIVD9va6ErM29UT6m08rGivcli0O
        y7+RR7wnfflcG7+a6Y6vR96iTi3AD3yLmMUzeKG5kRJ62V7+qsXfl30Qhpp5zUv7
        eAMjNqHWGW/PKukT2ZsPZ6KGOzR/666datYTf3N/0BqLex+rsgm7s7B0fMtLOysk
        1A+r/KS1m6+akegXNrkA3sJVhdzDc/o8S46YpSabBJIicktbWiYHbjX2RM0ki7hC
        a0w2T46iEMbpiSOTzcrFl7N4/lzSi1sJwEPsYbqqXI9s9NJODaThcbsjBUXiM3F/
        kht1RLnqF/FGK1Ew==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5db300ab (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 14 Sep 2018 17:28:41 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id a19-v6so5369903otl.12;
        Fri, 14 Sep 2018 10:45:45 -0700 (PDT)
X-Gm-Message-State: APzg51Ae/uCXuU0cLnkYpWNaKDJaNSMKrRCwN0WKGtn4FGnsdH6nYSHn
        dQQ9Upys2YHmh/drGAueUeRguum8OocA3u1OL8U=
X-Google-Smtp-Source: ANB0VdbhSrbDhbgstQRKxi0EBgEHF2jHuGcomM5u0Lp6hIhzhJWiCSsy2yvXHlxvBMSaeV+Lsu3VMYUF5aIz5pUavmY=
X-Received: by 2002:a9d:2dc8:: with SMTP id g66-v6mr4953890otb.311.1536947144119;
 Fri, 14 Sep 2018 10:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180914162240.7925-1-Jason@zx2c4.com> <20180914162240.7925-9-Jason@zx2c4.com>
 <CAKv+Gu8BD=fLk3zm8tvRQ3H-yiePqzXOrKLEz1BLFSRRz2opOQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu8BD=fLk3zm8tvRQ3H-yiePqzXOrKLEz1BLFSRRz2opOQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 14 Sep 2018 19:45:32 +0200
X-Gmail-Original-Message-ID: <CAHmME9rnzs5x3RTa3ZY0wYvScwssOumNL90YMTXyO4sv8Lwvgw@mail.gmail.com>
Message-ID: <CAHmME9rnzs5x3RTa3ZY0wYvScwssOumNL90YMTXyO4sv8Lwvgw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 08/20] zinc: Poly1305 ARM and ARM64 implementations
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Polyakov <appro@openssl.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Fri, Sep 14, 2018 at 7:27 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> As I asked in response to v3, could we please have this as a separate
> patch on top? The diff below is corrupted.

I had played with that originally, but thought it made things actually
harder to review, whereas here you have the changes presented pretty
straight forwardly, and I'd appreciate your review of them. If you and
Eric both prefer I split this into two commits, with the first one
just plopping down the CRYPTOGAMS code as is and the second one
bringing it up to kernel-snuff, I can do that.

> Also, both Andy and Eric have offered to get involved in upstreaming
> these changes to OpenSSL, so there is no delta to begin with.

Yes, I think this is probably a good long-term plan, which we can act
on sometime after Zinc is merged.

> I still don't like the GCC -includes, especially because these .h
> files contain function and variable definitions so they are not
> actually header files to begin with.

I very very strongly disagree with you here. I think doing it via
-include is significantly cleaner than any of the alternatives, and
allows the code to be cleanly expressed as conditionals that the
optimizer trivially compiles out in the case of stub functions
returning false and branch optimizes when the stub functions return
true. It is extremely important that these compile together as one
compilation unit. Yes, this is a different design than the crypto
API's approach, but I believe the approach presented here poses
significant improvements and is a lot cleaner.

> Also, you mentioned in the commit log that you got rid of defines and
> made the code more modular, but as far as I can tell, libzinc is still
> a single monolithic binary that is essentially always builtin once we
> move random.c to it.

Yes, it's still monolithic, but it's now trivial to split up when the
time comes to do that. If you and AndyL think that it should be split
into multiple modules _now_, then I can go ahead and do that for v5.
But if it's not essential, it seems simpler to keep it as is. I'll
wait for word from you two on this.

Jason
