Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3433C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A092B2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YRiqs79k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A092B2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeIJNsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:48:04 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:41256 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeIJNsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:48:04 -0400
Received: by mail-wr1-f49.google.com with SMTP id z96-v6so20999430wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CPaIQKU5+K002VCRA5S3jcqkWBDbKxtd81exWX28UQ8=;
        b=YRiqs79kFH1m2/ODCYjEvb+O9NHsmVFvfZLjlNMYHlyMwzbvnZE5ym4A3KtNx1LL/2
         t1hvDFsrkGFieQUEidyk605nylTV/vmcTmhiw4YdInK0nkEhO3Ee/boZ52CJ9GpXNKnK
         vEEqn3TAwyyPo9SSmRUm58/wCpTqKkzzI9wVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CPaIQKU5+K002VCRA5S3jcqkWBDbKxtd81exWX28UQ8=;
        b=EvLYnmz1WQWnuviatWEK+PpoS8qekBzwy5bEQsQ7XncZnTCeVkERwFxT6w0AcG4R8l
         DRkMUjba9KGgwtLRwFBHlK70JLVovl9jdqunUZTmaGlalQTTSZUIPChQWhHSxCowJtNn
         VKSAB1LKhzGurAMyQ0ChmOVDqjLaHnYo7qKc8KvUeL25QSNQcXbxU3n4aWXXpQq5uqqw
         kslkxSN+oZXeNu/8s8C3E4HoRXJq0cYT/vMqH/Cp2wR2D7emKRyAuBs53MvPhV7nqrzH
         M/3BmxNiCDd3KmfujWbUdLL+uxebl4QcFtjeWYJ2K8e7d8+f6hJwgbqJLPNc7WoPwS7J
         O5rA==
X-Gm-Message-State: APzg51AX3TEynmdLTkY3gxkR2Uu0IvKEFNh7BbyHs2JosXNKLadv1KNV
        PDQSX1qLIOyNja8JUW8y4S0yig==
X-Google-Smtp-Source: ANB0VdYENax8bujPK7i0+KglifarD3fcslEJ7UysYLOrxhK0DxbWX//4B1iHRm5ixBa1hsaIqF8H2w==
X-Received: by 2002:adf:a196:: with SMTP id u22-v6mr14357174wru.50.1536569703353;
        Mon, 10 Sep 2018 01:55:03 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id p11-v6sm16738466wrd.74.2018.09.10.01.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 01:55:02 -0700 (PDT)
Subject: Re: [PATCH v2 13/16] nvmem: add support for cell lookups from machine
 code
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-14-brgl@bgdev.pl>
 <484b6ec5-cd8e-e5c5-0c5c-2f11c504ea1c@linaro.org>
 <CAMRc=MdnSHY1ah4X3Bu55HvZcOQHxPHaFudidDA4mEOW9ZzeEg@mail.gmail.com>
 <20180910102324.52ecd8f7@bbrezillon>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c72866dd-1fb0-c765-5815-ba63d051a09b@linaro.org>
Date:   Mon, 10 Sep 2018 09:55:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180910102324.52ecd8f7@bbrezillon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/18 09:23, Boris Brezillon wrote:
> Well, if we get rid of nvmem-machine.h, the cell-lookup stuff
> should go in nvmem-consumer.h not nvmem-provider.h. On the other hand,
> everything that is related to cell creation should be placed in
> nvmem-provider.h.
Yes, this is how it should be!

--srini
