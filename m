Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZokOKLnibaRg8DRXhv46bRSodThp5zAUY+IGdao1LU73bFNs6xVKIUUvaQWO9/Paay1SHFO
ARC-Seal: i=1; a=rsa-sha256; t=1525767145; cv=none;
        d=google.com; s=arc-20160816;
        b=bB94rBytlgNFGNR+My3IoAisukWpHISwcG+r+KBb0IGGiAkqsFLp1s+/q3IdKVIZrf
         ZrGeVume9UASFC0mVYLwyFsJfV/JWZLzS80Ih3h+ZpnTI/5beUcQmNIyknFo2bddJZJo
         VIYFXY7eza43hWMOI1y8QbUT57Xxw8yFA/Rai1cic6khbPFzglZudPwJvio0GeKrrCWC
         PxV6h/TBOVG9VqrARIbskNVV1ajWKuNjWTX52Hq3ZpUcNT4SeXRzpztEgOh7KWzWbdPA
         qlXV8WgziBrKnZ0sUcSr9/jMvSWeFDhWwUMegkdvxUbiLXH8kscxLDbFby+8q9Y4XmLq
         y4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=0enMn5opaXZelGLjl+Ziw0t228Gh9wBYFn5348zzKdw=;
        b=FDPZoHJktUUfEp/sNsU1Run/1/uxIqFpXY/sjgDsv3tf7D25RBAM6Ez0xwwIDrIksJ
         zrvmTNn3EvFBY0kVUXb8aMYZdxaGuqLSuV6OnYEbOba4l0S9hIxy5EdbmVf7x+hz7lpZ
         sN7NYL1mC060xqEKiicJy9PoIc/ZHvr+poV2wI/QSJhHYQ0p486NA874Q7iMvUhexFm1
         /xvvrQG/jSqjdsvCX6zt7FjtdeY4IwzvQDWsKTX0OcvaEz+uALwxkKjh9p2hRW3KFXUi
         UctsNC53xgqHT6/avxkx+/b2T0IFTtoWD3v3ROB6cuKe4ma07r9Zu+FeYIzFd4P898Dz
         aK4w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=hvbnenR+;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=hvbnenR+;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	kbuild test robot <lkp@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.16 25/52] infiniband: mlx5: fix build errors when INFINIBAND_USER_ACCESS=m
Date: Tue,  8 May 2018 10:10:23 +0200
Message-Id: <20180508073931.430850032@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882810434316875?=
X-GMAIL-MSGID: =?utf-8?q?1599882810434316875?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

commit b3fe6c62bc66868c45b5bb16050e6bcb333af337 upstream.

Fix build errors when INFINIBAND_USER_ACCESS=m and MLX5_INFINIBAND=y.
The build error occurs when the mlx5 driver code attempts to use
USER_ACCESS interfaces, which are built as a loadable module.

Fixes these build errors:

drivers/infiniband/hw/mlx5/main.o: In function `populate_specs_root':
../drivers/infiniband/hw/mlx5/main.c:4982: undefined reference to `uverbs_default_get_objects'
../drivers/infiniband/hw/mlx5/main.c:4994: undefined reference to `uverbs_alloc_spec_tree'
drivers/infiniband/hw/mlx5/main.o: In function `depopulate_specs_root':
../drivers/infiniband/hw/mlx5/main.c:5001: undefined reference to `uverbs_free_spec_tree'

Build-tested with multiple config combinations.

Fixes: 8c84660bb437 ("IB/mlx5: Initialize the parsing tree root without the help of uverbs")
Cc: stable@vger.kernel.org # reported against 4.16
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/infiniband/hw/mlx5/Kconfig
+++ b/drivers/infiniband/hw/mlx5/Kconfig
@@ -1,6 +1,7 @@
 config MLX5_INFINIBAND
 	tristate "Mellanox Connect-IB HCA support"
 	depends on NETDEVICES && ETHERNET && PCI && MLX5_CORE
+	depends on INFINIBAND_USER_ACCESS || INFINIBAND_USER_ACCESS=n
 	---help---
 	  This driver provides low-level InfiniBand support for
 	  Mellanox Connect-IB PCI Express host channel adapters (HCAs).
