Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3554C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 05:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF69206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 05:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeEQgJdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF69206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbeIWLV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 07:21:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39331 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeIWLVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 07:21:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85-v6so4706896pge.6;
        Sat, 22 Sep 2018 22:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EYxJAjaRCOqbgSatR2vIJysDTaEOnnmfMdvZcoY2fzM=;
        b=JeEQgJdZsGWrFRNJdEbKyIrmsMHuhjYS5wW5FhUFps/z+cli7vQVzO4QCiI/+f6RQ5
         t6+u2DrhrRehgag0WtFDmGkU5gGYOcw+vX8v611GvxwixtONocoaAspkA2jyUDp58dPq
         g7cZqnqExCqyx3B2/DE2pDgnuLXF1ZSJsN6ToegaZMGk2jMGoPws1nfKxk3tvD8wsQdH
         VAR4r71IE2/vc0vRBKk06DprDYVB1alJdKEm53/sX0j791cxTBoZWFWkfv1k2ssqp//R
         7uzK828cSI6ZSxN/oOru/gCaa5ebC8DCLfrJ/mpa+YR4UYDEFRal1qJgxgxm/DtxUrWm
         9wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EYxJAjaRCOqbgSatR2vIJysDTaEOnnmfMdvZcoY2fzM=;
        b=Wzfb3jKm9MCw0xaX/C6yjm8hxUBecUTV6FjAVLpqe8qPvnKg0xsq6PbXJDlyQGCN3+
         OYt9XBuMRDiVXceOhY8MvKoC2ZxQpWQxTACirQ6b1jKPMkD+HnuK3HIKLLXJ3EYjMaY1
         FOBO58fIv+tvslGNnMSleLoV6LIdiPEmEok/uRvJ0rk6GhP5CCFO1B9NMNtIjImI0SJ7
         zEfI8CeYj2T8TZPqVaoX1a1ywPyiFC2cfmN/pVD2cobifmYm2VoS94ZRQ2lpgwqCNQK8
         umrShWT5u/UFgfgVT95c2etvu3M4hHPQw1DYiAmo5rP9hL4QKhMTFKiv15Y/sRR4WMNs
         eYaQ==
X-Gm-Message-State: ABuFfojZ/IrVDosx4vD/50yLiJ41xHPiu7zlnq4ei+HWfcL2vnZt6jcl
        g411IOznCWqGBjobsEk2ljWuA7E0
X-Google-Smtp-Source: ACcGV62T6KnM03M1EfBasqNoF5S7KXh4QNMZK6ABhvxA742tkaepKhUQUWgb1xDU7UbmzicPbTU/hg==
X-Received: by 2002:a63:5ec5:: with SMTP id s188-v6mr4382687pgb.126.1537680344580;
        Sat, 22 Sep 2018 22:25:44 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id v20-v6sm62231952pfk.12.2018.09.22.22.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 22:25:43 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] hwmon: ina3221: Read channel input source info
 from DT
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20180921223216.634-1-nicoleotsuka@gmail.com>
 <20180921223216.634-3-nicoleotsuka@gmail.com>
 <a7e6c311-eba4-e9b2-df64-9d02882a1dcb@roeck-us.net>
 <20180922184650.GB9092@Asurada>
 <f8e017c4-10dd-2d0d-84df-b05d3ed03bbf@roeck-us.net>
 <20180923003841.GA10071@Asurada-Nvidia.nvidia.com>
 <80510b08-0e89-03ce-7d69-fe51f8b6a7b5@roeck-us.net>
 <20180923033300.GA5736@Asurada>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5c102fee-202e-e5cb-18a0-be08b82dd461@roeck-us.net>
Date:   Sat, 22 Sep 2018 22:25:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180923033300.GA5736@Asurada>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/2018 08:33 PM, Nicolin Chen wrote:

>> No. If the chip was configured by the BIOS/ROMMON, it is supposed
>> to be that way. We can not just override that.
> 
> For this driver, it does soft reset in the probe() so we're
> sure that all channels are enabled at the moment of calling
> this regmap_update_bits. So there's no assumption anymore.
> 

Good point.

> But the case that you mentioned is a good one. It does give
> me some insight about the use case and the things that will
> need to be careful when adding in[123]_enable. Just it'd be
> also possible that BIOS could disable a channel that is not
> explicitly disabled in the DT -- then the driver should not
> enable it.
> 

Not necessarily. Again, we can not assume that everyone has DT
(or that it and/or the BIOS is correct, for that matter).

Nevertheless, adding the enable attribute is not required at this
point, so it is ok for me to skip it. Please note that I'll accept
a patch adding it, though, if it is ever submitted (with a use case).

Thanks,
Guenter
