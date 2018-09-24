Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6784CECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B102208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cX5p8JEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B102208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbeIXXjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:39:19 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:43038 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730136AbeIXXjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:39:19 -0400
Received: by mail-wr1-f50.google.com with SMTP id z14-v6so3046720wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rzmedtbhg7IS0r54ifhaUtzOPEG23s2mXamk/CVg76c=;
        b=cX5p8JEdEoZXt6dTNUTim3S1IrbbNolp8podHGGZFFKhIFPkEZ7pFIswP47VtmNX9y
         uKjB0JNcCsOompp7qSMCc/zUyElAoypLRBI22VE9guIzG3j9K8/X1vN5S0i9db3V+CNb
         Ld0N9PBQf9Rn9Fd94pKNl4+bQmpW/YL0A9a9lZKtOuuKvSajEqXeSnyq7Uit1fNFzC2Z
         WTdcv8ahrnKfc2LKH7R7vXTaAe2A4OODqVMyz/mgoXAYgPK8/lpobGBNpvL3TrQqKJK0
         puzTwF+o3sFAgCnuNdaz5fDuqhu6I2h3rliL+yX0fkSqZiG8UGVm9j+WF2e9p3wYzjQB
         ZL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rzmedtbhg7IS0r54ifhaUtzOPEG23s2mXamk/CVg76c=;
        b=YvOSHycvPXDk+pBfdU2J7WZhvrvwh2yt7muZGPmWSbyBdk3s1HXF4/5LuUFpsT8DQR
         BrVAxr+BhldEMIPUelrQbWsI4cuuaW+/QhBqx2sN4Sm13I/dfX7JTuJsLSTOVn2H4SJ6
         oThSK++7q/e98GTY+7diI8KzJTr2q+Hw13Ta/VPx17ZpCZ7RH3skuacDjzuqfZdbj+YU
         abVp++ifMJMLo6PFO8fdUvbJxbf7Fbqlj4goSHsNzY2+lZOQKv3JyGyiiG90RNRDn99U
         0P5Bt8nNFvIlPzYDdx2U0EPJI/4YJx8+845QuhljWGHkOZidro1cR4AS4YcfZ1kTEkBW
         X4Bg==
X-Gm-Message-State: ABuFfohlz4iLytPWz+Ps3slFKW8Ff6RRtbmG41Y0LiJwRvBHCITKTSXI
        KcPJV2IeSgCqFsfzaSaAd1M=
X-Google-Smtp-Source: ACcGV61sbc5aZCRSOQQJg2qvrA0UgrxEjwSqPAMOIDhiSUX2wC2m04eQgz7UMATvCZXEc+tOnVo5SQ==
X-Received: by 2002:adf:81b5:: with SMTP id 50-v6mr10305726wra.10.1537810564206;
        Mon, 24 Sep 2018 10:36:04 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:c])
        by smtp.gmail.com with ESMTPSA id k34-v6sm52138834wre.18.2018.09.24.10.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 10:36:03 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Aymen Qader <qader.aymen@gmail.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] staging: vc04_services: Fix checkpatch.pl errors
Date:   Mon, 24 Sep 2018 18:35:43 +0100
Message-Id: <20180924173547.23393-1-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes the following checkpatch.pl errors in the
interface/vchi directory:

ERROR: space prohibited after/before that open/closed parenthesis
ERROR: code indent should use tabs where possible
ERROR: space required after that ','
ERROR: Macros with complex values should be enclosed in parentheses
ERROR: "foo * bar" should be "foo* bar"

Aymen Qader (4):
  staging: vc04_services: Fix "space prohibited"
  staging: vc04_services: Use tabs instead of spaces
  staging: vc04_services: Remove unused macros
  staging: vc04_services: Remove spaces after '*'

v2: Added cover letter correctly
v3: Remove unused macros
v4: Added patch changelog to cover letter

 .../vc04_services/interface/vchi/vchi.h       | 208 +++++++-----------
 .../vc04_services/interface/vchi/vchi_cfg.h   |   2 +-
 2 files changed, 86 insertions(+), 124 deletions(-)

-- 
2.17.1

