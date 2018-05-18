Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo9C1tOXYbYlgUIZpbvuN5JKVC9MC9F+F6+Oh5Pix80vjBTHz8zc6NZ3oGK8knq2CLpenAN
ARC-Seal: i=1; a=rsa-sha256; t=1526631496; cv=none;
        d=google.com; s=arc-20160816;
        b=iVPreJ53Im9lCEVpSf0l1XlzShW7uX4af2QyeXmgYVc1EoT6fymeyp2/uaTwd5bRDG
         6FtnPCCL5eOCPv6gJ98U8iKDb8hOS5HfRrPC+8BrlxImR/P/eIBUxkebXFMk5kyaMmG6
         /VIiF+/ZMeFDqKCF4XoT6M4epiD6mLwJfwQBPg8ECrt9ne7s9hUDybMiOvE0dfUu/FDK
         a0ZCXKKvhpiD8Ibv9LTTNWJQfsr1yV8ZTBQyify30yE/Uyi4PodXwQagmD3MEMXoiQMM
         sr2U2XyMfUeANvXiDx0frB4fVjykx/PncJv9WR7mmO4LV4P30csvfYAb+2srnuM1Vlx6
         ThyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=micE5DJHAn6/oZ7wBsmbysre9UiYebKgM2CTgYF+CUI=;
        b=Tu9TQteexxrFevzV3A8b0srmTanLGXbJU19LBMUlhHXSlHBVbUtU1DSdjUL/fpr3ZT
         eqhAjsngmvqhTnLZruGybZ+f0eeT2IJ7GZAYKEaNaqNTmFTtA8Ty70X3v5Y4mHtlw3+S
         HSNCa0SDEz+45TBIxMd2YI7tVUcOYFjBNuUHCK+ZIkGuO41fuWM78+pvI1w1XSajtf0v
         l6X+FWKAGIdLbqvR5GX/vwjN5sC8p5yM8WcJr0njQSBBKHMljOL1rt5ek0ipE3OBGAK7
         GZKbBwj7vpx2lp8tU0wZVi4YNjodVLtSxMUp+XCuKPa6b/ioQM5YQcPhDFLUS9weApzm
         68MA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=q0fCEuvO;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=q0fCEuvO;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ido Schimmel <idosch@mellanox.com>,
	Colin King <colin.king@canonical.com>,
	Nogah Frankel <nogahf@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 41/55] mlxsw: spectrum_switchdev: Do not remove mrouter port from MDBs ports list
Date: Fri, 18 May 2018 10:15:37 +0200
Message-Id: <20180518081459.389605908@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789148114187942?=
X-GMAIL-MSGID: =?utf-8?q?1600789148114187942?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit c7f46cca8c73a44311e4164b9196b4d791f59ac7 ]

When IGMP snooping is enabled on a bridge, traffic forwarded by an MDB
entry should be sent to both ports member in the MDB's ports list and
mrouter ports.

In case a port needs to be removed from an MDB's ports list, but this
port is also configured as an mrouter port, then do not update the
device so that it will continue to forward traffic through that port.

Fix a copy-paste error that checked that IGMP snooping is enabled twice
instead of checking the port's mrouter state.

Fixes: ded711c87a04 ("mlxsw: spectrum_switchdev: Consider mrouter status for mdb changes")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Colin King <colin.king@canonical.com>
Reviewed-by: Nogah Frankel <nogahf@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1718,13 +1718,11 @@ __mlxsw_sp_port_mdb_del(struct mlxsw_sp_
 	struct net_device *dev = mlxsw_sp_port->dev;
 	int err;
 
-	if (bridge_port->bridge_device->multicast_enabled) {
-		if (bridge_port->bridge_device->multicast_enabled) {
-			err = mlxsw_sp_port_smid_set(mlxsw_sp_port, mid->mid,
-						     false);
-			if (err)
-				netdev_err(dev, "Unable to remove port from SMID\n");
-		}
+	if (bridge_port->bridge_device->multicast_enabled &&
+	    !bridge_port->mrouter) {
+		err = mlxsw_sp_port_smid_set(mlxsw_sp_port, mid->mid, false);
+		if (err)
+			netdev_err(dev, "Unable to remove port from SMID\n");
 	}
 
 	err = mlxsw_sp_port_remove_from_mid(mlxsw_sp_port, mid);
