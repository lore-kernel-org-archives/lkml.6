Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AB5C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8A621905
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="UxdE3qLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732946AbfAaMmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:42:22 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36163 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfAaMmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:42:21 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so3888167itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 04:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+8OimEZK+nvUGYMGgExdl/AUY0m0epPoJrl3+Raiob4=;
        b=UxdE3qLS4su9YSyDf/feLJLgNCoz5ihFoa5h30YObCQZAWajYwdK1W9OHqVZQSUsOi
         aHJDi5Jn0g4nDtJkwhTM2c04/vG6LeiV+pQ0ejoMsbe5vTZ/mai3Tbxuh3V1vf23nkff
         WFoeAyBjobVLQRxVjNlcuLtxourSIHINTWKEIXWvoGbRhy3yA214mEvtzZfbzpK8ruaf
         xPKgL0mUcOUJKpJytEEgkhqlWG3KkcAoQrr9HExzEJxE1g+Vy+xMLEcO0raoyIeRb5LK
         Cdxg/5gu1w34bg5qqxxKBzaMIkHlTtas8YK5Pv811yijeIQVqYPS3KPmsQJkABxR3VDv
         /c8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+8OimEZK+nvUGYMGgExdl/AUY0m0epPoJrl3+Raiob4=;
        b=OUuV/j5hs48zYY7Vrdy9YNuR8IqqpQrfyl/JigNTsXEr9lTRrIX+AEcQSmlfdftqsh
         RMpFd0A1gWCxADQ84qaQ2exxlEnZVWRblo5UTsfEaGkyVooDpx7wYSgPxj/YrxzRdFyU
         zeqHgZNTlP1lb8TT2Ja8PJMtPYgyAv39e8I6d/2JKdUmFW47lgV31Sn1KdkoGUzpfTun
         bkSeCkAYDx8vTT9SOGUBEY3yOYqopZDHqaDhd7zZZw0+3kyl0flyZzTu7fl9F9KmWn/O
         jxavho+zHh1Tmt7F0OHeqnw7YgzSoeSsOW0Et1xWkToguT2I+3xrAVIRwAIcPyw5Vaze
         PU8g==
X-Gm-Message-State: AJcUukf9O2Rk8jpdBVMU2idjh0UoC0foSLzgpn1tGh4C/zfHRDXLKUmx
        /BOUezqB2ugrho90S8eCllbXxiAzrIg=
X-Google-Smtp-Source: ALg8bN5k2gNyymdM2hQQaVR3sRrbjIiXHUE9os0ZukyUXtVBUeFr6sGl8vnLcUtiuIg0/Neofz2vPw==
X-Received: by 2002:a02:c08:: with SMTP id g8mr15297195jad.127.1548938540774;
        Thu, 31 Jan 2019 04:42:20 -0800 (PST)
Received: from [192.168.43.100] ([172.58.139.116])
        by smtp.googlemail.com with ESMTPSA id t69sm2946187itb.26.2019.01.31.04.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 04:42:20 -0800 (PST)
Subject: Re: Commit 594cc251fdd0 (user_access_begin does access_ok) made
 arch/sh stop booting on qemu.
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <51e0329b-5d0b-1099-54f3-b51a34b6b216@landley.net>
 <CAHk-=wgTxAaviY-WuOKtAd8f4XpE7WF43aaO8F9-CgyowyxSfA@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <77f57f50-4460-8997-756a-6d6f45504cb5@landley.net>
Date:   Thu, 31 Jan 2019 06:42:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgTxAaviY-WuOKtAd8f4XpE7WF43aaO8F9-CgyowyxSfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/19 2:30 AM, Linus Torvalds wrote:
> See
> 
>  
>   https://lore.kernel.org/lkml/CAHk-=wiHe4dNHKpE4oGhwwmy23jNTuuFQAgWTGCjjxyOVYjG_w@mail.gmail.com/
> 
> for an explanation of the SH bug.
> 
> But Guenter Roeck confirmed that my patch fixed it on SH for him. Is there
> something else going on in your configuration?

That fixed it for me.

Thanks,

Rob
