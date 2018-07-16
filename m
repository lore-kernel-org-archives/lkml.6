Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0903AECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901C520863
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OztOMSxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901C520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbeGPE20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 00:28:26 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40885 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbeGPE20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 00:28:26 -0400
Received: by mail-pf0-f195.google.com with SMTP id e13-v6so12258480pff.7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 21:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3bUYtYNlAFnz+X7ZBrVp+kpHY4ruCa1Ehzr9cn7vPTI=;
        b=OztOMSxSYYQ0dLsSivHoE3AV/INBabRVj5nPKCGMqWT97AEmZI7biydono00ozf5xq
         EIZrqx54azYjXN15xRac0ujj5fd9eul9tbb/JQ9/rbn2eRB/TXmEOjsjkG5IqaDfg5x8
         0cuUkTFVx8asE8hvP4QCvvVJcqVHLrQ5dVhpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3bUYtYNlAFnz+X7ZBrVp+kpHY4ruCa1Ehzr9cn7vPTI=;
        b=SnuFPnxK2MGhVuudVA5eMmQfBWMWz+8nuu4y3DrioquRuEDV+iLNiaqpBcscof1q0x
         h9t72DXZp/5VDzA9KYsRSYxbQnCorpP9eVRR/Ecpiz/P1FBx/1QqHkSdcufUbGhUHqU0
         J6Rsst2FemvZ7Aj9hB+281pnTjy0pDyp/dZqUjJjHCp9Y6DDuVzDRT7YGouw4oc9IkXN
         29EN2LdT+xprCOnq6WQ6ojQhFfvL2X3RDtUMM+xdexP5PcQfu0kfqhFxkZnsikcxdAwQ
         em1GtoyxL9pdJmecP6w8/Bdyb0Ne069FbJ3FdjIpBUb8PvY3n/Tb/YMOKOlkjyblGsHJ
         ZVKA==
X-Gm-Message-State: AOUpUlF27qZlSOcRGTNdaS76uH4crjcT/WYIVcfZRCMa3EoLFLUqd+7c
        XkszLQtCtUrqisbuGpq+STULCA==
X-Google-Smtp-Source: AAOMgpeyzUyq+IiS8aPSDvL+PfUvQNp0UKupkhakwpCkzMr7z/rombHFR1Y5DCNoT0sFABXnznPLYA==
X-Received: by 2002:a62:b40c:: with SMTP id h12-v6mr16627702pfn.18.1531713784108;
        Sun, 15 Jul 2018 21:03:04 -0700 (PDT)
Received: from localhost ([122.171.235.75])
        by smtp.gmail.com with ESMTPSA id z90-v6sm44245553pfk.85.2018.07.15.21.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 21:03:02 -0700 (PDT)
Date:   Mon, 16 Jul 2018 09:33:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg KH <greg@kroah.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>,
        "4 . 6+" <stable@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4.9] PM / OPP: Update voltage in case freq == old_freq
Message-ID: <20180716040301.ck5mssh25u7rnlvt@vireshk-i7>
References: <3717ee50c1f1f48cffcb1a2e41c04e28881776d1.1530521347.git.viresh.kumar@linaro.org>
 <20180710135912.GI1123@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710135912.GI1123@kroah.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-07-18, 15:59, Greg KH wrote:
> On Mon, Jul 02, 2018 at 02:19:47PM +0530, Viresh Kumar wrote:
> > From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
> > 
> > Original commit c5c2a97b3ac7 ("PM / OPP: Update voltage in case freq ==
> > old_freq").

Looking for this ^^ information ?
 
> Always give me a hint as to what the original commit is, otherwise I
> have to go dig for it :(

-- 
viresh
