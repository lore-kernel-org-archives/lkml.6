Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822CAECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E9E20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WGdBnrn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E9E20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeJaAXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:23:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43646 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbeJaAXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:23:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id g26-v6so10506445lja.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 08:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZtmXnmJyWcV3ODY01HTI6Wn9QrRQ/iAqsvYQvID67M=;
        b=WGdBnrn7F16rz92FKgx1F4F3xq2L9ulvrmEfPrKuWXMSJg17Aa63Fxb4Gpe3Qz7ahS
         SQx/RzzxMUHxL+geYcHIhSUG6fGusw3Q4xKa1lJPbq7lgRXc/NSDMDIEFgl3LPHIqfJ8
         80TSVyN3Gc0SnuacfrYuhwkcImopJDcH4u/ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZtmXnmJyWcV3ODY01HTI6Wn9QrRQ/iAqsvYQvID67M=;
        b=R8WWLWQgQSY2zt/n02HNXo4ec6B0lHZN0w5Vj/pH1v5FOFkS98zWTRmr27gjHoxsSC
         a7nGIFSVYLNE7FOw6rzHCODlIMQtGAPLJ0KRHGw/dD7vaj61hS15bcfFI/dff599ZO0K
         v+znRGbB+QkEfuP3wEqMReIN4/uvcHoSiPv5nl5B9HtTn5o5vq71S0RB9+QOajv+pUao
         gMhPQdbEdWbfgIPZbC2ttMYbz+EVLz8hkCZOswezUoKzJivewUl6Lm1oTgwjVtpnuZ7V
         vf1gLoDLS2aZ07mcFB0Lv40WmqMzk5W7gW0/ycuwxyhhXdrHyupCL53vi29aP2LcsWcd
         w0sw==
X-Gm-Message-State: AGRZ1gKWZaStJQJuZ8t8RI9ONstoW+20BkxBfvYsxyNVrMTlUWv1dng6
        05xSoNctWuqYupYVzFRJAF8jwMWRWdyweA==
X-Google-Smtp-Source: AJdET5cAtt0cSkLsXb7Z4ca+eTgp31FpiarQD+2CRrWjL7cSl/UPk8SpCHcyVQnPY2DZNrcwdsxFPw==
X-Received: by 2002:a2e:2909:: with SMTP id u9-v6mr6729839lje.28.1540913351212;
        Tue, 30 Oct 2018 08:29:11 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id a4-v6sm3735239lfa.91.2018.10.30.08.29.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 08:29:10 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id p86so6992717lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 08:29:10 -0700 (PDT)
X-Received: by 2002:a19:7019:: with SMTP id h25-v6mr2315708lfc.147.1540913349579;
 Tue, 30 Oct 2018 08:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1540904580.git.dsterba@suse.com>
In-Reply-To: <cover.1540904580.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Oct 2018 08:28:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPmELRt00f1tbOoG4kMU6Kn1nvF1AysxXJk2V45WPNJA@mail.gmail.com>
Message-ID: <CAHk-=wgPmELRt00f1tbOoG4kMU6Kn1nvF1AysxXJk2V45WPNJA@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 4.20, part 2
To:     dsterba@suse.com
Cc:     Chris Mason <clm@fb.com>, linux-btrfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 6:24 AM David Sterba <dsterba@suse.com> wrote:
>
> this part contains a few minor updates and fixes that were under testing
> or arrived shortly after the merge window freeze, mostly stable material.

Pulled,

                 Linus
