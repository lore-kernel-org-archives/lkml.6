Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7B3C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BC12084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ayDJrFsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0BC12084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeH2Mvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:51:43 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40352 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2Mvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:51:42 -0400
Received: by mail-io0-f193.google.com with SMTP id l14-v6so3825026iob.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 01:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBRXBjsL1VhXqExfmF1WJwft81XgHTOJ8G2Qg+8YTgM=;
        b=ayDJrFsYmy4T0AAVveEjL2HuNri9NdGzJOVqmLiyHfsw9gzScwXKDxe71pe0oWRtBC
         X34bgECUndwl5eIyfsy02axZE/xxte8sTHmwJuLEIOScqUHoxUskNaZ8q7h1TGDXePmr
         UKvfNtggbbc0ezX5X7liWIo415PcIxwCzcHeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBRXBjsL1VhXqExfmF1WJwft81XgHTOJ8G2Qg+8YTgM=;
        b=o4Pz7/IlQzSBl5aSjKSeBo/q9BQqJpHbiOi7gwqdvLbbGiiSyLk8m80jo11Hf+u0c1
         pjK2Zfyl0Wyr9Ume4WYyICJba7Q+c9CkU1E9YD0GSSOVPRUelby7cWKHwCeU0vG/nVSg
         F33TU64d71NS0xCMVJHx3ubmV1Nb7yI5ZLd8rhAGSTTsyUuji0ynyv8nqOTn6NUwdBl9
         74YJZt+OLizDPK4/ck7lZ1CA87GzLEu6aPObTRydwcvN1rHeQ4OpWNGiv6B6DoxFdR9q
         pQf+lCnzpFBbO4XcOVHDstrSHsw5ltBFc6jvXEKGgd0k2j3//77dL492QmOCXRpRC4Cs
         zYpw==
X-Gm-Message-State: APzg51AvQMFdedhgu85H496Qlm1D0Dvd1Iw4BD1PmqCJMTjrr+53ISz6
        /FDVNnMi5s5sqlsmeMHdF9pwIf5QO/1avSMDvK9jRw==
X-Google-Smtp-Source: ANB0VdaKlmBkEzHimBswwq108VEyRAAfOEVc56E9aDQjdz7CukEKbrcST6oVZs/KOyb38RTaY3bWJ5JLUJTRrtLdx84=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr4311677iof.304.1535532949598;
 Wed, 29 Aug 2018 01:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <1534168664-13034-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1534168664-13034-1-git-send-email-michael.hennerich@analog.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 10:55:38 +0200
Message-ID: <CACRpkdbw3DwYO=W7m5AaNkg8QZmCf+7yM4fNs7tBVDZgVma2wg@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpio: gpio-adp5588: Fix sleep-in-atomic-context bug
To:     Michael Hennerich <michael.hennerich@analog.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 3:53 PM <michael.hennerich@analog.com> wrote:

> From: Michael Hennerich <michael.hennerich@analog.com>
>
> This fixes:
> [BUG] gpio: gpio-adp5588: A possible sleep-in-atomic-context bug
>                           in adp5588_gpio_write()
> [BUG] gpio: gpio-adp5588: A possible sleep-in-atomic-context bug
>                           in adp5588_gpio_direction_input()
>
> Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

Thanks Michael, excellent and prompt fix. Patch applied
for fixes (v4.19-rcs).

Should we even tag it for stable?

Yours,
Linus Walleij
