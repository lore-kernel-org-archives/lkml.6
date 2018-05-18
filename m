Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqckQ5KtRHrPe0NDNzlvYR8C+dnWE1gMZpnDvGVbwk/hw7PCJlamZu/pi6BosAUrK/91iOp
ARC-Seal: i=1; a=rsa-sha256; t=1526631555; cv=none;
        d=google.com; s=arc-20160816;
        b=Cr+79p7sd3L+2E+wreb1FsP4HfuDay+iVOsbHbjWFjHfUX5xq59hfd8KGzIhgyxzbh
         S7O+DZYapVfDe8108FdLf83YWs9AQozSx6M3tIDZtJClEa38jV10m//kQsWEAQ4Av+21
         uAGBz3cnP0u7wtSufHOgyi5F3/kjumGoW4R3YzRK94ie6HtlSuIqdZeGb3PhHxKVAAkM
         Xny8d/PUg0ISdc2iuoVwBq5ID+PYuFA2g+KA2JO6i64qL2lScHWbX9GWWvDdqGjvKCe+
         XyGPO4LQCIjWCs9On3/9z3tojbZtnArC4Ckx4dXLqRyPaBZME01WtgSNM1x+PLSZrEuH
         tLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=nDl6Cw0bDQRqgzon7P6FDy7d3fKdukEQFR5CrAprKg4=;
        b=nJnHeY3ienHRtvBAnjCl+jFD3aUDVtbjQ4QK/tTVgl7yAsyWjW7FjAxpz+cVR8JMcJ
         OMxv4pw+4krdogq220V1kBiL1KHM8+scMT4MPQSKSrf63El2XSaHel3q4tujb7X90Sor
         7VhRAFMIvyVbnVofeSP4veluE2tMNAm5vtKSpFnas6tTCU0MISNaRSymUoBwBfNCIscZ
         oq12LIpk2gdx8H1Tf5O8EjDkl9yKp2IIthRi+Am44T6NIJfYSBmkoPSybD3bUm+WU6JC
         f3qXkFmKonYQ3Tafb2rAG4i0WKCIJgRW8mOowmXhzDgPB9EdZWqBmeKHOS5LffLHjo90
         +gZw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=CP11o9g0;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=CP11o9g0;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Ido Schimmel <idosch@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 50/55] mlxsw: core: Fix an error handling path in mlxsw_core_bus_device_register()
Date: Fri, 18 May 2018 10:15:46 +0200
Message-Id: <20180518081459.744546488@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789209637025063?=
X-GMAIL-MSGID: =?utf-8?q?1600789209637025063?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 8ccc113172e4c1ebef45c2433f3c32ed6ae1b9c9 ]

Resources are not freed in the reverse order of the allocation.
Labels are also mixed-up.

Fix it and reorder code and labels in the error handling path of
'mlxsw_core_bus_device_register()'

Fixes: ef3116e5403e ("mlxsw: spectrum: Register KVD resources with devlink")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -1099,11 +1099,11 @@ err_emad_init:
 err_alloc_lag_mapping:
 	mlxsw_ports_fini(mlxsw_core);
 err_ports_init:
-	mlxsw_bus->fini(bus_priv);
-err_bus_init:
 	if (!reload)
 		devlink_resources_unregister(devlink, NULL);
 err_register_resources:
+	mlxsw_bus->fini(bus_priv);
+err_bus_init:
 	if (!reload)
 		devlink_free(devlink);
 err_devlink_alloc:
