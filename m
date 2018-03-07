Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs139j6Y3nnU4cybT5fgudu38uGkNDZZzcea7SjknOZuOemVhntkuqSo+/cZLqWQrdJjYGv
ARC-Seal: i=1; a=rsa-sha256; t=1520451689; cv=none;
        d=google.com; s=arc-20160816;
        b=Jay8lmENk1qBi8h+GMn/oNPTYAh3Qb1Z/ATSgjTfUcJvCiIr18I++WMg81bD3YWYz7
         xo9dc1Yt2O1RJP6B5Anjv/CnAZAXieh/t/sCfOzq5XBbNdMu749awb6FACNlpne+FLfb
         +wiI3VOdmrKQLy81My3mLRPpNI8I1IfVO1iHIWmpkiBdKwxxHGltkUWy+1DCgB1Z+v8t
         Llz57ZIh2Ft+XxRglZVTdkixk3r0ZlWYF0dZo+BZ9g4AKpnyBoBP951lvckaPfxXkBQr
         HKZ1nw4Wk1Z/4wKferqzFy5yv9wb+fsOqi3LrFZUqITNRekJzF9kMx8SQZRhYYV/ngii
         ixug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ecewe6VNhvtZ6KB6YDshOG5q5HENs++eo8jBcm3dUdY=;
        b=sJUU1pUQ7aOZVxtg5blegBGJARKHRKtQ8PPrRVMP4xK5kZjyn6FbSQxU93mLW3CgMY
         UkAi4cs8YYOzIU3gIR34+S18AMRIhlHkDbgHYyrvusVlP3TFnxUIIDQ9zbabKlT1fh1j
         x0luDNE/IZvvWfNqQrXRTDDIbq/mMvBRUg/wWlWP1qqjFHv0MzBKYwYVKHNNYH3RjH3Y
         N1JFUCTsfqKDkbOPscXJZ9fys77/qdxyZQz1YbWDyOLZGgDiXrREU+mj9EqKB1KBH5as
         yrDLjDC6HhQmRSEJfqMM33VlGg2MO4LMcLDiAPtmL8avXgmnT4NkVhevcCTB8otGkJT/
         i/nA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ido Schimmel <idosch@mellanox.com>,
	Shalom Toledo <shalomt@mellanox.com>,
	Jiri Pirko <jiri@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 054/122] mlxsw: spectrum_switchdev: Check success of FDB add operation
Date: Wed,  7 Mar 2018 11:37:46 -0800
Message-Id: <20180307191736.966289092@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309150715591734?=
X-GMAIL-MSGID: =?utf-8?q?1594309150715591734?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shalom Toledo <shalomt@mellanox.com>


[ Upstream commit 0a8a1bf17e3af34f1f8d2368916a6327f8b3bfd5 ]

Until now, we assumed that in case of error when adding FDB entries, the
write operation will fail, but this is not the case. Instead, we need to
check that the number of entries reported in the response is equal to
the number of entries specified in the request.

Fixes: 56ade8fe3fe1 ("mlxsw: spectrum: Add initial support for Spectrum ASIC")
Reported-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Shalom Toledo <shalomt@mellanox.com>
Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |   29 +++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1203,6 +1203,7 @@ static int __mlxsw_sp_port_fdb_uc_op(str
 				     bool dynamic)
 {
 	char *sfd_pl;
+	u8 num_rec;
 	int err;
 
 	sfd_pl = kmalloc(MLXSW_REG_SFD_LEN, GFP_KERNEL);
@@ -1212,9 +1213,16 @@ static int __mlxsw_sp_port_fdb_uc_op(str
 	mlxsw_reg_sfd_pack(sfd_pl, mlxsw_sp_sfd_op(adding), 0);
 	mlxsw_reg_sfd_uc_pack(sfd_pl, 0, mlxsw_sp_sfd_rec_policy(dynamic),
 			      mac, fid, action, local_port);
+	num_rec = mlxsw_reg_sfd_num_rec_get(sfd_pl);
 	err = mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sfd), sfd_pl);
-	kfree(sfd_pl);
+	if (err)
+		goto out;
+
+	if (num_rec != mlxsw_reg_sfd_num_rec_get(sfd_pl))
+		err = -EBUSY;
 
+out:
+	kfree(sfd_pl);
 	return err;
 }
 
@@ -1239,6 +1247,7 @@ static int mlxsw_sp_port_fdb_uc_lag_op(s
 				       bool adding, bool dynamic)
 {
 	char *sfd_pl;
+	u8 num_rec;
 	int err;
 
 	sfd_pl = kmalloc(MLXSW_REG_SFD_LEN, GFP_KERNEL);
@@ -1249,9 +1258,16 @@ static int mlxsw_sp_port_fdb_uc_lag_op(s
 	mlxsw_reg_sfd_uc_lag_pack(sfd_pl, 0, mlxsw_sp_sfd_rec_policy(dynamic),
 				  mac, fid, MLXSW_REG_SFD_REC_ACTION_NOP,
 				  lag_vid, lag_id);
+	num_rec = mlxsw_reg_sfd_num_rec_get(sfd_pl);
 	err = mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sfd), sfd_pl);
-	kfree(sfd_pl);
+	if (err)
+		goto out;
 
+	if (num_rec != mlxsw_reg_sfd_num_rec_get(sfd_pl))
+		err = -EBUSY;
+
+out:
+	kfree(sfd_pl);
 	return err;
 }
 
@@ -1296,6 +1312,7 @@ static int mlxsw_sp_port_mdb_op(struct m
 				u16 fid, u16 mid_idx, bool adding)
 {
 	char *sfd_pl;
+	u8 num_rec;
 	int err;
 
 	sfd_pl = kmalloc(MLXSW_REG_SFD_LEN, GFP_KERNEL);
@@ -1305,7 +1322,15 @@ static int mlxsw_sp_port_mdb_op(struct m
 	mlxsw_reg_sfd_pack(sfd_pl, mlxsw_sp_sfd_op(adding), 0);
 	mlxsw_reg_sfd_mc_pack(sfd_pl, 0, addr, fid,
 			      MLXSW_REG_SFD_REC_ACTION_NOP, mid_idx);
+	num_rec = mlxsw_reg_sfd_num_rec_get(sfd_pl);
 	err = mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sfd), sfd_pl);
+	if (err)
+		goto out;
+
+	if (num_rec != mlxsw_reg_sfd_num_rec_get(sfd_pl))
+		err = -EBUSY;
+
+out:
 	kfree(sfd_pl);
 	return err;
 }
