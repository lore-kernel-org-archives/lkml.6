Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsyd7IevnZlqhctJlM6Kb/ZGuB+P12N3OBArhMziTscUTIwfUHKN6tHR/CO4ruI5s4nNs0A
ARC-Seal: i=1; a=rsa-sha256; t=1520954999; cv=none;
        d=google.com; s=arc-20160816;
        b=k6ejjDEACKSP8X7HTElTi5tyyqocOVJ/2n/gvrOgsNoqlO8XTXGgtKwp76XcT+COd4
         b8bJv7ZM5Dx5bgGGTT31iBwY3iGK5aM9e7lHSr6Q6adwPgfj3wtGsZfoPnYaC8BhE7Pn
         X000G1zTfNPpTsK4YEAIJD2cnbhqGI+ffc/CczTKsRX8qAcJO+Ml20EI4kCxbtz3dC6U
         Hcia1b2dOq+BmJA73FvaA9tXnKROkeRMNsIEat07J9QUPwbW/NaqXcrSEGO/OqRjqEXJ
         3aU+A2nqEMamZyOnF4wxIJGFzpiKEjuoCJ+1IGKVbcku60x8SNE9psZlhVGQQIJb/TC4
         ak3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mBDAp4u4oSE4um1fTMC4+dfNLYeLKMMIZRuI7IoFOFg=;
        b=ET+mw84NdB/UGvxoajNQmnTdc9g8hm06hFfqWx62upx1l2XrZaEYLbwwURo5BJMU0X
         QykduhyONSbHuGEw9IzXXk50qyEu2Yg+Fs5hrxr1PlX3PUIwpjrmZPCmFeFLyU+dgLPn
         jHwQwJm/IMfhXoAjnGz5K5huiYvHEq9s3bLYiePZArBeMKXq8KdtuntZGxpb3Y+vPBLM
         eruU/4V1FTZHUPovTAgf/8xi3oYzTcgVdnpIwgOPINM19xmOSCx358fMI5KwomxNDHfO
         AqfrOchLVtshJ+xPO8ymJ7d7HVpaCuPRs2sTEcLjsnJ4yDjZq8Plkr74Q8aUNNIjYVg7
         mbYw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel Jurgens <danielj@mellanox.com>,
	Parav Pandit <parav@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.15 055/146] IB/core: Fix missing RDMA cgroups release in case of failure to register device
Date: Tue, 13 Mar 2018 16:23:42 +0100
Message-Id: <20180313152324.885207547@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836909323251121?=
X-GMAIL-MSGID: =?utf-8?q?1594836909323251121?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Parav Pandit <parav@mellanox.com>

commit 2fb4f4eadd180a50112618dd9c5fef7fc50d4f08 upstream.

During IB device registration process, if query_device() fails or if
ib_core fails to registers sysfs entries, rdma cgroup cleanup is
skipped.

Cc: <stable@vger.kernel.org> # v4.2+
Fixes: 4be3a4fa51f4 ("IB/core: Fix kernel crash during fail to initialize device")
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/device.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -534,14 +534,14 @@ int ib_register_device(struct ib_device
 	ret = device->query_device(device, &device->attrs, &uhw);
 	if (ret) {
 		pr_warn("Couldn't query the device attributes\n");
-		goto cache_cleanup;
+		goto cg_cleanup;
 	}
 
 	ret = ib_device_register_sysfs(device, port_callback);
 	if (ret) {
 		pr_warn("Couldn't register device %s with driver model\n",
 			device->name);
-		goto cache_cleanup;
+		goto cg_cleanup;
 	}
 
 	device->reg_state = IB_DEV_REGISTERED;
@@ -557,6 +557,8 @@ int ib_register_device(struct ib_device
 	mutex_unlock(&device_mutex);
 	return 0;
 
+cg_cleanup:
+	ib_device_unregister_rdmacg(device);
 cache_cleanup:
 	ib_cache_cleanup_one(device);
 	ib_cache_release_one(device);
