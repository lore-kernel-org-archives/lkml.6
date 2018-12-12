Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52031C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189B420873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuXwdfmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189B420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeLLSak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:30:40 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44243 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbeLLSak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:30:40 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so17125483lji.11;
        Wed, 12 Dec 2018 10:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p/J0597ptXVFKTS6+8uV+mMbjxEeKJDs2XgrWFgzS34=;
        b=nuXwdfmGd3IGk6BtWhlJ7LpRbaOs929dJPY0LhYEAmrAvMC4JLsCBh7lBBEHFRMdJk
         4Zap8EthG+Z84JjuDk7epf9mF2hY2GSWZHEzFRfj+1GIzHQ2zzx17c+zjOho3qFhJdMn
         +vCC5xj/ArVtwtTICLeAOyWE8ZBVx3AxueFTWaSiBXn2kQmLTP3WACBoGWiu2PPpqeO0
         syrrU7YOCdpU5Rw4Ty4HIZdshiR2LSN9p130OC0DOAkUlFVBGC3xoEptXPNc8Mf9dTC7
         zdB9fbt1MXovKk9VKWJ4BieC0gT5wgWn9164m2hMgfsVn54oHva1IVNqVjW7k2uoNO0c
         4MIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p/J0597ptXVFKTS6+8uV+mMbjxEeKJDs2XgrWFgzS34=;
        b=XJu8NK8iWHwB7EoNnW/H1roPtVKb6H8XQ5eLrpzBDa7dDlor8+Ii4AERnaP45gXXjh
         Yv+NRC9BeAoPafNvQbBP/BcltWTjOxyQAGGBC547ZuC7RKkZPhgYRP+AgvYMweWTnHvc
         JywQI+glS31HMuP6Iu4a7Tl9XtFJGDt3cF49k9oNIXzl/ltDdTAOfYM0uEhD6YZLvVMi
         5CFgm7ybDp+ZgcI+dpVFfQgzrrGUyG06iDvE9m13sj73dUipMuO7BYof+SZekCXqLMFj
         p8RHcPBkHk40KikGT8B9Ko++dWEYSE7iblMxVJpfaaRkAk5LIsLtNo2DrLVCYA8jXwi6
         QI6Q==
X-Gm-Message-State: AA+aEWY7r+XlzjpSvhTPYNhDOjMNq4wMKc3HKDcsm35EdHGN2y/IfXCZ
        OpAw9mqQNehfLtf8zPkCjsdaXazr
X-Google-Smtp-Source: AFSGD/WPMAnIchKzNFaw6kFuSbh0C3v/OK7Rm+7G9tg0jcYNEwjLOJ94bBNnY06G2bIdDY6iGXkkQQ==
X-Received: by 2002:a2e:7c13:: with SMTP id x19-v6mr13226796ljc.83.1544639437222;
        Wed, 12 Dec 2018 10:30:37 -0800 (PST)
Received: from arch.domain.name (89-70-220-87.dynamic.chello.pl. [89.70.220.87])
        by smtp.gmail.com with ESMTPSA id b128sm3389852lfe.91.2018.12.12.10.30.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 10:30:36 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, jic23@jic23.retrosnub.co.uk,
        a.brauchli@elementarea.net, Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH v3 0/3] add support for Sensirion SPS30 PM sensor
Date:   Wed, 12 Dec 2018 19:30:08 +0100
Message-Id: <20181212183011.16567-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Sensirion SPS30 particulate matter
sensor. Along with a driver itself, new channel type and modifiers
for distinguishing between coarse and fine particles measurements are
introduced.

Sensor datasheet can be downloaded from

https://www.sensirion.com/fileadmin/user_upload/customers/sensirion/Dokumente/0_Datasheets/Particulate_Matter/Sensirion_PM_Sensors_SPS30_Datasheet.pdf

v3:
 * convert be32 to cpu using predefined macro
 * remove semicolon: reported by semicolon.cocci
 * use capitalization consistently (particulate matter)

v2:
 * add support for PM1 and PM4 measurements
 * get rid of variable length arrays
 * do proper cleanup via devm_add_action_or_reset()
 * add extra level of precision (two decimal places) while displaying
   measurements
 * improve comments a little bit
 * slight refactoring and general improvements here and there

Tomasz Duszynski (3):
  iio: add IIO_MASSCONCENTRATION channel type
  iio: chemical: add support for Sensirion SPS30 sensor
  iio: chemical: sps30: add device tree support

 Documentation/ABI/testing/sysfs-bus-iio       |  17 +-
 .../bindings/iio/chemical/sensirion,sps30.txt |  12 +
 drivers/iio/chemical/Kconfig                  |  11 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/sps30.c                  | 406 ++++++++++++++++++
 drivers/iio/industrialio-core.c               |   5 +
 include/uapi/linux/iio/types.h                |   5 +
 tools/iio/iio_event_monitor.c                 |  10 +
 8 files changed, 466 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
 create mode 100644 drivers/iio/chemical/sps30.c

--
2.19.2

