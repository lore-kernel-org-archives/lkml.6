Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B1CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95F420870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95F420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=egervary.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbeIJTcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:32:51 -0400
Received: from mail.datacast.hu ([195.70.49.210]:59132 "EHLO mail.datacast.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728520AbeIJTcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:32:50 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Sep 2018 15:32:49 EDT
Received: from localhost (mail.hauszmann.datacast [192.168.100.108])
        by mail.datacast.hu (Postfix) with ESMTP id 40C05201A3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 16:33:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.datacast.hu
Received: from mail.datacast.hu ([192.168.100.108])
        by localhost (mail.datacast.hu [192.168.100.108]) (amavisd-new, port 10024)
        with ESMTP id hYkKPUOLofmH for <linux-kernel@vger.kernel.org>;
        Mon, 10 Sep 2018 16:33:24 +0200 (CEST)
Received: by mail.datacast.hu (Postfix, from userid 8)
        id 20DEF201A7; Mon, 10 Sep 2018 16:33:24 +0200 (CEST)
Received: from datacast.hu (mail.datacast.hu [IPv6:2a00:10d0:8010::d2])
        by mail.datacast.hu (Postfix) with ESMTPSA id CEF3C201A3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 16:33:23 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 10 Sep 2018 16:33:23 +0200
From:   =?UTF-8?Q?Egerv=C3=A1ry_Gergely?= <gergely@egervary.hu>
To:     linux-kernel@vger.kernel.org
Subject: loop device: print_req_error - blk_update_request I/O error
Message-ID: <5f09fc3612e70730c4a76b410b81d83f@egervary.hu>
X-Sender: gergely@egervary.hu
User-Agent: Roundcube Webmail/1.3.2 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm mounting an ext4 filesystem residing on an AHCI SATA disk via loop:
   losetup -o 64424509440 --sizelimit 34359738368 /dev/loop0 /dev/sda
   mount -t ext4 /dev/loop0 /mnt

Works perfectly on <= 4.4.155 (latest version on 4.4.x longterm branch)

On 4.9.126 (longterm branch) I get these errors:
   blk_update_request: I/O error, /dev/loop0, sector 23778144
   blk_update_request: I/O error, /dev/loop0, sector 23789056
   blk_update_request: I/O error, /dev/loop0, sector 23791038
   ...

On 4.14.69 (longterm branch):
   print_req_error: I/O error, /dev/loop0, sector 22685550
   print_req_error: I/O error, /dev/loop0, sector 22696582
   print_req_error: I/O error, /dev/loop0, sector 22675034
   ...

and even on the latest stable 4.18.7:
   print_req_error: I/O error, /dev/loop0, sector 21044836
   print_req_error: I/O error, /dev/loop0, sector 22058444
   print_req_error: I/O error, /dev/loop0, sector 22858336
   ...

That's 100% reproducible on all my computers. They are amd64 desktop PCs
running unpatched vanilla kernels from kernel.org.

Any ideas?

I can provide more details if requested (.config, dmesg, etc.)
Thanks in advance.
-- 
Gergely EGERVARY
