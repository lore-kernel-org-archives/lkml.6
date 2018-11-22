Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2B5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED2320866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SD1vfvUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED2320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406031AbeKWDb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:31:26 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42739 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730348AbeKWDbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:31:25 -0500
Received: by mail-ed1-f66.google.com with SMTP id j6so8205368edp.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 08:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=13pJYVMGB9tCfD3Cs0rY/5holFbqjrE34OgSpt8Zcuc=;
        b=SD1vfvUC3PH6eSRNSTvtqWtZMSJbRv9QbHtEFwa5B6W3uCi5N752BXBv/RsKp+S8rs
         l22gARMIsjkqE/g2R+4k9u0X7YGS8g3vwkLqGQnl1P5gCxbO2mnuRqYYOTBwuwmOtg50
         TmckAElAHf2hVm7Q8zaTFIcW5HNcgO5JtvV3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=13pJYVMGB9tCfD3Cs0rY/5holFbqjrE34OgSpt8Zcuc=;
        b=kzTDXTaYJhgle0Lo1zQLjwnbcOyP2PHSA+U87W3iDgcdzli2kWl6/TfhHWNRvYf8Wt
         GTMTq3wxufrWS2sb8FWKimuhTotS9K/NHBPXzwCfM0mLfvim8xtXrUjni33/953/AsnT
         qb0xcrYVFyaqRD4Hb9UV7o/46JsXrDb/s8ox8n6XtaSyH3RvExU0w4UMO+3BccXTXeBY
         ngzz3myWI30HV6GLOi6IKfKGbILmJcBIDvxwRI58z5MbD3CtLBJqlfUAwKJmNg2BVgIk
         qjXHBqRYPri1ztOcAk3V9/3TPhRDAsQibTM/C1ofEJAz5kBUHdFNPBQwPOELldss0N8S
         63gQ==
X-Gm-Message-State: AA+aEWbJVMPuXRb032gpS4dGFzBlnZGdrLhAJZi78kBlI3HK2MEpQgyq
        0hzZWz0+sbipkEM/irOPU7Wf5wHvcW4=
X-Google-Smtp-Source: AFSGD/ViGtkqcW7sn54Rl1zvogaQNfMRvBp6pk2KuDbn13KpCSNlRZK81jLa0PJTZ7xaoiLTpsfMKA==
X-Received: by 2002:a50:f489:: with SMTP id s9mr10020576edm.101.1542905472847;
        Thu, 22 Nov 2018 08:51:12 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id s12sm12914780edb.43.2018.11.22.08.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 08:51:12 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 0/3] RFC: mmu notifier debug checks
Date:   Thu, 22 Nov 2018 17:51:03 +0100
Message-Id: <20181122165106.18238-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We're having some good fun with the i915 mmu notifier (it deadlocks), and
I think it'd be very useful to have a bunch more runtime debug checks to
catch screw-ups.

I'm also working on some lockdep improvements in gpu code (better
annotations and stuff like that). Together with this series here this
seems to catch a lot of bugs pretty much instantly, which previously took
hours/days of CI workloads to reproduce. Plus now you get nice backtraces
and the kernel keeps working, whereas without this it's real deadlocks
with piles of stuck processes (the deadlock needed at least 3 processes,
but generally it took more to close the loop, plus everyone piling in on
top).

If this looks like a good idea I'm happy to polish it for merging.

Thanks, Daniel

Daniel Vetter (3):
  mm: Check if mmu notifier callbacks are allowed to fail
  mm, notifier: Catch sleeping/blocking for !blockable
  mm, notifier: Add a lockdep map for invalidate_range_start

 include/linux/mmu_notifier.h |  7 +++++++
 mm/mmu_notifier.c            | 17 ++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.19.1

