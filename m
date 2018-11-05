Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505B1C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A7A20825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L4OgzKh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A7A20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbeKFHs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:48:28 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:42733 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbeKFHs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:48:28 -0500
Received: by mail-pl1-f182.google.com with SMTP id t6-v6so5137792plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 14:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=y+ddjEzD3JlIhTblXhZGXsMqfZXc/g+LWxolFBNW6WA=;
        b=L4OgzKh8cY1F03AuKCDZ2AoOwdF1EaKPYH57dn1BPPf6xtO6kKKK/1HEX4Avxw/p1Q
         bWqJiZ+TnP+28qomcfN//dRnVdiw/fF8dMWf2r9MlnU9ixDmxcOpaSZsLPkxSNqGsUpd
         RhLXCl75aMBVlgFgj+IjW7Xc6TVj91i7oHTO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y+ddjEzD3JlIhTblXhZGXsMqfZXc/g+LWxolFBNW6WA=;
        b=WGt1G7Ozdoi/C55lndUNbJMvt1aAfFyE43IM/qCY/fzzesGv4jn6it0oprh2L30/Pn
         qousNd43DLsedjwgbBBINrYtBNzh87NkdaSGzRRW4UfeD9L00RYz62paKp6ua3gl4Jjj
         vEljmYhSWEpsnrmnMh7LHUUx2cWsPYAg8VktYEYwLON5adW7LZJVnMwDI3XIxeYzgOOW
         dMge/uOdAct3y2mj98ZEbSLcxC/puXZmOdm3gZwf+xLfkWZ1rlZtTUeTRoVTcPV7BFbZ
         DogHuI8KxfobPBGtyVDJOJMl5zPVQN/hkrHEhDsOzZMQ8djyBwV+eTdE8mEu6JFfPYVS
         umTQ==
X-Gm-Message-State: AGRZ1gLj7iUWIuuMsDdYV3Jtpd5pO4Ms8hQaaftwyhFLc7tSq0o3A7Li
        d3J6BModZ0v9YlYOF5gRIjYQvw==
X-Google-Smtp-Source: AJdET5dKASFV12cJDfE66CPtk/1QUKIp3uymqarOiKDIBjZJVs0ffy1BNW7G5SKuL1iWcOHp4ZFFow==
X-Received: by 2002:a17:902:8342:: with SMTP id z2-v6mr23412122pln.147.1541456793397;
        Mon, 05 Nov 2018 14:26:33 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q26-v6sm58669804pfi.165.2018.11.05.14.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 14:26:32 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, leo.yan@linaro.org,
        suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] coresight: Fix miscellaneous problems with CLAIM tags 
Date:   Mon,  5 Nov 2018 15:26:27 -0700
Message-Id: <1541456790-28282-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set addresses 3 problems observed with the CLAIM tag feature.  The first
patch adds support for CLAIM tags to the ETB10 drivers.  The second and third
patch deal with releasing the tags on ETF and ETM3x devices.

Review and testing would be appreciated.

Regards,
Mathieu

Mathieu Poirier (3):
  coresight: etb10: Add support for CLAIM tag
  coresight: etf: Release CLAIM tag after disabling the HW
  coresight: etm3x: Release CLAIM tag when operated from perf

 drivers/hwtracing/coresight/coresight-etb10.c   | 23 +++++++++++++++++------
 drivers/hwtracing/coresight/coresight-etm3x.c   |  2 ++
 drivers/hwtracing/coresight/coresight-tmc-etf.c |  2 +-
 3 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.7.4

