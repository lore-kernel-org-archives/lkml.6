Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE14C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F335A20882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gzofjud8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F335A20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbeG2XH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 19:07:59 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51474 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbeG2XH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 19:07:58 -0400
Received: by mail-it0-f65.google.com with SMTP id e14-v6so14672419itf.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=537QtFfNDnc1yFQW8NoRE77KyJmBz4y9urrCczx0I2I=;
        b=gzofjud8W8h1i8n6myNLP5bDCKnHYfx8ij+PtEYu72SGSyHC5ieh480t17Z8Fd3lCW
         o2KaORM3l2YBQyLN65YLiza3pRqAxHXpF2eEoWAbqX+l22iswORYI0INwPFVNzMGennM
         H6L5A+vojrEhWtOmwPCmEB7oNWj/Xu+VkCh1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=537QtFfNDnc1yFQW8NoRE77KyJmBz4y9urrCczx0I2I=;
        b=rJCkeOfhaR7+zP7p7QV2jYScvz3vAuIqkZfCTLn5Fu4QHKQeohBgjHuAFFdJt2W5an
         tITjtSJHi9U3/+c8IU4LzePy0omTUExSuFWHFYOn8j6ZQ/yk6nhYQbXiSBleTCPq04Gu
         N6986g6oKL/2JVRPPz1sltq+no7zNzIYtFfzWjraY8BeRGYVGPqbPF8se/VBaDJGrfAC
         NChxwc15fI5jkskbuhq1Wb9wmhww4hiRDw600YWVYs6Kd5UsEhgAtptNEMSPJjDW14Zk
         9vwC22s+QgaedNcNDmiQ3i/JZO2nQsZyXg55NHs+XPbU2rokhsPl4k/Vf0mr9FwF5w1j
         gPFw==
X-Gm-Message-State: AOUpUlFjryaRlKnmoiz4vHoLqzu8g+Ddq7r2Y8lbGb9J0zmqAv1z551k
        9C+vXrQaX9JgN3iDtvvMnlmz+s3mrIA/yel6q4tMRA==
X-Google-Smtp-Source: AAOMgpemAckd6DICfC+ffwOE8Km5snL+10THiaOq+9P/FNWi5z5t2DUWHm5WwPHDSqG/xY69pKMxzFgRYv5f2uqUZAY=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr12184234itb.38.1532900162773;
 Sun, 29 Jul 2018 14:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <1532433463-42508-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1532433463-42508-1-git-send-email-zhongjiang@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 23:35:43 +0200
Message-ID: <CACRpkda3NDLcmf=_6fp5fKwFQ2ybMODdkwtKs0t=FoRWRnoJUA@mail.gmail.com>
Subject: Re: [PATCH linux-next] gpio: fix meaningless return expression
To:     zhongjiang@huawei.com
Cc:     Alban Bedel <albeu@free.fr>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 2:09 PM zhong jiang <zhongjiang@huawei.com> wrote:

> Fix the following sparse error:
>
> drivers/gpio/gpio-ath79.c:54:16: error: return expression in void function
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Patch applied with Alban's ACK.

Yours,
Linus Walleij
