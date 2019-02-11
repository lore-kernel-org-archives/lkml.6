Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD957C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30C220838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549894961;
	bh=nwe5s4NRFI2SssgFOqe+xo4uBmd8N0lfiYXW80rFqxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=olO7QHtu0ITHlsb+QzfpEm2DUzH/OPTeETQ2YnVZex7GXWnQNr434eiDs38rejLmW
	 gAMU5MXFyXC5slrYeqa29YUD7s9yOJVeP0VC0x4OnuASZVWzipuw6sbYR3pjQXBgy/
	 PkdJ7hqquWy6UzXwAFVmUXrmDD5JayMeK3fnYGqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfBKOWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:22:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728788AbfBKOWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:22:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 284E920838;
        Mon, 11 Feb 2019 14:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894956;
        bh=nwe5s4NRFI2SssgFOqe+xo4uBmd8N0lfiYXW80rFqxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qBo2KF6eYEZNpNXM44MnxihAd6loNm6u7tqQCCz1ubUpa/B+AYaAX6IlQm8liwamd
         JVn6NgKKJeUuGPKeoejpHeM1pU1WTODoWqCXY4Qf9vdI+IxOqBsEXVoRVVZWbiSyXE
         VeUbjsZxj5OMQZV/yTgaDXuZpHjiE5kvo28tqnFY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mitch Williams <mitch.a.williams@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 042/352] i40e: suppress bogus error message
Date:   Mon, 11 Feb 2019 15:14:29 +0100
Message-Id: <20190211141848.983190844@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



