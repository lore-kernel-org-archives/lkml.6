Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1027BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C812133D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KA2rizEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C812133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeKHI1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:27:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41246 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeKHI1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:27:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so2371031pgh.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 14:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=LRUOrVbOmo16PNyJZh9N/4ctCvpsTGWiKoWhsLjwS/I=;
        b=KA2rizEj5jCCrUTZ+ljWGhNlhPUqsaJ1AXbldp2dAEz3tbXDFj6/ZjmLNKezpvVFtA
         BUmejKG1fnh5gErnyS7qD5uZHgZd+3ia2Od7YP1deP0xR/t/b4fVb16B+etSqo1b3aN8
         8QZlFvzj5mMSn95rSr/swiEExM5mvwkvwROTrIkxJq61EgL3BrxkSa71WA120/5pl8zs
         aC8TXTrwqjWVVNRf2mZn6T7w+io/k6/0KToLmbamKAGDAsEq8oqe8jilX20YZA1VCqds
         mCGoJcV9ZpGEU4wkRS2LYg91opF8mKAhKx+hbt6ueE+TuybH43ctJyPhQjDAV70qpipa
         VNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=LRUOrVbOmo16PNyJZh9N/4ctCvpsTGWiKoWhsLjwS/I=;
        b=baTxBno8XeR4AlObNyshiaFf2hLR9ES2goLliyff0a2JwUN988W+m2Alaz+3le+Jf4
         C447aTJ3oe7TqPaqy/vV5dBijRJZaowrJV7rKjWDMIq2oo0d/HYuatUW1E0tFklIBqCf
         KzUKdQiUXOPqCKKyWiaIJiwpe08KCjndjVUOyxK9zUHhbEvMTbZW7eiAovJ/Vg0+J8Qd
         IflTyBUoJcqWtNLIyCUEthBb3m7RlyZ0uwipez3I0taT6ymTtswrsOxpylnBDenfPpyO
         gFg8ifaMdiIVCcRWSMKikigAAGO17n4B1QI9HZ4UVzn1BBvg1N9gLTRR87ZAqqb3PA9b
         DdWA==
X-Gm-Message-State: AGRZ1gKMK91kXApMfffC99RKNCGVD8B7qI1FiMBAPSkrJxuExSgMLtPR
        H01iajMoo6V8JIploPQeMtepmg==
X-Google-Smtp-Source: AJdET5d0YHyLq2VKTj11J8ogzxf1UXND8WBnO09qaPgg8bd01ZWPWsrcRAFz9wrt2xfwlOnKR2Ad7Q==
X-Received: by 2002:a63:d048:: with SMTP id s8-v6mr1793655pgi.311.1541631310019;
        Wed, 07 Nov 2018 14:55:10 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id r124-v6sm2015695pfr.151.2018.11.07.14.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 14:55:08 -0800 (PST)
Date:   Wed, 7 Nov 2018 14:55:07 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Yangtao Li <tiny.windzz@gmail.com>
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, slab: remove unnecessary unlikely()
In-Reply-To: <20181104125028.3572-1-tiny.windzz@gmail.com>
Message-ID: <alpine.DEB.2.21.1811071454580.230996@chino.kir.corp.google.com>
References: <20181104125028.3572-1-tiny.windzz@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Nov 2018, Yangtao Li wrote:

> WARN_ON() already contains an unlikely(), so it's not necessary to use
> unlikely.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
