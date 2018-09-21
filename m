Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E69C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18C82154B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8ylbvqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18C82154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388809AbeIUG6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 02:58:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33279 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeIUG6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 02:58:36 -0400
Received: by mail-io1-f67.google.com with SMTP id r196-v6so10599176iod.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 18:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=igI8G2gByOR1QVu3jR/S0ca3gySr/uG/4VCZHJX5Y14=;
        b=R8ylbvqD69MSJTs4c9ZpdqsUcS7QRIU6mHETrd8ZV351pwh8f9ox8/JBTklLudIWAe
         Zh+WvsOdtbt6r+f8RVYvu1VQzCkRTjKG/NaAHIFiyveFN90FsAuTNtyHWvtiq8jH488i
         EkXYZMysp4A/OBJGV3D8E20w/bpXXkCiLuNhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=igI8G2gByOR1QVu3jR/S0ca3gySr/uG/4VCZHJX5Y14=;
        b=PqtjrnMajOlY9EZ1feyJuP38QnwYs1pViyPwMJPHPRxhHrdsqph2zUGdJDv1ofuMG8
         N4Lz2yCdiGT1q2XNmzAQeH8r7UyWZndHvJQlsC522+3tO4B+3Xjjnk7pu7CKgObnY7gA
         51CH/479j7VvjQLA0W3Ixx1tQBKJuJyn47VCeI3kBPT8QCXs8l5j6o4ak3ao0NCZG4Ii
         7jpQ/CJL5XuUe2HVjhs+P7PCz7IcUDWvQV2CujlTK97rTZGa7kZGDOsL3b5EQRHnJmxJ
         bD23V44wA7u3kEMbDb46yPTgClEceAzdzPiYp42+qW79EWDU1zQesZ6I/nkK4JOkGAl6
         0HvA==
X-Gm-Message-State: APzg51DWDuG85HvS6Cj6ISdfXttrzLlZvp2eO8MMZOHRSFAtbazvdmdz
        PnRPIBQhjD1644mMvwCupDdRRA==
X-Google-Smtp-Source: ANB0VdZPOiXyC6lgWrm5kUcVWgXMFUGZ1LIztPSwnENI7PFxqajJ+IlEuaCCYEdH7+GXElF4Te6mWA==
X-Received: by 2002:a6b:bbc1:: with SMTP id l184-v6mr25400760iof.83.1537492338500;
        Thu, 20 Sep 2018 18:12:18 -0700 (PDT)
Received: from [10.199.96.233] ([209.82.80.116])
        by smtp.googlemail.com with ESMTPSA id f74-v6sm1574370itf.20.2018.09.20.18.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 18:12:17 -0700 (PDT)
Subject: Re: [PATCH v4 15/22] nvmem: add support for cell lookups from machine
 code
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180914144011.27614-1-brgl@bgdev.pl>
 <20180914144011.27614-16-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <822f2631-43e3-b4e8-91f6-8c8e94be3dde@linaro.org>
Date:   Thu, 20 Sep 2018 18:12:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180914144011.27614-16-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/09/18 07:40, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add a way for machine code users to associate devices with nvmem cells.
> 
> This restores the support for non-DT systems but following a different
> approach. Cells must now be associated with devices using provided
> routines and data structures before they can be retrieved using
> nvmem_cell_get().
> 
> It's still possible to define cells statically in nvmem_config but
> cells created this way still need to be associated with consumers using
> lookup entries.
> 
> Note that nvmem_find() must be moves higher in the source file as we
> want to call it from __nvmem_device_get() for devices that don't have
> a device node.
> 
> The signature of __nvmem_device_get() is also changed as it's no longer
> used to retrieve cells.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/nvmem/core.c           | 129 ++++++++++++++++++++++++++-------
>   include/linux/nvmem-consumer.h |  28 +++++++
>   2 files changed, 131 insertions(+), 26 deletions(-)

This patch and other follow on patches for core.c does not apply on top 
of 
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/log/?h=char-misc-next

Please rebase and send!

thanks,
srini
