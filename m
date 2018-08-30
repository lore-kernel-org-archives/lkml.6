Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758CEC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226D820835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m+bVJqyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226D820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeHaCAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:00:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36379 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeHaCAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:00:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so4501816pfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 14:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iWcmBCDwUKd4jj1L7AbvOTMWjbSc8v8zlrIjl+DjrBo=;
        b=m+bVJqytTZZvcesHHVIeSiYlNTdxjaRCL4mNVOiGZHwV3ocDEbpbsRfQF647E8Tldu
         FUgS4chkYthhEGlfnW1x5zlQXyIaExHi7D1vsg52oGSYBuRVLydEU0tu83KDGiuI7RoK
         QG37cb+863gh6rVWwiInJ6GeZVopJCA0n4VNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iWcmBCDwUKd4jj1L7AbvOTMWjbSc8v8zlrIjl+DjrBo=;
        b=XUKUOV58I2oL8r88W1rWSGnCCav77ivywmfY4WqWA/VhzG0GLyeagAzHnJe10UMyRw
         APdRunQvz4FA0kw3q17DD3eaGvnbdKKfChX7p+ery3HrDuskPZbE+U5qWI0nA7P9DLpH
         cTzZqBxdC8Kak3FGQoaUHYgrG4+TG8Rp2dEUWCmGMAdM28g6TjscTlhHeqbQB+THafMq
         itnqHt9qAgft9jIwyQF+pCcFm3VctXM+qG4dplaC8tSEpNX+RF+BoM3pU3b0dmJBYmDf
         MVF42pxJZFqfPJ0dTOHIg9+GqBOPfFZgXwec2CxzSQSup2mBJrv07LzCMxkEOwuM39iV
         QFtQ==
X-Gm-Message-State: APzg51BF28BLLGNYvNlb/lVWrefdcKrdu8r+kPCtLUJiJcngUnM6ubeJ
        iYFjv5+sYuYtm3QfN0kTqy1xFA==
X-Google-Smtp-Source: ANB0VdbGmWEE2EmQO6KH/JM1ykYqh4PwKfszwwS9XsJ1tip2BaTTdYVoIp1ABW44wsqK6xMjP9BHOA==
X-Received: by 2002:a63:6fcf:: with SMTP id k198-v6mr8290767pgc.360.1535666187696;
        Thu, 30 Aug 2018 14:56:27 -0700 (PDT)
Received: from kolhar.mtv.corp.google.com ([2620:15c:202:201:356a:9de2:526a:5bc])
        by smtp.gmail.com with ESMTPSA id h132-v6sm13516828pfc.100.2018.08.30.14.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:56:27 -0700 (PDT)
From:   Harry Cutts <hcutts@chromium.org>
To:     linux-input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jiri Kosina <jiri.kosina@suse.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Harry Cutts <hcutts@chromium.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <jikos@kernel.org>
Subject: [PATCH v2 0/5] Add support for high-resolution scrolling on Logitech mice
Date:   Thu, 30 Aug 2018 14:56:17 -0700
Message-Id: <20180830215622.47550-1-hcutts@chromium.org>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is v2 of the patch set adding support for high-resolution scroll
wheels on Logitech mice. See the linux-input "Reporting high-resolution
scroll events" thread [0] for previous discussion of the evdev changes.
I would love to hear your feedback.

Thanks,

Harry Cutts
Chrome OS Touch/Input team

[0]: https://www.spinics.net/lists/linux-input/msg57380.html


Changes in v2:
* Changed the REL_WHEEL_HI_RES code to use micrometres (a.k.a. microns)
  as its units, instead of 256ths of a millimetre.
* Removed support for mice connecting over Bluetooth, due to a bug where
  the mouse's high-res mode and the driver's settings get out of sync
  when the mouse is power cycled.
* Moved the creation of the HID++ 1.0 function and the refactor to use
  the LDJ_DEVICE macro into separate patches.
* Added a couple of explanatory comments to the Logitech driver.

Harry Cutts (5):
  Add the `REL_WHEEL_HI_RES` event code
  Create a utility class for counting scroll events
  Add function to enable HID++ 1.0 "scrolling acceleration"
  Enable high-resolution scrolling on Logitech mice
  Use LDJ_DEVICE macro for existing Logitech mice

 Documentation/input/event-codes.rst    |  11 +-
 drivers/hid/hid-input.c                |  45 ++++
 drivers/hid/hid-logitech-hidpp.c       | 311 ++++++++++++++++++++++---
 include/linux/hid.h                    |  28 +++
 include/uapi/linux/input-event-codes.h |   1 +
 5 files changed, 368 insertions(+), 28 deletions(-)

-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

