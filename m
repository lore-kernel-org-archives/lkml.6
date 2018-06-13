Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 87BC8C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B725208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mBdFI4mY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B725208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935229AbeFMQKq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:10:46 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38264 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935119AbeFMQKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:10:43 -0400
Received: by mail-pf0-f194.google.com with SMTP id b74-v6so1663661pfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 09:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=gjI8rKdFX51bBSqKtjqiajBoQQsveyIqnGcP5BXKLD8=;
        b=mBdFI4mYXvDLKfFQgHY3tnh48qFU6amVx59sKLTHXyKHiubUUXDe4XBnO7s2eTr1lq
         n27EHTG+V2yTI+EqbwtE6zwZjdKSt+BfFf8P7F8VHuBG0tTttdXN8IdW1M8VbDMChOuJ
         d+yF2/Jez9sNlMlPcZDcONIk+2Lt/m1XHQZ6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=gjI8rKdFX51bBSqKtjqiajBoQQsveyIqnGcP5BXKLD8=;
        b=hc5Hkwkw316cYyf6iG+fTvSlsQj1hSpMcrwZiwrLQSHns/dZLkIIWb0SmheG9UZOq6
         3iztv0gbaa+3TEv66WlnqB1InwVcbK9arxucVGJ7U7oe06KijmPJYWmWWrTxXdTfAMdd
         qIMPWkEwbozLcavqt7XIuA9gNmOQM6HDaw56Kft/f80l/xYcoqWSgHZI5KN8hhwQuehd
         /8/I8uPTeyUj7/DD32fwNIuFmg8PgCnPLqoW6tPG3PxKrz9N7aRCs1XXb0n9QGLT5gU3
         SKi5Ct9okgZ/bdWlMeXZpv7ihFHfEFNe1YqJTtBe6FMZU42Ry32fBcq8gbutIo3Z6jzS
         iYGw==
X-Gm-Message-State: APt69E29oyETM0RmqIw/3/IR784f8Ca1PGDl8hFtO+HdIni/+FEEg4Ln
        ruMGeRGQJnSkn8fub2aMomQMhQ==
X-Google-Smtp-Source: ADUXVKJYKJ291MWHSobvRrtk+q6bQfJ4n8IZQ/ubTgvQ8S8DbeljIo/tJ1qhbRPDL40T+n5of5mwBg==
X-Received: by 2002:a62:249b:: with SMTP id k27-v6mr5583590pfk.143.1528906242738;
        Wed, 13 Jun 2018 09:10:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id q69-v6sm9541718pfl.16.2018.06.13.09.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 09:10:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        andy.gross@linaro.org, david.brown@linaro.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com,
        robh+dt@kernel.org, wsa@the-dreams.de
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1528823348-30532-2-git-send-email-kramasub@codeaurora.org>
Cc:     Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
        evgreen@chromium.org, acourbot@chromium.org, dianders@chromium.org,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
References: <1528823348-30532-1-git-send-email-kramasub@codeaurora.org>
 <1528823348-30532-2-git-send-email-kramasub@codeaurora.org>
Message-ID: <152890624119.16708.17950072340975001909@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 1/4] i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI
 I2C controller
Date:   Wed, 13 Jun 2018 09:10:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Karthikeyan Ramasubramanian (2018-06-12 10:09:05)
> This bus driver supports the GENI based i2c hardware controller in the
> Qualcomm SOCs. The Qualcomm Generic Interface (GENI) is a programmable
> module supporting a wide range of serial interfaces including I2C. The
> driver supports FIFO mode and DMA mode of transfer and switches modes
> dynamically depending on the size of the transfer.
> =

> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>

