Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39E5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E8F2254B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wPul8xzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E8F2254B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389407AbeKOIbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:31:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40920 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389389AbeKOIbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:31:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id x2-v6so8607608pfm.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 14:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=d3ca9Th2qbGGdglHvHy5YXu/4+6WYRWXH6uDcyMPS1M=;
        b=wPul8xznsE1aCIiqxKpP1o9rnpk3Lbu9rRlFxYs+pW9kmWmZ4GdzV1vCEn+4tlwlPk
         RjjYqeUwJeyBdhdw48xyx3ERmqLn4cmw1HjSeT3X2Ds/8MkcssX3u5rCpPL4ZVX23t2s
         lM129dEWjNJueHlZQYgMYeSICWAvQsEJ9NM+Pe4H4MuLeljlLICtZRRVEe4687tf1voB
         OyO3z5dny1+WcSaPAKhgaUaavJxq9LFcdb7q/hXxuzsONyxPa+7IEFZBKsKvO9YS3Krq
         0FWfmGKT3u6zr2mBSXsU2ChIbyuXk4NfqiScWOI0Hwe+JiKRY6//yY2umbgLS56v9q0i
         EBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=d3ca9Th2qbGGdglHvHy5YXu/4+6WYRWXH6uDcyMPS1M=;
        b=I1ASDsSW8HozNUaF3up0zbtKCt7kGgy0DQelZUwc9I9CDm1JwZjuYOez+k6PDVJEgL
         Vhv9e+Rb08c8Odpk1ZF0/O1FElCbaaFUNNItbjg331F0VL5QCd0NwunwcJeMK18nrla3
         lZjZ7SMR3ugruGcmfDUwr0Pa8fpWvHb3eSJVEDfXja1K3vqbsBT/th9+lr2Z6ssa02Qy
         U0sCNwhBy09ZQwC+9Q3z+FhJcFHVfHuc+5wwO6tc/Dz7ZxI6Mop6oHZwk2YPete4TsUl
         NIDhcKQPkLekMaznpJhfbIRruiNp+Lcp2Peakxv9G9gh6DoXaetSEOA8TDR5Q5lcjSib
         8Y1w==
X-Gm-Message-State: AGRZ1gIqxPnE11AEIwEcfXs2aNPO/W9zY57tw8NtMWjLUQbqTDXAUBEE
        GDndnciYzqRu7XNnoIVFvgK4xQ==
X-Google-Smtp-Source: AJdET5c3tTpMiLcGIlgZQ4bQQDB5K6nHPJ4IeUFJ+eHQo9NNI/bDhbrGhOZ23RLEVZziiXpWZChd8g==
X-Received: by 2002:a63:dd55:: with SMTP id g21mr3378025pgj.86.1542234024761;
        Wed, 14 Nov 2018 14:20:24 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z83-v6sm29450958pfi.4.2018.11.14.14.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 14:20:23 -0800 (PST)
Date:   Wed, 14 Nov 2018 14:20:22 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Yangtao Li <tiny.windzz@gmail.com>
cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, linux@dominikbrodowski.net,
        dave.hansen@linux.intel.com, dwmw@amazon.co.uk, mhocko@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: mmap: remove verify_mm_writelocked()
In-Reply-To: <20181108174856.10811-1-tiny.windzz@gmail.com>
Message-ID: <alpine.DEB.2.21.1811141420110.212061@chino.kir.corp.google.com>
References: <20181108174856.10811-1-tiny.windzz@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018, Yangtao Li wrote:

> We should get rid of this function. It no longer serves its purpose.This
> is a historical artifact from 2005 where do_brk was called outside of
> the core mm.We do have a proper abstraction in vm_brk_flags and that one
> does the locking properly.So there is no need to use this function.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
