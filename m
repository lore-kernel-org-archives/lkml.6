Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E377EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE9D20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE9D20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeICLgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 07:36:19 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:54834 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeICLgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 07:36:19 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id D4C5515AF4B;
        Mon,  3 Sep 2018 16:17:28 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w837HR4q018546
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Sep 2018 16:17:28 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w837HRw5001540
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Sep 2018 16:17:27 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id w837HRrM001539;
        Mon, 3 Sep 2018 16:17:27 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: Relax checks for sector size and media type
References: <20180902131932.11558-1-pali.rohar@gmail.com>
Date:   Mon, 03 Sep 2018 16:17:26 +0900
In-Reply-To: <20180902131932.11558-1-pali.rohar@gmail.com> ("Pali
 =?iso-8859-1?Q?Roh=E1r=22's?=
        message of "Sun, 2 Sep 2018 15:19:32 +0200")
Message-ID: <87bm9ft5h5.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Rohár <pali.rohar@gmail.com> writes:

> Windows fastfat.sys driver accepts also media types 0x00 and 0x01 and
> sector sizes 128 and 256 bytes. Linux mkfs.fat can format disk also to
> larger FAT sector sizes then 4096 bytes, therefore relax also upper limit
> restriction.

> -	if (!is_power_of_2(bpb->fat_sector_size)
> -	    || (bpb->fat_sector_size < 512)
> -	    || (bpb->fat_sector_size > 4096)) {
> +	if (!is_power_of_2(bpb->fat_sector_size)) {

Just relaxing validation doesn't work. The block layer doesn't support
smaller than 512, and lager than PAGE_SIZE.  (And in specification, fat
doesn't support lager than 4096.)

>  static inline int fat_valid_media(u8 media)
>  {
> -	return 0xf8 <= media || media == 0xf0;
> +	return 0xf8 <= media || media == 0xf0 || media == 0x00 || media == 0x01;
>  }
>  #endif /* !_LINUX_MSDOS_FS_H */

This is ok though, this would be for ancient floppy media.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
