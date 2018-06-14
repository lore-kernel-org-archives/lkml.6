Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 46269C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC9A208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVr9lwB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC9A208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964855AbeFNKsv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:48:51 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45963 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755132AbeFNKsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:48:45 -0400
Received: by mail-lf0-f66.google.com with SMTP id n3-v6so8658401lfe.12;
        Thu, 14 Jun 2018 03:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WtPhsn8g9Sv+Qn5XEdB7QSsLx0z0q/vjwc5yS81f9RA=;
        b=lVr9lwB8HEI8/t7r94twEm+FqV4lqKULJAE/DEXHERgf5XnGm8swJuXrrROgAkZ8Ya
         Z8uwPCokQvc41YGcrxIoF0HAsC1vsM//4vOJP39iSPiZfeWifvLSaJbaSnEdt/FIZojg
         4ZaO8daF8TIfD4HUw2j8142d0BUxGGWhiS6b2zXb+YNjCbbsYsGqeildAEnRlZHkXZGW
         ZVxVx8C0vN775Zi+XIR4vo6zM0tZUlBm9yt5teZh8zoxxWL9TRSV9VTpfhHryCfUs6f9
         Sse3C17ojjkyGrFVycGAKdQ9VnhZbuOGeufwqcCPARb1SomzBZEXtc+IkOEjt3dDTkBI
         vmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WtPhsn8g9Sv+Qn5XEdB7QSsLx0z0q/vjwc5yS81f9RA=;
        b=g0yhz2xNj4x4+OO+mpOmG16Y8OJA58EF/g+rkNqqi5FlkI7rx379yZjLl0VXWc5oiB
         9SHVVdsqUp11HKcmuJcs3j9Zr65Lje/5D/aIcxPTZTBin3NzJSg5TrTQCB9w/PW/yAf9
         JF6OO/OTiNIMig9G9Md85NQP/4U6NNpSc70xBd0HEQjzt0KyH+JN/Vo4ukpDDdBiU4+8
         dO05PB7kVkxG3MiEXyYfx2CAWMPNu2HCS637jksK/8Lum6wrvng0tYy9YXMoQBdBbneI
         gddVloewOYO4CV1wSk8ZrdD5WRt3NVgaCKFHa29rcsFkY8dsAyCbsidYPiLn8FDvo7od
         eCCg==
X-Gm-Message-State: APt69E0EA07EbMs1vNGcFNNEFcM12RlF9+vCC2IV/qpKqQk0Cnh+vqyB
        S+lp6ZcVhjhxUHEkb+QLQvA=
X-Google-Smtp-Source: ADUXVKIcfsqtwHayWNRaIYRMIlm+jnBYnjMdRhd0MTP3OSa/cwl0DAzFtOTtolzpw6GLY1TObKnhsw==
X-Received: by 2002:a2e:5818:: with SMTP id m24-v6mr1492732ljb.84.1528973324051;
        Thu, 14 Jun 2018 03:48:44 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id j7-v6sm894613ljg.48.2018.06.14.03.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 03:48:43 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@kernel.org>)
        id 1fTPng-0002xF-NP; Thu, 14 Jun 2018 12:48:21 +0200
Date:   Thu, 14 Jun 2018 12:48:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 00/19] Dynamically load/remove serdev devices via
 sysfs*
Message-ID: <20180614104820.GC32411@localhost>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo, 

On Mon, Jun 11, 2018 at 01:52:16PM +0200, Ricardo Ribalda Delgado wrote:
> There are some situations where it is interesting to load/remove serdev
> devices dynamically, like during board bring-up or when we are
> developing a new driver or for devices that are neither described via
> ACPI or device tree.

First of all, this would be more appropriately labeled an RFC as this is
far from being in a mergeable state. Besides some implementation issues,
we need to determine if this approach is at all viable.

Second, I wonder how you tested this given that this series breaks RX
(and write-wakeup signalling) for serial ports (patch 19/24)?

Third, and as Marcel already suggested, you need to limit your scope
here. Aim at ten patches or so, and use a representative serdev driver
as an example of the kind of driver updates that would be needed. It
also looks like some patches should be squashed (e.g. the ones
introducing new fields and the first one actually using them).

> This implementation allows the creation of serdev devices via sysfs,
> in a similar way as the i2c bus allows sysfs instantiation [1].

Note that this is a legacy interface and not necessarily something that
new interfaces should be modelled after.

Johan
