Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuTGCpbYftiHjsCCmWh3lt42yW34EJkYKu5DLUrU/GDtW3MDQ6lKX01+fD6Eh7F+ecW+qLu
ARC-Seal: i=1; a=rsa-sha256; t=1520451802; cv=none;
        d=google.com; s=arc-20160816;
        b=mltT+uFvHiVfvZY6mE3MQk0Mzvr576VBOUcrmgKHlQKPvdNBYW0zfQ0+MUMoRQejGp
         jHfIe/LjbuVt7mD896R4QWp0iMTDoxBkEcIiLtoZHqKO5OkHuZnYoa6xyUrFJekhRjJq
         glZ6fvEtOD8O+e4JCtcE0b+74NK/rFapZR9K8grI1KCESVubN0sIsf2rSQf+3dNB4M6d
         +1kmDwzvZGIUDrIjlbU33+wMFE4lkpBotkYNgrjp3XGtSu6a9NZjzBmcTKyV2xEd/f0h
         bscSHBiO8+T8U3NWoJEcEFyxMfxbzYsHWM6+RiC+rvznKRV8giM88RQdzA0Y8YdLStym
         9Dug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6GmzlhQF/78W8ctpvsm1SuMudk71HrTHzFPjv6MuDIc=;
        b=fdPwXKcPNb2h8oF7N3frEd+HGf+YKGllgeWEdIBK4P9JxPKVM+R9r7GwfkoTrB1DpG
         mJCblR40kcG0Ik7Iq9G+UkYxGuyratih3i6R7viQaeUMbXjDklPOZb8hf6Upum91CeuC
         vqx5x4bcriKqLYoqkuwtM3RPFcUTF7de0EO1jH/MutkHtFa959PgvYmtrb+K4hgnwVdf
         mK/X/Fzth059LNaZDF/9bMmes/dKrE2Wy44wzs6cozUjrjcQNRSebD4fKLEc7fymR9xA
         WDz75y3R1T+Dor2t0XlmL2hD1bvcvVtBWQjHQBxD5vFFWxUieKGiNYQgH8TSfmEmlZsV
         vuzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ido Schimmel <idosch@mellanox.com>,
	Alexander Petrovskiy <alexpe@mellanox.com>,
	Jiri Pirko <jiri@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 073/122] mlxsw: spectrum_router: Do not unconditionally clear route offload indication
Date: Wed,  7 Mar 2018 11:38:05 -0800
Message-Id: <20180307191739.900424076@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309269240513543?=
X-GMAIL-MSGID: =?utf-8?q?1594309269240513543?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@mellanox.com>


[ Upstream commit d1c95af366961101819f07e3c64d44f3be7f0367 ]

When mlxsw replaces (or deletes) a route it removes the offload
indication from the replaced route. This is problematic for IPv4 routes,
as the offload indication is stored in the fib_info which is usually
shared between multiple routes.

Instead of unconditionally clearing the offload indication, only clear
it if no other route is using the fib_info.

Fixes: 3984d1a89fe7 ("mlxsw: spectrum_router: Provide offload indication using nexthop flags")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Alexander Petrovskiy <alexpe@mellanox.com>
Tested-by: Alexander Petrovskiy <alexpe@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -3765,6 +3765,9 @@ mlxsw_sp_fib4_entry_offload_unset(struct
 	struct mlxsw_sp_nexthop_group *nh_grp = fib_entry->nh_group;
 	int i;
 
+	if (!list_is_singular(&nh_grp->fib_list))
+		return;
+
 	for (i = 0; i < nh_grp->count; i++) {
 		struct mlxsw_sp_nexthop *nh = &nh_grp->nexthops[i];
 
