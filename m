Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48noFK1TmJxv04EUDRC7VFoBxU76Cb7utJ+P3U1kc/sPGf4/8gj2C6f3yrXVr+WTWMWxLFy
ARC-Seal: i=1; a=rsa-sha256; t=1524652861; cv=none;
        d=google.com; s=arc-20160816;
        b=UTouf31iqSqbXWYsYBdW2Nm5LeDqSNEWzRInQo0Lq8AoLuj92K8eYuS+4p2cRXOq3l
         uTX8ZIobkughD0HadlUdT+n0n8e2yCzydJw1nLweaToiMJ+Yz9OpcKv6kGebnCsjv9ez
         dPYDT0Oo3LpU1LKDuciUuI99QI8SeQCL+omu5FGdLJfpPLROV4vYhgFBuB1gp0oSZmKH
         cETinDE0hEU3rBSUJtmZJkCepOtYphXU5o3edj8Tp2SwgFSrbnSGoJZJNTARPML/QDO0
         OVmqnDz30h/1nuOMTFZj+ySBcAHRaFjp8REzhe1UeOcqViNKq5gpvG0n6u790HPKRhQp
         KvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DTSj1fZoAbGZu/zoqYGSmW5f6u0fJLt8WvclgQHkd7E=;
        b=0zcxq8vSh+jfQ4h4/p7+gVTsmNQjgaKv77UYmDOf15tZ7GumEPxFNwdFV4isLUzbmx
         Xfdy1kftzdu8XldEY7Mri7Ew0JeLfarpiWiyVfkyFzzaS1ZlRc+vzv8dnHK3msh+8ZyI
         zx88fNBTGS6yiQ14u+GPRwDQw5gEGhZpOUK4/bLRUxB6ICr2P8o9C42WDAPmWtJ0KQ/7
         Q93s2Wlsrh0eW6VMJWDeHiB1SgJKwyPzPIVwln2nWMw+AeN8+CgEcv/dijCvHZAA1t5U
         5BAYPE484Gyrl4+2sWIe9UrL/kr02CFgzVF42+hSu0XFYoGukgZ12a1EF8cXXRrJiU6Z
         15+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Parav Pandit <parav@mellanox.com>,
	Mark Bloch <markb@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 069/183] RDMA/cma: Check existence of netdevice during port validation
Date: Wed, 25 Apr 2018 12:34:49 +0200
Message-Id: <20180425103245.294226572@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714399029598605?=
X-GMAIL-MSGID: =?utf-8?q?1598714399029598605?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Parav Pandit <parav@mellanox.com>


[ Upstream commit 00db63c128dd3daf38f481371976c24d32678142 ]

If valid netdevice is not found for RoCE, GID table should not be
searched with NULL netdevice.

Doing so causes the search routines to ignore the netdev argument and may
match the wrong GID table entry if the netdev is deleted.

Fixes: abae1b71dd37 ("IB/cma: cma_validate_port should verify the port and netdevice")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/cma.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -624,11 +624,13 @@ static inline int cma_validate_port(stru
 	if ((dev_type != ARPHRD_INFINIBAND) && rdma_protocol_ib(device, port))
 		return ret;
 
-	if (dev_type == ARPHRD_ETHER && rdma_protocol_roce(device, port))
+	if (dev_type == ARPHRD_ETHER && rdma_protocol_roce(device, port)) {
 		ndev = dev_get_by_index(&init_net, bound_if_index);
-	else
+		if (!ndev)
+			return ret;
+	} else {
 		gid_type = IB_GID_TYPE_IB;
-
+	}
 
 	ret = ib_find_cached_gid_by_port(device, gid, gid_type, port,
 					 ndev, NULL);
