Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48eKI4SePxSQYPBgTbvBd1g+ilqdOLqPwrl0XoFTzVrdkbF085Nf2VNkMx3Suh1fQXWe41M
ARC-Seal: i=1; a=rsa-sha256; t=1522346655; cv=none;
        d=google.com; s=arc-20160816;
        b=b8omy5dCeA5auD37XZnO4jqxNQLLwRe1YLqLMS/Y2oZ3GgymeAZxhYKQbVEggT6RMz
         iWcX9nznirXD3OXIqoIYZRuDwfKq1gwVglVZfkCEjIOVjNnIGPb2EX5PHM5CW1MDM++7
         EJ4zTnm761w67CLfBlPG/qWJdotOvBY+GmE/SZ5r4gD/hoAy0cjqFrLDOtQxgHcYzGHS
         aamhx7adhBu/slUQtc+NvaD1tk53xqGztBU104gHHmMLrJdqjd3u+dtV+OjmltBjBgyX
         UrJl/2OUjIw3yqqZ9QuWUPELOBVado6FqFGB1dxyToTZOK3gcewVUPFjCpz8Gk95K4yR
         wKgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qZUb84EFpQZtSD9xAzSoajAbIhZ1hSpM1PQSZn6J6yo=;
        b=v/B7FOisenTyIUifs8DhnHd0u4npxZ7QSjiQvF4Icxnaqq/9mvbwEeK12kLzY/uJhc
         suo39vZRmk100q+ADJlmsKYjGo5qp9hiz8eVtyFuSGAu/LeLX5dyqviTrRURlSlXsxHX
         xwzcTmA2wASrR+/YJ0kmADBpDDP3byphIcOaenp/xaTPkmQ3GeaE0w65g52E0k+9Z9z5
         bua+trpmsYxK78XOLk5y5ksoHv0YhO+ALAo6nMFqYxhHAZk2L1Fk8P4dPNlRAS9dNrUw
         8AlNsNmyJ9Zju65NJGnPGXiAa1KEO1dt1XbVypxwHmWDVcTf9Q76kk9JpHzzniQrhRTo
         ET8w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ido Schimmel <idosch@mellanox.com>,
	Eddie Shklaer <eddies@mellanox.com>,
	Jiri Pirko <jiri@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 12/43] mlxsw: spectrum_buffers: Set a minimum quota for CPU port traffic
Date: Thu, 29 Mar 2018 20:00:07 +0200
Message-Id: <20180329175731.300534516@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296135615626830?=
X-GMAIL-MSGID: =?utf-8?q?1596296167171275210?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@mellanox.com>


[ Upstream commit bcdd5de80a2275f7879dc278bfc747f1caf94442 ]

In commit 9ffcc3725f09 ("mlxsw: spectrum: Allow packets to be trapped
from any PG") I fixed a problem where packets could not be trapped to
the CPU due to exceeded shared buffer quotas. The mentioned commit
explains the problem in detail.

The problem was fixed by assigning a minimum quota for the CPU port and
the traffic class used for scheduling traffic to the CPU.

However, commit 117b0dad2d54 ("mlxsw: Create a different trap group list
for each device") assigned different traffic classes to different
packet types and rendered the fix useless.

Fix the problem by assigning a minimum quota for the CPU port and all
the traffic classes that are currently in use.

Fixes: 117b0dad2d54 ("mlxsw: Create a different trap group list for each device")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Eddie Shklaer <eddies@mellanox.com>
Tested-by: Eddie Shklaer <eddies@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c
@@ -385,13 +385,13 @@ static const struct mlxsw_sp_sb_cm mlxsw
 
 static const struct mlxsw_sp_sb_cm mlxsw_sp_cpu_port_sb_cms[] = {
 	MLXSW_SP_CPU_PORT_SB_CM,
+	MLXSW_SP_SB_CM(MLXSW_PORT_MAX_MTU, 0, 0),
+	MLXSW_SP_SB_CM(MLXSW_PORT_MAX_MTU, 0, 0),
+	MLXSW_SP_SB_CM(MLXSW_PORT_MAX_MTU, 0, 0),
+	MLXSW_SP_SB_CM(MLXSW_PORT_MAX_MTU, 0, 0),
+	MLXSW_SP_SB_CM(MLXSW_PORT_MAX_MTU, 0, 0),
 	MLXSW_SP_CPU_PORT_SB_CM,
-	MLXSW_SP_CPU_PORT_SB_CM,
-	MLXSW_SP_CPU_PORT_SB_CM,
-	MLXSW_SP_CPU_PORT_SB_CM,
-	MLXSW_SP_CPU_PORT_SB_CM,
-	MLXSW_SP_CPU_PORT_SB_CM,
-	MLXSW_SP_SB_CM(10000, 0, 0),
+	MLXSW_SP_SB_CM(MLXSW_PORT_MAX_MTU, 0, 0),
 	MLXSW_SP_CPU_PORT_SB_CM,
 	MLXSW_SP_CPU_PORT_SB_CM,
 	MLXSW_SP_CPU_PORT_SB_CM,
