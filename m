Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC93FC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4639C2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bZL5ihj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4639C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbeJaIB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:01:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43855 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbeJaIB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:01:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id h4-v6so6598070pfi.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 16:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XRkJFF3stD22lptdYkTatKQUzbNskuSZegD0aCVwQIE=;
        b=bZL5ihj+gH9ezCB1mvjOwfRQOXDtig8siuAOIaavp1IjYq3416l/HXilApmU3J60H0
         tv15u7MX+vAzuYD7rlVpnzitj0NU9UehG1Qx9tJ/KLEkho/OcdpKSCgq3/3xCmt6e4r4
         rP2X3ghRk9qJg3/7NCfxDbhG/tyiYz3XoMsjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XRkJFF3stD22lptdYkTatKQUzbNskuSZegD0aCVwQIE=;
        b=BxV2LrMgt+Mqe3k7+IPVy9hVs2llHjshgVYsQjXPgK5y01DWEAIbtm472qQHwGyJnw
         EANliUWHbDUHun51XKlldXWurE/oiuzukQuw9MsgzlfdxxoT9u8Dzpm2gZKfNsq9zD0z
         7GquyVomNy1R9e80Zqe128ERp0N/meV5UBjTmmwQQ7izSYyhW4JYvfrWb4pym4fncqL9
         FbpZVlJKUs8NCfndbLJUbdhDsO2NZdau4LOaaUGIlTuaNZPcGCf0n/4aniH7/hucDUz5
         p9EICsZ4Z2Q/tLNmWB3Fldo+c6dL2tyr3aBrXghFVxYzE4tusTfa33s+6rJSx7tLH7Yu
         8paw==
X-Gm-Message-State: AGRZ1gIy4f0kG823JUpfBAum13SZQs5O+gvjVhHxwUx4z+h1anZ+YgCJ
        iPvzBsVnS0clqFpxYyaBhlsnxA==
X-Google-Smtp-Source: AJdET5fMdjdFZd5XvGZZ4+IyWfmusBrdYcBCBNL4ca87zBscwZ8XmEme2RM9yrkjb4omtEjT/QaK+Q==
X-Received: by 2002:a62:fd0b:: with SMTP id p11-v6mr658194pfh.167.1540940789652;
        Tue, 30 Oct 2018 16:06:29 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id z15-v6sm27953490pfn.170.2018.10.30.16.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Oct 2018 16:06:28 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] loop: Better discard for block devices
Date:   Tue, 30 Oct 2018 16:06:22 -0700
Message-Id: <20181030230624.61834-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series addresses some errors seen when using the loop
device directly backed by a block device. The first change plumbs
out the correct error message, and the second change prevents the
error from occurring in many cases.


Evan Green (2):
  loop: Report EOPNOTSUPP properly
  loop: Better discard support for block devices

 drivers/block/loop.c | 75 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 23 deletions(-)

-- 
2.16.4

