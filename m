Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817C4C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FDF217D9
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JUy/Pig7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfABVoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:44:00 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38680 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfABVn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 16:43:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so15013290plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 13:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=aC05bBCoXxIm2KIVwsPfjJVh2Mlak6ps4N17wDzsk8k=;
        b=JUy/Pig7HV75nP+QMn6qhkRF4ZCABun+cxsU/CA/130gkin3Yo7Zc9Mc7RtV9rM/PF
         HvWeb4uN6ojbyCNFpR9+mMYkw88c4qPsJmGotCNZVsGDid/XIT0NX8sUqkb81A8XBXjw
         mKsVtILVAd6ytEptK6opTO3CLlmrvmHxCZ+EOrifVlMHJ0v4ABWlXjR15eiVcplPa+dy
         BtS59Fu1ZGnLtXVQszEA1z7yKAgn9TpmC6SwuuzV086n6dguGqY8EjenF1y//t80gXZb
         TLQK6e+nXGC7bfh1mPzEET9AcjPXb3kyb7lnxYzPPq8SsOq4nFyY75EtwvIkDQ/b9u7A
         YgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=aC05bBCoXxIm2KIVwsPfjJVh2Mlak6ps4N17wDzsk8k=;
        b=YRz9M+QXQX+/m7Ms3q/ZesNpzUZMAmrNMozh0X7qZAes/ejidIVoT4sqiZ/CwezRa0
         RS9lkGlhFwy+llmWqEM0ROncauOvur8XHTvFTMbZuL9DV5tFbsqJeOz7pWrPEbdpD0b6
         ykoqB2c/CSrnr0iSqdxJOwtoOguknjAETCAUjbC/fbQFAVGmoeIzx6E4NfbqHS2iW3Yo
         AST4oxN50vcK5J/eca8LvkNjZ7jrXD2Kq65+ttmj4vGGu8Tk/gce0KCs3TW4ezwhjShN
         yrKEQyhlYL049RlL3Ty+C4fJtP/Yj1KY8MsMvECS3AnDVdctNV0VEhCQ2iuxt+uGgQMz
         koCw==
X-Gm-Message-State: AJcUukeCmjvjq3Or1gwDxzyWeQROnKIpE7hGnSviF6DL9cPQio5Rv4xt
        r80f58hBJDmlXxWJB96DApeL/g==
X-Google-Smtp-Source: ALg8bN79rTlMx9iwdBrKizw1SDk6ntuqOXNAbk/3h/mLUneCoGmUqeAKq6+JWBxzUtitwAletvkWPw==
X-Received: by 2002:a17:902:b943:: with SMTP id h3mr45345949pls.12.1546465439044;
        Wed, 02 Jan 2019 13:43:59 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id l70sm61172314pgd.20.2019.01.02.13.43.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 13:43:58 -0800 (PST)
Date:   Wed, 2 Jan 2019 13:43:57 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Peng Wang <rocking@whu.edu.cn>
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub.c: freelist is ensured to be NULL when new_slab()
 fails
In-Reply-To: <20181229062512.30469-1-rocking@whu.edu.cn>
Message-ID: <alpine.DEB.2.21.1901021343450.69024@chino.kir.corp.google.com>
References: <20181229062512.30469-1-rocking@whu.edu.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2018, Peng Wang wrote:

> new_slab_objects() will return immediately if freelist is not NULL.
> 
>          if (freelist)
>                  return freelist;
> 
> One more assignment operation could be avoided.
> 
> Signed-off-by: Peng Wang <rocking@whu.edu.cn>

Acked-by: David Rientjes <rientjes@google.com>
