Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC646C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAA920880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690326;
	bh=DhbrtCc5b1fp8mcthjvBdtYv1jxio08FaTg2OTtZLwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wj/44ir8z50oxHlRmOyuGNSq+X41ED0nlAmnZuW3xPU1CHWaXZzGcTZLIfXqCGPAg
	 HX7Yq0KVnfIck3P7XqKJRXXsrfR9ZiSMOEZLjzWsdG3W47fSgU4DmXpKPfeWdpldVm
	 SE7OjhQH7/0AUgcQ5LHHTtR4w2NKm+w6Mjo5+HEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfA1PpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:45:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfA1PpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:45:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DFCF20880;
        Mon, 28 Jan 2019 15:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690317;
        bh=DhbrtCc5b1fp8mcthjvBdtYv1jxio08FaTg2OTtZLwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e+CtyiKomTnHF/DpIv4YJRGgEZtRCG/19w+V3SnsMXeW1TTljf+Dz1TlilXBQusP6
         3BrUPKIH9ohF+nRqHvCbdQmRvdhrYY/mW/Y2Kx3ELdqToNcH2z7lHJQ4eEpHQV3KYH
         +FXaifoGge7a3SO2WFvmECmnaIPjURUDlRq5LFag=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mitch Williams <mitch.a.williams@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 048/304] i40e: suppress bogus error message
Date:   Mon, 28 Jan 2019 10:39:25 -0500
Message-Id: <20190128154341.47195-48-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mitch Williams <mitch.a.williams@intel.com>

[ Upstream commit 7cd8eb0861981ad212ce4242a1870c4b5831ceff ]

The i40e driver complains about unprivileged VFs trying to configure
promiscuous mode each time a VF reset occurs. This isn't the fault of
the poor VF driver - the PF driver itself is making the request.

To fix this, skip the privilege check if the request is to disable all
promiscuous activity. This gets rid of the bogus message, but doesn't
affect privilege checks, since we really only care if the unprivileged
VF is trying to enable promiscuous mode.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index ac5698ed0b11..c41e8ada23d1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1112,7 +1112,8 @@ static i40e_status i40e_config_vf_promiscuous_mode(struct i40e_vf *vf,
 	if (!i40e_vc_isvalid_vsi_id(vf, vsi_id) || !vsi)
 		return I40E_ERR_PARAM;
 
-	if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
+	if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps) &&
+	    (allmulti || alluni)) {
 		dev_err(&pf->pdev->dev,
 			"Unprivileged VF %d is attempting to configure promiscuous mode\n",
 			vf->vf_id);
-- 
2.19.1

