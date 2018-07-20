Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB66DECDFBD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7264C2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7264C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbeGTSul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:50:41 -0400
Received: from ale.deltatee.com ([207.54.116.67]:38344 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388244AbeGTSuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:50:03 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1fgZhn-0008E0-0V; Fri, 20 Jul 2018 12:00:41 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1fgZhk-00012l-JJ; Fri, 20 Jul 2018 12:00:36 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>
Cc:     Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>, Doug Meyer <dmeyer@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 20 Jul 2018 12:00:26 -0600
Message-Id: <20180720180034.3964-1-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, jdmason@kudzu.us, allenbh@gmail.com, fancer.lancer@gmail.com, Shyam-sundar.S-k@amd.com, shuah@kernel.org, dmeyer@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 0/8] Fix breakage caused by the NTB multi-port patchset
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

This is mostly a resend.

To reiterate the main points on the feedback: the switchtec driver,
in the cross link mode, will not be able to implement the port number
function callbacks and will have to always return 0. It's a physical
impossibility due to the symmetry. Therefore, in order fix this feature
(which worked when merged), the clients must be changed to support not
knowing the port number in the way they worked previously (ie. a legacy
mode where there will only be two ports and you know there will be two
sets of doorbells, one for each peer). The majority of this patch set
fixes these issues.

The other point of controversy is the dma mask. I still strongly
disagree with doing it in the driver as the code is clearly common
to all and not at all driver specific. Moreover, I think as written,
it is extra dangerous seeing all impleminting drivers are operating on
the new struct device before it's initialized in ntb_register().
Patch 2 in this series also fixes that.

Logan

--

Changes since v1:
- Rebased onto ntb-next (there was a minor conflict in a recent change
  to the intel driver)
- Collected Dave's ack.

--

Logan Gunthorpe (8):
  NTB: ntb_tool: reading the link file should not end in a NULL byte
  NTB: Setup the DMA mask globally for all drivers
  NTB: Fix the default port and peer numbers for legacy drivers
  NTB: ntb_pingpong: Choose doorbells based on port number
  NTB: perf: Don't require one more memory window than number of peers
  NTB: perf: Fix support for hardware that doesn't have port numbers
  NTB: perf: Fix race condition when run with ntb_test
  NTB: ntb_test: Fix bug when counting remote files

 drivers/ntb/hw/amd/ntb_hw_amd.c         |  4 ----
 drivers/ntb/hw/idt/ntb_hw_idt.c         |  6 ------
 drivers/ntb/hw/intel/ntb_hw_gen1.c      |  4 ----
 drivers/ntb/ntb.c                       | 22 ++++++++++++++--------
 drivers/ntb/test/ntb_perf.c             | 22 +++++++++++++++++++---
 drivers/ntb/test/ntb_pingpong.c         | 14 ++++++--------
 drivers/ntb/test/ntb_tool.c             |  3 +--
 tools/testing/selftests/ntb/ntb_test.sh |  2 +-
 8 files changed, 41 insertions(+), 36 deletions(-)

--
2.11.0
