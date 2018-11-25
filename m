Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C7BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 03:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02ECD20874
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 03:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UjNPmMhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02ECD20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbeKYN5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 08:57:24 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43076 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeKYN5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 08:57:24 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so11102334lff.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 19:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bg02qPrsD9IOCv1nTKYpouX2kMHkDvr5X0i0yeqjJlM=;
        b=UjNPmMhk+mJogmMxNR2UsUFq9xMsemc7/0ffNc4rdS1ys0TOON5jDG1EPNfuIK6scf
         qSwXPQJ9MLXV8Moa3+Zv8+BCvq2edyfHZemnCnLcViXIxfV59/u4Zznq4cPa1FdMbcsI
         hWiIigTgzSKLjeAwr965OpowkVltF6/2lACn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bg02qPrsD9IOCv1nTKYpouX2kMHkDvr5X0i0yeqjJlM=;
        b=CcpkjbPYCdd3Xv9UVhuAxE9yctomiylNPHkDmgw8A0yDrhJT80nSS/hFILWv5Exwh6
         lZwWWOppJChFh6r4QgEAzEWS+UfQgQ3OCPHMA5GpQYDgcgEkPK8NwSIHEi+fboLfJ2WR
         9gwg40oENDO5uK6svF8U4dFg0Xl2EY4k9pllKMCC0nUuCn+plpOKfsF+AGPore4enVAY
         RZ+8vvA/EqGm6MNQ6mopk2gSaNkdD/4+n+KnNJBT06N4zE5wz6EF9vWFX5vbqo/O/UqJ
         Nt4ItnCSwaFuT/cWypQ+33cE/F6vRKK7qaAVgPYd96UvtNMbV8HVKgbDqhWnsKTPCV7l
         zk7A==
X-Gm-Message-State: AGRZ1gJvXLH/7bWMdsKjvJ5Kx3yAwkajaA5aSROy+VYC4JFZOrgB3MV1
        P1udS0DJtFv5sXFOoeK4Xnlk4VfcqAc=
X-Google-Smtp-Source: AJdET5eiNShFIViZ4lVCPgpLZ+2cr7hUp66S4bufq+eyzQMa8ZAcfloVxNMLRJ2lNzBf8CdsJH/zjA==
X-Received: by 2002:a19:1cb:: with SMTP id 194mr12476767lfb.61.1543115240605;
        Sat, 24 Nov 2018 19:07:20 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id q67sm3589434lfe.19.2018.11.24.19.07.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 19:07:19 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id l15-v6so13576915lja.9
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 19:07:19 -0800 (PST)
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr13906672ljs.118.1543115239221;
 Sat, 24 Nov 2018 19:07:19 -0800 (PST)
MIME-Version: 1.0
References: <20181124173209.GZ3065@bombadil.infradead.org> <CAHk-=wgHTcLXY4P-EJiXd4MbwXjp9QdEfQ+udVUGRuUzT-8ZFA@mail.gmail.com>
 <20181125023814.GB3065@bombadil.infradead.org> <CAHk-=whU1RMvzGvCwq8HaApYZuJ4STyfAYC5b_qDPFTwcTWD=Q@mail.gmail.com>
 <20181125030023.GC3065@bombadil.infradead.org>
In-Reply-To: <20181125030023.GC3065@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 24 Nov 2018 19:07:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiRRYM2dM8GtPef6PgW-hXug91RL1j=ZOCektY8PYcd4Q@mail.gmail.com>
Message-ID: <CAHk-=wiRRYM2dM8GtPef6PgW-hXug91RL1j=ZOCektY8PYcd4Q@mail.gmail.com>
Subject: Re: [GIT PULL] XArray updates
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 7:00 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> I pushed it out to hkps://hkps.pool.sks-keyservers.net ... as I recall,
> pgp.mit.edu is frequently not synchronised well with the other keyservers,
> but I'm surprised that one of the sks-keyservers didn't have it.

I got it now, so it was just some propagation delay or somethinig.

Thanks,
                  Linus
