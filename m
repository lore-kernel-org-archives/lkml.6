Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF38C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A0F2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="JF8sYbZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A0F2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeJOM60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 08:58:26 -0400
Received: from vps01.wiesinger.com ([46.36.37.179]:42202 "EHLO
        vps01.wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeJOM60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 08:58:26 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Oct 2018 08:58:25 EDT
Received: from wiesinger.com (wiesinger.com [84.113.44.87])
        by vps01.wiesinger.com (Postfix) with ESMTPS id 750BD9F349;
        Mon, 15 Oct 2018 07:08:57 +0200 (CEST)
Received: from [192.168.0.14] ([192.168.0.14])
        (authenticated bits=0)
        by wiesinger.com (8.15.2/8.15.2) with ESMTPSA id w9F58q1d017449
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 15 Oct 2018 07:08:54 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com w9F58q1d017449
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
        s=default; t=1539580134;
        bh=ZTvStfAi3J7eGoCyi4TTTwaKhldTFsbIcaXMYYhDvSY=;
        h=From:Subject:To:Cc:Date:From;
        b=JF8sYbZPkwACiB0vJ8BRtaUohfEHoIrfLmQokgDub4x2+Bwlzu9D+O/T2aIk4l2zM
         YxHIidNjyl96VRD35mi3yOMjKOK7RFvs2Zyu0FRcTZnptqQzAAE6iLsem4+L2P76uy
         JWeHolpZFUYZh8veFgB5z0XFbfASFznaLhpLxpgSS9D7hrCp+kOUx1Lg2CmAhn/5ml
         8YCKTMpqT+E8Fx5N78aY2BUDUOr9R1QZ58fnLpWd8SRsF0bOCq+FfUALO0CuhIQvi8
         jQOi0YV8+LmyxLw1PSmceCWlrwytz6ARqZI/X/63CQADIwjSE6EP0xDDHg3QotAhgI
         vIzceCEQdeESs0o3idF9wXKY5GQfHk1121852qpEZj9c1ncxkjGQiHLuK156OzRBPj
         u+QXaeNfAgi6qUDrxnJGxv2kH27bYdBi5ajR0Xue7MnC9Xt30mTl2I/O4gkEy9CbI4
         8mTgJBmMWdZSf+3w+jajsiZRxivBbwyqWKrVCePRZb8a6w4aRbN39Ff5EovUbriJdF
         u1Ok7yWMTEz6dGHE2Mg7EBooDfJYZnJBFlzJHYnFVJjGtYphM8hH2BSJHIgNz2yhTg
         7mkUpl9lktYVEcI6KYfWP/VCFSgeow/PHfbCfVpiKRoWMlkY0Vg7YVbmkcSWocRGQL
         xv7yMIaOSL3Grng7u3MDAl+U=
From:   Gerhard Wiesinger <lists@wiesinger.com>
Subject: net: dsa: b53: Keep CPU port as tagged in all VLANs - merge request
To:     linux-kernel@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>
Message-ID: <d189257f-1d06-8509-37ed-229b14ff14d7@wiesinger.com>
Date:   Mon, 15 Oct 2018 07:08:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

The dsa b53 net driver is broken since 4.15 kernels. This patch hasn't 
been merged into 4.18.latest yet (is already in net.git). Can you please 
integrate it in 4.18.15.

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/drivers/net/dsa/b53/b53_common.c?id=ca8931948344c485569b04821d1f6bcebccd376b

References:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/drivers/net/dsa/b53/b53_common.c?h=v4.18.14

Thank you.

Ciao,

Gerhard

