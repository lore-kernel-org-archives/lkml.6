Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63815C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8505213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="e1XMq5o4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8505213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbeJDEax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:30:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35604 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeJDEaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 00:30:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id y19-v6so6734539edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 14:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0EoW6/M0CSM4gvZ4wT30NMjrEHjHBg5QS0vKUb7a8kU=;
        b=e1XMq5o4nVjdrq2Dg2ZwpWwx9n814Hxizvb+CjzbUxuGLVeAf/tPAT0hPYie3v1tYI
         AlvCw3yuRJVLJHqvWt/dgV5M3ZObH6CwMraoLNvgVPx0tXt7n/i9hByRtERZujO+6yuK
         XLCM/k4p20wRKJag40+kx07vmDr3nKjGZVCWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0EoW6/M0CSM4gvZ4wT30NMjrEHjHBg5QS0vKUb7a8kU=;
        b=Xh4jQCXlNigK7Xra+xoJvtgRD+rfgmg/DsJtQW73UFlcKiRQnaVqNttYkjDT8uMqxq
         wvExZrrkmP3d+YpnX/4RtMfKsqLLRRwWbVSP/ZHOkawx3WtLrUdXzNQUgThDIyS/mL+1
         SOX8fK5V/S9rNPFP1LjXYJFF3SWfpoAiN6uLq0oOlk/qR2khCIKdUUY1QcgcaIouJ5Z2
         +U1ANAktESXPYMaQ+gXx7G0rLePJcS3IZBt/kK36oy1tYWfVBZvlkAAAvnwHSVU5Y2xZ
         7cIcjWj+Zs67CIt2qO/3yWpb0aMNft2q25vieCSDgac0dWBIQE+8uNgREa9X6ez6/Vqv
         Gmkw==
X-Gm-Message-State: ABuFfohgRVCmd2uN62D2jGVSt7yrV/lVZ8ruX73n1NXUys8Ax181O1cP
        OHiFx8InMKy5kH2suoz7Rq/LWw==
X-Google-Smtp-Source: ACcGV62S59jHE1tfOWIZ8Ts2rgke18f4aHKnzGrdLP7TjP7zp65sSehxbq/pO1YJOMvsUvRhNV8XNA==
X-Received: by 2002:a50:b765:: with SMTP id g92-v6mr4859841ede.94.1538602841271;
        Wed, 03 Oct 2018 14:40:41 -0700 (PDT)
Received: from [192.168.0.189] (dhcp-5-186-116-96.cgn.ip.fibianet.dk. [5.186.116.96])
        by smtp.gmail.com with ESMTPSA id gk1-v6sm500190ejb.37.2018.10.03.14.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 14:40:40 -0700 (PDT)
Subject: Re: [PATCH 22/22] x86_64: use relative pointers with dynamic debug
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
 <20180919220444.23190-23-linux@rasmusvillemoes.dk>
 <20181002095055.GC98058@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <76d66929-0c3d-4251-f315-f034405a71ff@rasmusvillemoes.dk>
Date:   Wed, 3 Oct 2018 23:40:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002095055.GC98058@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-02 11:50, Ingo Molnar wrote:
> 
> * Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> 
>> Similar to how x86_64 uses bug_entry-relative pointers to reduce
>> sizeof(struct bug_entry), the same thing can now be done for struct
>> _ddebug, saving 16 bytes for each of those (i.e., each pr_debug, dev_dbg
>> etc. in a CONFIG_DYNAMIC_DEBUG kernel).
> 
> Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks! Can I assume this also applies to the latecomer 23/22, which I
think I'm gonna squash with 22/22? Then I'll resend the series with
various tags included and ask Andrew to pick it up.

Rasmus


