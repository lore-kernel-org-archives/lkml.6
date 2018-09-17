Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0E1ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 01:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88042208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 01:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xn6cRDwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88042208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeIQG2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 02:28:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53043 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbeIQG2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 02:28:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id y139-v6so7536227wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 18:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hiV+ijeh4HnsxpYfb8kP050hNtXZFsLt0pk7mL5EDws=;
        b=Xn6cRDwShA8SNRk6cSyJc7BVWCNALBt6u11eWPXQhx7vJO2A1LF7+dzOyR+mNJiFeG
         O1nBO8NCThJXE4FbpMdRWD/EoRtMjdeh3rWTeJggNoB4LnHV9PuiouSYKLuflvKj6Ijz
         LTNHizX8IDAC4kElD7zOPCZkRa6Q1IYjyZc3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hiV+ijeh4HnsxpYfb8kP050hNtXZFsLt0pk7mL5EDws=;
        b=Dno6Zc4YCumcH2PFZXlbBGln/LP5gmiKwb5PKtN5LQiGsuLJf6b0VoHfvDRWm8IAhT
         H/sG8sXmNVFOKqLQm9zvXFKMijsHQB5wFj+eAeWEhFaJhoXeK0bOzzxs0WuUUJ2u+yHh
         6g3m/KqBh0Al9UyhFruseZsLTRrhNgxlQEY8rof9zRQxypoNV/fJlXRKSPjdmALkM1WQ
         l20YForvmK04l3GUMh8vfAKJU2nXblhesTQADmI+ePd9B6gBvfsLqRFzqqBL6Yqc2WUg
         DmJtTyTJe5Cw0bJyhppYOzzAcusKdSHIk2v+D9+evm1aINC87l6rhDL8nzThomj4CUVY
         WwVQ==
X-Gm-Message-State: APzg51BiOAaGTFXA+Hw93qFIHUdNdVTTSQMk656GSar90a5uDStAlptr
        yk/NWr5IbxKBJ/qDKHd83buiiw==
X-Google-Smtp-Source: ANB0VdawENPztDhcuPpafkmE5PZ6OvdCze0UmM5FqdqQ8Al64YiM0Ym/gqgyiDnIgtGECquefpeIgw==
X-Received: by 2002:a1c:e289:: with SMTP id z131-v6mr9504453wmg.32.1537146230612;
        Sun, 16 Sep 2018 18:03:50 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id n5-v6sm4513630wmh.1.2018.09.16.18.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Sep 2018 18:03:49 -0700 (PDT)
Date:   Mon, 17 Sep 2018 02:03:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] mfd: ezx-pcap: Possible sleep-in-atomic-context bugs in
 pcap_adc_irq()
Message-ID: <20180917010340.GA3900@dell>
References: <f83a444a-1943-6c8c-5cd4-88e2acb17fa6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f83a444a-1943-6c8c-5cd4-88e2acb17fa6@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Sep 2018, Jia-Ju Bai wrote:

> The driver may sleep in an interrupt handler.
> The function call paths (from bottom to top) in Linux-4.17 are:
> 
> [FUNC] mutex_lock_nested
> drivers/mfd/ezx-pcap.c, 272:
>     mutex_lock_nested in pcap_adc_irq (interrupt handler)
> 
> [FUNC] mutex_lock_nested
> drivers/mfd/ezx-pcap.c, 100:
>     mutex_lock_nested in ezx_pcap_read
> drivers/mfd/ezx-pcap.c, 281:
>     ezx_pcap_read in pcap_adc_irq (interrupt handler)
> 
> [FUNC] mutex_lock_nested
> drivers/mfd/ezx-pcap.c, 85:
>     mutex_lock_nested in ezx_pcap_write
> drivers/mfd/ezx-pcap.c, 285:
>     ezx_pcap_write in pcap_adc_irq (interrupt handler)
> 
> [FUNC] mutex_lock_nested
> drivers/mfd/ezx-pcap.c, 244:
>     mutex_lock_nested in pcap_adc_trigger
> drivers/mfd/ezx-pcap.c, 299:
>     pcap_adc_trigger in pcap_adc_irq (interrupt handler)
> 
> These bugs are found by my static analysis tool DSAC.

Not sure what you want me to do with this.

Do you have something in mind?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
