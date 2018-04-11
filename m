Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/dxl8U/mXQzrqzpvyJLfqdwWM4Ug6bzUOvv70NIu3Ew+cTdrKgqp2vsPSm/PGUrt8ZnoPU
ARC-Seal: i=1; a=rsa-sha256; t=1523472553; cv=none;
        d=google.com; s=arc-20160816;
        b=FVYJVsw70WNqN4RtxX0Cu0XtU/w0ZQkTPaRm5rMYTYEVlQ7oLarpTZBPbihThRpwEU
         dnA5NMncCg1h7XG824GZw6WrMG04gaDvtkO22XU7joZV9fau1LaoEAkj6MQym2J5x4OE
         Xzp3rWzOp5DGptujrcNY3ObD0681ts2t5or1OtrGwWH3OtmdjZJ6P2NsnBWDhFcrJej/
         afZfGsE6JV0nTsda6O5TVGwl3zLt2eFMXUTt2obYqDCc9rOvB8FVeR5Jok5KQ731K82P
         uFApf/ziRV/Ul02E1mJXWUisBKtaxplUN8Cx4pi3yeBuCHyBL/S49yxYQxgU416emewI
         ul8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2t3TTin/aqqV4YXHmL8VCcR3bJNdKtJucPalJjGmuRI=;
        b=KqhgRVD5Q77AFSgejYCPKx2dFh9XcaeI1ETOFtg8GN7OfbUbwH6qMP47UOR9o0zGUa
         aio36AV9c1MZcZJmerd8Zm46XWzFZSqckB+lhxekE29ny3hC+QEmLB9+mTyb0qv6aJaE
         /BFGCf1kMhUWrZjSA8+mKR575EKC9+E1glhpwkVAGckeoX/WOxBjz1J8mJQuihWiFpH8
         QE2a4bikNTpZuZIKKr6bmON1Ckh7XZp3Dn6UPxvUtd1rI/CKs5m+X9Ij+3kUtXkmpGSe
         44UztzF9ugih9gFDQTZOy9Nzrbtd8L2n8iwox17hdEtP1NJGPfVp1Uq9YwwAU5OeTTS4
         TGgA==
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
Subject: [PATCH 4.4 100/190] net/mlx5: avoid build warning for uniprocessor
Date: Wed, 11 Apr 2018 20:35:46 +0200
Message-Id: <20180411183556.403300922@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476755785697819?=
X-GMAIL-MSGID: =?utf-8?q?1597476755785697819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -522,10 +522,9 @@ static int mlx5_irq_set_affinity_hint(st
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
