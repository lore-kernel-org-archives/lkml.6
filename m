Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6F7C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3903F2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij/nOVUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404497AbfBOWoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:44:09 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44150 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfBOWoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:44:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so5486844pfh.11;
        Fri, 15 Feb 2019 14:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=HBcjk503nQuKRSQt+/RVqHzYhBzzBuRiWKFD+cpVj7Q=;
        b=ij/nOVUEwkqqrwG9/VWRIis6Tn4jNei6jZnSUTGb91GMP0U/r/K8Dycz1T3SfKPx/L
         CAxjFNMxhYSCK7Ukh+OrQwX59qnpkizgpA+rppiFktl97+Kj/WZrct5+j6B79lnn8dVc
         tutGGEsYmFN2i3vgw5CoxxOWJs7AJJnkDypzejhCKmECyoqMQdpGRPpMUD9YI3z8rtGl
         C1vaIFfA9V2+NUPUOGZNGZolJHWZf8JEljC4dgydcXJ40su5OF0jzBV7Nkj61R8folS5
         V+17nKS+51lgVdoPC0Trl5KFvaqroM3WDA1CjqehtxYBeyeD0vv1Xb2Y9/3gvzmj2UDt
         UcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=HBcjk503nQuKRSQt+/RVqHzYhBzzBuRiWKFD+cpVj7Q=;
        b=WlXDwuAhYhbMPnvBxaXdHBLz4Edlg9bON5dDtd8oMS8ZN5JJppmGlnf4GPGnudDoD7
         bUX4Wea/F/wsNCLNe2xBX510Pilpb7dCcGhcPNHc1XBqiZmR0XC5uhcXOOqnmtheH8SQ
         wol5IiDcytXn7WW3vhK8D2u0BGf4N8be5HpwySqTXNVIN/nFGeM1PH3GrK4c0TNmxt+p
         Dk+F3xbxUqDbTwHX5Ax7YE0xONech05Wmy+IIukBuscjqb/jQqXf4tXK9MEiP52EeMDc
         eCCoVW7niWwinLMyw2BhsdGTnz6UlvS9fIviQ2LQs5/bdPjedZB/GnrW46SPr32xHKID
         8EyQ==
X-Gm-Message-State: AHQUAuYOGylklylbWmCEP/fANYoWS9l/+f32+W6cioE/Dc2VubnK+jVw
        1h4Rt3gEYESUoIMQiYx03+ffHe90
X-Google-Smtp-Source: AHgI3Iapx0tr5JpcSl3beD3Dn/WO+prh6r5/nue3Y9ihM/L9HBZVhKwpUmEo2uBYt/lL5VQLll16dg==
X-Received: by 2002:a62:5687:: with SMTP id h7mr12072726pfj.198.1550270647308;
        Fri, 15 Feb 2019 14:44:07 -0800 (PST)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id y21sm11474272pfi.150.2019.02.15.14.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:44:06 -0800 (PST)
Subject: [net PATCH 0/2] Address recent issues found in netdev
 page_frag_alloc usage
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     netdev@vger.kernel.org, davem@davemloft.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, jannh@google.com
Date:   Fri, 15 Feb 2019 14:44:05 -0800
Message-ID: <20190215223741.16881.84864.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set addresses a couple of issues that I had pointed out to Jann
Horn in response to a recent patch submission.

The first issue is that I wanted to avoid the need to read/modify/write the
size value in order to generate the value for pagecnt_bias. Instead we can
just use a fixed constant which reduces the need for memory read operations
and the overall number of instructions to update the pagecnt bias values.

The other, and more important issue is, that apparently we were letting tun
access the napi_alloc_cache indirectly through netdev_alloc_frag and as a
result letting it create unaligned accesses via unaligned allocations. In
order to prevent this I have added a call to SKB_DATA_ALIGN for the fragsz
field so that we will keep the offset in the napi_alloc_cache
SMP_CACHE_BYTES aligned.

---

Alexander Duyck (2):
      mm: Use fixed constant in page_frag_alloc instead of size + 1
      net: Do not allocate page fragments that are not skb aligned


 mm/page_alloc.c   |    8 ++++----
 net/core/skbuff.c |    4 ++++
 2 files changed, 8 insertions(+), 4 deletions(-)

--
