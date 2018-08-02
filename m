Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B650C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35855214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35855214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=torlan.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbeHBORN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:17:13 -0400
Received: from forward105j.mail.yandex.net ([5.45.198.248]:39105 "EHLO
        forward105j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732034AbeHBORN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:17:13 -0400
Received: from mxback20j.mail.yandex.net (mxback20j.mail.yandex.net [IPv6:2a02:6b8:0:1619::114])
        by forward105j.mail.yandex.net (Yandex) with ESMTP id 4F3A4188E92;
        Thu,  2 Aug 2018 15:26:14 +0300 (MSK)
Received: from smtp4p.mail.yandex.net (smtp4p.mail.yandex.net [2a02:6b8:0:1402::15:6])
        by mxback20j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id yUlpmXWGm5-QEBi9Ojq;
        Thu, 02 Aug 2018 15:26:14 +0300
Received: by smtp4p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id fmlSrLxBTt-QDOCYmsZ;
        Thu, 02 Aug 2018 15:26:13 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
To:     axboe@kernel.dk, idryomov@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        sagi@grimberg.me
From:   WGH <wgh@torlan.ru>
Subject: LVM snapshot broke between 4.14 and 4.16
Openpgp: preference=signencrypt
Message-ID: <226835ba-2197-b850-6e5b-8ba14f7fd016@torlan.ru>
Date:   Thu, 2 Aug 2018 15:26:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(I originally reported this problem here:
https://bugzilla.kernel.org/show_bug.cgi?id=200439)

When I updated from 4.14 to 4.16, my LVM snapshotting script broke for
no apparent reason.

My script has the following line, and it fails like this:
+ lvcreate --size 5G --snapshot --name snap0 --permission r
/dev/mapper/vg0-lvol_rootfs
  device-mapper: create ioctl on
vg0-snap0-cowLVM-sDdIeh9cecWdaNyRfZC31mxgfwTa4sOeHMJXVOykGVRtfP6Aii7IHvwS066AOLOM-cow
failed: Device or resource busy
  Failed to lock logical volume vg0/lvol_rootfs.
  Aborting. Manual intervention required.

At the same time, some errors appear in dmesg as well:
[   26.145279] generic_make_request: Trying to write to read-only
block-device dm-3 (partno 0)
[   26.145288] device-mapper: persistent snapshot: write_header failed
[   26.145847] device-mapper: table: 253:4: snapshot: Failed to read
snapshot metadata
[   26.145851] device-mapper: ioctl: error adding target to table

I bisected the vanilla kernel, and the first bad commit is
[721c7fc701c71f693307d274d2b346a1ecd4a534] block: fail op_is_write()
requests to read-only partitions

