Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADA3C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999EA2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS1snP4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999EA2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeJJFDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 01:03:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46186 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJFDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 01:03:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id a5-v6so1445073pgv.13;
        Tue, 09 Oct 2018 14:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9YUynER2nFDXBxj1r1ahMkKmyjudWCGLZOQBEVjHmUQ=;
        b=TS1snP4icMy+cq+sajRfQGYrh9MzMZvK3w0edG2yjujG/YF2+wtNTGkr83ur1euHus
         qLXJ1ihmkPbKvhitqTn6M4+dNAqhrpGaua8X4BNxU7g4RZgjpcfqCeyd87ekOI8kcFcO
         aVBQxHlYZRgDolmLPFlWUWBoiHPBIRZcQpg6zPeacgYaAExr8dkIoZCS9f4ikJ3Ro+56
         GWNzoB804uudkwXV9DliaH56MrcMo09RDVDDUOHPpjMK1X5bLcFuIRYV9LIVAykBzHWj
         7lUCDJc6wzHRhab7PCswdCfIvidNErBETSjeeUNRDFt6CgZ9j7DxiUdmQgzjrBaExcuY
         Xh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9YUynER2nFDXBxj1r1ahMkKmyjudWCGLZOQBEVjHmUQ=;
        b=MbwzIgZFb5UuvIPSEM8JbZkG4lLz+HSrKoClKOy1PhS8aZcH7spYGjQdThoHSWtYn1
         aIVa2y3STSyRZNXrgn60MDsg/i39m76s309Rb/UYnY7U75ksCpq3B+N9J4wqXpqTNiWb
         pTfrK9ypy4c6VXziO6GCT+sJjjkkjlAorbdJnnmBEVq7bgPro9NxseRVzrWmJTL40dIq
         cwu6f+yOLW45CIkha7elWCi3Db7THV+mJvgiKuUE9SzpgW8kAb04C2wod7J/5MXnQ4lA
         NWNtrAKvvEfk9oNeZYSvXnB2grLZn75S2D4XVgjUiSRChG5PwW62a+NhysTMt5U4hlS7
         1DDg==
X-Gm-Message-State: ABuFfojUr/kNozbx0inlp7JqVqrBtl6LmL5HEm30P40u6gQLE8ELjExA
        MhirXvgQzy9UPRU2gqjYEZE=
X-Google-Smtp-Source: ACcGV63KeOf5M48bPwCX+q5WexPF0X2nMXMQ3QPtLmiyfO2AQxnUDH3BOgPgL7E3u/B4fPNvOg/tlg==
X-Received: by 2002:a62:4803:: with SMTP id v3-v6mr32788599pfa.89.1539121492885;
        Tue, 09 Oct 2018 14:44:52 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id n13-v6sm24059868pgr.73.2018.10.09.14.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 14:44:51 -0700 (PDT)
Date:   Tue, 9 Oct 2018 14:44:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     kbuild-all@01.org,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>
Subject: Re: [PATCH v3 8/8] watchdog: stpmic1: add stpmic1 watchdog driver
Message-ID: <20181009214450.GA13702@roeck-us.net>
References: <1539016176-4072-9-git-send-email-p.paillet@st.com>
 <201810090846.it9ed9td%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201810090846.it9ed9td%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 08:47:26AM +0800, kbuild test robot wrote:
> Hi pascal,
> 
> Thank you for the patch! Perhaps something to improve:
> 

[ ... ]

>     42	
>     43	static int pmic_wdt_stop(struct watchdog_device *wdd)
>     44	{
>     45		struct stpmic1_wdt *wdt = watchdog_get_drvdata(wdd);
>     46	
>     47		return regmap_update_bits(wdt->pmic->regmap,
>   > 48					  WCHDG_CR, WDT_START_MASK, ~WDT_START);

Maybe use

#define WDT_STOP	0

instead, or just write 0. ~WDT_START may be convenient but not really correct.

Guenter
