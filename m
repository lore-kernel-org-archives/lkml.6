Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D200C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D631B206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218572;
	bh=H0TqbydTvvEY2L6XzgH6i9YwzxGk6qbpcrodCJx46yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r7YxZsRpJaZnSKO82UOqjKF8d0NgeR3ok+qgIPe0CpNXE8DIBH5zdTze3KYlpqRXf
	 I6FXCoEwPUnJco2QGUoZGqbWdtW7l0L5iosGmKHEtnkBQyAgidl0n2Pi+3b7ly9/qT
	 BU0eR8HQZjf5gvGqKzqvKs7ZJEaTNYSwQskt6FNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390268AbfAKOgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:36:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389539AbfAKOf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:35:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E87252063F;
        Fri, 11 Jan 2019 14:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217356;
        bh=H0TqbydTvvEY2L6XzgH6i9YwzxGk6qbpcrodCJx46yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+kagQtzK3ydgJ1TEH39y6xd2AQwv9yWkKTHlTcTURjvkKGk3Yedjn8WxwM+UO3+o
         lwTsKmElS2FkSdnSOVFxdSVDl1Dz5Yv6fJaigYMJ7C71l5oIoplk07Q7G+GVj5MZyO
         JwL7jnA+T7BtuueGPn1arO4rNdnYSIWTzNWw8x9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Lagerwall <ross.lagerwall@citrix.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 032/148] ixgbe: Fix race when the VF driver does a reset
Date:   Fri, 11 Jan 2019 15:13:30 +0100
Message-Id: <20190111131115.586312241@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 96d1a731611f711f0cb82cea93363ae2ea8cb028 ]

When the VF driver does a reset, it (at least the Linux one) writes to
the VFCTRL register to issue a reset and then immediately sends a reset
message using the mailbox API. This is racy because when the PF driver
detects that the VFCTRL register reset pin has been asserted, it clears
the mailbox memory. Depending on ordering, the reset message sent by
the VF could be cleared by the PF driver. It then responds to the
cleared message with a NACK which causes the VF driver to malfunction.
Fix this by deferring clearing the mailbox memory until the reset
message is received.

Fixes: 939b701ad633 ("ixgbe: fix driver behaviour after issuing VFLR")
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index eea63a99f29c..f6ffd9fb2079 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -699,7 +699,6 @@ static inline void ixgbe_vf_reset_event(struct ixgbe_adapter *adapter, u32 vf)
 	u8 num_tcs = adapter->hw_tcs;
 	u32 reg_val;
 	u32 queue;
-	u32 word;
 
 	/* remove VLAN filters beloning to this VF */
 	ixgbe_clear_vf_vlans(adapter, vf);
@@ -754,6 +753,14 @@ static inline void ixgbe_vf_reset_event(struct ixgbe_adapter *adapter, u32 vf)
 		}
 	}
 
+	IXGBE_WRITE_FLUSH(hw);
+}
+
+static void ixgbe_vf_clear_mbx(struct ixgbe_adapter *adapter, u32 vf)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 word;
+
 	/* Clear VF's mailbox memory */
 	for (word = 0; word < IXGBE_VFMAILBOX_SIZE; word++)
 		IXGBE_WRITE_REG_ARRAY(hw, IXGBE_PFMBMEM(vf), word, 0);
@@ -827,6 +834,8 @@ static int ixgbe_vf_reset_msg(struct ixgbe_adapter *adapter, u32 vf)
 	/* reset the filters for the device */
 	ixgbe_vf_reset_event(adapter, vf);
 
+	ixgbe_vf_clear_mbx(adapter, vf);
+
 	/* set vf mac address */
 	if (!is_zero_ether_addr(vf_mac))
 		ixgbe_set_vf_mac(adapter, vf, vf_mac);
-- 
2.19.1



