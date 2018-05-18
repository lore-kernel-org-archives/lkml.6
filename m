Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpcQi5Xhl7N/hu1Y1sXFkuwzX1eXISmoZU9YxxRTCcCJ0W6lMI7caLvm38yD4KlTJTC3U9Y
ARC-Seal: i=1; a=rsa-sha256; t=1526631633; cv=none;
        d=google.com; s=arc-20160816;
        b=fz6vXSAoOmDgxLhG4+Kr8tVU0tb6oydwuIItufvpINJEJ2bWL/cpXRWGbcd+BFva7W
         wA30rH0edxggR6ihCqSgk7ilKUyjJsqiRAQZCPdGxM4bonEq7+ETkZmmX7swoS4vQ66W
         2/IJ2UR+OgoBaNY1f8WAEb+jGt/NBn2+qY1iCyROMZJI9CbX2DjLd3rBz00qotbVRc4z
         cpsaD6czE0/RokByl6Suu8tRjnr3tImE+8vw6cIVUdlhRxgUveBe+brWH/86H6zD7t5g
         CKd8E+UQ7DLspv+f3RArAnI5nG0aTUKNRJKQeaI/fU+WWgKvPEsScyNNmm0D6bl8hKOI
         yJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=xBY9/F3/+4Y+ZeVJU3hZVqgFcyEWd53J6lXxELUwQoY=;
        b=TatZGs0mgyxClXVlaUuiIv5RG4VU08jyyMwNhSj7XF9JwhTzgzy952DrVEWemfbiMg
         QJsZArzgmWA8zOpH5ZCcZuGXo5FInfMBqXc8wD9sXaYAJ7RLR9u6dfyYVnVtWdHmF84e
         C4SMqTGJZTpJhlSjM5IGfs9GFrx0mwVYZPLiYJYCHdeaGRkyVtV0nN2AJZNKE/Kj3dRg
         ix6ddZZUrkmUxRehTi+sTXQp1tRvEvtv3kmFmYM3leZt4dagpgHNLPaQoUCGUQr418U6
         qJjUCxsp3+rrBxxUHnMINLVpU2+5Gwjl8mMNjCwSxgB+r4X/bxuiv8stwIgq65C47He9
         12NA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0oodKBm1;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0oodKBm1;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jianbo Liu <jianbol@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.14 37/45] net/mlx5e: Allow offloading ipv4 header re-write for icmp
Date: Fri, 18 May 2018 10:15:54 +0200
Message-Id: <20180518081532.249486627@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789139266208536?=
X-GMAIL-MSGID: =?utf-8?q?1600789292116578363?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jianbo Liu <jianbol@mellanox.com>

[ Upstream commit 1ccef350db2f13715040a10df77ae672206004cf ]

For ICMPv4, the checksum is calculated from the ICMP headers and data.
Since the ICMPv4 checksum doesn't cover the IP header, we can allow to
do L3 header re-write for this protocol.

Fixes: bdd66ac0aeed ('net/mlx5e: Disallow TC offloading of unsupported match/action combinations')
Signed-off-by: Jianbo Liu <jianbol@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1387,7 +1387,8 @@ static bool modify_header_match_supporte
 	}
 
 	ip_proto = MLX5_GET(fte_match_set_lyr_2_4, headers_v, ip_protocol);
-	if (modify_ip_header && ip_proto != IPPROTO_TCP && ip_proto != IPPROTO_UDP) {
+	if (modify_ip_header && ip_proto != IPPROTO_TCP &&
+	    ip_proto != IPPROTO_UDP && ip_proto != IPPROTO_ICMP) {
 		pr_info("can't offload re-write of ip proto %d\n", ip_proto);
 		return false;
 	}
