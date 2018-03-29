Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/fPthVSF5IcT2aBhs58ybt4M1R+1heA8bAvTrqcCa0pNWeTeX2BBpMCy6KoI7vl2Wy+NUa
ARC-Seal: i=1; a=rsa-sha256; t=1522346625; cv=none;
        d=google.com; s=arc-20160816;
        b=vy9oQu9dVrDD+oYq/5NXNnQ44eJ9UvtrGsSq3D7DIJOLPPqwDcoljsd+JbRfSEkShw
         /IpUw8px2c+qAsPo4VVGfPaXuaM7+fK0Q+rTvMjoALhI1o7GWySXIfOi2oIM+9PmCXBf
         ZMxHrShmC2a0LH4SpdpvbRTdaV+qQRYfuU4FFceKib2GMTVUjoSOOHEbR/94fvXl8T8n
         q3m4WwhFrMkd3TKa6mfgZOSV9VM9lMEq2chaYVKhTXHJPbQMSnhtml9aNOjJF33qMggg
         +uzIxBMn4v6HUX32WjgQMEMF81P+ruBIKDX4nJweOHJk1KXWT+rDl0lC6+8TKV+SMfyk
         zQow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3Ej32bYxHtTqfz/cJ1PCoBl4lLchdjYAx+PIvZBOS8s=;
        b=IlMMHLlyT/r9wDwW1IQlH2VwLlWcbaZzjqzHdGAl7OQmrLfDMkIwuGzaBZq62v+hfd
         67uXb1csUnl/rjTvONaIt4W6xxWFgvxhpmdp9FHX6CMQqBfz/Jndc2qed5H6X9m/QGVL
         FJBeiYjbfBGmsv+i7/LKL9JvPIdLRl/8j9jPegrTevIcnv2HbQhEVG7OrYJrKLspNwfn
         S4ZtM50mtcg2OO49iwUK3K5JkyKBbyp4R4Go9fCeRDzBi/tBFtw0w9rP/mz7z7/GMDMv
         DmBMRCLc9viybxYzpvHkbtZU53O/nappuNbYQzuUmQEbtLEkk/jq8qF9K3Qskwx6PYbw
         83+Q==
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
Subject: [PATCH 4.15 14/47] mlxsw: spectrum_buffers: Set a minimum quota for CPU port traffic
Date: Thu, 29 Mar 2018 19:59:55 +0200
Message-Id: <20180329175730.154527187@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296135615626830?=
X-GMAIL-MSGID: =?utf-8?q?1596296135615626830?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
