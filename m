Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227JPJZOVniCuC+7tlPybXIlCIzSxXOOcMYFTMQSiqMJidIwtHOJqM775Jsng2wcpis9l587
ARC-Seal: i=1; a=rsa-sha256; t=1519218382; cv=none;
        d=google.com; s=arc-20160816;
        b=mSZMk9czHfGDglgAjOwyQuoQB24BxSOcAC7lKM+tW7010kACZ9+xC/AWa5Gd+CtJxG
         kB9l2sjXcEAZlmGJc3ea1NJlnWu9ozWRtcnvkDby2u9GeGKOh94mPz1qEu66vXWvZphC
         0dXsdNhwjLovX6mmuutYLRsujfMX6sHR+ye/9wXo2lscgU9NsRt7MyIk8va0aV2XnLK4
         MfAfHSeRw09UDLZni/f4VFVR2ZdiYG/hfYxtHiXVQCf4ttF/2r3g40bcRpeCW7XjiDD4
         aBKgKDBIEhKksBoA0hFKYGqPoB9dC4sC+7E8h2lNfu+LBZM6dvdVlSlRqL6UYn7Z+s11
         CZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6sqRf1xPkMcjwtTJITTkiQ3m38rDbCLHUJxD2a7cixM=;
        b=ALbiNjFqOxZiMkVetrdnKe0wCE7vUg+RLSKXRBBsJM3FPEUpJCrRJSV6PMbQ9ZU8qY
         DDApCFIcRbhiKih4DUt9f0IxkRjBRr0cwoGDD3ILYhJbnN7phxF8d6E8xpszsENU0pLY
         P+HlHYdQCVTa+tY7WALr2tua6LhruyuOyijtN4DyjL+BikJzAAzWPv2aUilqkr7Orags
         60Rx5dq6uA7reIhOS5pIcuRTscMIjU9W+cJgcI7v0bSJOjQnffTjqFEuOFm+NQe3GnKQ
         v65BDgkiDF6mv//FI7xVYMRfRA0pRE8hyZjBJcNE8kdb1+TW04/dBi+n6hARcHbGofGT
         H5VQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.15 004/163] IB/mlx4: Fix incorrectly releasing steerable UD QPs when have only ETH ports
Date: Wed, 21 Feb 2018 13:47:13 +0100
Message-Id: <20180221124530.180604006@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014606648192784?=
X-GMAIL-MSGID: =?utf-8?q?1593015934842401054?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2995,9 +2995,8 @@ err_steer_free_bitmap:
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
@@ -3102,11 +3101,9 @@ static void mlx4_ib_remove(struct mlx4_d
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
@@ -287,6 +287,9 @@ void mlx4_qp_release_range(struct mlx4_d
 	u64 in_param = 0;
 	int err;
 
+	if (!cnt)
+		return;
+
 	if (mlx4_is_mfunc(dev)) {
 		set_param_l(&in_param, base_qpn);
 		set_param_h(&in_param, cnt);
