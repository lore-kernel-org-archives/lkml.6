Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B304DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCAA20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217813;
	bh=R/lRsQL0JvBa4VCX+CAfFFwAtlp3ux5rbadx48Pzi+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HNPqsswVDxG2s3rEzFyEoc9KuT7seHir9yIUsUp1D7tR+iCW029YdPZ7oajmPIck3
	 qIYwWpn/U9f0zfab5uE/2ixqS3dlTuK0q62naKN0BovZldh2udMEvqQMuMrLp2qNOi
	 qh55w9kRsYqMT5TXjkcJR5euHdCmSRnnOcjACfe8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404396AbfAKOnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:43:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404367AbfAKOn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:43:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 724B420872;
        Fri, 11 Jan 2019 14:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217807;
        bh=R/lRsQL0JvBa4VCX+CAfFFwAtlp3ux5rbadx48Pzi+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRoqUGefLRWXoidZNGJSN0kMTNXmsGq0WxbokhPrF85gbTnbxDspXraTXIl6dXQPF
         h3q3wOu/9Jq60yk8blS29iEywniVBAZYC1XWoWMPEQ/n2LfeorQucxOfiMoxcJa9JC
         78zXn/VbEzou/tmbSfNNNT9nXG1SD6ziXkPSh+0Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Wise <swise@opengridcomputing.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.20 49/65] RDMA/iwcm: Dont copy past the end of dev_name() string
Date:   Fri, 11 Jan 2019 15:15:35 +0100
Message-Id: <20190111131102.958577073@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
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

From: Steve Wise <swise@opengridcomputing.com>

commit d53ec8af56d5163f8a42e961ece3aeb5c560e79d upstream.

We now use dev_name(&ib_device->dev) instead of ib_device->name in iwpm
messages.  The name field in struct device is a const char *, where as
ib_device->name is a char array of size IB_DEVICE_NAME_MAX, and it is
pre-initialized to zeros.

Since iw_cm_map() was using memcpy() to copy in the device name, and
copying IWPM_DEVNAME_SIZE bytes, it ends up copying past the end of the
source device name string and copying random bytes.  This results in iwpmd
failing the REGISTER_PID request from iwcm.  Thus port mapping is broken.

Validate the device and if names, and use strncpy() to inialize the entire
message field.

Fixes: 896de0090a85 ("RDMA/core: Use dev_name instead of ibdev->name")
Cc: stable@vger.kernel.org
Signed-off-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/iwcm.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -502,17 +502,21 @@ static void iw_cm_check_wildcard(struct
  */
 static int iw_cm_map(struct iw_cm_id *cm_id, bool active)
 {
+	const char *devname = dev_name(&cm_id->device->dev);
+	const char *ifname = cm_id->device->iwcm->ifname;
 	struct iwpm_dev_data pm_reg_msg;
 	struct iwpm_sa_data pm_msg;
 	int status;
 
+	if (strlen(devname) >= sizeof(pm_reg_msg.dev_name) ||
+	    strlen(ifname) >= sizeof(pm_reg_msg.if_name))
+		return -EINVAL;
+
 	cm_id->m_local_addr = cm_id->local_addr;
 	cm_id->m_remote_addr = cm_id->remote_addr;
 
-	memcpy(pm_reg_msg.dev_name, dev_name(&cm_id->device->dev),
-	       sizeof(pm_reg_msg.dev_name));
-	memcpy(pm_reg_msg.if_name, cm_id->device->iwcm->ifname,
-	       sizeof(pm_reg_msg.if_name));
+	strncpy(pm_reg_msg.dev_name, devname, sizeof(pm_reg_msg.dev_name));
+	strncpy(pm_reg_msg.if_name, ifname, sizeof(pm_reg_msg.if_name));
 
 	if (iwpm_register_pid(&pm_reg_msg, RDMA_NL_IWCM) ||
 	    !iwpm_valid_pid())


