Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEF0C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44B32083A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44B32083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbeIZCnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:43:18 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41489 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbeIZCnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:43:18 -0400
Received: by mail-yw1-f66.google.com with SMTP id q129-v6so9875036ywg.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dVo2dBS5F/ZjqrcYMAwjqrxB3r5sWM9RMXB00RAf3+A=;
        b=sos5BLLTKQBZBxBZJkdyTfGG+Z8PbhL1M0DDjyrd193Q8vWOxvrgR9yDHCkSFhdzhC
         9Gv7We55qAWoVFWlxClmYRpWJBdtxm25FHGcLhnuDb/XWILRushFyHyT/FoSmO6jrdXD
         3s5C4UA7E7HkYP0vZUJEslUT9+SaIb3fMlkPDAguNfXSerJR5IsFDhh/62UIoVd6Ptoc
         tY97/pvJRfn+p7LbSW+iqNsYTWzqWolrqPP9V1uhLYm/k9vF1XMCr6pIbaJr1ELxwyzG
         Xc8/eBVmVGYzGR1bx/7ETEnvulCrf5NkQqAbXCQyA7ZUu6yPtjvh1vmJvv03J/Y3vSB6
         MvTg==
X-Gm-Message-State: ABuFfojVgoROsWmDpI+Qh0v9pI0gjxN0i7w44XkLlW7EoGzoiKas4a6E
        MPLFr5nQ9mBXHg4KMwez754=
X-Google-Smtp-Source: ACcGV60wXwG58QmAiF1hOrI8teipKV0RQwqvVhL66JmoRNmD4B8Q5Bg9PADCJUPmQMZeisggkC6ESw==
X-Received: by 2002:a81:508b:: with SMTP id e133-v6mr1539770ywb.222.1537907638674;
        Tue, 25 Sep 2018 13:33:58 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::3:9734])
        by smtp.gmail.com with ESMTPSA id t10-v6sm1263547ywg.74.2018.09.25.13.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 13:33:57 -0700 (PDT)
Date:   Tue, 25 Sep 2018 16:33:55 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] arm64: percpu: Initialize ret in the default case
Message-ID: <20180925203355.GA61443@dennisz-mbp.dhcp.thefacebook.com>
References: <20180925194459.13088-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925194459.13088-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Tue, Sep 25, 2018 at 12:44:59PM -0700, Nathan Chancellor wrote:
> Clang warns that if the default case is taken, ret will be
> uninitialized.
> 
> ./arch/arm64/include/asm/percpu.h:196:2: warning: variable 'ret' is used
> uninitialized whenever switch default is taken
> [-Wsometimes-uninitialized]
>         default:
>         ^~~~~~~
> ./arch/arm64/include/asm/percpu.h:200:9: note: uninitialized use occurs
> here
>         return ret;
>                ^~~
> ./arch/arm64/include/asm/percpu.h:157:19: note: initialize the variable
> 'ret' to silence this warning
>         unsigned long ret, loop;
>                          ^
>                           = 0
> 
> This warning appears several times while building the erofs filesystem.
> While it's not strictly wrong, the BUILD_BUG will prevent this from
> becoming a true problem. Initialize ret to 0 in the default case right
> before the BUILD_BUG to silence all of these warnings.
> 
> Reported-by: Prasad Sodagudi <psodagud@codeaurora.org>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

I've applied this to percpu/for-4.20.

Thanks,
Dennis
