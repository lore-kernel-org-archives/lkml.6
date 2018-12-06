Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A85C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD9D20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107209;
	bh=VhRq2Z9THU9FQ3yfYUb/mSj1XQ9YCaWRLzxtVVvLvgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RNJMmFvE2/FKNGPFqeO+M3QGUkyXapC5S1Pe48D1TDlkynsxvD+Dvli8RoakcoITC
	 uyLBFoa+GBc3F6jJftwgyrAc36XLVHfqGqfdDrwOQQspFWStC86Hf98b8UrxpNYwmo
	 aTf2ykUdEJco2YVz7qdpj07BVioHyohEyIZiORls=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD9D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbeLFOkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:40:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729797AbeLFOkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:40:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC75520892;
        Thu,  6 Dec 2018 14:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107205;
        bh=VhRq2Z9THU9FQ3yfYUb/mSj1XQ9YCaWRLzxtVVvLvgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rHBMhRubSjqI6VolNDndOWw58e3Rk6qZ6mAZK1WTsi/Ma32Xg5hBqd2zST3ow3uBE
         z6mLt5UflMre8nTK2C4LW7GB4DpfOh1V7SUvZtT6T/0UnwLqeVwKn9mD/P/ea8AzD2
         dIwyIka2WnCzklGox6qTbHHFxHEf8RE1qdYyDfiw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 15/41] drm/amd/dm: Dont forget to attach MST encoders
Date:   Thu,  6 Dec 2018 15:38:55 +0100
Message-Id: <20181206142951.034168427@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
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

From: Lyude Paul <lyude@redhat.com>

commit c9e0ab86b2e03154bb898cd2f851827783224727 upstream.

The change fixed huge delay in SST daisy chain and S3 soft hang
observed in 4.19 kernel rebase.

Regression point in drm:
drm/fb-helper: Eliminate the .best_encoder() usage

The aux sequence is altered due to the failure in
drm_connector_for_each_possible_encoder(). The failure is
caused by missing attached encoder in the process of adding
MST connector.
 
drm_dp_send_enum_path_resources() aux transaction is pushed after
mode probe, which causes conflict to drm_dp_mst_i2c_xfer(),
leading to the transaction timeout.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
Cc: Stable <stable@vger.kernel.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -374,6 +374,8 @@ dm_dp_add_mst_connector(struct drm_dp_ms
 		master->connector_id);
 
 	aconnector->mst_encoder = dm_dp_create_fake_mst_encoder(master);
+	drm_connector_attach_encoder(&aconnector->base,
+				     &aconnector->mst_encoder->base);
 
 	/*
 	 * TODO: understand why this one is needed


