Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB20C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A2F23E16
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PQC8oJ9x";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PQC8oJ9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A2F23E16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeGDOUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:20:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58378 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeGDOT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:19:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4F03860B24; Wed,  4 Jul 2018 14:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530713999;
        bh=6eCQGCIEVidHmMUNSNe81rp8Yv21ARXxVD1M3lCUosM=;
        h=From:To:Cc:Subject:Date:From;
        b=PQC8oJ9xO30IujenAjkUw12RnYmMeWyOAkxXvuHXJDog0rYvpSD8n7p5RABSB2w+e
         5kajgkVuACmJQQ17YymV+pBPAYHmT8LnCtpIPzjhqfwqrxj1mgXDxzxEz2J8gFLe3l
         JYwKB1r+q2qNIY/gI9/p0n1n9QcxrYZkkMv1TQ0A=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1803C6037C;
        Wed,  4 Jul 2018 14:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530713999;
        bh=6eCQGCIEVidHmMUNSNe81rp8Yv21ARXxVD1M3lCUosM=;
        h=From:To:Cc:Subject:Date:From;
        b=PQC8oJ9xO30IujenAjkUw12RnYmMeWyOAkxXvuHXJDog0rYvpSD8n7p5RABSB2w+e
         5kajgkVuACmJQQ17YymV+pBPAYHmT8LnCtpIPzjhqfwqrxj1mgXDxzxEz2J8gFLe3l
         JYwKB1r+q2qNIY/gI9/p0n1n9QcxrYZkkMv1TQ0A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1803C6037C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     davem@davemloft.net, bjorn.andersson@linaro.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH 0/2] net: qrtr: Broadcasting control messages
Date:   Wed,  4 Jul 2018 19:49:31 +0530
Message-Id: <1530713973-26696-1-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow messages only from control port to broadcast to avoid unnecessary 
messages and reset the node to local router NODE ID in control messages
otherwise remote routers consider the packets as invalid and Drops it.

Arun Kumar Neelakantam (2):
  net: qrtr: Broadcast messages only from control port
  net: qrtr: Reset the node and port ID of broadcast messages

 net/qrtr/qrtr.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

