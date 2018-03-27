Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+NRDmeQSd1GOEfyzQ0s06njaDtkMSS/sgMoiQJDp0pr7tD6hW8E5VNwbm97MEb0wLis3Ft
ARC-Seal: i=1; a=rsa-sha256; t=1522168752; cv=none;
        d=google.com; s=arc-20160816;
        b=kPqCCpwGRt4hda8cLQmtk6GvFNyGqPjwXbt2ZbtviVODKnuUNmxSpIvxvU1fYueX16
         Sq8Lw0u4JIe+KL1phIPuGDf8lWmMHRZ3Hzm4gHDeDc8Z5XjlG0jd0aVam2e8GJisJ4Jh
         RKvtPjoPZfo+w1BBA5GZjTIzM2M+vIu0o7vfWz8hLGyxsrj5MiFotl2pvwgauh+VLik0
         zCrJFmORbNBO7yuQbeoZnHHSE4T1RdTVJ4flQmqq50Ja1Z1Nykdl37DiVKzSNkeaxSRq
         Zxg+Zqkkw9qjyBofXh+DNp0nNDh/UCGupQb4Tg+KR1N8LS7Uz37tJKzHxBIdSUo79NRF
         SAYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UJL27qKu/yTmlzuGw9kpk4HMb+y89uKQs7g0F0vO+8o=;
        b=HA773a0F6ktN7ZqzM7b/+r4m1Qh/YAYsu02ryjv71M6rnsVR3WsrvklcBSYuhA7XAp
         ZcsXTYkSxrR8sSL0IZJAmiRY7hxZqfW6Ofbd3+Q1+n6UweVzJLyzunhh8uCwiX2APJc+
         5dHzZz09zAbhg6WxzYv1VewAQz+BxYCmuMqPVCfz9dEYHx9IoxQ27dGi2C/A3Zkpj32t
         MoHbhQe2fs+wnfGkiSCpDcAlaomId06M5dZTmDhRAa1sMK4MV18+VZop2EfS4brbbtu6
         0BYT9ve78tIjLAhThoDRST9ugi5PUzaFP/H9HFFr+jFoaNwGX/XPL63e6g6V7S5S3hF1
         0+lQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	NeilBrown <neil@brown.name>,
	Matt Redfearn <matt.redfearn@mips.com>,
	John Crispin <john@phrozen.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org,
	James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.15 002/105] MIPS: ralink: Fix booting on MT7621
Date: Tue, 27 Mar 2018 18:26:42 +0200
Message-Id: <20180327162757.916740121@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109314915316713?=
X-GMAIL-MSGID: =?utf-8?q?1596109622303534013?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neil@brown.name>

commit a63d706ea719190a79a6c769e898f70680044d3e upstream.

Since commit 3af5a67c86a3 ("MIPS: Fix early CM probing") the MT7621 has
not been able to boot.

This commit caused mips_cm_probe() to be called before
mt7621.c::proc_soc_init().

prom_soc_init() has a comment explaining that mips_cm_probe() "wipes out
the bootloader config" and means that configuration registers are no
longer available. It has some code to re-enable this config.

Before this re-enable code is run, the sysc register cannot be read, so
when SYSC_REG_CHIP_NAME0 is read, a garbage value is returned and
panic() is called.

If we move the config-repair code to the top of prom_soc_init(), the
registers can be read and boot can proceed.

Very occasionally, the first register read after the reconfiguration
returns garbage, so add a call to __sync().

Fixes: 3af5a67c86a3 ("MIPS: Fix early CM probing")
Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: John Crispin <john@phrozen.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.5+
Patchwork: https://patchwork.linux-mips.org/patch/18859/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ralink/mt7621.c |   42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -170,6 +170,28 @@ void prom_soc_init(struct ralink_soc_inf
 	u32 n1;
 	u32 rev;
 
+	/* Early detection of CMP support */
+	mips_cm_probe();
+	mips_cpc_probe();
+
+	if (mips_cps_numiocu(0)) {
+		/*
+		 * mips_cm_probe() wipes out bootloader
+		 * config for CM regions and we have to configure them
+		 * again. This SoC cannot talk to pamlbus devices
+		 * witout proper iocu region set up.
+		 *
+		 * FIXME: it would be better to do this with values
+		 * from DT, but we need this very early because
+		 * without this we cannot talk to pretty much anything
+		 * including serial.
+		 */
+		write_gcr_reg0_base(MT7621_PALMBUS_BASE);
+		write_gcr_reg0_mask(~MT7621_PALMBUS_SIZE |
+				    CM_GCR_REGn_MASK_CMTGT_IOCU0);
+		__sync();
+	}
+
 	n0 = __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
 	n1 = __raw_readl(sysc + SYSC_REG_CHIP_NAME1);
 
@@ -194,26 +216,6 @@ void prom_soc_init(struct ralink_soc_inf
 
 	rt2880_pinmux_data = mt7621_pinmux_data;
 
-	/* Early detection of CMP support */
-	mips_cm_probe();
-	mips_cpc_probe();
-
-	if (mips_cps_numiocu(0)) {
-		/*
-		 * mips_cm_probe() wipes out bootloader
-		 * config for CM regions and we have to configure them
-		 * again. This SoC cannot talk to pamlbus devices
-		 * witout proper iocu region set up.
-		 *
-		 * FIXME: it would be better to do this with values
-		 * from DT, but we need this very early because
-		 * without this we cannot talk to pretty much anything
-		 * including serial.
-		 */
-		write_gcr_reg0_base(MT7621_PALMBUS_BASE);
-		write_gcr_reg0_mask(~MT7621_PALMBUS_SIZE |
-				    CM_GCR_REGn_MASK_CMTGT_IOCU0);
-	}
 
 	if (!register_cps_smp_ops())
 		return;
