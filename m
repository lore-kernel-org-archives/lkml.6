Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62CCC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7DD21722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzllTMae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7DD21722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeHTTQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:16:52 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43449 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbeHTTQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:16:52 -0400
Received: by mail-yw1-f68.google.com with SMTP id l189-v6so6997656ywb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a5BIQ2pWF2RmzTeXue1BXmxXRolTxVgkMVfm4evtPQ4=;
        b=XzllTMaeGQWZq6mY6kTFriFRBtYVaPIfgGMMI7cux1sbw80jp7+jm7IG+/qMmRQrfG
         Tz7uEM1mSO9WuwHX9y0jO3kqcDazF8EIPKoMifI3x1gocP6dW2VdRLN85h2j1wrhgXtA
         Zit29xQbQhQH1xEsEqlbzx9XFbedftBuGu/sWgMD9NTbtCB0f50DRbrdGBD4ml+E4exQ
         fC0/iAsk1fQ2wi4Y8gwKlzEovo+snTrkBj1ad5eFfJx6CElOmb+9TUhfe45UkTr2E1Pw
         1jE4A13h77WCTZTgnthyuOii2ZArxl31SiCreugGOIhSdCmeSsEEBjRxMCa7Yiqrary1
         uH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=a5BIQ2pWF2RmzTeXue1BXmxXRolTxVgkMVfm4evtPQ4=;
        b=RHBmnRnPUQAJzGafcw/wg78eQXbzf2/czW95EQGYfxzftb9J12EInPpz2qmU4Cm5ba
         mJZGos5erNr84/TttrL4iDJAuPf+ebPGWZCrkBT9ntEUSPpYVvg7g7P+1w/UCC33nvqH
         WCTEWdZiWb8h1jYzE2hZ04740/v+uzZTNzy0GAK9JoAUc/ZUNvODdRL8chR3QlZUTAUv
         tlDqflZtUJ5v6pfYjYtumAyd+G8j+Orjkls8iPC2uBu8CtbhntgOVE1eA/qbZETcz8fH
         hi1T7UerTgluvv8g1Fl3lbCNhkokiGfboVpIgDqzQJTltcV8Aiev0SJQ2DsYecbOjOhX
         M/rg==
X-Gm-Message-State: AOUpUlE1TeK2aCJKveEl4b946XAe7oo6MBhr+yw/gsd2gd4Y2lTad9OW
        lOSBMufvHb7zP/+5PKnrjRk=
X-Google-Smtp-Source: AA+uWPwl6hn34zPUm88qtoZ2OwiGu3LVo/7zBjB7VzZlhsiN5B2NnY3At3dnVSZkL1KOT7QvN3z0bQ==
X-Received: by 2002:a81:6d4:: with SMTP id 203-v6mr5676171ywg.42.1534780839229;
        Mon, 20 Aug 2018 09:00:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:9c5d])
        by smtp.gmail.com with ESMTPSA id p126-v6sm4563205ywf.22.2018.08.20.09.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 09:00:38 -0700 (PDT)
Date:   Mon, 20 Aug 2018 09:00:36 -0700
From:   Tejun Heo <tj@kernel.org>
To:     wang.yi59@zte.com.cn
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn
Subject: Re: [PATCH] workqueue: fix memory leak in wq_numa_init()
Message-ID: <20180820160036.GL3978217@devbig004.ftw2.facebook.com>
References: <1533518439-3982-1-git-send-email-wang.yi59@zte.com.cn>
 <201808201205500126227@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201808201205500126227@zte.com.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 12:05:50PM +0800, wang.yi59@zte.com.cn wrote:
> Gentle ping :)
> 
> > The 'tbl' variable may leak when return in function
> > wq_numa_init(), and this patch fixes this.
> >
> > Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> > Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>

It's a kernel bug path where we might as well crash.  Whether the tbl
gets leaked or not doesn't matter.

Thanks.

-- 
tejun
