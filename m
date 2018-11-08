Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C5DECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB6220857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="X+pyiBXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB6220857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeKICGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:06:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54863 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbeKICGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:06:07 -0500
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so1893857wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 08:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZCgvZXGzhiPiUR9nmkJpVfvqYrVP3dagzuJ60T+7Hx0=;
        b=X+pyiBXJ9tqy0a+lzo7aG9XP/Bv4DDfFDsAhar1ng6WWv1pCs9EBNM+EjaYuC/53FV
         YByvPqfahmC5Y1vx/wfYwccW+pCcEmLqDKqgr+/Alm9gTKrUIcpwXBGIIsqyjRqQ+ee6
         eG9E8kJudhOK0wU2TEU8mTHcgfMQxUMkpA7kIykMesnwXWR+OZhlupc4c3k1gwxJkZW7
         KhJNAR41EaHOLHwMJRljNX6NbInRUPSb4gpC3tdBL4CzRYw39j+lGaHbu1wh02RXodOW
         fatX3JztFYbDA+hm9H4IiasGAmaribgJ90H9k3tAy0cJn4Wou0YTvfEbuf0EtAGqKSni
         wUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ZCgvZXGzhiPiUR9nmkJpVfvqYrVP3dagzuJ60T+7Hx0=;
        b=GdslR3TzWVfSHZ92nwLYzVkiwhg2FRIEQOpOu1lp6h/mV6j7SN+yR7flxQ4gLIv2Cn
         p8YwJlfQSpr7uEX6ZZQhxTVfRu1nexA8LZ6kRpo5Qox96mRe5SqON4V0KgMe1YN0C4Ry
         wWXD3uSovQiG91paoNJDPDEfQtY5FfCtvY8WcDDEeOqTD1s6bQG8T4jUn2oJfJXCdIHe
         DPgT/0lzRSftMCf7b/dqmk2YTH8JS3xruq3mMRF1nY/1mbj7r/Zby/9BV5HTRW+uQFlv
         IkdD4c7oadLXIERQ+ejHTnLDxCQy/4+TFOv8hDqKTMYSSTuuMPcHhEG/mkLxZZK6iayZ
         QqSQ==
X-Gm-Message-State: AGRZ1gLB1KKpWHO2CWI0mWp/Lq/4fQo1/EH+dDAbZtdYg/fvryieoMpu
        FgE59GqXY/lchEbTt600YC+VKg==
X-Google-Smtp-Source: AJdET5eOFGG4p/K2+ciW8ctMuWNE7I+hStdNgl6Qproe7IyikKoTMW0HkiP2zx/A3bewcjcW89skCw==
X-Received: by 2002:a1c:dc86:: with SMTP id t128-v6mr1769455wmg.111.1541694590296;
        Thu, 08 Nov 2018 08:29:50 -0800 (PST)
Received: from boomer.baylibre.com ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 67-v6sm4132103wrm.32.2018.11.08.08.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 08:29:49 -0800 (PST)
Message-ID: <a52c64d6159c73e1cb97089ed051321f121f0467.camel@baylibre.com>
Subject: Re: [PATCH 3/4] Documentation: bindings: Add missing Amlogic SCPI
 sensor bindings
From:   jbrunet@baylibre.com
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 08 Nov 2018 17:29:47 +0100
In-Reply-To: <20181108160457.GA10953@e107155-lin>
References: <20181108135352.8459-1-jbrunet@baylibre.com>
         <20181108135352.8459-4-jbrunet@baylibre.com>
         <20181108160457.GA10953@e107155-lin>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-08 at 16:04 +0000, Sudeep Holla wrote:
> On Thu, Nov 08, 2018 at 02:53:51PM +0100, Jerome Brunet wrote:
> > amlogic,meson-gxbb-scpi-sensors is both the driver and DT but is not
> > documented. Just add it to amlogic's scpi documentation
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/arm/amlogic,scpi.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/amlogic,scpi.txt
> > b/Documentation/devicetree/bindings/arm/amlogic,scpi.txt
> > index 7b9a861e9306..5ab59da052df 100644
> > --- a/Documentation/devicetree/bindings/arm/amlogic,scpi.txt
> > +++ b/Documentation/devicetree/bindings/arm/amlogic,scpi.txt
> > @@ -17,4 +17,11 @@ Required sub-node properties:
> >  - compatible : should be "amlogic,meson-gxbb-scp-shmem" for SRAM based
> > shared
> >  		memory on Amlogic GXBB SoC.
> >  
> > +Sensor bindings for the sensors based on SCPI Message Protocol
> > +--------------------------------------------------------------
> > +SCPI provides an API to access the various sensors on the SoC.
> > +
> > +Required properties:
> > +- compatible : should be "amlogic,meson-gxbb-scpi-sensors".
> > +
> 
> Not sure if it's worth mentioning the reason for being able to identify
> amlogic,meson-gxbb sensors from generic scpi ones. IIRC it was for the
> unit values of these sensors are different ? But I will leave that to
> DT or platform maintainers' taste.

Yes Sudeep, the unit are different.
If we probe on the generic one, it will "work" but the result is just not
good. 

BTW, the point of this patch is merely to remove an existing issue.
The scpi driver and meson-gx.dtsi are both refering to an undocumented
compatible.

> 
> --
> Regards,
> Sudeep


