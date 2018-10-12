Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F706C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306B220835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306B220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbeJLV5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:57:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbeJLV5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:57:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B46C981DED;
        Fri, 12 Oct 2018 14:24:20 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-204-150.brq.redhat.com [10.40.204.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C57F2B59C;
        Fri, 12 Oct 2018 14:24:15 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     KT Liao <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/5] Fix Elan I2C touchpads in latest generation from Lenovo
Date:   Fri, 12 Oct 2018 16:24:08 +0200
Message-Id: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 12 Oct 2018 14:24:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since v4.18, we unconditionally switch the I2C capable touchpads over I2C.
In the model I had (a pre-prod t480s I guess), the touchpad was behaving
fine.
However, it occurs that later production models don't expose the clickpad
information from I2C. The Windows driver gets all the information from PS/2
so we should do the same.

The situation is even worse for the P52. Once of the query parameter function
fails, which means the touchpad doesn't even probe. This effectively kills
the touchpad, which is less than ideal.

Dmitry, I am not sure if we should take those for stable in v4.18+.
I'd like to, but given the series is 5 patches, I don't know if this
will be acceptable.
We could revert in stable df077237cf55928f5 but that would mean
distributions will have to revert the revert if they want to provide
the I2C behavior.

So, regarding stable: your call :)

Cheers,
Benjamin

Benjamin Tissoires (5):
  Input: elantech - query the min/max information beforehand too
  Input: elantech - add helper function elantech_is_buttonpad()
  dt-bindings: add more optional properties for elan_i2c touchpads
  Input: elan_i2c - do not query the info if they are provided
  Input: elantech/SMBus - export all capabilities from the PS/2 node

 .../devicetree/bindings/input/elan_i2c.txt         |   8 +
 drivers/input/mouse/elan_i2c_core.c                |  49 +++-
 drivers/input/mouse/elantech.c                     | 272 +++++++++++----------
 drivers/input/mouse/elantech.h                     |   5 +
 4 files changed, 188 insertions(+), 146 deletions(-)

-- 
2.14.3

