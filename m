Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6338C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 14:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8612E218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 14:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sy+hDwYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeLZOf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 09:35:58 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:35198 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeLZOf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 09:35:58 -0500
Received: by mail-pg1-f174.google.com with SMTP id s198so7643819pgs.2;
        Wed, 26 Dec 2018 06:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=Z/S6rociO40WEylPX85eW/RoOKQQboxq9QKvp3/aISg=;
        b=sy+hDwYagbeUn0MIlNUT30OWQesqLqY9AXTgWblCGjbi7XJQSyD2JPw0LVq0guWVfu
         AhSATt5ePooMaADmNgAfH9a/E9NeqmClj14vEnA12oq0aNusg1iOTtazUo/NlVt+ii0o
         lIlu0mkWyL12EYXkxq9G/vnQySX5V6l1KgjwRkG0xTdLDO/BbVlPOgg0epm1s0xM34p/
         fHSpxIw+ZPc52tVfmxjBYNTi9Runm2uce5QVaGfiJWhwHHBTBkRwwfAZtM8PzPygghxH
         4UYFfQuBXuoj8I2uRRBXpKQ3xVha8JiiV/g4/4ecXR1RnTHqEw7SFCnB5uO6u3FP244V
         MV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=Z/S6rociO40WEylPX85eW/RoOKQQboxq9QKvp3/aISg=;
        b=tufy33esZ9vbubkOKxE0zMFYwpScIAJ+t3ukiA0F6IG4NzS7F2M7D6UEtHPSpXv3oC
         c5Tt0cHyOmLks88qt4hn8/UdwwcO1jSdKR7zBn+O984mwX6ObN3x0/UieBPt6udLsLc7
         Dp7/GQAqatkpyB9Zye7fzjMhZNh6Gt16ZNUNYz5oPHXbYyc5nIsziV09Ei3GB65YXwrg
         TtnwslExCwYjnXVnee4mPEv1/WAXF8p8jsxaKpoarlyF3g4rS3Gx8EheL41aZ3UzFkce
         7W+r7hEiTLERqLYi2Iy1d3LPOgkSMFfRx8Re8HUnfvGaGVFmRU1Rfd9V5RiF5NWw6WGs
         Zcaw==
X-Gm-Message-State: AA+aEWa9g4feC8/r7/T4lHcP+7/uZVWIRe6rN4fbZ6HDvGab+PmlR5ee
        4uE1xiF0pwkE4n9+gxN8c+IPLCWo
X-Google-Smtp-Source: AFSGD/WFyfd759kWIOR18bBbbpKVtoCp+DWffJgGffKuAYl5dLrNY5Hqjf0SwZMTVtRqVUciFQWuKw==
X-Received: by 2002:a62:6b8a:: with SMTP id g132mr19973225pfc.201.1545834957065;
        Wed, 26 Dec 2018 06:35:57 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.49? ([2402:f000:1:1501:200:5efe:a66f:4731])
        by smtp.gmail.com with ESMTPSA id i184sm49434544pfc.41.2018.12.26.06.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 06:35:56 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] net: brocade: bna: Possible concurrency use-after-free bugs
To:     rasesh.mody@cavium.com, sudarsana.kalluru@cavium.com,
        Dept-GELinuxNICDev@cavium.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <f04fa5fa-c340-5afe-a5a1-52806c7981a3@gmail.com>
Date:   Wed, 26 Dec 2018 22:35:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/net/ethernet/brocade/bna/bnad_debugfs.c, the functions 
bnad_debugfs_read_regrd() and bnad_debugfs_write_regrd() may be 
concurrently executed.

bnad_debugfs_read_regrd()
   line 293: if (!bnad->regdata)
   line 297: simple_read_from_buffer(..., bnad->regdata, ...)
   line 300: kfree(bnad->regdata)

bnad_debugfs_write_regrd()
   line 335: kfree(bnad->regdata)
   line 338: kfree(bnad->regdata)
   line 357: regbuf =  (u32 *)bnad->regdata

All these accesses to bnad->regdata are not protected by any lock.
Thus, possible concurrency use-after-free bugs may occur.

A possible fixing way is to use a lock to protect these accesses.
I am not sure about this way, so I only report the bugs.


Best wishes,
Jia-Ju Bai




