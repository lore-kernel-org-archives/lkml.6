Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629B5C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079E0208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OW6fTAp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079E0208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeHXCjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 22:39:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46816 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbeHXCjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 22:39:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id e23-v6so5286861lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r2QfptiOd16jzJdYZkp75TCmPQ60T9Pw8JbpZOinfTE=;
        b=OW6fTAp+UiuSdcNLGx3DRrrw/v97nIsaQUwNX1PenLUZOO+9ggGFgnZLiOR3eQKnUK
         Jt8VTzWaFIw7w7gB+zPouPQMnCvxTy3m1GAf+u6rLCaYWZI4LnEx70VwZPCfqZFj9yGF
         Xy3ZUGR+1w30LE64wApkg5kobyIvFGoTSgbr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r2QfptiOd16jzJdYZkp75TCmPQ60T9Pw8JbpZOinfTE=;
        b=Pelb3vIwnoiniyWOqPB7dGf52+6S8xXtDxpw/M+HLC9hocO0ndt8u0B4vYUwoZDFjK
         qpFaweCEYgNZvEI7OTxiQiqmvByMqRDuHLg6d99MCUGWshfskGZgtAwwxQn+kQ3xfW5D
         2WI3iElHMI/EX2KbzVf5cgR40amskc6BFX7wV9fa4ys6WvPJGPp+AE1eOA+YARhxPqrj
         AJxRGnFsNERIayB6VqeoFGfPANlWtx0W6TjCVC++aMiAnU/gByJCbDsc6G9CB5dvw1Gf
         zll5lifL0BrrNuKYnGEfWmAJERBufJSlwRW+yyCZpngKzQvD8xLm9VdFHUgpbOG7RkNq
         BnqQ==
X-Gm-Message-State: AOUpUlEc0c2RzdRFllFIwovQdiFEohYgAiVqlAt/FGUq1Hgsy78oi1TW
        ob22SqJB4vNUNY7EvJ3Fje+lqK5+2Fk=
X-Google-Smtp-Source: AA+uWPwhyJyhfB6n5HAChhWFKREfXmaf4AVGkTZDj4sX2K25Sz71Z1EFTvIiz/FIcK/L7jW+KRPcOQ==
X-Received: by 2002:a19:5c57:: with SMTP id q84-v6mr15354665lfb.51.1535065680888;
        Thu, 23 Aug 2018 16:08:00 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id f18-v6sm933324lja.85.2018.08.23.16.08.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 16:08:00 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id j19-v6so5432036ljc.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:08:00 -0700 (PDT)
X-Received: by 2002:a2e:1248:: with SMTP id t69-v6mr8907615lje.129.1535065343687;
 Thu, 23 Aug 2018 16:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <1534550915-18230-1-git-send-email-vnkgutta@codeaurora.org> <1534550915-18230-3-git-send-email-vnkgutta@codeaurora.org>
In-Reply-To: <1534550915-18230-3-git-send-email-vnkgutta@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 23 Aug 2018 16:01:46 -0700
X-Gmail-Original-Message-ID: <CAE=gft4X9jbBJvQPykdiLRrQMJfhuGy4myjU9QKD2rjTUkLegg@mail.gmail.com>
Message-ID: <CAE=gft4X9jbBJvQPykdiLRrQMJfhuGy4myjU9QKD2rjTUkLegg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] drivers: soc: Add support to register LLCC EDAC driver
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
> Cache error reporting controller is to detect and report single

Should be "Cache error reporting controller detects and reports single"...

Other than that:
Reviewed-by: Evan Green <evgreen@chromium.org>
