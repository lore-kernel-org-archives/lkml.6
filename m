Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtzO+Zwk543PloEolXAYD/XxHmJ+P1deHvIq1pKPLv4wGW6vCw+Jo4DBc6QXo7QyjRfcNKF
ARC-Seal: i=1; a=rsa-sha256; t=1520955573; cv=none;
        d=google.com; s=arc-20160816;
        b=ffExZxRM7w8RYIoRDD7PcaWE5qLlY9bBZENmSDunG5Fi/RwQxHc/3CM0BGzoeJHzB0
         IWVSFoj5C7NnySCBKYcU1ojJ2TZThxDH15G+wam+GxMHDBNivetDhC9ZqntylF8UvS6T
         Cen4/2MsFxV3LXePWOHcLInK7U91hNyfibyc71cUS9EvPnIHLoO1d2Unr5zMyi3mgC43
         XyNomiFK2Bck/S+M1UmnmVLTsLngCJmQaDN5n43qqM8cIypV4ZtPZqGwMuDS+xPRg1wd
         fCYphspXuwH7Uolq8ea52U0ecAoKzyvL4aieRmywBQJOaafgUyzz3Ik4sHmIMNCNha7i
         sTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/Q74BKxKpEMCw6sciqwseBX0VmuKGEG1JsAJx1fZjus=;
        b=tSXhcPcY/xBcSnm2a19aTfC7fTBxk18+UPf/riFekLOaHzoQCotxfm/ub5hb0OCfmY
         LgLtRDvl55bZQEHbtDCXAhAZFqtgjickZ146925MJDaL8+Mw1/isSNtSkVAxu0rBqPaF
         QPxriTUNT+hyIQpcRt8lAgtB9BtkQNqc/TMeM3rEpfimysiqhSaRocyzt2lvtS7xdsgS
         SLEf5bP3Rii3XwtT2frjscivMytQuMdA/YZRy8cCtAs76wWvu4OxlQc0QXIy/pBNdp6j
         Wa1w9510vMXYgiLYAdEgleNc4PivZ2MVHaKKZgeh/3nJ/qRETOz9DW/FtvP4eQd4c8LW
         FQ2Q==
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
Subject: [PATCH 4.14 091/140] IB/core: Fix missing RDMA cgroups release in case of failure to register device
Date: Tue, 13 Mar 2018 16:24:54 +0100
Message-Id: <20180313152504.242468275@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836909323251121?=
X-GMAIL-MSGID: =?utf-8?q?1594837510739026332?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
