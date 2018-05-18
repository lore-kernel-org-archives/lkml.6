Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo+o/4Hjk9XOgzKjuvcnIYLR0Cn9JSDOiAkzSmTHv07suhbRxqw2fPlX1STBpw1oY0ghK7B
ARC-Seal: i=1; a=rsa-sha256; t=1526631413; cv=none;
        d=google.com; s=arc-20160816;
        b=g2HyeQt6Uge9sxrIOJwVCzzmt1+N/GtCZ4wwit2BA5yeu76pSXv5ct8viuNHokfkeW
         /RfLNQhhjSfi4+FqbCcF4haE2HsrqCbCxWi9szGHJv6SLn1Mcum6QuOkeYmckFyUX7s4
         ukU+ceL7rNKq6BVizbNiL8eg9AS8U1HfYtfpeJurPHo07ruJ3Z+9xRVqS+YNY4S2oV5K
         VOixcii+OghizLL7+d/t/XSSkuUEWZLrRRWRKLfnokCO6cJ9718u2di1MLYtca2Bzgz9
         nWfK/eYQZsS+5GmtKjeK8qUdPKhLivvul9PbxlRbxvczMDlTKvO8sPfPrqKj9WHVKcB5
         ALSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Zw7LiGgC7foG3GpKp3fq0vMJoIaoN5FTFLq/Uw0Jjw4=;
        b=MjqMtAHHTRmuKP50RfEJJe7i5vXxqkTMZWHoWGfu4jozgWc5kE0SOFNH34RiB/V+Y5
         u0kGNfhZa0XVoFawSlOUJJ65biffInulfVvhA0qE3XFHLG9k8N8r5K39lT3nt2TJJBEp
         +W8Keclf6X2RpKjNzG5NoKgndT8D9huDNIKwhPNZgv3erXefDKvBNlwCO5dQ8goHa146
         LTy53O4f4LIsXHSJf3DwWBrhmHig0zpefJF5Saig/XSD3B3WZlVVcbRUysv7PFuNr9SV
         3QbSdD45Lp6USuCm1T9J9nt+89cV9rzW3OQTVyyjDEICjtYEAR/K7Ai4d0sTl1JFhO8i
         g7LA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=UaCDpeOs;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=UaCDpeOs;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Roi Dayan <roid@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.16 11/55] net/mlx5e: Err if asked to offload TC match on frag being first
Date: Fri, 18 May 2018 10:15:07 +0200
Message-Id: <20180518081457.943855895@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789061393322698?=
X-GMAIL-MSGID: =?utf-8?q?1600789061393322698?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roi Dayan <roid@mellanox.com>

[ Upstream commit f85900c3e13fdb61f040c9feecbcda601e0cdcfb ]

The HW doesn't support matching on frag first/later, return error if we are
asked to offload that.

Fixes: 3f7d0eb42d59 ("net/mlx5e: Offload TC matching on packets being IP fragments")
Signed-off-by: Roi Dayan <roid@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1260,6 +1260,10 @@ static int __parse_cls_flower(struct mlx
 						  f->mask);
 		addr_type = key->addr_type;
 
+		/* the HW doesn't support frag first/later */
+		if (mask->flags & FLOW_DIS_FIRST_FRAG)
+			return -EOPNOTSUPP;
+
 		if (mask->flags & FLOW_DIS_IS_FRAGMENT) {
 			MLX5_SET(fte_match_set_lyr_2_4, headers_c, frag, 1);
 			MLX5_SET(fte_match_set_lyr_2_4, headers_v, frag,
