Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs7sARBBEMLjhvtLXxS4G67vje6uI3rQ/XTCpI+e/4wSX5nJzA9R3fsvqZJbwDXldOSrXAo
ARC-Seal: i=1; a=rsa-sha256; t=1520452070; cv=none;
        d=google.com; s=arc-20160816;
        b=P4HP6ZsBFlW4+fg7vdTsdezo6FmyIvMYyVx+CoMQoEA/0NbcIEUe/CNhs4zB1gNi4H
         ftRWJCwthpmint1KUAUBQqWB97s34c/0LYtY8gu8Dq7wnGuMLYwV6bsQDWiMyHcnIiup
         +va+AMLFW76LpOav0wjgy5KDj5m8z9MbXFQj+4QWvHdtix8+dMdCZty9iTQwUpx8r6cI
         dehJVCGt5wTyL9RCDSfKvWKrMYRIj9/T1SGMvasLew8E7VIb/W8ekgwhtXdVeMcxJyIo
         5H5xi55MwQaM00LDqObkGtB2mJi5dTOtDtJBcmxAcn6KKTuU00LOOOi1sdWB4YKBdtmA
         7MCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+AgaDkjmyYYnyOLNYe5qRi/wpXOprUcijGKvORvjeG4=;
        b=F7Ry6NUlfU8ZFt9Z823lrxBQ7SBGm3E4c8mmMY4crf0MtXlngsuYroTBRTUNc5ndPc
         HGSwQ0LXBYTgQleKZ2o3Y60Kx7qXITtgUEBguJ6Z+Ps6wD+8f/f4V5hdpwS3/OFXWp9v
         uQk+rnjwUVcxTDjgmH31RG8mAtlYKWYrjxz1p+cg2dNjRz6lK+ssx+89qOA/OAXNlADQ
         TsCQtDGgVvfxefbkBJxpsHX/MGJY4cAgGxccIRRBiPPkjQuX2dpb8N+CTHs2fVQntPM1
         HzCtT6TlVq/B6FrQwIW15TB98FIoVAUKM8GRGNh3V081O1PcJhIP1A4qaTTQ6LdfkgqI
         4uJQ==
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
Subject: [PATCH 4.14 049/110] mlxsw: spectrum_switchdev: Check success of FDB add operation
Date: Wed,  7 Mar 2018 11:38:32 -0800
Message-Id: <20180307191045.991894527@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309150715591734?=
X-GMAIL-MSGID: =?utf-8?q?1594309549958533272?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1098,6 +1098,7 @@ static int __mlxsw_sp_port_fdb_uc_op(str
 				     bool dynamic)
 {
 	char *sfd_pl;
+	u8 num_rec;
 	int err;
 
 	sfd_pl = kmalloc(MLXSW_REG_SFD_LEN, GFP_KERNEL);
@@ -1107,9 +1108,16 @@ static int __mlxsw_sp_port_fdb_uc_op(str
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
 
@@ -1134,6 +1142,7 @@ static int mlxsw_sp_port_fdb_uc_lag_op(s
 				       bool adding, bool dynamic)
 {
 	char *sfd_pl;
+	u8 num_rec;
 	int err;
 
 	sfd_pl = kmalloc(MLXSW_REG_SFD_LEN, GFP_KERNEL);
@@ -1144,9 +1153,16 @@ static int mlxsw_sp_port_fdb_uc_lag_op(s
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
 
@@ -1191,6 +1207,7 @@ static int mlxsw_sp_port_mdb_op(struct m
 				u16 fid, u16 mid, bool adding)
 {
 	char *sfd_pl;
+	u8 num_rec;
 	int err;
 
 	sfd_pl = kmalloc(MLXSW_REG_SFD_LEN, GFP_KERNEL);
@@ -1200,7 +1217,15 @@ static int mlxsw_sp_port_mdb_op(struct m
 	mlxsw_reg_sfd_pack(sfd_pl, mlxsw_sp_sfd_op(adding), 0);
 	mlxsw_reg_sfd_mc_pack(sfd_pl, 0, addr, fid,
 			      MLXSW_REG_SFD_REC_ACTION_NOP, mid);
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
