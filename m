Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112D5C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B43208A5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B43208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbeG0N2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:28:52 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42675 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbeG0N2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:28:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id r4-v6so3756613edp.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 05:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9oC6Si718hlZRxlNrMpx5GRpwqAukuLmKjMgDdFUAUQ=;
        b=PzE7UwlQLkLxLfzxc96nC2khwZkBCKI4L4rZ/ia1CYbp39/9ZqJg0YW3BFw6lz3/0/
         C/Rsv6n+UYSpJm5+Is18zhwFdAvceCR599jjh0Mm3WK1yMvVkL6N1Ze8qY08GwcfOKgU
         1le40X6r7rlNCLZxJPbwcWm36TJVZ5MMj+V1p6yaDfIv4Te7EjklL8t6R1CXpGxhxpmH
         dcJS0NWql54xQe2h4eo9wN4F+kurZDn18fYxAXHi0UeO007j2Oh8th5ZM4ozmi/X2rDD
         NhUO5NMKWZJPJoGRbZ3FuSVSX0Xx8RS3vp+zs6YX/9grsy5A9njJQMK9YQcjWz3eZJVn
         d0ew==
X-Gm-Message-State: AOUpUlHzEu6B7pi8Nq7iV+Sz7kUTpd0jcs/dEybLsu7SCIP896WUNy3k
        Q5TvvEcC2tZwusj35xl3dfe/fw==
X-Google-Smtp-Source: AAOMgpdCjtFMSZsqmCHYH21BUcWLsPskK1flU3NB5lSDaCSRXDLTuWn07kctaozc4n074+swxlXDiw==
X-Received: by 2002:a50:a305:: with SMTP id 5-v6mr7214425edn.57.1532693233782;
        Fri, 27 Jul 2018 05:07:13 -0700 (PDT)
Received: from localhost.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id x8-v6sm1862484edr.24.2018.07.27.05.07.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 05:07:13 -0700 (PDT)
Subject: Re: [PATCH] i2c: enable async suspend/resume on i2c devices
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Derek Basehore <dbasehore@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        venkateswarlu.v.vinjamuri@intel.corp-partner.google.com
References: <20180726225508.74612-1-dbasehore@chromium.org>
 <CAHp75VfXXdzmp7M8rpcYTTKzwMT=QKt=_m7m7Bfp7uM4izMkrQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1c3aba3d-0dfb-dc24-bd7a-5289a19a9065@redhat.com>
Date:   Fri, 27 Jul 2018 14:07:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfXXdzmp7M8rpcYTTKzwMT=QKt=_m7m7Bfp7uM4izMkrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/27/2018 12:44 PM, Andy Shevchenko wrote:
> On Fri, Jul 27, 2018 at 1:55 AM, Derek Basehore <dbasehore@chromium.org> wrote:
>> This enables the async suspend property for i2c devices. This reduces
>> the suspend/resume time considerably on platforms with multiple i2c
>> devices (such as a trackpad or touchscreen).
> 
> How did you test this?
> 
> Especially on Chromebooks based on Intel Cherrytrail / Braswell
> platforms, they have a painful PMIC vs. OS design solution.
> 
> +Cc: Hans, who did a lot in this area.

We disable suspend of the i2c controller for the i2c-bus
to which the PMIc is connected on these platforms, so I do not
expect this to cause any new issues.

But this is something to keep an eye on,

Regards,

Hans

