Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19209C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA60F2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA60F2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbeJ2RcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:32:07 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40894 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeJ2RcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:32:06 -0400
Received: by mail-ed1-f65.google.com with SMTP id z12-v6so743238edp.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 01:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ajumEsASgZT9eBRHK4nLQlcsQovJ+/WEFGfGS0sTCw=;
        b=q8lodT4A63JILnWLgt2QiAd8LJc2LSFApSwEdxoADS6t4xxEPh6/NxQ6934ui2AoCc
         gnKhLJnVffbspyTcpcclvdieL6nqjoh9FVe8Hpp2xqjMEtL9drVzhkayRdlQWNmQI2Ti
         3EyPO9Dk2dTlRQQip0Sj6Qu9zzmUut/WxkSM4awTLPQFXLZNRCMmecEI0f7+ZsKtRo90
         nme/ld87St3h3GByOdgoLia3WgMvp+vF37CO0MtyovOjS3xpEMMWS0fS5S2M7HhKuHtl
         EFUKcWNCBBTVjkczExSnIjuRWq//mTw0FK8/5cqFyRVDL48roUxV1+c6YGD0QZwBjGVw
         ARJg==
X-Gm-Message-State: AGRZ1gLtvQmOribWb0P1zgYRs2Cf+v0hCJNRO0hGwgEfSQwzhhdzWDEM
        OS0SzB7DRj4DastXWocz4gBYZS4U
X-Google-Smtp-Source: AJdET5fVYvTkzltlVfntqbZR3F8Tl5g4TcrVpSmLq5Wl+a1TacHULfGROrH1jzkZuA5t+R6Sun/PMA==
X-Received: by 2002:a50:ca47:: with SMTP id e7-v6mr12711139edi.56.1540802665677;
        Mon, 29 Oct 2018 01:44:25 -0700 (PDT)
Received: from linux-x5ow.site (nat.nue.novell.com. [2620:113:80c0:5::2222])
        by smtp.gmail.com with ESMTPSA id l52-v6sm6574375edc.10.2018.10.29.01.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 01:44:24 -0700 (PDT)
Subject: Re: [PATCH] mcb: fix a missing-check bug
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, open list <linux-kernel@vger.kernel.org>
References: <1539961894-11928-1-git-send-email-wang6495@umn.edu>
From:   Johannes Thumshirn <jth@kernel.org>
Message-ID: <5d09862f-e903-169e-9b11-310d4a1fd01c@kernel.org>
Date:   Mon, 29 Oct 2018 09:44:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539961894-11928-1-git-send-email-wang6495@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wenwen,

Sorry for the late reply:

On 19/10/18 17:11, Wenwen Wang wrote:
> In chameleon_parse_cells(), to parse each cell, the descriptor type 'dtype'
> is acquired from the IO memory region pointed by 'p' through readl() in
> get_next_dtype(). Then 'dtype' is checked to see whether it is
> CHAMELEON_DTYPE_GENERAL. If yes, chameleon_parse_gdd() is invoked to parse
> Chameleon general device descriptor. In chameleon_parse_gdd(), the data in
> the IO memory region is read again through readl() field by field.
> Specifically, the 'reg1' field contains the type information. That means
> the type is read twice. More importantly, no check is re-enforced after the
> second read. Given that the IO memory region can also be accessed by the
> device, it is possible that a malicious device controlled by an attacker
> can modify the type information between the two reads. This can cause
> undefined behavior of the kernel and introduce potential security risk.

Yes but this doesn't really mitigate the problem, does it? If a
malicious attacker controlling the MMIO space can change the register
contents after the first read, what stops him/her from doing it after
the second, third, 4096th read?

>  
>  	reg1 = readl(&gdd->reg1);
> +	if ((reg1 >> 28) != CHAMELEON_DTYPE_GENERAL) {
> +		ret = -EINVAL;
> +		goto err;
> +	}


Just an advice for your next submission, give that 'magic' 28 a define
(like CHAMELEON_DTYPE_SHIFT or whatever), this makes the code nicer to read.
