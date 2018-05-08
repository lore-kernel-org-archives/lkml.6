Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753597AbeEHFE4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 01:04:56 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:34305 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbeEHFEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 01:04:54 -0400
X-Google-Smtp-Source: AB8JxZpsE9UaBsKnCpr6iYela12epZ1tSSbUg6qK0PGJBDIrsvEjDRh4bupSYCbhzYZoqfykRJSGDg==
Subject: Re: [PATCH] net: 8390: Fix possible data races in __ei_get_stats
To: Jia-Ju Bai <baijiaju1990@gmail.com>, davem@davemloft.net,
        fthain@telegraphics.com.au, joe@perches.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180507140809.28847-1-baijiaju1990@gmail.com>
 <e48345b4-fe9f-d267-777b-6a51baba0307@gmail.com>
 <d4de4f6c-c697-fde5-9d31-d8792621bfb5@gmail.com>
 <c336fdb9-4865-4729-d34b-84dd0bfc9af5@gmail.com>
 <6fe51782-2169-53c8-9bac-1715262e716d@gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <dddbec3f-4b63-3e70-d857-4980135d6f31@gmail.com>
Date: Mon, 7 May 2018 22:04:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6fe51782-2169-53c8-9bac-1715262e716d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/07/2018 07:16 PM, Jia-Ju Bai wrote:

> Yes, "&dev->stats" will not change, because it is a fixed address.
> But the field data in "dev->stats" is changed (rx_frame_errors, rx_crc_errors and rx_missed_errors).
> So if the driver returns "&dev->stats" without lock protection (like on line 858), the field data value of this return value can be the changed field data value or unchanged field data value.


We do not care.

This function can be called by multiple cpus at the same time.

As soon as one cpu returns from it, another cpu can happily modify dev->stats.ANYFIELD.

Your patch fixes nothing at all.
