Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZor245elgKM2Mmp1M1X29bsasHwJABPXV26K13NCC9njFmN5LoqIgLLuoHXZ1Oj2Ut60DMQ
ARC-Seal: i=1; a=rsa-sha256; t=1527155986; cv=none;
        d=google.com; s=arc-20160816;
        b=mreYbNULQUHDSeUGCsu9PUrop4fkdAAy9gqoQXxrXYuFb/zAhyUk1nV8fThadLisq1
         Ez9oSnTOrU2EzFGlO41jdy7oLKq9mJQ0Idf18mjjbLSmUsuDz1EtWdSnoIeFU/rm2l/p
         wuw4gJaSb/LTmYLNvZPj9+4BLGK2yC3Id7n2q5GwQapNlC3aIAlrscuXU32KTxYShk4x
         huH13h/REPNkFwl/KxTQHyaUBtmllCl1ncA48xAQNodOjDzOmUdWZoD/Kp1OzGT8bzdD
         4JwRtMElBMXLHZWPhXyXUvA94f086EXM0NdI11Nu0rnGH3mGk3y1TWQ/m2anafpemkUg
         83vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=GwXCXX+98CUs0S5cpSIHI4dcEzSElbjIJf1+kcFIGWc=;
        b=NxJtzJuEvfo91l0f6xlAzhtG3sZCGrAE+TLXEWbZXCzEAubzddh9jKbXxZdzhuPo6I
         +VqRx0F1t2JlvTyGWCNvxwymunHKkEeB03fi2pGTeCdExSzCJn/neK8BtQitcHPIlvaS
         r/2tqGz+ngUNTUDRUsNKmSNWW+V4hHT4CcKqFwiQV9wJrPtWDnPHrpoxD7fvf9ZS4Ujr
         khR2hm/NISe7MzsVBiyPtHbe2v06Pc1+5XKS+v7yNVcD3FW8kGNIyAJXpsFepuzO3IxM
         ZLsJN+WRE95Z3SS6l7ai6D05Iy4yIqDpbJxYmDscyIRhrLhqde1NHCCxz9q546jcd8QQ
         eHwA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EZupQmOr;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EZupQmOr;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tarick Bedeir <tarick@google.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 003/161] net/mlx4_core: Fix error handling in mlx4_init_port_info.
Date: Thu, 24 May 2018 11:37:08 +0200
Message-Id: <20180524093018.765532985@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338319391384707?=
X-GMAIL-MSGID: =?utf-8?q?1601339115482914388?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tarick Bedeir <tarick@google.com>

[ Upstream commit 57f6f99fdad9984801cde05c1db68fe39b474a10 ]

Avoid exiting the function with a lingering sysfs file (if the first
call to device_create_file() fails while the second succeeds), and avoid
calling devlink_port_unregister() twice.

In other words, either mlx4_init_port_info() succeeds and returns zero, or
it fails, returns non-zero, and requires no cleanup.

Fixes: 096335b3f983 ("mlx4_core: Allow dynamic MTU configuration for IB ports")
Signed-off-by: Tarick Bedeir <tarick@google.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -3007,6 +3007,7 @@ static int mlx4_init_port_info(struct ml
 		mlx4_err(dev, "Failed to create file for port %d\n", port);
 		devlink_port_unregister(&info->devlink_port);
 		info->port = -1;
+		return err;
 	}
 
 	sprintf(info->dev_mtu_name, "mlx4_port%d_mtu", port);
@@ -3028,9 +3029,10 @@ static int mlx4_init_port_info(struct ml
 				   &info->port_attr);
 		devlink_port_unregister(&info->devlink_port);
 		info->port = -1;
+		return err;
 	}
 
-	return err;
+	return 0;
 }
 
 static void mlx4_cleanup_port_info(struct mlx4_port_info *info)
