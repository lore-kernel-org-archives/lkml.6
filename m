Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA365C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 17:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACDC206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 17:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FfDVXDBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACDC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbeI3Xqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 19:46:35 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34434 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbeI3Xqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 19:46:35 -0400
Received: by mail-yw1-f65.google.com with SMTP id m129-v6so4605257ywc.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 10:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=toVxlOVlpbFXu5FpKkl6ix9DOJTfs3kcKYXDWQ+GUvg=;
        b=FfDVXDBe//uAZpiG/NJ5SCZLA6zycyMNWOekVAfSjUhUU35umKnezczHIJIwbK09dP
         VacSZf/88GPWYSy2zLyrVXMcfKkpIaWnCv6zGNaxz4ggoKgpyYyvx0k/GTwUnOc6wTYz
         Vxdi/ifWERry//VQUrO6lkZSQkezLw2dpobQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=toVxlOVlpbFXu5FpKkl6ix9DOJTfs3kcKYXDWQ+GUvg=;
        b=jV2mMlnpN6qBujNYBPxCa2y7MlhkPoOf38gLT7XkcOm/uIKPEXWDp/CZ/Ud1jC8U0e
         /szoEqY5UBhMoKcBK7nZ2ISQXK0kZByGeURfPMyvycu4/4OiVtTmpt5097zj4IdntGQ5
         eladljmtnURpsuVUZVGd/mQa4pra3AfO6ewfgs0OOutAtjMFodZXdLUnanKkVvJLbK3N
         7gqwGWU+0wkfofc1SXSaS3605A/sw/2bSia9ZAF/cSPRHbhi6Rumq/ILoVVWk/i4oN6Z
         srjfJFC/Bai79xC3+EHOjic3Duzb3ZYpad+9BSsYs20zAb9caE/5f/1jXf3fmIky9yk5
         Fi8g==
X-Gm-Message-State: ABuFfogW7did7sgM2qHhl9jgfFxpfOdMnrY5WVKk+YaSOgIETS+FHKen
        qE6rSM3Luei1Pk55uvkDnKgVSQ==
X-Google-Smtp-Source: ACcGV6058583QZfDP/g15SUrovHpVqsD14iv0XALbN6PVYKiOQ3gTu/qgYZ5SQcdhMxvSK7DoJDE4g==
X-Received: by 2002:a0d:cfc1:: with SMTP id r184-v6mr3325973ywd.118.1538327563937;
        Sun, 30 Sep 2018 10:12:43 -0700 (PDT)
Received: from localhost ([2600:1700:141:4960:b19b:8662:2992:bdd8])
        by smtp.gmail.com with ESMTPSA id x185-v6sm738919ywd.40.2018.09.30.10.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 10:12:42 -0700 (PDT)
Date:   Sun, 30 Sep 2018 12:12:41 -0500
From:   Andy Gross <andy.gross@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>, robh@kernel.org,
        coresight@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Brown <david.brown@linaro.org>, leo.yan@linaro.org,
        frowand.list@gmail.com, "Ivan T . Ivanov" <ivan.ivanov@linaro.org>
Subject: Re: [PATCH v2 05/11] arm64: dts: msm8916: Update coresight bindings
 for hardware ports
Message-ID: <20180930171241.GB2955@hector.attlocal.net>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
 <20180912135352.19722-6-suzuki.poulose@arm.com>
 <8ada229a-49ca-95ff-dc31-df459aaa7196@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ada229a-49ca-95ff-dc31-df459aaa7196@arm.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 09:18:06AM +0100, Suzuki K Poulose wrote:
> Hi Andy
> 
> On 09/12/2018 02:53 PM, Suzuki K Poulose wrote:
> >Switch to updated coresight bindings for hw ports
> >
> >Cc: Andy Gross <andy.gross@linaro.org>
> >Cc: David Brown <david.brown@linaro.org>
> >Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> >Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >---
> >Changes since v1:
> >  - Fixed TPIU port direction
> >  - Use better subject tag for the patch
> >---
> 
> 
> Please could you pull this and the patch for ARM (Patch 9/11)  ?
> 
> Suzuki

Done.  Thanks
