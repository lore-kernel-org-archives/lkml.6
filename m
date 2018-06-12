Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7E8D8C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C3C208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C3C208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933749AbeFLIXg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:23:36 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:34477 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932794AbeFLIXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:23:32 -0400
Received: by mail-it0-f52.google.com with SMTP id y127-v6so13529059itd.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 01:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F9JggbAYwZSRIwpFbW2IaGPn4H9EBdP3lNc3jkyBPZ4=;
        b=fsZm9yHcii7Rf6dhIRbKln5cGArJhFp22D3R1xVNoIZ/cLOcwWe04V0vcpmYF9GczS
         +4XO4iSXRE0Y1gA/cHWpYLW2G9ped9u7Mo9bhGOTXHLFRCRhfQ8oIuUQLqdNr+d0ucxH
         A93UeHMMW7vdlbi80Lc5xS4NcfX9AEov2g5etSudYNIMBKnD51ViWziBNHhRMfRsXT3s
         ARimZcl/L+nkKKMh/Eeiq2jpCsu4I9v1SEzJrD3q8MuVY3ZlF7f3ZWGhzMpcpXIhXkcx
         VVrQv2emrlcdSqSVFjkTzvxHjTRqZPaWC54WcQ3lL0eixVxTKmF0qYyUvn38EkEXTxx6
         LHgQ==
X-Gm-Message-State: APt69E2KknbDGOU8vNWG+Nte5po7FltNGbl/ZurivrZy4959wgwP8hwc
        lKnASU/YJnR21+S0+K2eAY7Xs60iTtuv9gyrR3aH2g==
X-Google-Smtp-Source: ADUXVKLKix990HVk+4IS5wUCV5lDnn1WhyoaEg05lMnmrP1mWMbaYDWkChmfPZFtwyhiyudF4n6uTe4Z7y7e1pjo8ss=
X-Received: by 2002:a24:5b81:: with SMTP id g123-v6mr2134107itb.1.1528791811426;
 Tue, 12 Jun 2018 01:23:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:8407:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 01:23:30
 -0700 (PDT)
In-Reply-To: <C20C8754-0C63-4EB2-B3E9-68E4EE29338D@gmx.com>
References: <1528774692-38990-1-git-send-email-jiazhouyang09@gmail.com> <C20C8754-0C63-4EB2-B3E9-68E4EE29338D@gmx.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 12 Jun 2018 10:23:30 +0200
Message-ID: <CAHc6FU6M0dOnJOuJ9ffP22Qbd0tkQ3mPqt7BexjeJ4rPPJdz8w@mail.gmail.com>
Subject: Re: [PATCH] gfs2: add error handling for kmem_cache_zalloc
To:     "cgxu519@gmx.com" <cgxu519@gmx.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 June 2018 at 09:24, cgxu519@gmx.com <cgxu519@gmx.com> wrote:
>
>> 在 2018年6月12日，上午11:38，Zhouyang Jia <jiazhouyang09@gmail.com> 写道：
>>
>> When kmem_cache_zalloc fails, the lack of error-handling code may
>> cause unexpected results.
>>
>> This patch adds error-handling code after calling kmem_cache_zalloc.
>
> Should not fail on this case.

Indeed, with the __GFP_NOFAIL flag, kmem_cache_zalloc will not fail.
This is documented in include/linux/gfp.h.

Thanks,
Andreas
