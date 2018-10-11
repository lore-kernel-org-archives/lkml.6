Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC178C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7386C21470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBgxqpTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7386C21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbeJKXGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeJKXGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:06:34 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 307CF2087A;
        Thu, 11 Oct 2018 15:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272331;
        bh=A6hBdAoyDGHQGkNx91KcM/ZyVqMsbk0S9AKeEWldjE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qBgxqpTQJ8C7AnSOebYC7Zjy4oPGQN0T+nFR0KCDS4jOBi2n5CmJ33d09IrZbJK/c
         p4QA9P7KXOyxNBY2uzERqxme4qRhpJFw29v0IlHZxiX5sKrVZIEw8Dd4Bv92X/986p
         d6ve5Wu17A0KPId8naRexw/3kYFvKw940WicScwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Danek Duvall <duvall@comfychair.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 072/120] mac80211: correct use of IEEE80211_VHT_CAP_RXSTBC_X
Date:   Thu, 11 Oct 2018 17:34:13 +0200
Message-Id: <20181011152552.793140431@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Danek Duvall <duvall@comfychair.org>

[ Upstream commit 67d1ba8a6dc83d90cd58b89fa6cbf9ae35a0cf7f ]

The mod mask for VHT capabilities intends to say that you can override
the number of STBC receive streams, and it does, but only by accident.
The IEEE80211_VHT_CAP_RXSTBC_X aren't bits to be set, but values (albeit
left-shifted).  ORing the bits together gets the right answer, but we
should use the _MASK macro here instead.

Signed-off-by: Danek Duvall <duvall@comfychair.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/main.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -465,10 +465,7 @@ static const struct ieee80211_vht_cap ma
 		cpu_to_le32(IEEE80211_VHT_CAP_RXLDPC |
 			    IEEE80211_VHT_CAP_SHORT_GI_80 |
 			    IEEE80211_VHT_CAP_SHORT_GI_160 |
-			    IEEE80211_VHT_CAP_RXSTBC_1 |
-			    IEEE80211_VHT_CAP_RXSTBC_2 |
-			    IEEE80211_VHT_CAP_RXSTBC_3 |
-			    IEEE80211_VHT_CAP_RXSTBC_4 |
+			    IEEE80211_VHT_CAP_RXSTBC_MASK |
 			    IEEE80211_VHT_CAP_TXSTBC |
 			    IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE |
 			    IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |


