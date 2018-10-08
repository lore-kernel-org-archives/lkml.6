Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7268DC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B85F204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PucrFrxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B85F204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbeJICBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:01:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbeJICBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:01:22 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BB2D204FD;
        Mon,  8 Oct 2018 18:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024495;
        bh=D7fNSCHU86OMgINeOV0aOtJ0D2Znxoq5yHyu0ADfrcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PucrFrxtRCS7yDpo86mlTMUYrEnDEBb0lGGXVJG/5H1sME1lz6whjVwttZOf7BhAh
         0zUijuZXnh5Ccia0vP911IYDs3fg+Kw4IvOAHnlnDjUVRuc1jzSQYBg46/C6uyUhDf
         /NOJ6mxrU1emstotNlejt7a3zlRsfHRSewkar9+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 058/168] cfg80211: fix a type issue in ieee80211_chandef_to_operating_class()
Date:   Mon,  8 Oct 2018 20:30:38 +0200
Message-Id: <20181008175622.259986752@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 8442938c3a2177ba16043b3a935f2c78266ad399 ]

The "chandef->center_freq1" variable is a u32 but "freq" is a u16 so we
are truncating away the high bits.  I noticed this bug because in commit
9cf0a0b4b64a ("cfg80211: Add support for 60GHz band channels 5 and 6")
we made "freq <= 56160 + 2160 * 6" a valid requency when before it was
only "freq <= 56160 + 2160 * 4" that was valid.  It introduces a static
checker warning:

    net/wireless/util.c:1571 ieee80211_chandef_to_operating_class()
    warn: always true condition '(freq <= 56160 + 2160 * 6) => (0-u16max <= 69120)'

But really we probably shouldn't have been truncating the high bits
away to begin with.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/util.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1374,7 +1374,7 @@ bool ieee80211_chandef_to_operating_clas
 					  u8 *op_class)
 {
 	u8 vht_opclass;
-	u16 freq = chandef->center_freq1;
+	u32 freq = chandef->center_freq1;
 
 	if (freq >= 2412 && freq <= 2472) {
 		if (chandef->width > NL80211_CHAN_WIDTH_40)


