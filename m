Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407C2C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED11320852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6PHmBsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED11320852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389025AbeGXUin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 16:38:43 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35328 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388597AbeGXUil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 16:38:41 -0400
Received: by mail-yb0-f193.google.com with SMTP id x15-v6so2081121ybm.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 12:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JbYRo0RGKTHyd0pBO4zKn9pHWLbxTZO+OYfNY6aQj84=;
        b=F6PHmBsRTxJQIi3CDBpeCe7adTg9XwfMjnknaumb8O3iD1Su7sexeyzxZOZ7+uHprC
         0yfEEtNZQIJrpr5epRXihItf2GnU9JqStObHKvTEqyvDy5BRs3He9Lvf1VJ4qke3FERy
         n++8dIPxz1fP8EArJpnyawdIH56RbLHgW4cT4dDpdERjm5MghcIrU6Ck1cee5YU+3e9h
         yTPGn8jEVEmCiM/5FUgqwVRpX8jRI2K8Cf9qvkW1WfDjFSMAB4KN/QaDAJqLnMxN9HK1
         rXOrk3deEmCn4ZeUmc8B+xCCrMkx7vi7ZtH4S8xwZtFYpI20jzK6rgKnKriAibUA/fqI
         RRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JbYRo0RGKTHyd0pBO4zKn9pHWLbxTZO+OYfNY6aQj84=;
        b=EGX8xoUepOj2Nx+ATdqkp6m2GlruWYXAHzR9O9B2G5J6zz0iEy6qpxnakwe0Eq9SgL
         Xu/mwnGf5EhzXL+Q8lfGKU5gPbImLI7uxx0xpsFVrvEiA9w6q00qJCMM3kTi6go2+QeL
         ufSIrnhwiJH/11LSBvl7K43kQmp8aObf40X34y4dZ2LimjZ916E5py6hHevcNTFWBiAJ
         lrCdKMLfOSwjhxmgFPoAa6mrS83uXZ+u3kEXYwQfp82SHdtIM9A8PXeXIaSBMfsfvLzS
         eBDslWh5Fo2fldrl+qbo7vt8OBvXkkmPd5+B79QRlN9tUwvaSlWjLisrqZiRPmbMh22h
         IQgQ==
X-Gm-Message-State: AOUpUlHyyk405NchEOtaFmWoaTjAXpCw/p+2uNGGNiJQHWxH53bnbNfA
        YLAHvLFqhe/fUcWMjDvGMek=
X-Google-Smtp-Source: AAOMgpcBI35DigAi8/IKNcVtt8E7FCbyWrtAIUd4UvvOUWquhkjn6uVS7+xAlxV8AwNOtdQZvlS4Xw==
X-Received: by 2002:a25:22c1:: with SMTP id i184-v6mr9910767ybi.479.1532460644382;
        Tue, 24 Jul 2018 12:30:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:b2d5])
        by smtp.gmail.com with ESMTPSA id a188-v6sm2619078ywa.89.2018.07.24.12.30.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 12:30:43 -0700 (PDT)
Date:   Tue, 24 Jul 2018 12:30:42 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] delayacct: Fix crash in delayacct_blkio_end() after
 delayacct init failure
Message-ID: <20180724193042.GR1934745@devbig577.frc2.facebook.com>
References: <20180724175542.GP1934745@devbig577.frc2.facebook.com>
 <20180724122913.af508cf58033e9b1147e7def@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724122913.af508cf58033e9b1147e7def@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andrew.

On Tue, Jul 24, 2018 at 12:29:13PM -0700, Andrew Morton wrote:
> How did you make this happen, btw?  Fault injection, or did a small
> GFP_KERNEL allocation fail?

We have a group of machines which are pushing memory really hard and
this actually triggered in prod on several of them.

Thanks.

-- 
tejun
