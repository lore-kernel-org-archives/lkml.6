Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsPKMiuFSySAiKytsL0XKBs/iVXDIToYBGVPV0T+mwsm2mLxCOZ8JoYDkUQIES4c8nwbep1
ARC-Seal: i=1; a=rsa-sha256; t=1520451724; cv=none;
        d=google.com; s=arc-20160816;
        b=QWFNk6qtY9UzJellMrQxprvhTGukpFHVpGkBgDvyHtdU0Sxl0I5NCcfTwkqxUa5NdO
         ux3SVPqJavlMYvmhnIqip7WFm09MJEF9cUfHqJfoRZgivGZFLYREffcyWjq2myh42fOK
         tBVVfiGbkrp/i4LlglcH2ojprmhWEpq4qEB1wcqEvrONrIFsByw4g0JbykVij/CoQPwS
         StKk4YYxArASYVDnFHLjjvTUJ7RvEoyCTfcIVPrrPbJmyzUjILjhO5bthwtuV6/ajhVz
         SNp1yqfueqy86TTyHYXsy+lMs2ms9qWPGMI/txW7WzXdjE/h6KJKEJ7UfdSGi86sRVU+
         wv4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gNf0kaB3u+6Y1xfjH5UMT6V4J7gqwC1n1sGaCcg7FPE=;
        b=PE6OejU0VPxxhsSgzFpaVaSTjLcUXMnXqeUNNM+sghTSBvP0yF2/jHqDVmGgzqRINR
         82QJKscbHwIJMTCzhjyd+ZXAU7WWTge2qBUsh2xxOfQXPBd4Z2U8X6cjcbn0F9024Enr
         G/tP8u4CnYYFe2NK8GBXt9eZPJzJ6PA/V5k3VjpNI0CGVDaN9fn+OFj5frv2p4I4qy4f
         d8vnOZMrGKA9VX+vWP7B00SrKzh+x2u0q5k9lKv3o4un7PB7nLg95c52enoDrLPNR3gT
         Gj3N0Ao6jMk92NUp3t7jQ3yn6og3IWhPqEmxeK8xcpvSUd2mMzzIYls6cJRtoBEDxgXM
         vJuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eran Ben Elisha <eranbe@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.15 069/122] net/mlx5e: Verify inline header size do not exceed SKB linear size
Date: Wed,  7 Mar 2018 11:38:01 -0800
Message-Id: <20180307191739.358205777@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309187550945375?=
X-GMAIL-MSGID: =?utf-8?q?1594309187550945375?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eran Ben Elisha <eranbe@mellanox.com>


[ Upstream commit f600c6088018d1dbc5777d18daa83660f7ea4a64 ]

Driver tries to copy at least MLX5E_MIN_INLINE bytes into the control
segment of the WQE. It assumes that the linear part contains at least
MLX5E_MIN_INLINE bytes, which can be wrong.

Cited commit verified that driver will not copy more bytes into the
inline header part that the actual size of the packet. Re-factor this
check to make sure we do not exceed the linear part as well.

This fix is aligned with the current driver's assumption that the entire
L2 will be present in the linear part of the SKB.

Fixes: 6aace17e64f4 ("net/mlx5e: Fix inline header size for small packets")
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -176,7 +176,7 @@ static inline u16 mlx5e_calc_min_inline(
 	default:
 		hlen = mlx5e_skb_l2_header_offset(skb);
 	}
-	return min_t(u16, hlen, skb->len);
+	return min_t(u16, hlen, skb_headlen(skb));
 }
 
 static inline void mlx5e_tx_skb_pull_inline(unsigned char **skb_data,
