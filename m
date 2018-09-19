Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4612FECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFB120867
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQJOsWhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFB120867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbeITEAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:00:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36467 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeITEAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:00:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so3356937pfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QMPnc7R+KyqhorgJumqr7AhbuHK1r2kT9gXIvgUfXcI=;
        b=QQJOsWhwF9fVIUvIuUog6dZWXs5axvm2Q7ws8laO4W34mlrwVDzTbJk1BskHA221rA
         mDVQvYKPMy4EKfsUaCAGwLH1lREG7//GxzgxS+791++dihvJPsgQjkfzkEdmcAjipCI1
         D+Shke0qiauCTDPBtLgPPw75h29xN8Oec5fmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QMPnc7R+KyqhorgJumqr7AhbuHK1r2kT9gXIvgUfXcI=;
        b=DBNsCD6rhjg37Vi3Xm9r1Pt5ndqhFA4J8AJ8d1TyqgvA8r5flBt8dOJqXChtkK95Nh
         zAuPgdegdUBx/DLHoYIwEgZGExcP6nenBg55f+YvGQkbw/TQPW1bF9GiEyAKt9yWHcVo
         VqqZ4QPrEEXBOFIq/DMngLtoo6cxGivqwVOJAWagXgwu/aY0wmJGR9VmtMvzuV5nzzcl
         uLqC0XDNBswNKHz6cvZOCpZ/Jc8+IPJWeQRRDE+kFIKkNBsrTu1LwYSuFi0suZvBp5xz
         PCK1Ux7/8bmbi3sFKmlNjiYpsIHmfX8DW4f2v0bjAji3s+gRF9VTtWNslC95JwmfkZ1f
         u5sg==
X-Gm-Message-State: APzg51Dw9iSQx9ZeeAnfaTyMy93HbUBt3Lg2pSCvGrk8MaBPxqfPdIsC
        5L7VDY0BAVUBeMSMIxFa3NGNDQ==
X-Google-Smtp-Source: ANB0VdZUNeEbFh3jHbRD+MZ0TxynVLhOJMlg8KdkAC/H5CGZq7Glm0caXdBSISCcJSy3as5RvKhTiQ==
X-Received: by 2002:a62:1192:: with SMTP id 18-v6mr38341906pfr.54.1537395643007;
        Wed, 19 Sep 2018 15:20:43 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id g5-v6sm28676961pgn.73.2018.09.19.15.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 15:20:41 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "4.18" <stable@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH V2 00/12] OPP: Don't create multiple OPP tables for devices sharing OPP table
Date:   Wed, 19 Sep 2018 15:20:19 -0700
Message-Id: <cover.1537394233.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Niklas Cassle recently reported some regressions with his Qcom cpufreq
driver where he was getting some errors while creating the OPPs tables.

After looking into it I realized that the OPP core incorrectly creates
multiple OPP tables for the devices even if they are sharing the OPP
table in DT. This happens when the request comes using different CPU
devices. For example, dev_pm_opp_set_supported_hw() getting called using
CPU0 and dev_pm_opp_of_add_table() getting called using CPU1.

This series redesigns the internals of the OPP core to fix that. The
redesign has simplified the core itself though.

The first three patches are fixes really for the current code and the rest
of them are making necessary changes to fix the issue defined in
$subject here.

Nikklas already tested this series and his Tested-by is already applied
to series here. I would like to get this merged during the 4.20 merge
window and will push the series to linux-next soon to get more test
coverage. Please provide comments as soon as possible, else will send it
as part of the pull request to Rafael for 4.20.

--
viresh

V1->V2:
- Nikklas reported another regressions which is fixed by the 2nd commit
  in this series.

Viresh Kumar (12):
  OPP: Free OPP table properly on performance state irregularities
  OPP: Don't try to remove all OPP tables on failure
  OPP: Protect dev_list with opp_table lock
  OPP: Pass index to _of_init_opp_table()
  OPP: Parse OPP table's DT properties from _of_init_opp_table()
  OPP: Don't take OPP table's kref for static OPPs
  OPP: Create separate kref for static OPPs list
  cpufreq: mvebu: Remove OPPs using dev_pm_opp_remove()
  OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()
  OPP: Use a single mechanism to free the OPP table
  OPP: Prevent creating multiple OPP tables for devices sharing OPP
    nodes
  OPP: Pass OPP table to _of_add_opp_table_v{1|2}()

 drivers/cpufreq/mvebu-cpufreq.c |   9 +-
 drivers/opp/core.c              | 147 ++++++++++++++++++++-----------
 drivers/opp/cpu.c               |  15 ++--
 drivers/opp/of.c                | 188 +++++++++++++++++++++-------------------
 drivers/opp/opp.h               |  19 ++--
 include/linux/pm_opp.h          |   6 ++
 6 files changed, 226 insertions(+), 158 deletions(-)

-- 
2.14.1

