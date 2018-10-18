Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44CCECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DBE208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z/4RhS3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DBE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeJSH4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:56:06 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42190 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeJSH4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 03:56:05 -0400
Received: by mail-vs1-f68.google.com with SMTP id e126so24238104vsc.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+f18/zbwVlBhsTynVhtf9gyGnVBE2xByUDRG7KmtNWo=;
        b=Z/4RhS3+2cfQ1TwJMnY4VIB5NAJCtEWJ8pupcPnjZTm8jFb6DUXDhg+qihK8CBWmRC
         +Q8rstniqndoyDpWuy3sba24hiOyceB6hzqS1wdaH8H8iGPcjhfv90hczm/RCMTFkW6k
         JGEC/VP5DB8EPwyWF/cchfbJMkUv4coFX9VLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+f18/zbwVlBhsTynVhtf9gyGnVBE2xByUDRG7KmtNWo=;
        b=rh2VV0BOfKmKPpHt/e6/SFqyWO3a6JUUMxQvxARjB79qxemF+ZsljltrDbsKGXrG6K
         FQCDTzvCc2l7Za+C00Xaw+o0fYTeP+aXxy+SgpB3VIwa+SjPCaowYUKAifMh+gNdvQ0r
         NkLsCRQ9liJ8Q6OhwnC9JpTiedJfh30RbxmuwAQ6DFHjF0hsiICqmmKh4hkKTb8St+YK
         UcP9l6xJpUnYP0p8YrGddaDg+V//htPjt7Ttoj2Lq2bcHGNxVICLUW5xE4hcN6ZN//N1
         4hHgqZrFh0FW8lXygmQs/N+GqXT710XW8CPoXJ8QVUqAeXTffquxO2uv034Sc6mibuGk
         pdbw==
X-Gm-Message-State: ABuFfoiaXIEU8P6bvEH6bgVEBkD2V5BMJqhxZYIj/s/DpXXtaiKggFS/
        ax33SbzEIxdEIeNbTzmpSKOaj9JTQ/0=
X-Google-Smtp-Source: ACcGV62l6LHOppOZ2ifOqN8FRMmi+xul19fuhLMwvRxS+VAhNIrGopm2+wV0cdut+nzL9uPFO9lLbQ==
X-Received: by 2002:a67:e892:: with SMTP id x18mr12505631vsn.108.1539906763392;
        Thu, 18 Oct 2018 16:52:43 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id g27sm4029773uah.16.2018.10.18.16.52.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 16:52:42 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id o17so4092958uad.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:52:42 -0700 (PDT)
X-Received: by 2002:ab0:150:: with SMTP id 74mr14680188uak.83.1539906761985;
 Thu, 18 Oct 2018 16:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181018210933.113592-1-evgreen@chromium.org> <20181018210933.113592-5-evgreen@chromium.org>
In-Reply-To: <20181018210933.113592-5-evgreen@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Oct 2018 16:52:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VFceh3gho4G48FWVk1mkN7GQSBWueeopbJj4PHiN-d0g@mail.gmail.com>
Message-ID: <CAD=FV=VFceh3gho4G48FWVk1mkN7GQSBWueeopbJj4PHiN-d0g@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] arm64: dts: qcom: sdm845: Add UFS nodes for sdm845-mtp
To:     Evan Green <evgreen@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>, cang@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 18, 2018 at 2:10 PM Evan Green <evgreen@chromium.org> wrote:
>
> From: Can Guo <cang@codeaurora.org>
>
> This change enables the UFS host controller and PHY on sdm845-mtp.
>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
