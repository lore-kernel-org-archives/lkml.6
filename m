Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25323C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E143F20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107250;
	bh=Q7mOY2zSevvx5eM+w5YjhNR7hFNgDLzNUG276gb+boA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uAed05TsVY+fs2fHYF8mwsGHR5ZmM02WzZNw4WflIybUrhNVVor+YHDuQUbclVRdb
	 A0ZHxddCfWrgeNHG3Dfg7d1HuGkCO+Dezj6p/AwdC4ltqWQ9u6SfjbWJUwCJFnpJTB
	 wl1wqfgzW/LKFA2iXxcFa7JJ9Kbkkm3IS2kNMvcE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E143F20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbeLFOks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:40:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730027AbeLFOko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:40:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB76020672;
        Thu,  6 Dec 2018 14:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107244;
        bh=Q7mOY2zSevvx5eM+w5YjhNR7hFNgDLzNUG276gb+boA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I939dJiASDTbF0F0+CrBBqeWYFP0d18bceQzWMF3Vp2AKrqm3+zpLzLh7doa6Ovn2
         94r7ISUs12YmVJm5ECGOeRxGFEDv7D+g0wCaNQo9k8/e41xsWTJql+CUcZ34+RDeq0
         6Fy2RUfXBrdRBt2U2tAxmksd/VXNEVCh3Uk4EkMY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lihong Yang <lihong.yang@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: [PATCH 4.19 29/41] i40e: Fix deletion of MAC filters
Date:   Thu,  6 Dec 2018 15:39:09 +0100
Message-Id: <20181206142952.236156978@linuxfoundation.org>
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

From: Lihong Yang <lihong.yang@intel.com>

commit eab077aa84331afbda071a213925d4cdbca58941 upstream.

In __i40e_del_filter function, the flag __I40E_MACVLAN_SYNC_PENDING for
the PF state is wrongly set for the VSI. Deleting any of the MAC filters
has caused the incorrect syncing for the PF. Fix it by setting this state
flag to the intended PF.

CC: stable <stable@vger.kernel.org>
Signed-off-by: Lihong Yang <lihong.yang@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/intel/i40e/i40e_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1409,7 +1409,7 @@ void __i40e_del_filter(struct i40e_vsi *
 	}
 
 	vsi->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
-	set_bit(__I40E_MACVLAN_SYNC_PENDING, vsi->state);
+	set_bit(__I40E_MACVLAN_SYNC_PENDING, vsi->back->state);
 }
 
 /**


