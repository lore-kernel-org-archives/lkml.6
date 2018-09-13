Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D76C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23CE20C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alibaba-inc.com header.i=@alibaba-inc.com header.b="e4FPW85t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23CE20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alibaba-inc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeIMN1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:27:38 -0400
Received: from out0-151.mail.aliyun.com ([140.205.0.151]:55015 "EHLO
        out0-151.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeIMN1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alibaba-inc.com; s=default;
        t=1536826731; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        bh=WaOpUu45Fmkn78F70Avqzug5HiAk/6J2WufiS7ScWdE=;
        b=e4FPW85tldEzwUyKYoBfyuEm32tBADZwVJ6VrLITuNqEnp7MTqWukjW1+FOuMTtnm9xFz+XQrAJAqJBK3AhclapXj2hXyk28V4IGqvyCFXavbsCdad/NEo17xGY7185Mi1y8H/TabYP3Dy2+qMhUn/zn9bURnlDTTmoUZ5ZItm0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e02c03308;MF=xiongwei.jiang@alibaba-inc.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---.CqBVRvx_1536826728;
Received: from ali55502n(mailfrom:xiongwei.jiang@alibaba-inc.com fp:SMTPD_---.CqBVRvx_1536826728)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Sep 2018 16:18:48 +0800
Reply-To: "=?UTF-8?B?6JKL6ZuE5LyfKOiSi+WGsik=?=" 
          <xiongwei.jiang@alibaba-inc.com>
From:   "=?UTF-8?B?6JKL6ZuE5LyfKOiSi+WGsik=?=" 
        <xiongwei.jiang@alibaba-inc.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     <shli@kernel.org>, <neilb@suse.de>
Subject: raid5: how to bind worker threads to specified cpus
Date:   Thu, 13 Sep 2018 16:18:48 +0800
Message-ID: <003401d44b3a$65afbf70$310f3e50$@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdRLNAWj0BVeFBSXQj6IUHm89jT3Ig==
Content-Language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b721420e8719131896b009b11edbbd27d9b85e98, raid5 has been
enabled to support workqueue offload handling of stripes. However, if I hope
to bind worker threads to specified cpus, for example 0-3, is it possible?
The reason for doing this is that I hope applications will not be disturbed
by raid5's jobs. My naive idea is to add a field named "affinity_hint" to
struct r5conf, and then add a sysfs entry to input cpu list, and then take
stripe_head's sector as the hash key to evenly distribute stripe_head across
the cpus.
Anyone has suggestion about my idea or any alternative solutions to bind
worker threads to specified cpus ? thanks a lot .

