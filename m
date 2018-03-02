Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtmE3KsKYQOhMiQkJmAYkRDVK4sV7KMjEvGfxLgPrcJVdg/oExo2vL1cuBSv9372eYdz/kE
ARC-Seal: i=1; a=rsa-sha256; t=1519981264; cv=none;
        d=google.com; s=arc-20160816;
        b=r+P22EHWH80gULYIBvn2mhoOHrLTolQ5xLIuD+GChYHxf2wJoXheiB3giPjBjAebyQ
         lMkj5m2Jmf+wxCcZv/34pRq6RoGQBlargdtccR5LCHrfIGU5IKwDPgXL1pDXmASXslD+
         2k9kToADhJEfvSV6EzGAFnLt4O5nrmaGRmDxyo/89Fl3g35GlZOL+WVWyAREPNkK6mLq
         OmMWPLep8n6/ihAzmx+1WoNNJ6H6jP99xrCgwg+NuZZatlII4QZlWroxB7FikEBisD+B
         cNXuTWf16RsTTna6gu9mm+tv3DKudu0Yoob5s/C1J2BsZJb60KOPwvBZFsHpvPIu+1fp
         04jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=s8r+XWvPorh/ZJCbLHgotPayw85j6sYucS6Zlv2LTVU=;
        b=xjR5Ik4N4t/1c/9zqfPJbEKlm99OSkOU1MBz4tQq51YZhSX0xQuy80RH+n+8KVqsaf
         f/rnH23pulACPr+O+CHt+MQNPBNR3y92zGvnUNn//lghn71h5bdnwWr+1wi6pRijXdN/
         yLqn5nlMV8PULYicJAQ/wuugEzyzICBCXIgIzEX233OEF6Wh/32ce45vhWrGQuEvWeDw
         PhPU+8YF8NZsk5cmz4BzvV2SoR5bGWc01UcKx4shhbRM0fqi1PibeG0n3THJaZnTXPRh
         X3lCEtAoiUsCAENzQGC3BuibeZ+gzg77gQupFZnSy7VPuuMdzp2cGhkjG55vIP1fcEDm
         E25w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Moshe Shemesh <moshe@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 040/115] net/mlx5: Stay in polling mode when command EQ destroy fails
Date: Fri,  2 Mar 2018 09:50:43 +0100
Message-Id: <20180302084505.511127237@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815874527686302?=
X-GMAIL-MSGID: =?utf-8?q?1593815874527686302?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Moshe Shemesh <moshe@mellanox.com>


[ Upstream commit a2fba188fd5eadd6061bef4f2f2577a43231ebf3 ]

During unload, on mlx5_stop_eqs we move command interface from events
mode to polling mode, but if command interface EQ destroy fail we move
back to events mode.
That's wrong since even if we fail to destroy command interface EQ, we
do release its irq, so no interrupts will be received.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -802,11 +802,9 @@ void mlx5_stop_eqs(struct mlx5_core_dev
 	mlx5_cmd_use_polling(dev);
 
 	err = mlx5_destroy_unmap_eq(dev, &table->cmd_eq);
-	if (err) {
+	if (err)
 		mlx5_core_err(dev, "failed to destroy command eq, err(%d)\n",
 			      err);
-		mlx5_cmd_use_events(dev);
-	}
 }
 
 int mlx5_core_eq_query(struct mlx5_core_dev *dev, struct mlx5_eq *eq,
