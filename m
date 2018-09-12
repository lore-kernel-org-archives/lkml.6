Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4E5C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7975C206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7975C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=egervary.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeILXLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:11:04 -0400
Received: from mail.datacast.hu ([195.70.49.210]:53050 "EHLO mail.datacast.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbeILXLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:11:04 -0400
Received: from localhost (mail.hauszmann.datacast [192.168.100.108])
        by mail.datacast.hu (Postfix) with ESMTP id 630B720156
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 20:05:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.datacast.hu
Received: from mail.datacast.hu ([192.168.100.108])
        by localhost (mail.datacast.hu [192.168.100.108]) (amavisd-new, port 10024)
        with ESMTP id WXKpuY8PEzcz for <linux-kernel@vger.kernel.org>;
        Wed, 12 Sep 2018 20:05:22 +0200 (CEST)
Received: by mail.datacast.hu (Postfix, from userid 8)
        id 3488A20173; Wed, 12 Sep 2018 20:05:22 +0200 (CEST)
Received: from datacast.hu (mail.datacast.hu [IPv6:2a00:10d0:8010::d2])
        by mail.datacast.hu (Postfix) with ESMTPSA id F3EDE20156
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 20:05:21 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 12 Sep 2018 20:05:21 +0200
From:   =?UTF-8?Q?Egerv=C3=A1ry_Gergely?= <gergely@egervary.hu>
To:     linux-kernel@vger.kernel.org
Subject: Re: loop device: print_req_error - blk_update_request I/O error
In-Reply-To: <5f09fc3612e70730c4a76b410b81d83f@egervary.hu>
References: <5f09fc3612e70730c4a76b410b81d83f@egervary.hu>
Message-ID: <5e91727cab412e4d15c6ebb7a3c43b5e@egervary.hu>
X-Sender: gergely@egervary.hu
User-Agent: Roundcube Webmail/1.3.2 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Answering to myself:
It looks like ext4 lazy init does not play well with loop device.

If the ext4 filesystem was previously created with lazy init there are
I/O errors. Disabling lazy init fixes problem. Bug or feature?

Thanks,

> I'm mounting an ext4 filesystem residing on an AHCI SATA disk via loop:
>   losetup -o 64424509440 --sizelimit 34359738368 /dev/loop0 /dev/sda
>   mount -t ext4 /dev/loop0 /mnt
> 
> Works perfectly on <= 4.4.155 (latest version on 4.4.x longterm branch)
> 
> On 4.9.126 (longterm branch) I get these errors:
>   blk_update_request: I/O error, /dev/loop0, sector 23778144
