Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq5J7KB+WGCe1eEA4U4rgPgMMYmVIpV5V3TCuhHHC/afTEjECz33QPqFk4DuQCTuPBkdD3T
ARC-Seal: i=1; a=rsa-sha256; t=1526631488; cv=none;
        d=google.com; s=arc-20160816;
        b=QLleypRNY6b63MbH1NidanrrD2zRL/XP9hZuPqrlKsyuM1S6h0zyJFRmp9gZwEz0yA
         oRtaLxac64gP0T6lBWbPD4Zhq9oBL0XFShMY/yLmxYf5lGkO1+DYJV/7JDLOgsQlEmUy
         RU+BdaS97/gXuVl4aH4jYYBZgDKu/B8X42VVq7sohUlAtNa8LX8fRlcPGxJ/KAmueG6s
         +VfhrEi6SVVvaIHPsvX7Og0cCHjq+312F7+gLGIzO5VG6D5OQ43X5K0ZCSOwAmdEnffR
         1S5aJmxARoF/dFURza+TwDfaZZ4fI+lX+06fDp08OXS67qE902Qi/Ibyv73Y1BzxqJI0
         ZRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=g8eeA9X15LfMiaaLw6IFyAZWFkUTsK2G7Ggzxjh6e4I=;
        b=pLRWKEHV10GkTP5wvM8utesWiMtfugcIJ9gDzmKFteu+DKM9vg4haCoNtr0qdDbQqs
         DyS5DmzdvA2zSwXZvUbsoWX2s9TFxR+1bps7lgj/LPfaNQoRN9Ig5xRkRcjDqG9HO1AP
         wWpbH0RidYtEjoXLdzBesKIbKzSxLIt/DMWr8V+w8LQ4dWZnO+JBPIq8XY3HC+GUZLic
         dixRFFHkeoGjcP98z526SvZPGTI4lFzxE2tOARJdEeduWAt3XqIjbaUKgPHBcrf0Yda0
         Y7vLlYRd26M43FPeoSnVjolBBWnqT0NsacuXHTFyBlWhby1wdsfLrKX5nB0qM+93LVtq
         oVMg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NYr9BHXr;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NYr9BHXr;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jianbo Liu <jianbol@mellanox.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.16 38/55] net/mlx5e: Allow offloading ipv4 header re-write for icmp
Date: Fri, 18 May 2018 10:15:34 +0200
Message-Id: <20180518081459.247755021@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789139266208536?=
X-GMAIL-MSGID: =?utf-8?q?1600789139266208536?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1867,7 +1867,8 @@ static bool modify_header_match_supporte
 	}
 
 	ip_proto = MLX5_GET(fte_match_set_lyr_2_4, headers_v, ip_protocol);
-	if (modify_ip_header && ip_proto != IPPROTO_TCP && ip_proto != IPPROTO_UDP) {
+	if (modify_ip_header && ip_proto != IPPROTO_TCP &&
+	    ip_proto != IPPROTO_UDP && ip_proto != IPPROTO_ICMP) {
 		pr_info("can't offload re-write of ip proto %d\n", ip_proto);
 		return false;
 	}
