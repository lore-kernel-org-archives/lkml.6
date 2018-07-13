Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B2AECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB78C20850
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB78C20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbeGMQkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:40:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729735AbeGMQkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:40:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C39381A4EA5;
        Fri, 13 Jul 2018 16:24:58 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-125-176.rdu2.redhat.com [10.10.125.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F14EB1C731;
        Fri, 13 Jul 2018 16:24:55 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Karol Herbst <karolherbst@gmail.com>, stable@vger.kernel.org,
        "David Airlie" <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, "Ben Skeggs" <bskeggs@redhat.com>
Subject: [PATCH 0/2] drm/nouveau: Fix connector memory corruption issues
Date:   Fri, 13 Jul 2018 12:24:39 -0400
Message-Id: <20180713162442.22522-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 13 Jul 2018 16:24:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 13 Jul 2018 16:24:58 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes some nasty issues I found in nouveau that were being caused
looping through connectors using racy legacy methods, along with some
caused by making incorrect assumptions about the drm_connector structs
in nouveau's connector list. Most of these memory corruption issues
could be reproduced by using an MST hub with nouveau.

Cc: Karol Herbst <karolherbst@gmail.com>
Cc: stable@vger.kernel.org

Lyude Paul (2):
  drm/nouveau: Use drm_connector_list_iter_* for iterating ues connectors
  drm/nouveau: Avoid looping through fake MST connectors

 drivers/gpu/drm/nouveau/nouveau_backlight.c |  6 ++--
 drivers/gpu/drm/nouveau/nouveau_connector.c |  9 ++++--
 drivers/gpu/drm/nouveau/nouveau_connector.h | 36 ++++++++++++++++++---
 drivers/gpu/drm/nouveau/nouveau_display.c   | 10 ++++--
 4 files changed, 51 insertions(+), 10 deletions(-)

-- 
2.17.1

