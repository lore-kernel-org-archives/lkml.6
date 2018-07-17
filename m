Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8486CECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354F7205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354F7205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbeGQXdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 19:33:15 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:34103 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729907AbeGQXdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 19:33:14 -0400
Received: by mail-qt0-f170.google.com with SMTP id m13-v6so2460370qth.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 15:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hp7BHugqwHetcfx7Qtfncp8vk5Rfnp+Kd9uoegqTaxM=;
        b=KAq5TID0uiJJe8eoLxRHUswT4OMqn0hBr35A+pNhY0lFLDK0IJ09GYxsrTBAlyzTEt
         Hv0FTe3UuPo3YyMB9Phlf/mcZutGLB+2Uhip/pagrvmgvsEb6dd1PgMjTvWvUDS72O6H
         Oyhf6T7ZHRVDnCALVn/7iCbS4xRXNFJ2z4eONiVx7q0XKVf97m8EZnpgJBVP5NSt6IZZ
         eyTHRLEsjDZb5w7vuJ6qSDl7f7xn8Kt3FeXFfQLfnsFEtVh1qfHkrRNzPXxMOpt1pCgo
         nB369CSkeIYM/VDJl6LIhGmInqyJEB98/w5qtwVtdYwwQlrZbflfsZahfoBHsvwz8EfK
         Rw6w==
X-Gm-Message-State: AOUpUlG7zS4eNQcCTZATdSU4ixJFLJMH/ANNfSq0ZcW6TEz8t33EDBYf
        94C5dfGKL6J9For/GMtz/oEpNA==
X-Google-Smtp-Source: AAOMgpfsRWTflBl0hOndfcICAPwTI8LzV7+fsUmRSvCg1c1vNZOYClUlS/Ewhldcvwy1oCtF0DGgyQ==
X-Received: by 2002:a0c:be15:: with SMTP id k21-v6mr3961452qvg.1.1531868303169;
        Tue, 17 Jul 2018 15:58:23 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc:4eb2:6dae:ab32:e5b0? ([2601:602:9802:a8dc:4eb2:6dae:ab32:e5b0])
        by smtp.gmail.com with ESMTPSA id 144-v6sm999088qkh.37.2018.07.17.15.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 15:58:21 -0700 (PDT)
Subject: Re: [PATCH] arm64: Clear the stack
To:     Mark Rutland <mark.rutland@arm.com>, will.deacon@arm.com,
        catalin.marinas@arm.com
Cc:     alex.popov@linux.com, Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com
References: <20180629190553.7282-1-labbott@redhat.com>
 <9733d929-3c6a-40e1-6110-8f79975323d3@linux.com>
 <1b97aa7d-2b6c-a5df-0caa-1cd16e18a816@redhat.com>
 <20180703121440.v4olvwqb3ykgt5fm@lakrids.cambridge.arm.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <06dd55e6-d39e-7617-b644-bdd04fa3c030@redhat.com>
Date:   Tue, 17 Jul 2018 15:58:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703121440.v4olvwqb3ykgt5fm@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 05:14 AM, Mark Rutland wrote:
>> It might be cleaner just to use on_accessible_stack and then another
>> function to get the top of stack. This also might just be
>> reimplementing what x86 already has? (Mark, Ard?)
> It looks like we could build a get_stack_info() as they have.
> 
> We could probably clean up our stack traced atop of that, too.

So I spent some time looking at this and I'm not 100% clear
if there would actually be much benefit to re-writing with
get_stack_info. Most of that design seems to come from x86
needing to handle multiple unwind options which arm64 doesn't
need to worry about. Any rework ended up with roughly
the same code without any notable benefit that I could see.
It's possible I'm missing what kind of cleanup you're suggesting
but I think just going with a tweaked version of on_accessible_stack
would be fine.

Thanks,
Laura
