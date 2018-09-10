Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40068C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7EE020866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EE020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeIJIP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:15:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbeIJIP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:15:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 216AF26A81;
        Mon, 10 Sep 2018 00:57:47 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-121-42.rdu2.redhat.com [10.10.121.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C26E2026D66;
        Mon, 10 Sep 2018 00:57:44 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH 0/2] [i915] Getting rid of GUP and use HMM for user ptr features.
Date:   Sun,  9 Sep 2018 20:57:34 -0400
Message-Id: <20180910005736.5805-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 10 Sep 2018 00:57:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 10 Sep 2018 00:57:47 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
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

[1] https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-intel-v00

Cc: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org

Jérôme Glisse (2):
  gpu/i915: use HMM mirror instead of mmu_notifier
  gpu/i915: use HMM mirror for userptr buffer object.

 drivers/gpu/drm/i915/Kconfig            |   4 +-
 drivers/gpu/drm/i915/i915_gem_userptr.c | 395 ++++++++++++------------
 2 files changed, 199 insertions(+), 200 deletions(-)

-- 
2.17.1

