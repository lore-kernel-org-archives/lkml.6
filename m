Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307FCC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0169820835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0169820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbeJDAJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:09:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbeJDAJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:09:09 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D625B3099FC2;
        Wed,  3 Oct 2018 17:19:51 +0000 (UTC)
Received: from rules.brq.redhat.com (ovpn-200-24.brq.redhat.com [10.40.200.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6A36309136D;
        Wed,  3 Oct 2018 17:19:46 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] HID: debug: fix the ring buffer implementation
Date:   Wed,  3 Oct 2018 19:19:33 +0200
Message-Id: <20181003171936.11271-1-vdronov@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 03 Oct 2018 17:19:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is fixing some aspects of the ring buffer implementation in
drivers/hid/hid-debug.c. This implementation has certain problem points:

- it may stuck in an infinite loop
- it may return corrupted data
- a reader and a writer are not protected by spinlocks, which can lead to
  the corrupted data

The suggested patchset is a new ring buffer implementation which overwrites
the oldest data in case of an overflow. One can verify the suggested ring
buffer implementation by fuzzing it with modified kernel and fuzzer-reader
at: https://gist.github.com/nefigtut/33d56e3870b67493cc867344aed2a062

Vladis Dronov (3):
  HID: debug: avoid infinite loop and corrupting data
  HID: debug: provide reader-writer locking for the ring buffer
  HID: debug: fix ring buffer implementation

 drivers/hid/hid-debug.c   | 201 ++++++++++++++++++++++++++------------
 include/linux/hid-debug.h |   1 +
 2 files changed, 142 insertions(+), 60 deletions(-)

-- 
2.19.0
