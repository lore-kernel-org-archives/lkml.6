Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C000C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439622146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439622146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbeKVCCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:02:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729128AbeKVCCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:02:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99BE731256A9;
        Wed, 21 Nov 2018 15:27:23 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-204-124.brq.redhat.com [10.40.204.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08DF2103BAB7;
        Wed, 21 Nov 2018 15:27:17 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        torvalds@linux-foundation.org
Cc:     Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/7] HID: revert the Logitech High Resolution wheel support
Date:   Wed, 21 Nov 2018 16:27:05 +0100
Message-Id: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 21 Nov 2018 15:27:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that the implementation of the high resolution support of
Logitech wheels is rather incompatible with the mice from Microsoft.

We had a lengthy discussion off-list and the summary is quoted in 7/7.

The TL;DR, we need to revert the current series before it gets out in
a released kernel and work on a better approach for 4.21.

This patch series has informally been acked by Dmitry, Harry, Jiri, Nestor
and Peter, but I wouldn't mind a public ack before I push this to
the for-linus branch.

Dmitry, I chose to also revert "Input: Add the `REL_WHEEL_HI_RES` event code"
as the documentation needs to be updated.
I would understand if you rather keep the patch that way and we just update
the doc. This would help synchronizing the trees. So please tell me if you
want 7/7 in the series or not (I'll reshuffle the commit message to have
the summary from Peter).

Cheers,
Benjamin

Benjamin Tissoires (7):
  Revert "HID: input: simplify/fix high-res scroll event handling"
  Revert "HID: logitech: fix a used uninitialized GCC warning"
  Revert "HID: logitech: Use LDJ_DEVICE macro for existing Logitech
    mice"
  Revert "HID: logitech: Enable high-resolution scrolling on Logitech
    mice"
  Revert "HID: logitech: Add function to enable HID++ 1.0 "scrolling
    acceleration""
  Revert "HID: input: Create a utility class for counting scroll events"
  Revert "Input: Add the `REL_WHEEL_HI_RES` event code"

 Documentation/input/event-codes.rst    |  11 +-
 drivers/hid/hid-input.c                |  44 ----
 drivers/hid/hid-logitech-hidpp.c       | 309 +++----------------------
 include/linux/hid.h                    |  28 ---
 include/uapi/linux/input-event-codes.h |  10 -
 5 files changed, 28 insertions(+), 374 deletions(-)

-- 
2.19.1

