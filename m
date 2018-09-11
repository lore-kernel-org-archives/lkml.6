Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F56DC4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2032A20880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqwO5FYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2032A20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeILCvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:51:16 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:38286 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbeILCvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:51:16 -0400
Received: by mail-io0-f193.google.com with SMTP id y3-v6so4852863ioc.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 14:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fgna4PdGFwEoKN458QoB7zhkmwlBKa1IPSt362SyF6Y=;
        b=RqwO5FYja9IlyZeCgo4q5mEr3Af83zfN4CSqW8+d49u51mGkZ81MaUtz6ZlCYkzo36
         U42ZIvdjLbl/Kylx5/k5a8R10e3l3rFuuJ3/W5RpLbCXZ0l+rHICpEVK3kl69sq/Jk0I
         /6GlKUAL2XJysTXr7w9jsbs2ZQRcTEJlgGZwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fgna4PdGFwEoKN458QoB7zhkmwlBKa1IPSt362SyF6Y=;
        b=qYQyvnNnCDgjtiPOrX/QWdRa5+NSkofG+6cWooV7RGg0CBQPAxTqNZjbmjJ6hrAAAv
         EuLeyBFLJuIuf0KMUQ4PED2MA2S+bRbkE7lVGQvEbAn8T4XuJxuBaJhttVxXWCJK5maD
         EEpS2yO2ns0lhYIpNt02G89FLNQkgPAZfZ1kpCd78QzIjqWVxcSPiN79kPl5I3ED17PS
         piBNTXbqD3nJ7MjMd1j3CBvxeDx4yJruRKGCC7/PYivwXTQPBNACxxd/gPJANegugZVX
         H1nK5LCMW471uNFYCmyDbHdlUdodrCBpv5dnsuwGHxUiSReo/LfXfdAQt18Kv/LsBl5x
         NfTw==
X-Gm-Message-State: APzg51C3x9JG2mUEOmxOMLdiN08UsCZaXR0GZgplPkeR4ZmAsgZ2dRHs
        Tm2C2qjGuWhbNc8CJLCyYNTMvQ==
X-Google-Smtp-Source: ANB0VdZj9DaZqs4k/oUe0QDlUYQ8Q5qgrWAJKX6K//+wHrn+SF+9xnYZ742YZTOv04LMexkJJIrNKw==
X-Received: by 2002:a6b:ac03:: with SMTP id v3-v6mr22664374ioe.71.1536702598558;
        Tue, 11 Sep 2018 14:49:58 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c3-v6sm1102172itd.8.2018.09.11.14.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Sep 2018 14:49:57 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, suzuki.poulose@arm.com,
        gregkh@linuxfoundation.org, kim.phillips@arm.com,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] coresight: Output debug messages only in sysFS mode
Date:   Tue, 11 Sep 2018 15:49:50 -0600
Message-Id: <1536702595-9999-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Status messages related to the establishment of paths between source and
sinks are not useful outside of a debugging environment and clogs the log
files needlessly.  They also trigger the lockdep mechanic when operating
from perf since they call output functions during process context switch.

This patch is fixing the problem by allowing debugging information to be
emitted only when operating from sysFS.  This doesn't change the 
debugging capability of the system since 1) everything that is done from
perf is built on top of the sysFS mode and 2) debugging output is
completely useless under perf.

Regards,
Mathieu 

Mathieu Poirier (5):
  coresight: Make path enable/disable aware of operation mode
  coresight: Make link components aware of operation mode
  coresight: Make sink disable functions aware of operation mode
  coresight: Define macro to replace dev_dbg() boiler plate code
  coresight: Allow drivers to be verbose only in sysFS mode

 .../coresight/coresight-dynamic-replicator.c       |  8 +++----
 drivers/hwtracing/coresight/coresight-etb10.c      |  8 +++----
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  4 ++--
 drivers/hwtracing/coresight/coresight-etm3x.c      |  7 ++++--
 drivers/hwtracing/coresight/coresight-etm4x.c      |  8 +++++--
 drivers/hwtracing/coresight/coresight-funnel.c     | 10 ++++----
 drivers/hwtracing/coresight/coresight-priv.h       |  9 +++++++-
 drivers/hwtracing/coresight/coresight-replicator.c |  8 +++----
 drivers/hwtracing/coresight/coresight-stm.c        |  2 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c    | 14 +++++------
 drivers/hwtracing/coresight/coresight-tmc-etr.c    |  4 ++--
 drivers/hwtracing/coresight/coresight-tpiu.c       |  6 ++---
 drivers/hwtracing/coresight/coresight.c            | 27 +++++++++++-----------
 include/linux/coresight.h                          |  8 ++++---
 14 files changed, 71 insertions(+), 52 deletions(-)

-- 
2.7.4

