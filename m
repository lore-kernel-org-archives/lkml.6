Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A4FC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4821527444
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BV+UUIHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4821527444
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966495AbeF1OPA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:15:00 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35381 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965894AbeF1OO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:14:59 -0400
Received: by mail-it0-f66.google.com with SMTP id l16-v6so12006011ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e2pYU8liiPL9V9Nn/6SvHZMuKNe009daXkOb/03LCxk=;
        b=BV+UUIHmlpwmRHojwFIHn/EfoztkreRQr/AuSVsKegw9azgglPZw1nH5qrOipLicxy
         H04CKnTOQBWee6cANc3XWhqate4cBFJITXl+M6BpsPbeTxRBdbOnmGeoM8K7aDUse2rq
         LP4KbjuVrN3wLFYYw81QuyutJbguMW7W+Fk1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e2pYU8liiPL9V9Nn/6SvHZMuKNe009daXkOb/03LCxk=;
        b=Dlz1UPV+nnOWxOVIu7ruGcFZVtV8jY07WhSJYfn+9849ZZwOZE+SJtK2XhJuvHLD62
         lZ7BcjLd3lJMO7Pe5K0ZPSt6SNHu0fiFFlXKs/9e2r9hkPNCoWkGbLVlFco4GvFelH1a
         lsiikxjlN0AoKOBIRtqxPo90Hvhc+h53OQlQdt889v13Gk4ogzpkHV4NwRem+PiULUtm
         8+6Dpuar3n/bpo74vKiKhGyA2mJ+s680bzkCUmK/OLfYVuZDUcuNZFqj5zSFXTpFcCVQ
         rm30aNfyYLpS67M14+hv9KVOYT0ThCEExFyh5WOC3Nrm/EqgHNK4uK4GcTXFRBLhsUCY
         XRoA==
X-Gm-Message-State: APt69E1kRbG/M3xgWyFUPGYPquXhAv3uJYKzWAtN+vBykCOaspUz5Sqw
        q4wlt9m866nXgp2argl6D8SAGHW/AEoMMh0ECJOij7pJ
X-Google-Smtp-Source: AAOMgpeDQpfFlFm5QXm2q1QZlGzpgiXBca/kIzrPeRJrWlkEv/JRYRMX1NVNsjHlERzqdrF+2YyTk7ERa7MLXgJYA0E=
X-Received: by 2002:a24:5746:: with SMTP id u67-v6mr8520666ita.38.1530195297173;
 Thu, 28 Jun 2018 07:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180618142352.3556062-1-arnd@arndb.de>
In-Reply-To: <20180618142352.3556062-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Jun 2018 16:14:45 +0200
Message-ID: <CACRpkdYjXeb=XzdbKDGrt+fp5arkWuH_GS9FAkygqsovtjw70g@mail.gmail.com>
Subject: Re: [PATCH] power: supply: ab8500: stop using getnstimeofday64()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 4:23 PM Arnd Bergmann <arnd@arndb.de> wrote:

> getnstimeofday64() is deprecated in favor of the ktime_get() family.
>
> The direct replacement would be ktime_get_real_ts64(), but we only need
> the seconds value, and it seems better to use boottime than real time
> to avoid unexpected behavior with a concurrent settimeofday().
>
> ktime_get_seconds() might also work, but it seems better to use
> boottime than monotonic time since I assume that the charging
> process continues during suspend.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
