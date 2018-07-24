Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104AFC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B497820856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B497820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388278AbeGXGKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 02:10:11 -0400
Received: from gate.crashing.org ([63.228.1.57]:54427 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388176AbeGXGKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 02:10:11 -0400
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6O55JLG028169;
        Tue, 24 Jul 2018 00:05:20 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     openbmc@lists.ozlabs.org
Cc:     Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] fsi: Convert misc devs to proper chardevs and more
Date:   Tue, 24 Jul 2018 15:05:14 +1000
Message-Id: <20180724050519.31920-1-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the various FSI devices from misc dev to chardev,
as there can potentially be too much of them for misc devs limited
minors, and because there are some lifetime issues with the current
support.

This provide a common infrastructure to allocate an FSI major and
distribute minors in a way that keeps it compatible with existing
userspace. A new representation grouping FSI devices under a
/dev/fsi directory is optinally provided, which will work in
conjunction with new udev scripts aimed at providing fixed ID
based symlinks.

A side effect of those conversions is to fix some object lifetime
issues caused by a mixup between devm_kzalloc and proper object
lifetime.

This series also adds a /dev{/fsi}/cfamN chardev for raw CFAM
access that will superseed the existing "raw" sysfs file.

Finally there's also a locking fix to avoid horrible mixups if
the "rescan" file is poked while a rescan is already in progress.


