Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B46ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A95B20857
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A95B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbeGTPzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:55:33 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45483 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731792AbeGTPzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:55:33 -0400
Received: by mail-io0-f195.google.com with SMTP id k16-v6so416894iom.12;
        Fri, 20 Jul 2018 08:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=62qZXJU3Ffr08U2yYEmf4Dn+cH6zAE+X9S/2+PEGwSY=;
        b=d7wh9kvyrfAK6dae+821yV8FuilccMHwYeSFZ1HGvkfwaCAqCv9RPfjuYkUOWix6uF
         XFBy/059Snb9LrsnNoEbP+fxb0f3XK6I/yh24nfJ5FHkp5gz9yU9KLVI+EEWB6Fj5Mz7
         Wh1ooGEx6S9OjlI1jbMXXzU84nrHU7j7nh4JPqVGEnQ8OjwA9T3qnSwo8eYkRto+mH5E
         W/2RWgetfsHQevI42FI9NTDm9w1YYqmrq6Mdwpt019lp3iK4YdeE1bP/Gxv/Exf8HwB2
         81DbEwNVDcphPwciAAwLuvbYAwpidBiftYCRZgSpBWf/VmS9tbDR8vtVwX5LkMgCklxh
         PK4A==
X-Gm-Message-State: AOUpUlFS6X4MecD3iwWFk6TBLx6LDPOMH1Rt0T1FIJ+vDZZ3z2vGs8vo
        BjhuR9JD+0+1kVhAOQhXjw==
X-Google-Smtp-Source: AAOMgpcVfRU2SsxUksNTFuiCvNhVLNGMHjp0USeyE0x7b2Wo7gmk6koQkpcgpzuBTJZOHKcbqNKX6Q==
X-Received: by 2002:a6b:b496:: with SMTP id d144-v6mr1839368iof.26.1532099211570;
        Fri, 20 Jul 2018 08:06:51 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id f18-v6sm1339237itc.44.2018.07.20.08.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 08:06:50 -0700 (PDT)
Date:   Fri, 20 Jul 2018 09:06:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     Alan Tull <atull@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
Subject: Re: [PATCH] of: overlay: update phandle cache on overlay apply and
 remove
Message-ID: <20180720150650.GA32296@rob-hp-laptop>
References: <1531429207-3245-1-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531429207-3245-1-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 02:00:07PM -0700, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> A comment in the review of the patch adding the phandle cache said that
> the cache would have to be updated when modules are applied and removed.
> This patch implements the cache updates.
> 
> Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
> Reported-by: Alan Tull <atull@kernel.org>
> Suggested-by: Alan Tull <atull@kernel.org>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> Changes since RFC:
>   - update code comment to mention race condition avoidance
> 
> For the RFC version of this patch, the 0day test reported a general
> protection fault from the KASAN runtime memory debugger on x86_64
> in qemu.  The GPF was in a devicetree unittest.
> 
> 0day tested the patch on v4.17-rc1, with some other patches applied.
> I was unable to replicate the GPF on v4.18-rc1 with just this patch
> applied.  I was also unable to replicate the GPF on a clone of the
> v4.17-rc1 0day repository, using the 0day kernel config.  I will
> reply to this email with the 0day GPF report.

Didn't see any 0-day issues, so I've applied and it is in Linus' tree 
now.

Rob
