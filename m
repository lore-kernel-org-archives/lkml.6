Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D34AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D622720666
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SaZBpcoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D622720666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbeIZWX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:23:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53924 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeIZWXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wq7ISVzsJDUIsC2v5kxwtm3ZttxBOJm1KM5Ze+GtpdI=; b=SaZBpcoan4NBHmslqQXLGQgY9G
        KIVovBDrhMeGPNZxlIHy5EgEEgUulRxDrwFll90q8t/ZIjYSabs0xg95nKRHz4L7yL+0rHj49WAFP
        /1aSWtee9fGT9UW0T9PCi9VLCbN3K8pTLmoDwXChVgEuZPAQPncPpVm21524HZUhpXPMi9bWCRVWq
        PxfXNg5KkN908LIdxi/+q3reaa+Zotipcpx5lkB8g+wChOVcj+ABOqTVwTxGh0Udsvkwiz+SR2Od+
        ZGA2LsrEriyshJpSc9fPqgufcC2WFmuIJyqNrKgjR5VtETs/DAsuAoofP46C2pY7uZU4ky4zG+t5S
        64yXXfFg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5CNs-0001FJ-GP; Wed, 26 Sep 2018 16:10:12 +0000
Subject: Re: [PATCH 2/2] init: add support to directly boot to a mapped device
To:     Helen Koike <helen.koike@collabora.com>, dm-devel@redhat.com
Cc:     agk@redhat.com, snitzer@redhat.com, linux-kernel@vger.kernel.org,
        enric.balletbo@collabora.com, wad@chromium.org,
        linux-doc@vger.kernel.org, linux-lvm@redhat.com,
        kernel@collabora.com
References: <cover.1537936397.git.helen.koike@collabora.com>
 <2c01b2a43a46fab760208d7af3a7af37eec8c41a.1537936397.git.helen.koike@collabora.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c0da1483-4d82-0e13-d03b-9ee8ea6a9d84@infradead.org>
Date:   Wed, 26 Sep 2018 09:09:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <2c01b2a43a46fab760208d7af3a7af37eec8c41a.1537936397.git.helen.koike@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/18 10:00 PM, Helen Koike wrote:
> From: Will Drewry <wad@chromium.org>
> 
> Add a dm= kernel parameter modeled after the md= parameter from
> do_mounts_md. It allows for device-mapper targets to be configured at
> boot time for use early in the boot process (as the root device or
> otherwise).
> 
> Signed-off-by: Will Drewry <wad@chromium.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> [rework to use dm_ioctl calls]
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> [rework to use concise format | rework for upstream]
> Signed-off-by: Helen Koike <helen.koike@collabora.com>

Hi,

A few small comments inline...

> ---
>  .../admin-guide/kernel-parameters.rst         |   1 +
>  .../admin-guide/kernel-parameters.txt         |   3 +
>  Documentation/device-mapper/dm-boot.txt       |  63 +++
>  init/Makefile                                 |   1 +
>  init/do_mounts.c                              |   1 +
>  init/do_mounts.h                              |  10 +
>  init/do_mounts_dm.c                           | 475 ++++++++++++++++++
>  7 files changed, 554 insertions(+)
>  create mode 100644 Documentation/device-mapper/dm-boot.txt
>  create mode 100644 init/do_mounts_dm.c

> diff --git a/Documentation/device-mapper/dm-boot.txt b/Documentation/device-mapper/dm-boot.txt
> new file mode 100644
> index 000000000000..f598f102c980
> --- /dev/null
> +++ b/Documentation/device-mapper/dm-boot.txt
> @@ -0,0 +1,63 @@
> +Boot time creation of mapped devices
> +====================================
> +
> +It is possible to configure a device mapper device to act as the root
> +device for your system in two ways.
> +
> +The first is to build an initial ramdisk which boots to a minimal
> +userspace which configures the device, then pivot_root(8) in to it.
> +
> +The second is to possible when the device-mapper and any targets are

parse error:  ^^^^^^^^^^^^^^

> +compiled into the kernel (not a module), one or more device-mappers may
> +be created and used as the root device at boot time with the parameters
> +given with the boot line dm=...
> +
> +The format is specified as a simple string of data separated by commas and

for some definition of "simple".

> +optionally semi-colons, where:
> + - a comma is used to separate fields like name, uuid, flags and table (specifies
> +   one device)
> + - a semi-colon is used to separate devices.
> +
> +So the format will look like this:
> +
> + dm=<name>,<uuid>,<minor>,<flags>,<table>[,<table>+][;<dev_name>,<uuid>,<minor>,<flags>,<table>[,<table>+]]
> +
> +Where,
> +	<dev_name>	::= The device name.
> +	<uuid>		::= xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | ""
> +	<minor>		::= The device minor number.
> +	<flags>		::= "ro" | "rw"
> +	<table>		::= <start> <length> <type> <options>
> +	<type>		::= "verity" | "bootcache" | ...
> +
> +The dm line may be as normal when using the dmsetup tool when using the
> +--concise argument.
> +
> +Examples
> +========
> +An example of booting to a linear array made up of user-mode linux block
> +devices:
> +
> +  dm="lroot,,,rw, 0 4096 linear 98:16 0, 4096 4096 linear 98:32 0" \
> +  root=/dev/dm-0
> +
> +This will boot to a rw dm-linear target of 8192 sectors split across two
> +block devices identified by their major:minor numbers.  After boot, udev
> +will rename this target to /dev/mapper/lroot (depending on the rules).
> +No uuid was assigned.
> +
> +An example of multiple device-mappers, with the dm="..." contents shown
> +here split on multiple lines for readability:
> +
> +    vboot,,ro,
> +      0 1768000 bootcache
> +        aa55b119-2a47-8c45-946a-5ac57765011f+1
> +        76e9be054b15884a9fa85973e9cb274c93afadb6
> +        1768000 100000 23 20000;
> +    vroot,,ro,
> +      0 1740800 verity 254:0 254:0 1740800 sha1
> +        76e9be054b15884a9fa85973e9cb274c93afadb6
> +        5b3549d54d6c7a3837b9b81ed72e49463a64c03680c47835bef94d768e5646fe;
> +    vram,,rw,
> +      0 32768 linear 1:0 0,
> +      32768 32768 linear 1:1 0

> diff --git a/init/do_mounts_dm.c b/init/do_mounts_dm.c
> new file mode 100644
> index 000000000000..507ae31808ef
> --- /dev/null
> +++ b/init/do_mounts_dm.c
> @@ -0,0 +1,475 @@
> +// SPDX-License-Identifier: <SPDX License Expression>
> +
> +/*
> + * do_mounts_dm.c
> + * Copyright (C) 2017 The Chromium OS Authors <chromium-os-dev@chromium.org>
> + * Based on do_mounts_md.c
> + *
> + * This file is released under the GPLv2.
> + */
> +#include <linux/async.h>
> +#include <linux/ctype.h>
> +#include <linux/device-mapper.h>
> +#include <linux/fs.h>
> +#include <linux/string.h>
> +#include <linux/delay.h>
> +
> +#include "do_mounts.h"
> +
> +#define DM_MAX_DEVICES 256
> +#define DM_MAX_NAME 32
> +#define DM_MAX_UUID 129
> +
> +#define DM_MSG_PREFIX "init"
> +
> +#define is_even(a) (((a) & 1) == 0)
> +
> +/* See Documentation/device-mapper/dm-boot.txt for dm="..." format details. */
> +
> +struct target {
> +	sector_t start;
> +	sector_t length;
> +	char *type;
> +	char *params;
> +	/* simple singly linked list */
> +	struct target *next;
> +};
> +
> +struct dm_device {
> +	int minor;
> +	int ro;
> +	char name[DM_MAX_NAME];
> +	char uuid[DM_MAX_UUID];
> +	struct target *table;
> +	int table_count;
> +	/* simple singly linked list */
> +	struct dm_device *next;
> +};
> +
> +static struct {
> +	unsigned long num_devices;
> +	char *str;
> +} dm_setup_args __initdata;
> +
> +static int dm_early_setup __initdata;
> +

// @a: must be a power of 2

> +static void __init *_align(void *ptr, unsigned int a)
> +{
> +	register unsigned long agn = --a;
> +
> +	return (void *) (((unsigned long) ptr + agn) & ~agn);
> +}


thanks.
-- 
~Randy
