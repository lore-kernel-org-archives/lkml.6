Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161144AbeBOTu6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 14:50:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39392 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033454AbeBOTu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 14:50:56 -0500
From: Colin King <colin.king@canonical.com>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i40e: check that pointer vsi is not null before dereferencing it
Date: Thu, 15 Feb 2018 19:50:52 +0000
Message-Id: <20180215195052.29037-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Function i40e_find_vsi_from_id can potentially return null, hence
vsi may be null, so defensively check it is non-null before
dereferencing it to check the seid.

Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 5cca083da93c..14bbd5c1db78 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3062,7 +3062,7 @@ static struct i40e_vsi *i40e_find_vsi_from_seid(struct i40e_vf *vf, u16 seid)
 
 	for (i = 0; i < vf->num_tc ; i++) {
 		vsi = i40e_find_vsi_from_id(pf, vf->ch[i].vsi_id);
-		if (vsi->seid == seid)
+		if (vsi && vsi->seid == seid)
 			return vsi;
 	}
 	return NULL;
-- 
2.15.1
