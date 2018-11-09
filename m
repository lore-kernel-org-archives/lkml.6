Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37605C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1A320817
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1A320817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbeKJEol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:44:41 -0500
Received: from lnfm1.sai.msu.ru ([93.180.26.255]:36208 "EHLO lnfm1.sai.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbeKJEol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:44:41 -0500
Received: from dragon.sai.msu.ru (dragon.sai.msu.ru [93.180.26.172])
        by lnfm1.sai.msu.ru (8.14.1/8.12.8) with ESMTP id wA9J1mIi013105;
        Fri, 9 Nov 2018 22:01:54 +0300
Received: from alpha.local (unknown [92.243.181.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by dragon.sai.msu.ru (Postfix) with ESMTPSA id 099D1691B;
        Fri,  9 Nov 2018 22:01:49 +0300 (MSK)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     matwey.kornilov@gmail.com,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>, tfiga@chromium.org,
        laurent.pinchart@ideasonboard.com, stern@rowland.harvard.edu,
        ezequiel@collabora.com, hdegoede@redhat.com, hverkuil@xs4all.nl,
        mchehab@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        isely@pobox.com, bhumirks@gmail.com, colin.king@canonical.com,
        kieran.bingham@ideasonboard.com, keiichiw@chromium.org
Subject: [PATCH v6 0/2] media: usb: pwc: Don't use coherent DMA buffers for ISO transfer
Date:   Fri,  9 Nov 2018 22:01:19 +0300
Message-Id: <20181109190121.23492-1-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA cocherency slows the transfer down on systems without hardware coherent
DMA. In order to demontrate this we introduce performance measurement
facilities in patch 1 and fix the performance issue in patch 2 in order to
obtain 3.3 times speedup.

Changes since v5:
 * add dma_sync_single_for_device() as required by Laurent Pinchart

Changes since v4:
 * fix fields order in trace events 
 * minor style fixes

Changes since v3:
 * fix scripts/checkpatch.pl errors
 * use __string to store name in trace events

Changes since v2:
 * use dma_sync_single_for_cpu() to achive better performance
 * remeasured performance

Changes since v1:
 * trace_pwc_handler_exit() call moved to proper place
 * detailed description added for commit 1
 * additional output added to trace to track separate frames

Matwey V. Kornilov (2):
  media: usb: pwc: Introduce TRACE_EVENTs for pwc_isoc_handler()
  media: usb: pwc: Don't use coherent DMA buffers for ISO transfer

 drivers/media/usb/pwc/pwc-if.c | 69 ++++++++++++++++++++++++++++++++++--------
 include/trace/events/pwc.h     | 65 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+), 13 deletions(-)
 create mode 100644 include/trace/events/pwc.h

-- 
2.16.4

