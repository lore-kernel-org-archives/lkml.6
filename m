Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56783C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188742086E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188742086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeIDPzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:55:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44173 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeIDPzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:55:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id v16-v6so3538269wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 04:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vSCn6fiZzyTTaQUxUDlBKjxYgYBbsl94RTnRD9W7vnA=;
        b=jjHMSPKXZb1b2hokF9VwLxy6BLlapRPCmfbY9qDf5pd/gZ8Z35H++4rawxL0uVv6+b
         rlVmAZEfVKLyEKwzNvKxVoPtfsTAOGG6rL5hrGDu5shwkjBm159gqsF5Bxyg3zqQUoSo
         Mh5/ZkoKcKaJ/mQq7pjZfCJJwOA6ciy4tHSIKkTtoChvwu9euSJU4PV6P5L1OStVZMYX
         Jl09M0POj/HbHi9uDOufpch1ZwXsikdRkz0XVzbtHEanNrAV+3nP/brA5rGzV+4+aQUD
         tv9iM4HfPdTvg8q1+oHcaESGUqwbinQAm8yhdqG7lS4dMND1Om7G3et+bIaXpiZF3Xgw
         7kRA==
X-Gm-Message-State: APzg51A/lbgzjMUjpECbfxA/XBeZp4pH1XgHSL3jvjYxT7AgHWB/+tz8
        Y3sy/Lg8JbVxVaDTQdoKs9f0rmewnEs=
X-Google-Smtp-Source: ANB0VdaOeALn37x8g0nlE0xujV4dwwnGB16RHmhafGUr3v28rkb7h6HU8ZIX21Y7xyB2hhURvXZSyw==
X-Received: by 2002:a5d:6841:: with SMTP id o1-v6mr22152860wrw.159.1536060629096;
        Tue, 04 Sep 2018 04:30:29 -0700 (PDT)
Received: from minerva.redhat.com ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id s13-v6sm22574155wrq.39.2018.09.04.04.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 04:30:28 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jian Xu Zheng <jian.xu.zheng@intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
Subject: [PATCH 0/2] media: intel-ipu3: allow the media graph to be used even if a subdev fails
Date:   Tue,  4 Sep 2018 13:30:16 +0200
Message-Id: <20180904113018.14428-1-javierm@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series allows the ipu3-cio2 driver to properly expose a subset of the
media graph even if some drivers for the pending subdevices fail to probe.

Currently the driver exposes a non-functional graph since the pad links are
created and the subdev dev nodes are registered in the v4l2 async .complete
callback. Instead, these operations should be done in the .bound callback.

Patch #1 just adds a v4l2_device_register_subdev_node() function to allow
registering a single device node for a subdev of a v4l2 device.

Patch #2 moves the logic of the ipu3-cio2 .complete callback to the .bound
callback. The .complete callback is just removed since is empy after that.

Best regards,
Javier


Javier Martinez Canillas (2):
  [media] v4l: allow to register dev nodes for individual v4l2 subdevs
  media: intel-ipu3: create pad links and register subdev nodes at bound
    time

 drivers/media/pci/intel/ipu3/ipu3-cio2.c | 66 ++++++-----------
 drivers/media/v4l2-core/v4l2-device.c    | 90 ++++++++++++++----------
 include/media/v4l2-device.h              | 10 +++
 3 files changed, 85 insertions(+), 81 deletions(-)

-- 
2.17.1

