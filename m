Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A49FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB61421480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB61421480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbeHQAUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 20:20:55 -0400
Received: from mail-yw1-f48.google.com ([209.85.161.48]:41079 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeHQAUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 20:20:54 -0400
Received: by mail-yw1-f48.google.com with SMTP id q129-v6so3658232ywg.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 14:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GV7MLnKSSKkwmYSbeFUjXakbD8pfo4B7R+wT1iY5rpI=;
        b=ix+z3A2wwIUwSpd8uzV568+MacAUqel7e67aoMFJ+N+ApMVHKCthU8F4lpAhYeihDT
         ftCCJ7lMW2rtqerLQIE/6xE2Id1Ah8YzFnEKTafcw9TKdgtjY0W2yRN+dearzIvnlSYI
         QESPkvt7sUaHb7brFH8G6zlEbzFhd94ZrTfeQ0U5MQ+nChmuTwwjygXaJqIvuLEd/59j
         FoGSYuXGfbd/56UuWOAMNJsgaEOIabtDqhZyx8rC4k3sOlkFDlIoVKHarhsMHk9bubSK
         yjdhU7v12lhqeoKZ+dIGt/dRFn6jJeaPpOcyAZuCOHXaw5NOKcUfLO+XmvGnpxw7vRqf
         8l+g==
X-Gm-Message-State: AOUpUlE5Hp4KUdRBPKUkxDSoCZxrN3a5Ec52MpcK+Q8VTyGB/9YHDv9d
        v55hMbtzerLbfLJlN3BYYfQ=
X-Google-Smtp-Source: AA+uWPxGTNj26MRd2Bwh4b/x6H0yxdq+VGwm9CerW/xE3t4KWQrQh2O3DjQnisjjXeurgAF/EWrA0w==
X-Received: by 2002:a81:9ecf:: with SMTP id v198-v6mr18410678ywg.201.1534454411651;
        Thu, 16 Aug 2018 14:20:11 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:601c:55dc:cc7e:5472? ([2600:1700:65a0:78e0:601c:55dc:cc7e:5472])
        by smtp.gmail.com with ESMTPSA id 64-v6sm140565ywg.106.2018.08.16.14.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 14:20:10 -0700 (PDT)
Subject: Re: [PATCH v2] Bugfix for handling of shadow doorbell buffer.
To:     Michal Wnukowski <wnukowski@google.com>,
        torvalds@linux-foundation.org
Cc:     axboe@fb.com, hch@lst.de, keith.busch@intel.com,
        keith.busch@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, yigitfiliz@google.com
References: <CA+55aFxOc7_s-BbWJx-kyit-pH9m5fQJk6MSMJ57tFFvMtNh-w@mail.gmail.com>
 <20180815225157.89523-1-wnukowski@google.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f4bfde7e-96e5-0751-2248-78b5912aa03b@grimberg.me>
Date:   Thu, 16 Aug 2018 14:20:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180815225157.89523-1-wnukowski@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 17a0190bd88f..4452f8553301 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -306,6 +306,14 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
>   		old_value = *dbbuf_db;
>   		*dbbuf_db = value;
>   
> +		/*
> +		 * Ensure that the doorbell is updated before reading
> +		 * the EventIdx from memory. NVMe controller should have
> +		 * similar ordering guarantees - update EventIdx before
> +		 * reading doorbell.
> +		 */
> +		mb();
> +
>   		if (!nvme_dbbuf_need_event(*dbbuf_ei, value, old_value))
>   			return false;
>   	}

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
