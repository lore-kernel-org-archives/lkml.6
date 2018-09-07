Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209E3C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3122077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3122077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeIGQAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 12:00:14 -0400
Received: from mx01.hxt-semitech.com ([223.203.96.7]:46769 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728407AbeIGQAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 12:00:14 -0400
X-ASG-Debug-ID: 1536319181-093b7e54e60b370001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda.hxt-semitech.com with ESMTP id SyYyS7FJ72Mkz07p (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 07 Sep 2018 19:19:41 +0800 (CST)
X-Barracuda-Envelope-From: dongsheng.wang@hxt-semitech.com
Received: from localhost.localdomain.localdomain (10.5.21.103) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 7 Sep 2018 19:19:45 +0800
From:   Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
To:     <jeffrey.t.kirsher@intel.com>, <sergei.shtylyov@cogentembedded.com>
CC:     <jacob.e.keller@intel.com>, <davem@davemloft.net>,
        <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Subject: [PATCH v3 0/2] net: ethernet: i40e/i40evf fix build error
Date:   Fri, 7 Sep 2018 19:19:33 +0800
X-ASG-Orig-Subj: [PATCH v3 0/2] net: ethernet: i40e/i40evf fix build error
Message-ID: <1536319175-3660-1-git-send-email-dongsheng.wang@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.103]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15)
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1536319181
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9231 1.0000 3.4748
X-Barracuda-Spam-Score: 3.47
X-Barracuda-Spam-Status: No, SCORE=3.47 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.57058
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i40e: function __i40e_add_stat_strings can never be inlined because it uses
variable argument lists.

i40evf: A risk of "Multiple definition" from cross-including.

I am working on aarch64 platform and unfortunately the config file is MODULE.
So I missed the buildin test... Sorry for pushing this patch to v3 version...

Now I tested this patch with buildin and modules.

Tested on: x86_64, make ARCH=i386

Modules section .text:
i40e: 00019380 <__i40e_add_stat_strings>:
i40evf: 00006b00 <__i40e_add_stat_strings>:

Buildin:
i40e: c351ca60 <__i40e_add_stat_strings>:
i40evf: c354f2c0 <__i40e_add_stat_strings>:


Wang Dongsheng (2):
  net: ethernet: i40e: fix build error
  net: ethernet: i40evf: fix underlying build error

 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 24 ++++++++++++++++++
 .../ethernet/intel/i40e/i40e_ethtool_stats.h  | 25 ++-----------------
 .../intel/i40evf/i40e_ethtool_stats.h         | 23 +----------------
 .../ethernet/intel/i40evf/i40evf_ethtool.c    | 24 ++++++++++++++++++
 4 files changed, 51 insertions(+), 45 deletions(-)

-- 
2.18.0

