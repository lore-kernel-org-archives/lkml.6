Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4629FC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EF020647
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GxUF/0dS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EF020647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389693AbeG0WNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:13:32 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46417 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389317AbeG0WNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:13:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id l16-v6so4373656lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 13:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/QJWZlYHIDgL0FeyaIGnkpso5IArjmSJPu3XTkHeYpU=;
        b=GxUF/0dS36A5i4XrBcawVWSBgq5k+QN5AsQhMvmVFS3FdpUPZr0XmW3ZzeloSRd1la
         il23bdWv1r3ivVODJcdvquQ0n0Eas90ZzzUjubh8EiDOAyR2oK/c7jJ9L09yos1xuCt8
         uNMV004I0Hr2t7hzgJsw9zzKg1dzvnYdzw8Fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=/QJWZlYHIDgL0FeyaIGnkpso5IArjmSJPu3XTkHeYpU=;
        b=WypQSein3mHzV2AKuJoG/GyHhz7C6WULvkTt25AXjuDYip1L3bh2V+q2Ptt9PSXRou
         kMNb8bU6uJsJXc/ywHaNqUOpmzbPnUnqirxRiNIpWyLk/1dQwpc1e0ktNj5yyuT/S3rV
         gOquvelacRiLdTcURE7pvJrqI7Hyn3PzFBjUvcxzAG5Algvg+tP44HZXBqjMQC/rL8xz
         ey7fKcQKm6XxNUDUwVK4ZVd7453Z3NyI9StBGjNw+x6PL5pB7myfur4mLEDElXlMkpmz
         MEYj3T2/Zh1J4zyvC6iSuhGoM+BIgL35YMX/wsNs9eRRsmVSKyMNHLS1UpLobE5B33Iu
         3ppA==
X-Gm-Message-State: AOUpUlGdpMHRNkcpn1eBYfRoKNhPJ2GkThiGRHW6smYsuqEc7x2uK49R
        m68+oUqvi2KnDvZSTQqwzatcbA==
X-Google-Smtp-Source: AAOMgpcIDCw8cK2qcQlqzL1Dub2MsvHPPxxEpHNaNSUlbWBJrb5XgM+1ZBfFDCAXMKV7/kIbQzOBeg==
X-Received: by 2002:a19:1c81:: with SMTP id c123-v6mr5124230lfc.105.1532724594201;
        Fri, 27 Jul 2018 13:49:54 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id w2-v6sm814181lje.73.2018.07.27.13.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 13:49:53 -0700 (PDT)
Date:   Fri, 27 Jul 2018 23:49:51 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     grygorii.strashko@ti.com, davem@davemloft.net,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: replace unnecessarily
 macroses on functions
Message-ID: <20180727204950.GD2619@khorivan>
Mail-Followup-To: Andrew Lunn <andrew@lunn.ch>, grygorii.strashko@ti.com,
        davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180727191318.18698-1-ivan.khoronzhuk@linaro.org>
 <20180727203203.GB17441@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180727203203.GB17441@lunn.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 10:32:03PM +0200, Andrew Lunn wrote:
>> +static inline void cpsw_src_port_detect(struct cpsw_common *cpsw, int status,
>> +					struct sk_buff *skb)
>
>Please don't use inline. Let the compiler decide.
>
>       Andrew

Corrected in v2

-- 
Regards,
Ivan Khoronzhuk
