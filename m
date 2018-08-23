Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D1CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6754A21566
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IySI7V8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6754A21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeHWWCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:02:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41745 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbeHWWCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:02:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id s15-v6so3044755pgv.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 11:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3369VEYSstVH4+PoGpIQpAG6rFkOt9VHBqkwbcndrHw=;
        b=IySI7V8LRhdZPqzlPAlFvIRQkfWeBSt8LB6cjNZxpZKg/aK93x5STVjxml2Is5yurt
         nPQMmaN1p4OXLZZHVoozeBTl4ynnAc+LnRwxVOxUaopqwJEbhh9jOoxq78EU+TXf28KT
         HIgHdoGXqkv4QeymrEICa7mDp2BH19x/wXu60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3369VEYSstVH4+PoGpIQpAG6rFkOt9VHBqkwbcndrHw=;
        b=FwLpNEiivrAHV9YremKu1uKwehFPXUr1Cv6pZAw9I0e88I5y9tgpeJFZAewwd8+tpc
         F/u8UHTr4OlF5xSfyaY2+7hQVR85AA3DNuxddkspr38OgWMrE0lKeS/aYcrmnHuSZL9o
         KvPLlnjogd83vvUHbYYZDUqfDTYUW4a2K1QX0rRcdp8RMOw3pOCiTTotRjnXYu0BNgo7
         K2L1YWf+FjdM1Z7ffOzURllGRCK4TctEfCpydVTstjUHBj1/6/LfQklfT+mb4SMrALWh
         iOJuIL3JO25cl6vA2m0CAkt7DWaCqJH2kK1otUNku1edUTT13tIuvfHGqYue9DInSW1+
         pC9w==
X-Gm-Message-State: AOUpUlE6c3iP8dAqO0SWifbEUjsLzpdGNqthwCynDQdcy1DwbsIPgJKM
        N6CO+Iel8uDBLFm5eMKJCG90RQ==
X-Google-Smtp-Source: AA+uWPxcS8aoUKhgD53T/OtT+P1qhXjoieaxxr9uW7gRy4av6jgCjubMwnPup30W7iYmwbRSePEt8A==
X-Received: by 2002:a63:7d7:: with SMTP id 206-v6mr25951038pgh.17.1535049070673;
        Thu, 23 Aug 2018 11:31:10 -0700 (PDT)
Received: from kolhar.mtv.corp.google.com ([2620:15c:202:201:356a:9de2:526a:5bc])
        by smtp.gmail.com with ESMTPSA id p11-v6sm9054225pfj.72.2018.08.23.11.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 11:31:10 -0700 (PDT)
From:   Harry Cutts <hcutts@chromium.org>
To:     linux-input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jiri Kosina <jiri.kosina@suse.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Harry Cutts <hcutts@chromium.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <jikos@kernel.org>
Subject: [PATCH 0/3] Add support for high-resolution scrolling on Logitech mice
Date:   Thu, 23 Aug 2018 11:30:54 -0700
Message-Id: <20180823183057.247630-1-hcutts@chromium.org>
X-Mailer: git-send-email 2.18.0.1017.ga543ac7ca45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This set of patches adds support for high-resolution scroll wheels on
Logitech mice. See the linux-input "Reporting high-resolution scroll
events" thread [0] for previous discussion of the evdev changes. I would
love to hear your feedback.

Thanks,

Harry Cutts
Chrome OS Touch/Input team

[0]: https://www.spinics.net/lists/linux-input/msg57380.html



Harry Cutts (3):
  Add the `REL_WHEEL_HI_RES` event code
  Create a utility class for counting scroll events
  Enable high-resolution scrolling on Logitech mice

 Documentation/input/event-codes.rst    |  11 +-
 drivers/hid/hid-ids.h                  |  15 ++
 drivers/hid/hid-input.c                |  44 ++++
 drivers/hid/hid-logitech-hidpp.c       | 341 +++++++++++++++++++++++--
 drivers/hid/hid-quirks.c               |  11 +
 include/linux/hid.h                    |  28 ++
 include/uapi/linux/input-event-codes.h |   1 +
 7 files changed, 423 insertions(+), 28 deletions(-)

-- 
2.18.0.1017.ga543ac7ca45-goog

