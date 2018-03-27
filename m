Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbeC0Gdg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 02:33:36 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35579 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752446AbeC0Gdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 02:33:33 -0400
X-Google-Smtp-Source: AG47ELvhVwyX8vxT0wnsjMmsdr62Dl9JWiNnfE3yWe10zOXZiPLo1XMXPaW6egxNQTK2hxuB/VulpQ==
Subject: Re: [PATCH script] hwmon: Use octal not symbolic permissions
To: Joe Perches <joe@perches.com>, Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        patches@opensource.cirrus.com
References: <1522096136.12357.21.camel@perches.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <9b112651-d0cf-5f3b-b643-3328028a95cd@roeck-us.net>
Date: Mon, 26 Mar 2018 23:33:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522096136.12357.21.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/2018 01:28 PM, Joe Perches wrote:
> drivers/hwmon is the most frequent user of symbolic permissions
> like S_IRUGO in the kernel tree.
> 
> $ git grep -w -P "S_[A-Z]{5,5}" | \
>    cut -f1 -d: | cut -f1-2 -d"/" | sed -r 's/[A-Za-z0-9_-]+\.[ch]$//' | \
>    sort | uniq -c | sort -rn | head
>     3862 drivers/hwmon
>      814 drivers/scsi
>      763 drivers/net
>      242 drivers/infiniband
>      184 drivers/staging
>      181 drivers/usb
>      158 fs/proc
>      150 fs/xfs
>      148 fs/
>      142 drivers/misc
> 
> But using octal and not symbolic permissions is preferred by many
> as it can be more readable.
> 
> https://lkml.org/lkml/2016/8/2/1945
> 
> Rather than converting these piecemeal, perhaps just do them all
> at once via a trivial script like the below:
> 
> $ git grep -w -P --name-only "S_[A-Z]{5,5}" drivers/hwmon | \
>    xargs ./scripts/checkpatch.pl -f --types=symbolic_perms --fix-inplace
> $ git grep -w -P --name-only "S_[A-Z]{5,5}" drivers/hwmon | \
>    xargs ./scripts/checkpatch.pl -f --types=symbolic_perms --fix-inplace
> 
> It's run twice because checkpatch only does 1 conversion per line
> and there are some multiple instance lines.
> 
> This currently results in a 669 KB patch which is too large
> to post but can be easily generated when appropriate.

I have something similar using coccinelle, which has the added benefit
of also adjusting multi-line alignments. But then I am hesitant to pull
it in because I don't really see the point. A more intelligent approach
would be to convert hwmon drivers to the latest API, and/or to introduce
more intelligent macros such as SENSOR_DEVICE_ATTR_{RO,RW,WO}. But that
would require active work as well as reviewers, and especially the latter
is extremely difficult if not impossible to find for the hwmon subsystem.

Since the hwmon subsystem has been labeled as both "obsolete" and "obscure",
that is maybe not entirely surprising, and I think we are good as we are.
I am happy to accept patches updating permissions as other changes are made
to a file, but I don't see a pressing need to change all files just to make
statistics happy (and backports more difficult).

Guenter
