Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1744E16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB41020857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hpQ06qRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB41020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbeG3SXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:23:01 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46541 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731687AbeG3SXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:23:01 -0400
Received: by mail-qt0-f194.google.com with SMTP id d4-v6so12777694qtn.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bGPmtzeDCSxhHTxoCpLKQTdmtJmVPaUX8g3u/Gc8gjo=;
        b=hpQ06qRQe9Z1onLUofidRiwNzxAHujeEf3n/Ohe/RWG9gbdDJV+Ez9cSOUyjWxRzLJ
         jexsaB0ARFkWMq1VDD++I2nQCXVErTWFKN/zUb0Y3zy2U0izJGNy1EfKIQVTDHtoVd+O
         Cq/o1daLt/8MZIt5kkx6s56cQgtRGxmdLnrqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bGPmtzeDCSxhHTxoCpLKQTdmtJmVPaUX8g3u/Gc8gjo=;
        b=DlgslITiVdSCDbv4jY0H8WNtss7t01HgWcURX4YzTWaBcL3TtUNgy5YWzpj/fVRSEX
         B68KXNJOWWWjPQ2K++7PEzGvP6w53HykSHDQkl/ETIPttNKvAg0GpGkSsp3bLkN5QW1W
         3DJ/xLX83cbHkHOcFPfIRkDCUnIC+MRmXNLiwy2g9TFA5oiHU4QCLfmuIEOkjyv50uyf
         1ecQMiu4x5akZNGTAJW9pKKWv+cEKCzGnJdNi4pIeByBwFQeWtcnaxC452bkyoZbq6OV
         p5n1gADC8FbVe4Pv6eooVyG+iaHBzcolISGiQ/+GvHT7bEOvDbcQhgu9tRZRioDXzLzx
         uW+Q==
X-Gm-Message-State: AOUpUlHcheIBtMKaaq5+hsqvtrIm7wMm1KBLlz0/lJmdoz9K0rv2o3dq
        qliP5s2Q/VWSxB3Ut7uPSFIMrmxXvVqiKQ==
X-Google-Smtp-Source: AAOMgpd9MCJDI1LT742sKQZc70MGjzpn4dQ7MBU9lY1b72WUpjiEp2/E+jgs2JSMaIAASH4pnHoJCA==
X-Received: by 2002:a0c:c78c:: with SMTP id k12-v6mr15342012qvj.99.1532969230809;
        Mon, 30 Jul 2018 09:47:10 -0700 (PDT)
Received: from [10.136.4.147] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id w79-v6sm9631735qkw.35.2018.07.30.09.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 09:47:10 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-7-git-send-email-arun.parameswaran@broadcom.com>
 <20180728000303.GA23816@lunn.ch>
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
Message-ID: <b7b62b2f-2936-c8d0-3443-66d00713db20@broadcom.com>
Date:   Mon, 30 Jul 2018 09:47:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180728000303.GA23816@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

On 18-07-27 05:03 PM, Andrew Lunn wrote:
>>  static void mdio_mux_iproc_config(struct iproc_mdiomux_desc *md)
>>  {
>>  	u32 val;
>> +	u32 divisor;
> 
> Hi Arun
> 
> Reverse Christmas tree please.
> 
> 	Andrew
> 
Ok, will send out an updated patch.

Thanks
Arun
