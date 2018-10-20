Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F342FC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 17:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F6E21532
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 17:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="isKjzhMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F6E21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeJUCHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 22:07:13 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:59342 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeJUCHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 22:07:13 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 7DE0183C
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 17:55:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rZTNmh_alI5w for <linux-kernel@vger.kernel.org>;
        Sat, 20 Oct 2018 12:55:59 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 50540840
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 12:55:59 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id v12-v6so33851014iob.15
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 10:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=f5b20fDa6HGHc9aMvm73NBQ33p9AUdVtX4EScsoJeIc=;
        b=isKjzhMdypFOYAAbxglH/iuo8xHVD/IZUQELbPjVkaiprAaC8VkcjkRUl8hcXTlI57
         KufaH/8QtdR9NMnLivibbQMnshZnCNFFIkF3gCtL4wzvfu/9ZfhDucwfN6Y8ivo9atlv
         w/jkR6fjKvR4Zz9KHqF9e1bqKvPaSdhQHcpzf6xPkzLXEg/axGK0TWPZDS/dE/4tfTwF
         y5HuDm1Xvh3wcYHwE8f0JXft9IIqbOzt6t/Mj3oo2bDsXT3YCtDG1yjSNmcE61GDLEOL
         FVT84qmfEZcben4vxnDmfkBOcWXn9lKCeFjhrQAuu272eueDjj1SGR3mxxxfazslSxG2
         +iLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f5b20fDa6HGHc9aMvm73NBQ33p9AUdVtX4EScsoJeIc=;
        b=RxA8eW74w7lFlAtoEyjwTjgOaA/fuk7TVLLSue07bM/wWx9btKYTqK/NegoEf+CxRA
         BAxedhatQpPVMyXhOGiIlkfUyrhSlRbhIXhyRkHIjyluuGkdjgugYP+sXam1t+avPGM8
         C0jS8OisW2tboOoNPygwYXdXEPqP+fXg/v1cJKh7mLVS8g+9bwxxsjNvFaC+VhbUWZBU
         VrAv67MIsjzDQC4TBCSPM8zcT4g8hTFMFAO/F7G43uljlujfkQMMAxh67IsEJK8Hebty
         T9sy0jxiMwdYvjLvzPUTOVPMbSrqOEtB1PXuMsZ92Y7VJvXFuPAy/z3gKUHdHEqbwEAl
         b9ow==
X-Gm-Message-State: AGRZ1gK+r942hNb+XYkEf5W98XIHoZqp1ipYal/fZrAyzv1pp7qpF1Hd
        omByUUmAO0cbBVfni48QI7WzDb4XV3H/qpvCxTjdkvAd1XlXjFhG66KkNbW3LxiE37TyAsw43NU
        Khf9Sm9Y2g9p+jt1Rsf3GLrbxxXeX
X-Received: by 2002:a6b:3842:: with SMTP id f63-v6mr5307710ioa.223.1540058158944;
        Sat, 20 Oct 2018 10:55:58 -0700 (PDT)
X-Google-Smtp-Source: AJdET5fyTVZpsKJMZJ+p3e4Jbp76HhHrFP9f3LBBIIy2XGCKJjRDDE/tGSpf1PqGm296MllXcDcYnA==
X-Received: by 2002:a6b:3842:: with SMTP id f63-v6mr5307705ioa.223.1540058158708;
        Sat, 20 Oct 2018 10:55:58 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id u132-v6sm3602663ita.9.2018.10.20.10.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 20 Oct 2018 10:55:57 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thunderbolt: Fix a missing-check bug
Date:   Sat, 20 Oct 2018 12:55:51 -0500
Message-Id: <1540058151-17116-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tb_ctl_rx_callback(), the checksum of the received control packet is
calculated on 'pkg->buffer' through tb_crc() and saved to 'crc32', Then,
'crc32' is compared with the received checksum to confirm the integrity of
the received packet. If the checksum does not match, the packet will be
dropped. In the following execution, 'pkg->buffer' will be copied through
req->copy() and processed if there is an active request and the packet is
what is expected.

The problem here is that the above checking process is performed directly
on the buffer 'pkg->buffer', which is actually a DMA region. Given that the
DMA region can also be accessed directly by a device at any time, it is
possible that a malicious device controlled by an attacker can race to
modify the content in 'pkg->buffer' after the checksum checking but before
req->copy(). By doing so, the attacker can inject malicious data, which can
cause undefined behavior of the kernel and introduce potential security
risk.

This patch allocates a new buffer 'buf' to hold the data in 'pkg->buffer'.
By performing the checking and copying on 'buf', rather than 'pkg->buffer',
the above issue can be avoided.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/thunderbolt/ctl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index 37a7f4c..9e40572 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -409,6 +409,8 @@ static void tb_ctl_rx_callback(struct tb_ring *ring, struct ring_frame *frame,
 	struct ctl_pkg *pkg = container_of(frame, typeof(*pkg), frame);
 	struct tb_cfg_request *req;
 	__be32 crc32;
+	void *pkg_buf = pkg->buffer;
+	void *buf = NULL;
 
 	if (canceled)
 		return; /*
@@ -422,6 +424,13 @@ static void tb_ctl_rx_callback(struct tb_ring *ring, struct ring_frame *frame,
 		goto rx;
 	}
 
+	buf = kzalloc(frame->size, GFP_KERNEL);
+	if (!buf)
+		goto rx;
+
+	memcpy(buf, pkg->buffer, frame->size);
+	pkg->buffer = buf;
+
 	frame->size -= 4; /* remove checksum */
 	crc32 = tb_crc(pkg->buffer, frame->size);
 	be32_to_cpu_array(pkg->buffer, pkg->buffer, frame->size / 4);
@@ -476,6 +485,10 @@ static void tb_ctl_rx_callback(struct tb_ring *ring, struct ring_frame *frame,
 	}
 
 rx:
+	if (buf) {
+		pkg->buffer = pkg_buf;
+		kfree(buf);
+	}
 	tb_ctl_rx_submit(pkg);
 }
 
-- 
2.7.4

