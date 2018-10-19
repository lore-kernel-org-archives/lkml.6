Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1C3ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907DC21479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8F2k2bx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907DC21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeJSWI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:08:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40012 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbeJSWI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:08:57 -0400
Received: by mail-lf1-f68.google.com with SMTP id t22-v6so25325295lfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 07:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pEaq2WADQ8QhQo85ktbko2SRiMC6j426PMsstb1Vrso=;
        b=e8F2k2bxtyT/9qqMi6YX7WTno+Dnjlqle4KnJ7WLDJChLYDqKUFf/5rJ1F3G/Zv/dz
         2wNnwCMQzyYvsKRSGibhoqJ5PxhWk4IhcZQMh5yEpvPnixzhXYWPoJhE8a/mHS7V6pWp
         hV0NGjz/iZisx05SDvWmpn3UPBe1VsQ/OMJYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=pEaq2WADQ8QhQo85ktbko2SRiMC6j426PMsstb1Vrso=;
        b=HTcAnyEFtc96CCL+BNSUvP9KDb6b3QX2Ojv4WkQH8YMQX7lSIe0X1HB+T9/XeBwMr7
         vC/BjFqLDGzZKySOUHtjXmTmA0nDA5GkH4Em4cYUGKX/sL4V9O6SMpa9XWp2LjTbQLsy
         HQOpGNIw8boTmqd2ve+yAGAXf1LhemIDj1hU9mHiUqP8sATc9jelkTRGQjq+3SDGiuU1
         St/5kQ43XmqlHnuG4piqt27SYj6ovsWgX/AItlAoejqfltiJ/4ydsI2E5s4TqItabajC
         RgEmCnp7LiLMSjGu8DOkNCnkk1aRxxZf1mAmc/KgYY8XQQwMW7WbzdJ1YlhEjHoP0oR4
         yh6g==
X-Gm-Message-State: ABuFfohqXYmo3ZNSMTLCa7yBj/DbVQqJqBK28LH3xfvfzUUEEM+OA2gT
        1JovW4UPs+qThcoUTkd0z4ynQw==
X-Google-Smtp-Source: ACcGV63GulBBwtdR+HMFch2gCIvXuAYuvJlHfstM2zq7L4sADtusR8070kxWNZFySOA/rfMd16grlw==
X-Received: by 2002:a19:f115:: with SMTP id p21mr2352014lfh.20.1539957759579;
        Fri, 19 Oct 2018 07:02:39 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id w1-v6sm5016812lfe.93.2018.10.19.07.02.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 07:02:38 -0700 (PDT)
Date:   Fri, 19 Oct 2018 17:02:36 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc:     grygorii.strashko@ti.com, davem@davemloft.net,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com
Subject: Re: [RFC PATCH net-next 2/4] net: 8021q: vlan_core: allow use list
 of vlans for real device
Message-ID: <20181019140235.GB3909@khorivan>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        grygorii.strashko@ti.com, davem@davemloft.net,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com
References: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
 <20181016182035.18234-3-ivan.khoronzhuk@linaro.org>
 <878t2up4er.fsf@miraculix.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878t2up4er.fsf@miraculix.mork.no>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 01:22:20PM +0200, Bjørn Mork wrote:
>Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> writes:
>
>> @@ -236,6 +239,13 @@ __vlan_find_dev_deep_rcu(struct net_device *real_dev,
>>  	return NULL;
>>  }
>>
>> +static inline int
>> +vlan_for_each(struct net_device *dev,
>> +	      int (*action)(struct net_device *dev, int vid, void *arg),
>> +	      void *arg)
>> +{
>> +}
>> +
>
>
>This stub should return 0, shouldn't it?
yes, it has.

>
>
>Bjørn

-- 
Regards,
Ivan Khoronzhuk
