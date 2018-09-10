Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974D8C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D432086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D432086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbeIJIOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:14:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbeIJIOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:14:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79BE781663F6;
        Mon, 10 Sep 2018 00:57:56 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-121-42.rdu2.redhat.com [10.10.121.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C0A4621B5;
        Mon, 10 Sep 2018 00:57:55 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 0/2] [radeon] Getting rid of GUP and use HMM for user ptr features.
Date:   Sun,  9 Sep 2018 20:57:51 -0400
Message-Id: <20180910005753.5860-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 10 Sep 2018 00:57:56 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 10 Sep 2018 00:57:56 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

[This depends on some HMM patchset queued upstream see branch [1]]

This is simple change to switch to use HMM for user ptr buffer object
which conveniently avoid to pin pages. I have more things in the pipe
to make HMM more usefull for such cases (like sharing more resources
accross multiple mirror of a same process).

Beside avoiding pining, this is also an attempt to isolate core mm
from device drivers by having clearly define API and boundary where
we can set expection of everyone and thus having mm folks to have to
read and understand driver code and conversly having driver folks
understand mm maze.

This is also part of what i want to discuss during XDC2018.

Consider this as an RFC to start the discussion.

[1] https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-radeon-v00

Cc: dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: David (ChunMing) Zhou <David1.Zhou@amd.com>
Cc: Nicolai Hähnle <nicolai.haehnle@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>

Jérôme Glisse (2):
  gpu/radeon: use HMM mirror instead of mmu_notifier
  gpu/radeon: use HMM mirror for userptr buffer object.

 drivers/gpu/drm/radeon/radeon.h     |  14 +-
 drivers/gpu/drm/radeon/radeon_gem.c |  16 +-
 drivers/gpu/drm/radeon/radeon_mn.c  | 283 +++++++++++++++++++++-------
 drivers/gpu/drm/radeon/radeon_ttm.c | 129 ++-----------
 4 files changed, 259 insertions(+), 183 deletions(-)

-- 
2.17.1

