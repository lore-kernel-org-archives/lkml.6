Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqVPHD1upsH1nTDLqsj0A/8ClFyfXpF2sU/Jkil2xV8/n/kiOfkb+RG+EsmHeJmKXr/RG8F
ARC-Seal: i=1; a=rsa-sha256; t=1526631563; cv=none;
        d=google.com; s=arc-20160816;
        b=eBZfD0220+9fYRKz5XYCaIUcQbB8QmDyG4dzbZlbRY2T1I1pEd5OIixq3CiQcg0oUr
         mifyVDx4WmZv61Tvd6L7iWMkytx5XqqOih1TOnRdSAsaADkcpQYGULhtzl6AYAeFmnG+
         uI5ttahlxdQdms4JgvzY2xw26X3I6LZ6bP9yz8uEmV6HQlrs0VPRu14SLV499cmRfC8L
         MMgprWI6Jh2nAu1eJHixAaZ4HdFz/eEqXrj3ACZ9yMwBZwsnu4xSUaGqYtECQpX+4bHv
         3ViMHLCHch1PuzlNI7X77+2tYzZx5hFxEjOxsxAvFf8A64EO/KYxUF6zmnTBw+YYZAJR
         85Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=6NUkCPV6GI7RI6MefDwfLmGMfQvT4dBizcL0hE5rDIA=;
        b=mQNa9DdkmXYTvt1YfR3P3oXlNXJVJbsDisraRAcg/AlhKQ8oX2r5cI0ozSQTmI7I0k
         3NEbw65vhsNsL/yGVK0xaiKrDYNDUy7R2PTJ9C/d74zJFiGM94F5otSQLrvIvOx7NPEn
         rdEKI/xJ3Yjx/WUe/ZSPeGIdO0ipR0BUsAgn1HHyBNMLjWvLz17EC9arIkBusmJf7DU/
         Ph5VQwRss8xeHCZNRfu4lO3U6X3lNZ/g8EdyfO7HToQgG6xOLKuzvy67G602E8Ft2MUp
         ouKHgVX6bJg6ifwXIe6auaxLDDss6phrAzONWizrK5GweX0xW1HM1ESHZ6SL13u2y+o9
         Th6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XNJCFSff;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XNJCFSff;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Roi Dayan <roid@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.14 11/45] net/mlx5e: Err if asked to offload TC match on frag being first
Date: Fri, 18 May 2018 10:15:28 +0200
Message-Id: <20180518081530.900460953@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789061393322698?=
X-GMAIL-MSGID: =?utf-8?q?1600789217691899688?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -780,6 +780,10 @@ static int __parse_cls_flower(struct mlx
 						  f->mask);
 		addr_type = key->addr_type;
 
+		/* the HW doesn't support frag first/later */
+		if (mask->flags & FLOW_DIS_FIRST_FRAG)
+			return -EOPNOTSUPP;
+
 		if (mask->flags & FLOW_DIS_IS_FRAGMENT) {
 			MLX5_SET(fte_match_set_lyr_2_4, headers_c, frag, 1);
 			MLX5_SET(fte_match_set_lyr_2_4, headers_v, frag,
