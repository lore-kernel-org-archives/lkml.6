Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDAEC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F3720868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eRlNRX68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F3720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbeLFXov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:44:51 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37975 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbeLFXot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:44:49 -0500
Received: by mail-vs1-f68.google.com with SMTP id x64so1427514vsa.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 15:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B862xZ0dLxc7Y3HjJ577fyIVhBtb2+ARBITM++EIqCY=;
        b=eRlNRX68Z0vnlQgECH8Unw5VK0T48FI+Rk9ZmkOEC+AIG/AttvYH+wlrqu0BzNbNPw
         SQfKQ8uGVMr6VLCAt/wW/VgIEjSqRcsKxnyWzOYU4wzQ94gEdV7M8+a/Sfj0Ci4TSfjD
         EywuN9SrYJOYyl6vQKrea1DfVel3NthA+6kTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B862xZ0dLxc7Y3HjJ577fyIVhBtb2+ARBITM++EIqCY=;
        b=U5XlaRYvgTzJDWpCgTkXUn5Zz/f5AVyVrFK/K4N8XqhVP4n1HTLlz3ZEQp6XyKoSxh
         PVgIGrMpvwn29EF7ALJikS1BJ9eGZt/yu1p2Zsepx/a/dUt+WA14YBKoIcVybfqfwghB
         aj2soy+k3ET1LTt4WZkC3kNpZAt+qjiXjiPInJatDZVLBmmGJ6XOQpTG9bHAzet9gnNV
         xVYsp+hFVKbBvtu+zvUvH57ZPzadnAYGUbz7bbSYWX6ZfQTGhaPirjWXsoAoRjwSW+J7
         oUEqlTrT5O+hAsVtU8h7ulHkVuNCFqV3xtZ0/tx45R6Lnqc6jDGZn4spAmIhbiy7OYYU
         jaLw==
X-Gm-Message-State: AA+aEWbb2Y4y9UmGxLRqfpKMugTmYpirR2Z9rX7YVX0aoE+HrdKbfp0R
        r9stMroYFGqdKXzKcqi2h/lGgj76MtY=
X-Google-Smtp-Source: AFSGD/U8UOjnU6XlBDUCRHLKkr6u7MnRXufsrvvaIkFeOyEx8bTsJvmlCon7t3V7MJbU/CATIIC9iw==
X-Received: by 2002:a67:2dcf:: with SMTP id t198mr14058969vst.169.1544139888209;
        Thu, 06 Dec 2018 15:44:48 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 2sm519847vsd.13.2018.12.06.15.44.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 15:44:47 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id z3so1420787vsf.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 15:44:46 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr12075868vsv.20.1544139886370;
 Thu, 06 Dec 2018 15:44:46 -0800 (PST)
MIME-Version: 1.0
References: <20181206184522.118062-1-evgreen@chromium.org> <20181206184522.118062-4-evgreen@chromium.org>
In-Reply-To: <20181206184522.118062-4-evgreen@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Dec 2018 15:44:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W+-+YpPQESSN6GTy_O5UiPOZLvZ9g8fxXFA55g8h9S5g@mail.gmail.com>
Message-ID: <CAD=FV=W+-+YpPQESSN6GTy_O5UiPOZLvZ9g8fxXFA55g8h9S5g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sdm845: Add SD nodes for sdm845-mtp
To:     Evan Green <evgreen@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 6, 2018 at 10:46 AM Evan Green <evgreen@chromium.org> wrote:
>
> Enable support for one of the micro SD slots on the MTP.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>
> Changes in v2:
>  - Fixed alphabetization of node placement in sdm845-mtp.dtsi (Doug)
>  - Fixed card detect name to match schematics (Doug).
>  - Moved comment about drive strength next to the drive-strength entry
>  (Doug)
>  - Removed drive-strength from card detect input pin (Doug).
>  - Consolidated tlmm nodes in MTP.
>
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 58 ++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
