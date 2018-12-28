Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CC3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D71B2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999391;
	bh=mTQwV9POMLhAbrSlxv5wSnytiVMQN/3xDM1wyAqH/Bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MmT0tNMPXXsXmDVD+Vk4B+KGo+1tPy4Kv46RtTjgLzoGLVfrHIH/Xkzg6u81NFXgF
	 yQnLdqL8CxKBJNubAm+cyiQ43pQQVw8xm0K5+Di8UMlAfqoPCB8majoNJJAkX1cIa4
	 geYzgsB2gPkyzgXOnZ1iagou57WFVQjZx6OJdYUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732680AbeL1MQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:16:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:35566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732693AbeL1MQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:16:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABA002087F;
        Fri, 28 Dec 2018 12:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999386;
        bh=mTQwV9POMLhAbrSlxv5wSnytiVMQN/3xDM1wyAqH/Bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R3NOAOQOo4Zeivc3Lz/G5jUzvbMmyXSLSt+ExNYEBW7uG3BwXwk3Jcfu/r/RrG5h2
         D6mORYz3sNIM+fY6xz1VL7SoEYONivrdDc5Jx7KZOWrRWj2MKGh+loGOBtvQAn+MFi
         HwTgvDX6SfPUTQTSxiCbgpnPUGAYre/EO0RIo7rA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.14 29/36] iwlwifi: mvm: dont send GEO_TX_POWER_LIMIT to old firmwares
Date:   Fri, 28 Dec 2018 12:52:45 +0100
Message-Id: <20181228113128.461272700@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.526729877@linuxfoundation.org>
References: <20181228113126.526729877@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

commit eca1e56ceedd9cc185eb18baf307d3ff2e4af376 upstream.

Old firmware versions don't support this command. Sending it
to any firmware before -41.ucode will crash the firmware.

This fixes https://bugzilla.kernel.org/show_bug.cgi?id=201975

Fixes: 66e839030fd6 ("iwlwifi: fix wrong WGDS_WIFI_DATA_SIZE")
CC: <stable@vger.kernel.org> #4.19+
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -952,6 +952,15 @@ static int iwl_mvm_sar_geo_init(struct i
 	int ret, i, j;
 	u16 cmd_wide_id =  WIDE_ID(PHY_OPS_GROUP, GEO_TX_POWER_LIMIT);
 
+	/*
+	 * This command is not supported on earlier firmware versions.
+	 * Unfortunately, we don't have a TLV API flag to rely on, so
+	 * rely on the major version which is in the first byte of
+	 * ucode_ver.
+	 */
+	if (IWL_UCODE_SERIAL(mvm->fw->ucode_ver) < 41)
+		return 0;
+
 	ret = iwl_mvm_sar_get_wgds_table(mvm);
 	if (ret < 0) {
 		IWL_DEBUG_RADIO(mvm,


