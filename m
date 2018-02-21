Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1429242-1519217118-2-10100359046729931671
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519217117; b=EQjDqAZOoKxW1e/LS6lD00UlEGflTwUDmfeYz2S7wMznXLp
    6Dc9aR6q/gyb2X9FCfBOgxfBGm8BSbnKHKf0x/Cp+zrGUjEbewgy2LHJQpx97Z8f
    ydXs+Ibv8xyhhvx4N+ML+D4a6jCleqzUopeAn2PJ47cVDx1Oy8qf/AMJZhQAvMRF
    0tMOhFTlG4bUgUo+a7jfxxt6VmdO861c5zPP8FsLzzkM0hW1+cx7aEsoboe1YeYj
    Et3GDxKwEyVYZ0jv/Ap0gJARnofp5Hnt4jr9fdwlEwVrjDFcWwKSJXfTW8UjByW7
    AjAlQ2VKiyQfneo60yZnaSbKY/DdyVYz0w16+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519217117; bh=QcVmQl8tAs8+wKu4ZpQTuJ0YeY
    ZgmXOsxZCc8E7QOpk=; b=rgD/3Y2GEwowWnG5kx4v5eCZtvDhgwoWFeLLyyDuML
    XZmNZg0B3IKsK04+db2J9leRVQ5HKdu0lb2SEo7zFRyWXzBK+dgyiFYgtTfbnuky
    JK+DVlBHoYiWiH0FY2qjiVWUGSal/5iwmMRIHXALQN1aWffA27Jn3yJxicFkTfKF
    0OfhTXYhle6SqebaQvlZGh52bdLTP0WdqOahk9swZL3F+y9l/DAtXBpRJGs1VRiU
    aTUJIZUo3w+l+iTFMEbBU3vYWfj0va5Jr37NDmzvkBDxAjGtL7Qv02IcWDN1zp4F
    zBtg7GvZImzRSsZncOOfd3tJG/2HpOo2e8n3joggp6gQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeBUMpQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 07:45:16 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:58976 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeBUMpP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 07:45:15 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.4 01/33] IB/mlx4: Fix incorrectly releasing steerable UD QPs when have only ETH ports
Date: Wed, 21 Feb 2018 13:44:44 +0100
Message-Id: <20180221124409.651818242@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

commit 852f6927594d0d3e8632c889b2ab38cbc46476ad upstream.

Allocating steerable UD QPs depends on having at least one IB port,
while releasing those QPs does not.

As a result, when there are only ETH ports, the IB (RoCE) driver
requests releasing a qp range whose base qp is zero, with
qp count zero.

When SR-IOV is enabled, and the VF driver is running on a VM over
a hypervisor which treats such qp release calls as errors
(rather than NOPs), we see lines in the VM message log like:

 mlx4_core 0002:00:02.0: Failed to release qp range base:0 cnt:0

Fix this by adding a check for a zero count in mlx4_release_qp_range()
(which thus treats releasing 0 qps as a nop), and eliminating the
check for device managed flow steering when releasing steerable UD QPs.
(Freeing ib_uc_qpns_bitmap unconditionally is also OK, since it
remains NULL when steerable UD QPs are not allocated).

Fixes: 4196670be786 ("IB/mlx4: Don't allocate range of steerable UD QPs for Ethernet-only device")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx4/main.c       |   13 +++++--------
 drivers/net/ethernet/mellanox/mlx4/qp.c |    3 +++
 2 files changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -2483,9 +2483,8 @@ err_steer_free_bitmap:
 	kfree(ibdev->ib_uc_qpns_bitmap);
 
 err_steer_qp_release:
-	if (ibdev->steering_support == MLX4_STEERING_MODE_DEVICE_MANAGED)
-		mlx4_qp_release_range(dev, ibdev->steer_qpn_base,
-				      ibdev->steer_qpn_count);
+	mlx4_qp_release_range(dev, ibdev->steer_qpn_base,
+			      ibdev->steer_qpn_count);
 err_counter:
 	for (i = 0; i < ibdev->num_ports; ++i)
 		mlx4_ib_delete_counters_table(ibdev, &ibdev->counters_table[i]);
@@ -2586,11 +2585,9 @@ static void mlx4_ib_remove(struct mlx4_d
 		ibdev->iboe.nb.notifier_call = NULL;
 	}
 
-	if (ibdev->steering_support == MLX4_STEERING_MODE_DEVICE_MANAGED) {
-		mlx4_qp_release_range(dev, ibdev->steer_qpn_base,
-				      ibdev->steer_qpn_count);
-		kfree(ibdev->ib_uc_qpns_bitmap);
-	}
+	mlx4_qp_release_range(dev, ibdev->steer_qpn_base,
+			      ibdev->steer_qpn_count);
+	kfree(ibdev->ib_uc_qpns_bitmap);
 
 	iounmap(ibdev->uar_map);
 	for (p = 0; p < ibdev->num_ports; ++p)
--- a/drivers/net/ethernet/mellanox/mlx4/qp.c
+++ b/drivers/net/ethernet/mellanox/mlx4/qp.c
@@ -280,6 +280,9 @@ void mlx4_qp_release_range(struct mlx4_d
 	u64 in_param = 0;
 	int err;
 
+	if (!cnt)
+		return;
+
 	if (mlx4_is_mfunc(dev)) {
 		set_param_l(&in_param, base_qpn);
 		set_param_h(&in_param, cnt);
