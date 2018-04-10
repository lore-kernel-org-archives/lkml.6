Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx495kJ24/imW6yPK8HOxcOET7tI74b4s8zUhoPMz7PAGu0xEJDIz0MqB2jEZ4tU6yCXTWxYI
ARC-Seal: i=1; a=rsa-sha256; t=1523399602; cv=none;
        d=google.com; s=arc-20160816;
        b=IFhe/mxx5cRjZiICJfyorLRV9mu9WyqVQYw5XDNtvOQ6n8gUTjeLnk1ck9WVY122/i
         9Vnu9fFic4ACQy4acXfZAHsPldWhgbex01VaZPqDBb2fakcIyX+VuWRzlBjtIoqMrGpP
         CALbPUkvsZT9FOP197kk8wpBE+6AP8QXzNbb4tTA8q8mISKi5bZ2K3fKbUFgbiIIq9G0
         m3dEnwnwHHpP+8h5Rt8CZh5EhK3BbcVn7GOdzWlZu6nGSbwAhdB+9BqXnoUcruogLZX1
         92IHdNcgwZKdsia5FZpofqODgtUki1QRrXFq8KLXPOoDaI0svIp+RrQ+x1ELPN8hg48I
         Ca5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=z3Nho64pMYb38F1yax2YHuIaAH7YnobbSxcxU+nd/SM=;
        b=ye76LEzfCiKpDkO9PDP7IpfKoULZoK5WkWI+8VhQMnF+prWfZO81/Q7dARdVdxc9/V
         xJQlbXc7gVNDeVwpiJRrfVrBQ794b3P6HqtACQPx0hby1kqo3gkjWwR2Zw9HM/xp1kt+
         NwdPvuDZzX2dg8CTZTCCT80LYsfTWHuJzLxjI3PBUGN6bnySqxy6MFmV6z0UHTfHhazn
         X5rvgwa1V6K8wsKkpymOd/HdyyzthpnHl8DYILOcKO3pnznk+bqT4nygarpMfNRJZmtF
         rfhatSJ4r5kCzAJVp0bO90FkOX6CBkxgdczuzYuqtTPa5FzEEapfyPGApwdeibZRmrTW
         TDnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Moshe Shemesh <moshe@mellanox.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 168/168] net/mlx4_core: Fix memory leak while delete slaves resources
Date: Wed, 11 Apr 2018 00:25:10 +0200
Message-Id: <20180410212808.371930070@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400260993026397?=
X-GMAIL-MSGID: =?utf-8?q?1597400260993026397?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Moshe Shemesh <moshe@mellanox.com>


[ Upstream commit 461d5f1b59490ce0096dfda45e10038c122a7892 ]

mlx4_delete_all_resources_for_slave in resource tracker should free all
memory allocated for a slave.
While releasing memory of fs_rule, it misses releasing memory of
fs_rule->mirr_mbox.

Fixes: 78efed275117 ('net/mlx4_core: Support mirroring VF DMFS rules on both ports')
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
+++ b/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
@@ -5088,6 +5088,7 @@ static void rem_slave_fs_rule(struct mlx
 						 &tracker->res_tree[RES_FS_RULE]);
 					list_del(&fs_rule->com.list);
 					spin_unlock_irq(mlx4_tlock(dev));
+					kfree(fs_rule->mirr_mbox);
 					kfree(fs_rule);
 					state = 0;
 					break;
