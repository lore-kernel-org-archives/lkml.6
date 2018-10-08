Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36D7C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5F72087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwdCUT0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5F72087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbeJICCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:02:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbeJICCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:02:12 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F28321508;
        Mon,  8 Oct 2018 18:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024545;
        bh=zu3NtjZLN/NzA2S/Lyal5ImadyqG8QwsFt3nX47odjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JwdCUT0KWcQ30JmYRReI8OG+28VUXh9mD5YOaJfAypGgN3pzZ5/xs2dKvz0o/msFD
         WTUKfgcu+JMPpRvArjneR3/0v7ez9S0dL6nOyPSlqfkDkvBeRC8ivEQHBQhZBG9JyT
         h7SUgRpBTEFuu8P6fKPVO16MhRBNHZCtR+ey4/Cc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 075/168] firmware: arm_scmi: fix divide by zero when sustained_perf_level is zero
Date:   Mon,  8 Oct 2018 20:30:55 +0200
Message-Id: <20181008175622.924936054@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit 96d529bac562574600eda85726fcfa3eef6dde8e ]

Firmware can provide zero as values for sustained performance level and
corresponding sustained frequency in kHz in order to hide the actual
frequencies and provide only abstract values. It may endup with divide
by zero scenario resulting in kernel panic.

Let's set the multiplication factor to one if either one or both of them
(sustained_perf_level and sustained_freq) are set to zero.

Fixes: a9e3fbfaa0ff ("firmware: arm_scmi: add initial support for performance protocol")
Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/arm_scmi/perf.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -166,7 +166,13 @@ scmi_perf_domain_attributes_get(const st
 					le32_to_cpu(attr->sustained_freq_khz);
 		dom_info->sustained_perf_level =
 					le32_to_cpu(attr->sustained_perf_level);
-		dom_info->mult_factor =	(dom_info->sustained_freq_khz * 1000) /
+		if (!dom_info->sustained_freq_khz ||
+		    !dom_info->sustained_perf_level)
+			/* CPUFreq converts to kHz, hence default 1000 */
+			dom_info->mult_factor =	1000;
+		else
+			dom_info->mult_factor =
+					(dom_info->sustained_freq_khz * 1000) /
 					dom_info->sustained_perf_level;
 		memcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
 	}


