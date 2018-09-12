Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0275FC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8E52133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5TjUl6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8E52133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeIMCrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 22:47:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37972 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeIMCrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 22:47:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so1645956pfh.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 14:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jvHq+hJf2ypIovF5HUQy7sBsSsecJsR8m10zepqPKb0=;
        b=K5TjUl6K18qlNtKDtFy3cHihGG+Tsa2cM9ndXVFUSycndTehseG51IoU6iu9K4k1bj
         eRdosSApAcRYBHWJLmfjKSotnn7ayAHUBflU115UpWQZbzQmJhruLL+62muoekezuruu
         sVTnmMjIguarXzzXrTvIWN9rHvA+RGtYV4KAMoXb/wCZxNBb/EsZ2Xxv15I8ng9qiDE9
         X/C7zlzwSjPHdXC0T8yaEJqUbQJigWBjHzu++s+AfETyulPGCluehRmSaACQFCUnG690
         lzt5uHhmoFa7lU/dkUws3pwUxQdiHp8cSpcbUy8VJdc9iPuHrAEtfnLEdGEw4ocfoffk
         ShhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jvHq+hJf2ypIovF5HUQy7sBsSsecJsR8m10zepqPKb0=;
        b=g+QCfJJvAaZRH6IRGiTHdlQcywo1uZespojKFaFwSk4EB4kusZIFF6z1gTdBd/Wrv4
         dsD13LPGzA6ohpEP7I7ObM74Ssd/+Gufz3hmBRaqpMsnEz2XgO0fuGdRCBcW5822+x/K
         yYAOS8+fJVJo6NDo8+A6I9txHza5cWQrx8p8CZIdCxX3DT9nrMHeRImo5FTQiWEp01Oi
         PEG3kaSUBgio4GK27fNxa3lsLrA3FoJH2eAcIktan4YuAigxGSbbzXR8hWzSrT4JF7DD
         Q36IsTIyGACWlSYuF4IUxNhf5AGqegvakn63trbXSWLR1gUOhujEWUThuthwfv/4k1JZ
         e1og==
X-Gm-Message-State: APzg51ACEqS+cjUN8bv+3NxPk5htva54sTzvnr8IaYNh2+iNn+mG5U5S
        cY/vCLhg9dQuWzPCzHronFU=
X-Google-Smtp-Source: ANB0Vda7vIEh2QY7QZDlkOfleNsJN6Id8Irk6d4bE/ULieeTh9+pLcPbVx1yBYrV2orIDmCsO9/Chg==
X-Received: by 2002:a63:1921:: with SMTP id z33-v6mr4310064pgl.302.1536788466953;
        Wed, 12 Sep 2018 14:41:06 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id n22-v6sm4194289pfj.68.2018.09.12.14.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 14:41:05 -0700 (PDT)
Date:   Wed, 12 Sep 2018 14:41:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Claudiu Zissulescu <Claudiu.Zissulescu@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARCv2: build: use mcpu=hs38 iso generic mcpu=archs
Message-ID: <20180912214104.GA28367@roeck-us.net>
References: <20180912165817.GA5118@roeck-us.net>
 <C2D7FE5348E1B147BCA15975FBA23075012B0949BC@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B0949BC@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 05:06:25PM +0000, Vineet Gupta wrote:
> >
> > I use a toolchain based on gcc 7.3.0 and binutils 2.30. What version
> > of gcc and binutils do I need for the builds to complete ?
> 
> Hmm I have a prebuilt 2017.03 release of tools (gcc 7.1.1 based) and I don't see
> the issue above when building net/core/dev.o
> I presume your toolchain was built off of upstream gcc sources.
> Can you please post the output of your arc-linux*gcc -v
> 

I decided to build a new toolchain with gcc 8.2.0 and binutils 2.31.1.
Problem solved ... building with this toolchain works.

Guenter
