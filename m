Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA6EC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432E321473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Dasn2JEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432E321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeJSAoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:44:15 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:47788 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeJSAoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:44:15 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id C17AC16D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:42:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lAHgL9cfEnNb for <linux-kernel@vger.kernel.org>;
        Thu, 18 Oct 2018 11:42:26 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 9434D541
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 11:42:26 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id v125-v6so772154ita.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 09:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+6q/uH4W6v4LdhrFbX/XCjOkBm43DLpRJ706h4X3hkw=;
        b=Dasn2JEQW+AxVvpbGdkojvdS+7rQS63gk7Hk8tOlF1sjK70jR8cbiDw1HaKfUukHRo
         rAhvCEnZ8iR0viEckApfRjUlWWBEae4EqNhxiMXJ4SPAfDJfTTJjkXOiDDofMOIc+EyQ
         HN2sP0p01LSeYsIEpRRfOtj4vym9uTcIr54k8JGmG8zt79bTEa9hduYliHIFP2M+rvi8
         v6uhhZscoTlWdKbWteiuza3dFbnRuc9SzUkMBcwNYfNyZzlZB85rX0Qusq5JLT77ZGq9
         HDFlNxpEqA+dtLkHoaDF5Wc6d0kPMgnyKMb8AYs4wJ8NW//CS2JIJRy8wqDNX/pOgMvN
         v6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+6q/uH4W6v4LdhrFbX/XCjOkBm43DLpRJ706h4X3hkw=;
        b=mF2IqMPdLtxbK7JjMwaETdPi0j8VGeL6KtERyj1gE5UuOQm0WcUialzuRlhXhd+B+q
         R90PoEYgOusy7mqgqK4ay8hBj2qpzREVv4qWLB46OnqApaLeefYx+q53GpefJPlqeWxe
         4wUOyiqQT2DrXjt9vGHW0c+RFii++SoYBma7gWHTl/pv+B0ERhqm/K476NejiyQ5b7Sz
         bbUKFjmH5fOttjWwQJpVRQG8+oG0VntmJSo5XHTMDXs12V6o6ziaPt8tFYEDxt2qdez8
         jalasuKDYS/zUeA5wB88i1tP3w4BI7PJ3YSyltq3A5dVA228QLRlDQ5gFOc+cqK/SvKD
         Pldg==
X-Gm-Message-State: AGRZ1gJiCPP7YatKmDbR6hiDKPYJjY7kAoK21AuzQvbgFkCVxjD5hO5e
        i10o0jczx55JNLjTv2UiUg9TFJcO0jMonABQQ/jiNvGXjxI8162rCmPnhVPjn/GUm6eMQHK+JZQ
        WjQ0Kqhh7l5pfVoeHOcxa/ctS7QoL
X-Received: by 2002:a6b:cc02:: with SMTP id c2-v6mr673390iog.180.1539880945960;
        Thu, 18 Oct 2018 09:42:25 -0700 (PDT)
X-Google-Smtp-Source: AJdET5cN7nDLtd+Wp2PQT09lOStJWfGkHXOHHgvr50Y1QPespg7ONJzk8XBnBwr0D0FsB57jAPXf2g==
X-Received: by 2002:a6b:cc02:: with SMTP id c2-v6mr673378iog.180.1539880945765;
        Thu, 18 Oct 2018 09:42:25 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id h10-v6sm6486246iom.67.2018.10.18.09.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 09:42:24 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/radeon: fix a missing-check bug
Date:   Thu, 18 Oct 2018 11:42:13 -0500
Message-Id: <1539880933-6887-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In igp_read_bios_from_vram(), the start of vram is firstly remapped to the
IO memory region 'bios' through ioremap(). Then the size and values of
'bios' are checked. For example, 'bios[0]' is compared against 0x55 and
'bios[1]' is compared against 0xaa. If no error happens during this
checking process, the whole data in 'bios' is then copied to 'rdev->bios'
through memcpy_fromio().  The problem here is that the checks are performed
on 'bios' directly. Given that the IO memory region can also be accessed by
the device, it is possible that a malicious device race to modify 'bios[0]'
and/or 'bios[1]' after the checks but before memcpy_fromio(). This can
cause undefined behavior of the kernel and potentially introduce security
risk, especially when the device can be controlled by attackers.

This patch avoids the above issue by rewriting the first two bytes of
'rdev->bios' after memcpy_fromio() with expected values.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/gpu/drm/radeon/radeon_bios.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 04c0ed4..d8304fa 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -69,6 +69,8 @@ static bool igp_read_bios_from_vram(struct radeon_device *rdev)
 		return false;
 	}
 	memcpy_fromio(rdev->bios, bios, size);
+	rdev->bios[0] = 0x55;
+	rdev->bios[1] = 0xaa;
 	iounmap(bios);
 	return true;
 }
-- 
2.7.4

