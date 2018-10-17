Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A436FECDE3C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6195F20645
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bieph7Fm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6195F20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeJRHfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:35:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35538 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeJRHfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:35:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id o14-v6so25985836ljj.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 16:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4plGu7ct3HK53KtQRhP2auXc45X1hJgtHs5JZpGLyr4=;
        b=Bieph7FmIOV2ffSn66D50+FBQpZN1i1Otk8k4+vFmcmKpG247PrAjYW2rTSJSS4S9/
         XbcbfIFGNiqOX0+uPpT9lYnqyZUAxpkCwQLoLgL2g5i6bAmo6r4APzLNvfyauMDOxBJq
         V7oXD7iW1P7g2f2GYgnoKI0tSejtwORmX8FCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4plGu7ct3HK53KtQRhP2auXc45X1hJgtHs5JZpGLyr4=;
        b=rHtiFLdlavI+IsXzj+lgSuAZUsJHh9U/WCUXqIO3Y4wd8NgZznbnoYd8+ELv3zA4dX
         EbFaHfyz94j5er0/4XHKOuhwNRWnjRnf8kmG+SK+/rb9vamaoZk1VVKuqFtRp90KTY26
         CqUlrM9VcFtc8TtruE/DYmhf61QNDpcdoitG4Ka4Ke+e/YUYpI09p5tgmuiJEkhX2zaw
         YvMoA0TCT3fQTMcEI22zkZxMCuimfbg1RiU4QbmEIYtmS+736QHANjlVc8+cgwDFeTzR
         rsjiW8dG/W71oFqFCC/gMlPYjCML8L2WFkjvbMkTJJkJQ1PLiu2GgTASdg1dSgS1JbNs
         NAtQ==
X-Gm-Message-State: ABuFfoiVAZW/XSp5ou0cuS8N/pCMjhXXcI4vl5BZYXTinUNuqRpzaGR8
        aSerdigGf5mXj2jXjsQ5KzPjeCuAeNs=
X-Google-Smtp-Source: ACcGV637nQF+X4ytvZppUb/nTUuT5zLjHk1+UdKWX40iNqH86G3Oz2VQ3fqZesBrvKyY2+tso2Lejw==
X-Received: by 2002:a2e:83d7:: with SMTP id s23-v6mr19600248ljh.0.1539819430118;
        Wed, 17 Oct 2018 16:37:10 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id e16-v6sm2096810lfb.42.2018.10.17.16.37.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 16:37:09 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id j4-v6so25959667ljc.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 16:37:07 -0700 (PDT)
X-Received: by 2002:a2e:9d05:: with SMTP id t5-v6mr5608176lji.57.1539819427371;
 Wed, 17 Oct 2018 16:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181012213632.252346-1-dianders@chromium.org>
In-Reply-To: <20181012213632.252346-1-dianders@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 17 Oct 2018 16:36:31 -0700
X-Gmail-Original-Message-ID: <CAE=gft6W_gGXQRP++AMauHien4yG8TN3pOOgzKpND65KqMqy=w@mail.gmail.com>
Message-ID: <CAE=gft6W_gGXQRP++AMauHien4yG8TN3pOOgzKpND65KqMqy=w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: phy-qcom-qmp: Fix several mistakes from
 prior commits
To:     Doug Anderson <dianders@chromium.org>
Cc:     robh+dt@kernel.org, kishon@ti.com, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, sayali <sayalil@codeaurora.org>,
        varada@codeaurora.org, asutoshd@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 2:36 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> Digging through the "phy-qcom-qmp" showed me many inconsistencies
> between the bindings and the reality of the driver.  Let's fix them
> all.
>
> * In commit 2d66eab18375 ("dt-bindings: phy: qmp: Add support for QMP
>   phy in IPQ8074") we probably should have explicitly listed that
>   there are no clocks for this PHY and also added the reset names in
>   alphabetical order.  You can see that there are no clocks in the
>   driver where "clk_list" is NULL.
>
> * In commit 8587b220f05e ("dt-bindings: phy-qcom-qmp: Update bindings
>   for QMP V3 USB PHY") we probably should have listed the resets for
>   this new PHY and also removed the "(Optional)" marking for the "cfg"
>   reset since PHYs that need "cfg" really do need it.  It's just that
>   not all PHYs need it.
>
> * In commit 7f0802074120 ("dt-bindings: phy-qcom-qmp: Update bindings
>   for sdm845") we forgot to update one instance of the string
>   "qcom,qmp-v3-usb3-phy" to be "qcom,sdm845-qmp-usb3-phy".  Let's fix
>   that.  We should also have added "qcom,sdm845-qmp-usb3-uni-phy" to
>   the clock-names and reset-names lists.
>
> * In commit 99c7c7364b71 ("dt-bindings: phy-qcom-qmp: Add UFS phy
>   compatible string for sdm845") we should have added the set of
>   clocks and resets for "qcom,sdm845-qmp-ufs-phy".  These were taken
>   from the driver.
>
> * Cleanup the wording for what properties child nodes have to make it
>   more obvious which types of PHYs need clocks and resets.  This was
>   sorta implicit in the "-names" description but I found myself
>   confused.
>
> * As per the code not all "pcie qmp phys" have resets.  Specifically
>   note that the "has_lane_rst" property in the driver is false for
>   "ipq8074-qmp-pcie-phy".  Thus make it clear exactly which PHYs need
>   child nodes with resets.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
