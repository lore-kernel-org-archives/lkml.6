Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA4FC282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46470214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="qvbkfegU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfA2AuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:50:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34159 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfA2AuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 19:50:03 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so8838964pfg.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 16:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jg6aq2qM6m4l90Ss3Zx/84j4bJ7/iJOBmUryrRwDOmE=;
        b=qvbkfegUucyY7NFSzV9g4Ekbrezoi8IcPETwEgSIhhQs6dSNu6JwgpBjLofPNlb4tb
         sAspic4EZvsuAOEqNOVqOb3YOW/fzZlwmzHFoL8YSpWLUTA1igwv7OkIryT38XgJtw76
         54OvVmboe2biCUaHq20xkU9pD0vxXXoDlICvym7MWZpaDR5JkqB96XGv9H7Sl8DS9G0H
         OtKESy8f8SlpLbD+2bNf0fcXO+BsuuXTyF75G7dURriD+jwt2Qa9shGLm4W7kq3FAEKZ
         Y8APazTrs9a4z+Vae+WV6LkWN2tvn8Hqk9l+n4eHlRK9tZZmnZJW1UPtrMiGXU+VJdi0
         Kt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jg6aq2qM6m4l90Ss3Zx/84j4bJ7/iJOBmUryrRwDOmE=;
        b=OYrTxej4AxNa5UL1jFpvjldPXHMeXLsKbB/GwbJ8wL61ugcKbCM/8lAY7BEcbX/wbh
         dLVZfF3vozO+382txcVrI5YC8IwbaqCoHYsr+ivUvNvgrWpU7Ma4gpTv1elXt0D5t0sY
         4PC3heUDagrDkygAoADCRJVSfQp25/I3AHuUapmxlawd+3QPzdkaanMWrN8i52VX5rsT
         Qwxh966tJeBgNVkM+g4vHSJSUMl2d5r9sv+9dZ9wmcVc6P1/8wfJf/NEXTfUmwXFf9JL
         VXlmSOGq6Ov9EHk4N4MyWK2S8ZktSY4PZR1Rf1Pw7zdYj8KTuIBM1pns2MGIrecOs291
         /m9Q==
X-Gm-Message-State: AJcUukeMkoBtGU5QtYzMQTJ4JpNaQHvvenKYfPN/VoqrZzqWoWGZ03AL
        DCaf5p3IpqpLxuSPCoHaLBMkTw==
X-Google-Smtp-Source: ALg8bN6kPKgP1YmER91jBOaUnwSejJaSQeQyBWPvkKeiTAxlomqk2JhVv5kDww7A+bwIxx5CwX5LOw==
X-Received: by 2002:a63:6d48:: with SMTP id i69mr20963818pgc.215.1548723002083;
        Mon, 28 Jan 2019 16:50:02 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id g3sm52090792pfe.37.2019.01.28.16.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 16:50:01 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH 0/7] binder: eliminate use of vmalloc space for binder buffers
Date:   Mon, 28 Jan 2019 16:49:27 -0800
Message-Id: <20190129004934.85885-1-tkjos@google.com>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binder buffers have always been mapped into kernel space
via map_kernel_range_noflush() to allow the binder driver
to modify the buffer before posting to userspace for
processing.

In recent Android releases, the number of long-running
binder processes has increased to the point that for
32-bit systems, there is a risk of running out of
vmalloc space.

This patch set removes the persistent mapping of the
binder buffers into kernel space. Instead, the binder
driver creates temporary mappings with kmap() or
kmap_atomic() to copy to or from the buffer only when
necessary.

Todd Kjos (7):
	binder: create userspace-to-binder-buffer copy function
	binder: add functions to copy to/from binder buffers
	binder: add function to copy binder object from buffer
	binder: avoid kernel vm_area for buffer fixups
	binder: remove kernel vm_area for buffer space
	binder: remove user_buffer_offset
	binder: use userspace pointer as base of buffer space

 drivers/android/Kconfig        |   2 +-
 drivers/android/binder.c       | 461 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------
 drivers/android/binder_alloc.c | 302 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------
 drivers/android/binder_alloc.h |  47 +++++++++---------
 drivers/android/binder_trace.h |   2 +-
 5 files changed, 538 insertions(+), 276 deletions(-)
