Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0A6A5C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFDA2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFDA2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933073AbeFLFiM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:38:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54792 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932448AbeFLFiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:38:11 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B14ED7ABF6030;
        Tue, 12 Jun 2018 13:38:00 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.382.0; Tue, 12 Jun 2018
 13:37:54 +0800
To:     <agk@redhat.com>, <snitzer@redhat.com>, <gmazyland@gmail.com>
CC:     <wangxiongfeng2@huawei.com>, <broonie@linaro.org>, <arnd@arndb.de>,
        <joakim.bech@linaro.org>, <dm-devel@redhat.com>,
        <linux-kernel@vger.kernel.org>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: [Query] Failed to create dm-crypt device when using AEAD type
Message-ID: <33220afd-9a26-6133-ebf0-83b1268c34b7@huawei.com>
Date:   Tue, 12 Jun 2018 13:37:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dm-crypt maintainers,

Recently, I was testing the dm-crypt, but I failed to create dm-crypt device when using AEAD type.
I would really appreciate it if you could give some help.
The error info is as follows:
localhost:~ # export SIZE_INT=997376
8 J 0"ost:~ # dmsetup create integ1 --table "0 $SIZE_INT integrity /dev/sdd2 0 2
localhost:~ #
dom \host:~ # dmsetup create crypt1 --table "0 $SIZE_INT crypt capi:gcm(aes)-ran
>  11ff33c6fb942655efb3e30cf4c0fd95f5ef483afca72166c530ae26151dd83b \
>  0 /dev/mapper/integ1 0 1 integrity:28:aead"
[ 1746.631559] device-mapper: crypt: Integrity AEAD, tag size 16, IV size 12.
[ 1746.649796] device-mapper: crypt: INTEGRITY AEAD ERROR, sector 997248
[ 1746.656382] device-mapper: crypt: INTEGRITY AEAD ERROR, sector 997248
[ 1746.662826] Buffer I/O error on dev dm-3, logical block 124656, async page read

I tested it both on qemu and hardware, and it printed the same error.
The error seems always on the last several sectors within the SIZE_INT I designated.
When I change the SIZE_INT, the error sector num also change.
I think something went wrong in the software, not the hardware.

My board don't have AEAD accelerator, so it uses the software implemented cipher.
My kernel version is 4.17-rc3.

The command is as follows:
export SIZE_INT=997376
dmsetup create integ1 --table "0 $SIZE_INT integrity /dev/sdd2 0 28 J 0"
dmsetup create crypt1 --table "0 $SIZE_INT crypt capi:gcm(aes)-random \
 11ff33c6fb942655efb3e30cf4c0fd95f5ef483afca72166c530ae26151dd83b \
 0 /dev/mapper/integ1 0 1 integrity:28:aead"

This command comes from the commit information of the commit which introduce AEAD.
(commit ef43aa38063a6b2b3c6618e28ab35794f4f1fe29
dm crypt: add cryptographic data integrity protection (authenticated encryption))
I only change 'aes-gcm-random' to 'capi:gcm(aes)-random'

Really appreciate it if you could have a look at it, Thanks!

Regards,
Xiongfeng


