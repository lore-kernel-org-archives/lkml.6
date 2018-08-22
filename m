Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34F4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC39208DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC39208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeHWBKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 21:10:22 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:55769 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeHWBKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 21:10:22 -0400
Received: from [148.252.241.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fsauk-0003A9-TY; Wed, 22 Aug 2018 22:43:43 +0100
Message-ID: <1534974222.2902.15.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 40/43] loop: add recursion validation to
 LOOP_CHANGE_FD
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Theodore Tso <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Date:   Wed, 22 Aug 2018 22:43:42 +0100
In-Reply-To: <20180716073516.296730239@linuxfoundation.org>
References: <20180716073511.796555857@linuxfoundation.org>
         <20180716073516.296730239@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-16 at 09:36 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Theodore Ts'o <tytso@mit.edu>
> 
> commit d2ac838e4cd7e5e9891ecc094d626734b0245c99 upstream.
> 
> Refactor the validation code used in LOOP_SET_FD so it is also used in
> LOOP_CHANGE_FD.  Otherwise it is possible to construct a set of loop
> devices that all refer to each other.  This can lead to a infinite
> loop in starting with "while (is_loop_device(f)) .." in loop_set_fd().
> 
> Fix this by refactoring out the validation code and using it for
> LOOP_CHANGE_FD as well as LOOP_SET_FD.
[...]
> +static int loop_validate_file(struct file *file, struct block_device *bdev)
> +{
> +	struct inode	*inode = file->f_mapping->host;
> +	struct file	*f = file;
> +
> +	/* Avoid recursion */
> +	while (is_loop_device(f)) {
> +		struct loop_device *l;
> +
> +		if (f->f_mapping->host->i_bdev == bdev)
> +			return -EBADF;
> +
> +		l = f->f_mapping->host->i_bdev->bd_disk->private_data;
> +		if (l->lo_state == Lo_unbound) {
> +			return -EINVAL;
> +		}
> +		f = l->lo_backing_file;

This looks racy; I don't see anything that prevents a lower loop device
from being reconfigured while this walks down the device stack.

(But this isn't a new problem.)

Ben.

> +	}
> +	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
> +		return -EINVAL;
> +	return 0;
> +}
[...]

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
