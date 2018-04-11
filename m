Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+gZnD0An22gUYE38Xupa3TS3/9EM9yRT5j7aTHRiSQQNxRotEV+IJjwDXkuo463nTT/YFL
ARC-Seal: i=1; a=rsa-sha256; t=1523473183; cv=none;
        d=google.com; s=arc-20160816;
        b=ZESDy5SFO//lojqHFTEvZzJdBQ7JXIQ8NwH7ch8ImDSdwy6+e1AIky8htB7Vfe3MGI
         Nx1K9q1mD1WFkklZIiIPkbrz/k0aGCgeIXJY6h/8n1ciYU6s+G+YTSepp6IHZaXmhDsx
         HiXz/JBh9NPg3t8v5nBb3t10m0UmNgK1ipqRdHCCWW2VYSCIQpttdcgb4+bj9aqhNGya
         Pvb3JIUOaR11sZ4QmBZs4bdn2k1S3A1paolaAQzJ+HsAqY0bUi6M0FEyTjA7uCozsu/a
         Zvq6jPFBnaUs0cpo86MyKaZppRgcYz5uWBIsmjouxjQEtNQNF21ip2zlq7UpsJzq/18B
         CDqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2MuCuhiPKYGXxM6CUWwnwjeR7E25KWHXL/pIDBOEVYM=;
        b=axhVZNo7ZlppOBCHsurxJv/YjDHkW8QrjwcZ2jcPNb+IJ98cLT2sPXOXm5RNdIDWBG
         KVxB9xAuaIfz4bxOA20BL4br+UbOT/jobvk/N7zrQPyZYyvS8wgM7O/YzcFAKh2473Sz
         oEEiQVQFunXx80isi2/Up5Zbrq/uESS8R45HI8bCTD3iQ26pyVnyOLpLr7dzDbVc+l9u
         /DC9r8mvkoJnxHa1ntk0ytd3o9a8rWkl0zuZxOxq1W4HsxDGuAim34U1LthzvSNcU+Dd
         QgE44/xc+qaP1R5XNfExK/WVY4/GNyS2EintA6dJF2emXXfNMZsG28Ky6JIuBNSSgB/L
         5AcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Saeed Mahameed <saeedm@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 157/310] net/mlx5: avoid build warning for uniprocessor
Date: Wed, 11 Apr 2018 20:34:56 +0200
Message-Id: <20180411183629.159068749@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476755785697819?=
X-GMAIL-MSGID: =?utf-8?q?1597477416103201999?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>


[ Upstream commit f0d7ae95fff4ab444b8433f07afc4b077ef1a285 ]

Building the driver with CONFIG_SMP disabled results in a harmless
warning:

ethernet/mellanox/mlx5/core/main.c: In function 'mlx5_irq_set_affinity_hint':
ethernet/mellanox/mlx5/core/main.c:615:6: error: unused variable 'irq' [-Werror=unused-variable]

It's better to express the conditional compilation using IS_ENABLED()
here, as that lets the compiler see what the intented use for the variable
is, and that it can be silently discarded.

Fixes: b665d98edc9a ("net/mlx5: Tolerate irq_set_affinity_hint() failures")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -557,10 +557,9 @@ static int mlx5_irq_set_affinity_hint(st
 	cpumask_set_cpu(cpumask_local_spread(i, priv->numa_node),
 			priv->irq_info[i].mask);
 
-#ifdef CONFIG_SMP
-	if (irq_set_affinity_hint(irq, priv->irq_info[i].mask))
+	if (IS_ENABLED(CONFIG_SMP) &&
+	    irq_set_affinity_hint(irq, priv->irq_info[i].mask))
 		mlx5_core_warn(mdev, "irq_set_affinity_hint failed, irq 0x%.4x", irq);
-#endif
 
 	return 0;
 }
