Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtJrA6yaz6uEBDIIm0sM/IV3bLfLvVB+2UiGM3Qo3+rsnHPnVSjv3iaXokLg0Xcrbc1nbB1
ARC-Seal: i=1; a=rsa-sha256; t=1520641332; cv=none;
        d=google.com; s=arc-20160816;
        b=cfOtdbQBaGfPUYoyPeTcY/kEdJVfKnTrUIvC6VqrVR5m+iITBLbEFqDI5UKpStZ+zb
         RkB8eH8fdEcxndXv1GHKfVhibPLt3DQVEt8LJpO0MGEGq0mP6OsO10dPeNEXx4k6fpxb
         sDYXT2q8A0y5nohblw9JcgpD5MVmSoFeKnhdKKPcM5gmRnjGcPkOxPenTwWK18e8+VAH
         2IBCkPTin9+SQRdMRLDY+uuwzHHYYa0F2rRmBx9nRDF38ATkuNUg7t6Pua80G4PwcIdC
         WnuKvEJDbB6hrBiNsRULVYmT38J6MC/s0OWBMjtnLI94KAcrc6BWI2LQJ4BaGavSLuqr
         tjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QsdH0osN6P3her8eBFZpnEPbBSRydW+1Bc93d/1n+XE=;
        b=sRPw8NiaeHy1MXHM6l+kkHlk46Zr5VjsEp6Q1/wJGOrf6jwhU4k4y+AjU3gAUFwe6I
         m0mdKWo4ILT/ruw35ahIXrljBXRlIcBFDLWSQqpxQhR6U0Io7JFLJwFliu7od+BhjyOq
         Zb16lOLpuRN2rzJNg5JpikmXoQISTTw5fuDxX22zOhyVXt/KPTBlYoexXX4Klj1IkwJc
         lsgvaC/cT9bhWfqiLamMSRG2d673p8CePjXx7jkaNRrTU3/blEVaVMrhzs3aXjg3qEkA
         IMSAluv152CP+cXQTRawr+zULs9K0tiEnow5JFbkpjNrdgtwRi2ouLmz5F+izqmaZQUi
         cIIg==
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
Subject: [PATCH 4.9 43/65] mlxsw: spectrum_switchdev: Check success of FDB add operation
Date: Fri,  9 Mar 2018 16:18:43 -0800
Message-Id: <20180310001828.431646614@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594508006571093736?=
X-GMAIL-MSGID: =?utf-8?q?1594508006571093736?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -809,6 +809,7 @@ static int __mlxsw_sp_port_fdb_uc_op(str
 				     bool dynamic)
 {
 	char *sfd_pl;
+	u8 num_rec;
 	int err;
 
 	sfd_pl = kmalloc(MLXSW_REG_SFD_LEN, GFP_KERNEL);
@@ -818,9 +819,16 @@ static int __mlxsw_sp_port_fdb_uc_op(str
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
 
@@ -845,6 +853,7 @@ static int mlxsw_sp_port_fdb_uc_lag_op(s
 				       bool adding, bool dynamic)
 {
 	char *sfd_pl;
+	u8 num_rec;
 	int err;
 
 	sfd_pl = kmalloc(MLXSW_REG_SFD_LEN, GFP_KERNEL);
@@ -855,9 +864,16 @@ static int mlxsw_sp_port_fdb_uc_lag_op(s
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
 
@@ -891,6 +907,7 @@ static int mlxsw_sp_port_mdb_op(struct m
 				u16 fid, u16 mid, bool adding)
 {
 	char *sfd_pl;
+	u8 num_rec;
 	int err;
 
 	sfd_pl = kmalloc(MLXSW_REG_SFD_LEN, GFP_KERNEL);
@@ -900,7 +917,15 @@ static int mlxsw_sp_port_mdb_op(struct m
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
