Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEEAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A60208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="deciRQKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A60208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbeHXCeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 22:34:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35269 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeHXCeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 22:34:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id p10-v6so5431918ljg.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VrqstRhJOtJnEAdJwOBgPE3DaBruFzHTcqBIoLwtfSw=;
        b=deciRQKYaytzpf08VdOFil5DyzM0TVCPreRs48fDa4W/BgwQ09CQ/X3WJ9YCn6i5uP
         16/2GJdUAL1zLsASUrlgTK8IwwR2xLsjc1k9S7/TnlgsTzbnsTq/mHMSoSI6d2KtNuBy
         MUwcybrWWMiDIM3crhFcD7ljD15lrGG7B6nlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VrqstRhJOtJnEAdJwOBgPE3DaBruFzHTcqBIoLwtfSw=;
        b=qTnEwUIpB9HWN4AuDpHMl5AIgdAXtvAI12Z3FWJk2BQSIVz7Hdm8ALiTpaQugKFo0b
         RZreHY93WgwHFZehWnu2kEB3/MimGXB8A7TfEUrDCVTKTl+jzEoLFW1kZ92LiBvyab4J
         cbgzTnqx5ppHg5DyzSS4ahbzYinO1dGI2P0ZRNQiuCcapSuRO9MilfJ9ZmF9ch4a/ITI
         NuzURaT4BB8UDsGzguTtiSLim0dGJY+b7QTE8cewnJoCf2TYDARoO3oZNWnQNnd9Djqq
         CSYxojeszdmbn2GQ7wa05o7AvuybHdURQOTI+8Ka2EzcLJ7bHnTiQhXS8yDuzhWArwKG
         wAlw==
X-Gm-Message-State: AOUpUlGfFa7tShCFIq43uUkZSFE0RbRWPj0h9Q5qxujDVa8uSYgd4w8E
        bV/7RUs9sG9wkCEKuhcI8r+bdQKSAX4=
X-Google-Smtp-Source: AA+uWPzCFQTjOXHRWk+bjkr8KhiPxh66SpjPCDi4IlZpNK0FJ/G3rwGZnd7X6Mfams+bmwE2bJOzDA==
X-Received: by 2002:a2e:85d5:: with SMTP id h21-v6mr40349140ljj.103.1535065335683;
        Thu, 23 Aug 2018 16:02:15 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id q128-v6sm935649ljq.72.2018.08.23.16.02.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 16:02:15 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id s12-v6so5438301ljj.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:02:13 -0700 (PDT)
X-Received: by 2002:a2e:8103:: with SMTP id d3-v6mr3590178ljg.3.1535065333382;
 Thu, 23 Aug 2018 16:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <1534550915-18230-1-git-send-email-vnkgutta@codeaurora.org> <1534550915-18230-2-git-send-email-vnkgutta@codeaurora.org>
In-Reply-To: <1534550915-18230-2-git-send-email-vnkgutta@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 23 Aug 2018 16:01:36 -0700
X-Gmail-Original-Message-ID: <CAE=gft64sF7APE490guRHo7PS9XsFkPn9-ZKcMB4_wPE5FXONQ@mail.gmail.com>
Message-ID: <CAE=gft64sF7APE490guRHo7PS9XsFkPn9-ZKcMB4_wPE5FXONQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drivers: soc: Add broadcast base for Last Level
 Cache Controller (LLCC)
To:     vnkgutta@codeaurora.org
Cc:     robh@kernel.org, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 5:08 PM Venkata Narendra Kumar Gutta
<vnkgutta@codeaurora.org> wrote:
>
> Currently, boradcast base is set to end of the LLCC banks, which may

s/boradcast/broadcast/

> not be correct always. As the number of banks may vary for each chipset
> and the broadcast base could be at a different address as well. This info
> depends on the chipset, so get the broadcast base info from the device
> tree (DT). Add broadcast base in LLCC driver and use this for broadcast
> writes.
>
> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> ---
>  drivers/soc/qcom/llcc-slice.c      | 55 +++++++++++++++++++++++---------------
>  include/linux/soc/qcom/llcc-qcom.h |  4 +--
>  2 files changed, 35 insertions(+), 24 deletions(-)
>

Reviewed-by: Evan Green <evgreen@chromium.org>
