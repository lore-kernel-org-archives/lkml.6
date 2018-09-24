Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26903C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FFB2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i01oxOVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FFB2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbeIXWuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:50:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33493 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbeIXWuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:50:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so9273837pfn.0;
        Mon, 24 Sep 2018 09:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/G07YbdXL8jf30XSPS9sydR4znAKgUtQi9Qnks7eL50=;
        b=i01oxOVNRnasSKDDcwkJ/t1x1p1U89T0ukL21kzOcwhI1Kv36/RPXXW9SawkZLSCZs
         T0aHARifyfAA1CSH4HNIUkul8zsDm6R/ba0incRfa7qbG99jgCdEIcocoGWiJhzkijXp
         prmjhKbwGI5BsfgYDCGhynZ+x3c9aTeg4W+krKKiflQhRPCyGf6R9fbOsKJ6WSfodPuW
         lqE7vMWbRYBacPlGthhA5LMWKBl+q8HebBdgcUAdFOnjRS/IprMCzuZSPeDCSuqQofpC
         ZozELp9NyAO6oJoHO2bakPfiNGB7g6JxdXJ4CYRU1f3+MTz7pu/3vlfXMXMsd/gANrXV
         JTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/G07YbdXL8jf30XSPS9sydR4znAKgUtQi9Qnks7eL50=;
        b=SqwldTC9g6zxBGTjWFd9ZsR/F5YNuPNKsZtE7ULjR7sa9r5XZkU9Rrb+CNDU2Wx/zt
         rffXI55K3sZF/67fC2M7uYGA0qhHg4Jr+pjOIB+HxQJIbTbIENFS3MYjCcFaCyJTB5E4
         +FXnbMjlqbrg/k6Nez7mWDUybAX7Le8KNmAzzkncyWemP0tlQ1S9SC3IuTOJfg7q3un0
         0ouJRJteutNdZoE++1m252ZIfunsspgcy+NSD9IkNxz70R6KKEn5eJHmRsIRw253rRtw
         qN1p/0xL4N/ayYlm6bR3DTs3DB0ER1aJcGyZMtP/Czb541pJ0vKFhDoVoXPXs3R7nRzq
         OUrA==
X-Gm-Message-State: APzg51AcuTekdts+RShEG5FWucCUWA/vDk7c4CFP8C4HbQM9KbPpo9IG
        NWKsxfYGaRLYpfRYytCmSGs=
X-Google-Smtp-Source: ANB0Vdanuv0PGT+yfkBe/uVppNAyklrWD/eMDSB+gZDSGh9HfpCaZn5XxQobAfJZBgG07Nby1VVGjg==
X-Received: by 2002:a62:7788:: with SMTP id s130-v6mr7214894pfc.189.1537807617578;
        Mon, 24 Sep 2018 09:46:57 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:a699:bb10:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id y3-v6sm56337202pfi.24.2018.09.24.09.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 09:46:56 -0700 (PDT)
Date:   Mon, 24 Sep 2018 09:46:53 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Keerthy <j-keerthy@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] thermal: add thermal_zone_device_toggle() helper
Message-ID: <20180924164651.GC4988@localhost.localdomain>
References: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180410124248epcas1p453f74df4e183f9d68de255847c093d4e@epcas1p4.samsung.com>
 <1523364131-31059-2-git-send-email-b.zolnierkie@samsung.com>
 <20180910171605.GA4196@localhost.localdomain>
 <0495124b-9ae8-3b4b-5f0c-208d2e06e5a5@samsung.com>
 <20180917093401eucas1p1f1e0de762a88b1327ba229971996e5da~VJjFwrEK11702417024eucas1p1m@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917093401eucas1p1f1e0de762a88b1327ba229971996e5da~VJjFwrEK11702417024eucas1p1m@eucas1p1.samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Sep 17, 2018 at 11:33:59AM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> On 09/14/2018 01:40 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> [...]
> 
> >>> --- a/include/linux/thermal.h
> >>> +++ b/include/linux/thermal.h
> >>> @@ -467,6 +467,7 @@ struct thermal_cooling_device *
> >>>  int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
> >>>  int thermal_zone_get_slope(struct thermal_zone_device *tz);
> >>>  int thermal_zone_get_offset(struct thermal_zone_device *tz);
> >>> +int thermal_zone_device_toggle(struct thermal_zone_device *tz, bool on);
> >>>  
> >>
> >> You missed the #else section of the #if IS_ENABLED(CONFIG_THERMAL),
> >> didn't you?
> > 
> > No, this function shouldn't be used outside of CONFIG_THERMAL.
> 
> Please disregard my previous comment. I see now that the CONFIG_THERMAL=n
> stub is needed and I will add it in the next patch revision.

Thanks Bartolomiej for keeping this up.

> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
