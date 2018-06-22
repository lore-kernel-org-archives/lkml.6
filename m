Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C22C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE4B24824
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="UqPvvsI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE4B24824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934591AbeFVTrk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:47:40 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:54220 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934399AbeFVTri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:
        To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HIYUTFnlVzWrZi8jr3U9zRY3qFoEV+A0Mf5DP9uBOQI=; b=UqPvvsI13MhJBvk2VBMJ0dR6JO
        Qb6hNLyfXxbC9oQoKbg/DYib9R9yLs8ydZ15zFkmP+WbR9FlzGSrqLDSxQLLpmb4DeHDiK1eyj0y+
        W+nSSrqc4x1HdfXH7yHVMcOYVMiRbGKM6ay+BUM8+EboBFlWPOXJb6mkaUAYqwTgsygU0hgHsLjH/
        n2NNciqv8ZGNCtauaaOWdIVI3UxXnOIVjnAkSyuXCBdl1X7G2MqJSu9YUBXO+aewxKml75yZ+b53D
        g5I8/Rq0yZ/PC8c3psYyDAfBGwTUy0WQj8gtFGXVNsejcW0QEB730Nvg3KfZI1yri2D7pNRl1wZHb
        5eK/Bc7A==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:44204 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fWS1x-00BFn5-Cn; Fri, 22 Jun 2018 19:47:38 +0000
Date:   Fri, 22 Jun 2018 12:47:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: s390 qemu boot failure in -next
Message-ID: <20180622194736.GA5794@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

starting with commit 's390/boot: make head.S and als.c be part of the
decompressor only' in -next, s390 immages no longer boot in qemu.
As far as I can see, the reason is that the command line is no longer
passed from qemu to the kernel, which results in a panic because the
root file system can not be mounted.

Was this change made on purpose ? If so, is there a way to get qemu
back to working ?

Thanks,
Guenter

---
bisect log:

# bad: [2e6381681ec48ed6dd455473a657d8a393518aa6] Add linux-next specific files for 20180622
# good: [ce397d215ccd07b8ae3f71db689aedb85d56ab40] Linux 4.18-rc1
git bisect start 'HEAD' 'v4.18-rc1'
# bad: [07b762f7baf30aaa93d35f36ff367d4b36632059] Merge remote-tracking branch 'spi-nor/spi-nor/next'
git bisect bad 07b762f7baf30aaa93d35f36ff367d4b36632059
# good: [6d92c59898b58a2ee80e7aa15cc72c035d33ba20] Merge remote-tracking branch 'realtek/for-next'
git bisect good 6d92c59898b58a2ee80e7aa15cc72c035d33ba20
# bad: [0e743bf802047ea83ce2345bbe9df52e96bf6d1a] Merge remote-tracking branch 'ext4/dev'
git bisect bad 0e743bf802047ea83ce2345bbe9df52e96bf6d1a
# good: [8039f3664e6b07b6797579e29bcc1c51c022e07b] Merge remote-tracking branch 'microblaze/next'
git bisect good 8039f3664e6b07b6797579e29bcc1c51c022e07b
# bad: [c6c285ec2bb43d90176dda4a0cd63c48df7dee98] Merge remote-tracking branch 's390/features'
git bisect bad c6c285ec2bb43d90176dda4a0cd63c48df7dee98
# good: [0e56f3749f0b28166a29691a5422d62a516877ae] MIPS: loongson64: use generic dma noncoherent ops
git bisect good 0e56f3749f0b28166a29691a5422d62a516877ae
# bad: [32bf311a88e9fa70eb3604a697c2390f02ef2de2] init/Kconfig: add an option for uncompressed kernel
git bisect bad 32bf311a88e9fa70eb3604a697c2390f02ef2de2
# bad: [34139a786a40f9f97f84e7f422a9c29d59e2606d] s390/decompressor: rename entry point to startup_decompressor
git bisect bad 34139a786a40f9f97f84e7f422a9c29d59e2606d
# good: [d035a77cb9256f52dc6c4940cbdb2051adb5420c] s390/decompressor: correct build flags
git bisect good d035a77cb9256f52dc6c4940cbdb2051adb5420c
# good: [652e75c51463aead06389dd6f5756f9b91f7fd75] s390/setup: do not reserve the decompressor code
git bisect good 652e75c51463aead06389dd6f5756f9b91f7fd75
# bad: [1b78ef09741223c630a37311ae12d6f6bd212e1a] s390/boot: make head.S and als.c be part of the decompressor only
git bisect bad 1b78ef09741223c630a37311ae12d6f6bd212e1a
# good: [aa71c78a63a3ac82e47714f48b3ea14e2ef94dfc] s390/decompressor: trim the kernel image up to 1M
git bisect good aa71c78a63a3ac82e47714f48b3ea14e2ef94dfc
# first bad commit: [1b78ef09741223c630a37311ae12d6f6bd212e1a] s390/boot: make head.S and als.c be part of the decompressor only
