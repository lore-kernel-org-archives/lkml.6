Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CF7C04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 22:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651942086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 22:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fE6eTF5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651942086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbeINDhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 23:37:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35638 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbeINDhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 23:37:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id 7-v6so3401793pgf.2;
        Thu, 13 Sep 2018 15:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KT85D3d0NmKGKqNVwqzx2eagX+ScxoxczTO/shHCPE0=;
        b=fE6eTF5efPkHtr+s0khVfsITCT6pXnG6MSkzR17sJD26JrPnCszBU3aCynJm+CLG4a
         MkIcy2+DJAyTmGU9v1DMYEp+nO83cee1Cu5ZL+6IR7xcRrXWGax2HW381HSeIYXWH44s
         gSNF7UDcc9H2F6qO8wAQt/oBZi2Hsbdg9sr3CaEQvGtFHc1aN2/HjRguX50IOQwNrKKR
         OZ2lbKAyLg3ofNFs7UwbrmIYoqV1gz8ePeu6k8UPpmnX5xyX2FVZtcuR7flghBnKZ/p/
         XtxJIU+oTcvrsiCsE2egi/1aVnNnA3m6xE8Q0pGlB7Y6vXBZqzwQuAsHjoBSrPSsYekd
         nCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KT85D3d0NmKGKqNVwqzx2eagX+ScxoxczTO/shHCPE0=;
        b=ggZ7EU1sAVZNuEDSDMn7ceV+kd5pv2oXA0lQ5zwMgrgF/6JMS32fPflZl9Skgnao+P
         9RSoRBF+qFJIZl7ntGfWPRLEsLkk3kM1aHWfRO8a40c330BlFO9CTGK+Z95yFadE8pnZ
         gwJwvzF+5X9F5a4SFZ+LloGb0A8V8A/eVbHo5/cHv5BkfEgbGri6QFRS1pwUldKlhlGQ
         mpvOQI+aGSv7lMMKyg4uSRx/z9Zky1s4d4L0Cdqxfa0oK1Pkm1Yup6mpMXkxn1iINXlG
         hQSLzH22pLTN57dAVrj06STZe8WGc8esZq47RSsw/lYNA50tXQkhVuS3433f6wiXCOy7
         gulg==
X-Gm-Message-State: APzg51CuXca9Ppf2e+8EC7xkJ5LaeFz00mk+hF8y7Xembk9lJ3JnYtDb
        f7x7rbTPblnCv536rfNeM0U=
X-Google-Smtp-Source: ANB0Vdakw7w21ZPCVDH3vsL0xD+m6M3GwUmdPfG84KkuOc4uiC31+xitaJjfpRGZn8rB1wA8dSLSbg==
X-Received: by 2002:a62:fcd2:: with SMTP id e201-v6mr9402345pfh.101.1536877549386;
        Thu, 13 Sep 2018 15:25:49 -0700 (PDT)
Received: from [10.0.2.15] ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id 143-v6sm7199833pfy.156.2018.09.13.15.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 15:25:48 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] Stingray thermal driver support
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <1533819299-3401-1-git-send-email-srinath.mannam@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <9dee54fd-eaef-5454-0c96-d105ba2e221d@gmail.com>
Date:   Thu, 13 Sep 2018 15:25:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533819299-3401-1-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/09/18 05:54, Srinath Mannam wrote:
> These patches adds the stingray thermal driver and its
> corresponding DT nodes with documentation.
> 
> Changes from v2:
>   - All stingray TMON DT nodes are combine together into single.
>     Temperature registers are combined into one mem resource.
>     brcm,tmon-mask parameter has available TMONs mask value.
>   - All available TMONs are initialized together in single
>     instance of driver probe call.
> 
> Changes from v1:
>   - Fixed auto build sparce warning.

Thermal maintainers, can you please review patch #3? The binding and DTS
changes can go through arm-soc if you would like, or you can take
patches 1 and 3 and I take patch 2, either way is fine.

Thank you

> 
> Pramod Kumar (3):
>   dt-bindings: thermal: Add binding document for SR thermal
>   arm64: dts: stingray: Add Stingray Thermal DT support.
>   thermal: broadcom: Add Stingray thermal driver
> 
>  .../bindings/thermal/brcm,sr-thermal.txt           |  23 +++
>  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  13 ++
>  drivers/thermal/Kconfig                            |   3 +-
>  drivers/thermal/broadcom/Kconfig                   |   9 +
>  drivers/thermal/broadcom/Makefile                  |   1 +
>  drivers/thermal/broadcom/sr-thermal.c              | 216 +++++++++++++++++++++
>  6 files changed, 264 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
>  create mode 100644 drivers/thermal/broadcom/sr-thermal.c
> 

-- 
Florian
