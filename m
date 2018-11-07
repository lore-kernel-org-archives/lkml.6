Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E57C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762DD20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 762DD20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeKHBR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:17:58 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37629 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbeKHBR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:17:58 -0500
Received: by mail-qk1-f193.google.com with SMTP id 131so21560329qkd.4;
        Wed, 07 Nov 2018 07:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoA0Qb0cOE5SBGWVr1LViBkS93kOkg6Zkg864HfNFSk=;
        b=plKNkB6t+njjBBy1/hmW2mzzE//5Yr7XE20Q7DxtzuqDGzzZTPF8hQjTbjOrwOS2b5
         5SFrrSLlMZEipeOlCTmTGzqypdXtklKS3ZLlj30NiZjIQhe8RVpax2so8zLMsSC3wV7i
         82NQ9tGv1Y4hLMf99smV7pFl4nD7YWkg6AOGtWK2iD+GP8valUbJjN3G762Mr5cLJ/jV
         yha7z2XdxBc+dcAkaqP1B9CFatGasyo4v4N6MZb7OdEGs+6iyYBB9XCbRsTjPYyyfvr2
         IwpRtQuyQMbWIStfKFJjeA/yzctMAhI//w1KD5wQhXocQYgQm862UmtnZkAXiItxDLuX
         v72g==
X-Gm-Message-State: AGRZ1gJtJcy/56Spg82zKQiTiU06htSPItsUFVdYiic0/LUgW2cJ+tP1
        nHKzdh8GShcEoTwCVJ1xyfHRzbzGCQDTE00DWyU=
X-Google-Smtp-Source: AJdET5dmej+Ffr5uhY7CgH4XO+4PoCBj9eguPKUeOFC6S9fagw4Sz2TYXICOHmoIt5Gx7Hy1frZl/zNASagTS05Fhdo=
X-Received: by 2002:ac8:410a:: with SMTP id q10-v6mr712764qtl.96.1541605623368;
 Wed, 07 Nov 2018 07:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20181107003250.5832-1-elder@linaro.org>
In-Reply-To: <20181107003250.5832-1-elder@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Nov 2018 16:46:47 +0100
Message-ID: <CAK8P3a15nTnL0tD4TJgtPVEKFwZRcyNy=m6_Pi3+8Nd0W6FQtQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] net: introduce Qualcomm IPA driver
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Networking <netdev@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
> The code has undergone considerable rework to prepare it for
> incorporation into upstream Linux.  Parts of it bear little
> resemblance to the original driver.  Still, some work remains
> to be done.  The current code and its design had a preliminary
> review, and some changes to the data path implementation were
> recommended.   These have not yet been addressed:
> - Use NAPI for all interfaces, not just RX (and WAN data) endpoints.
> - Do more work in the NAPI poll function, including collecting
>   completed TX requests and posting buffers for RX.
> - Do not use periodic NOP requests as a way to avoid TX interrupts.
> - The NAPI context should be associated with the hardware interrupt
>   (it is now associated with something abstracted from the hardware).
> - Use threaded interrupts, to avoid the need for using spinlocks and
>   atomic variables for synchronizing between workqueue and interrupt
>   context.
> - Have runtime power management enable and disable IPA clock and
>   interconnects.
> Many thanks to Arnd Bergmann, Ilias Apalodimas, and Bjorn Andersson
> for their early feedback.

Thanks for getting the current version out even with the long TODO
list. I've had my first deeper look at some of the patches and found
a few more things that likely require substantial rework. I also think
there is still significant room for simplifying it further, and getting
better performance out of it in the process.

Also, despite the criticism in my patch review, I have to say you've
done a great job at cutting out a lot of the things that were present
in the past, it's good to see that you have come this far with the
cleanup!

      Arnd
