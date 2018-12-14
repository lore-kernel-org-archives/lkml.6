Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21606C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7382133F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789832;
	bh=558fEEKum02KDM4sZQGV1x4OqqhxF+d7BQUE0gJx9p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mmf6u38DCEztAwFFi+DsIV364QrcYVA7GbOGvPaF0gKmm8qk9IVUoDXwNgH93Vfdu
	 zf+OVMtv4rjgF9JHB48tgzZVsNaMxonezDRcEbP6NiQNPjUqud9+SO0h9h64UJdcrG
	 a54XQO/QQb2xmk8zxxdgbQQ57H2jzbfdAS2XjV4Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7382133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbeLNMRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:17:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:37404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732864AbeLNMRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:17:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B236421479;
        Fri, 14 Dec 2018 12:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789827;
        bh=558fEEKum02KDM4sZQGV1x4OqqhxF+d7BQUE0gJx9p0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=raUpZoWVkkl9BQHHkAKxF+FpsNHoz4KukLLYnjXsv15UgiWCdzTR+uX+7zAZQ+wxl
         OjRt0Rhjec+pVFVNn18MSIkhoRgPKadecQ5vCk4zjn3qoEs0cHgInOanPmMsyudJYn
         Ux7tjPvZt5HkKQhprGV69W711OO7muy9Bww2rKVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.4 84/88] media: dvb-frontends: fix i2c access helpers for KASAN
Date:   Fri, 14 Dec 2018 13:00:58 +0100
Message-Id: <20181214115709.282928971@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 3cd890dbe2a4f14cc44c85bb6cf37e5e22d4dd0e upstream.

A typical code fragment was copied across many dvb-frontend drivers and
causes large stack frames when built with with CONFIG_KASAN on gcc-5/6/7:

drivers/media/dvb-frontends/cxd2841er.c:3225:1: error: the frame size of 3992 bytes is larger than 3072 bytes [-Werror=frame-larger-than=]
drivers/media/dvb-frontends/cxd2841er.c:3404:1: error: the frame size of 3136 bytes is larger than 3072 bytes [-Werror=frame-larger-than=]
drivers/media/dvb-frontends/stv0367.c:3143:1: error: the frame size of 4016 bytes is larger than 3072 bytes [-Werror=frame-larger-than=]
drivers/media/dvb-frontends/stv090x.c:3430:1: error: the frame size of 5312 bytes is larger than 3072 bytes [-Werror=frame-larger-than=]
drivers/media/dvb-frontends/stv090x.c:4248:1: error: the frame size of 4872 bytes is larger than 3072 bytes [-Werror=frame-larger-than=]

gcc-8 now solves this by consolidating the stack slots for the argument
variables, but on older compilers we can get the same behavior by taking
the pointer of a local variable rather than the inline function argument.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715

Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/dvb-frontends/ascot2e.c     |    4 +++-
 drivers/media/dvb-frontends/cxd2841er.c   |    4 +++-
 drivers/media/dvb-frontends/horus3a.c     |    4 +++-
 drivers/media/dvb-frontends/itd1000.c     |    5 +++--
 drivers/media/dvb-frontends/mt312.c       |    5 ++++-
 drivers/media/dvb-frontends/stb0899_drv.c |    3 ++-
 drivers/media/dvb-frontends/stb6100.c     |    6 ++++--
 drivers/media/dvb-frontends/stv0367.c     |    4 +++-
 drivers/media/dvb-frontends/stv090x.c     |    4 +++-
 drivers/media/dvb-frontends/stv6110x.c    |    4 +++-
 drivers/media/dvb-frontends/zl10039.c     |    4 +++-
 11 files changed, 34 insertions(+), 13 deletions(-)

--- a/drivers/media/dvb-frontends/ascot2e.c
+++ b/drivers/media/dvb-frontends/ascot2e.c
@@ -155,7 +155,9 @@ static int ascot2e_write_regs(struct asc
 
 static int ascot2e_write_reg(struct ascot2e_priv *priv, u8 reg, u8 val)
 {
-	return ascot2e_write_regs(priv, reg, &val, 1);
+	u8 tmp = val; /* see gcc.gnu.org/bugzilla/show_bug.cgi?id=81715 */
+
+	return ascot2e_write_regs(priv, reg, &tmp, 1);
 }
 
 static int ascot2e_read_regs(struct ascot2e_priv *priv,
--- a/drivers/media/dvb-frontends/cxd2841er.c
+++ b/drivers/media/dvb-frontends/cxd2841er.c
@@ -241,7 +241,9 @@ static int cxd2841er_write_regs(struct c
 static int cxd2841er_write_reg(struct cxd2841er_priv *priv,
 			       u8 addr, u8 reg, u8 val)
 {
-	return cxd2841er_write_regs(priv, addr, reg, &val, 1);
+	u8 tmp = val; /* see gcc.gnu.org/bugzilla/show_bug.cgi?id=81715 */
+
+	return cxd2841er_write_regs(priv, addr, reg, &tmp, 1);
 }
 
 static int cxd2841er_read_regs(struct cxd2841er_priv *priv,
--- a/drivers/media/dvb-frontends/horus3a.c
+++ b/drivers/media/dvb-frontends/horus3a.c
@@ -89,7 +89,9 @@ static int horus3a_write_regs(struct hor
 
 static int horus3a_write_reg(struct horus3a_priv *priv, u8 reg, u8 val)
 {
-	return horus3a_write_regs(priv, reg, &val, 1);
+	u8 tmp = val; /* see gcc.gnu.org/bugzilla/show_bug.cgi?id=81715 */
+
+	return horus3a_write_regs(priv, reg, &tmp, 1);
 }
 
 static int horus3a_enter_power_save(struct horus3a_priv *priv)
--- a/drivers/media/dvb-frontends/itd1000.c
+++ b/drivers/media/dvb-frontends/itd1000.c
@@ -99,8 +99,9 @@ static int itd1000_read_reg(struct itd10
 
 static inline int itd1000_write_reg(struct itd1000_state *state, u8 r, u8 v)
 {
-	int ret = itd1000_write_regs(state, r, &v, 1);
-	state->shadow[r] = v;
+	u8 tmp = v; /* see gcc.gnu.org/bugzilla/show_bug.cgi?id=81715 */
+	int ret = itd1000_write_regs(state, r, &tmp, 1);
+	state->shadow[r] = tmp;
 	return ret;
 }
 
--- a/drivers/media/dvb-frontends/mt312.c
+++ b/drivers/media/dvb-frontends/mt312.c
@@ -142,7 +142,10 @@ static inline int mt312_readreg(struct m
 static inline int mt312_writereg(struct mt312_state *state,
 				 const enum mt312_reg_addr reg, const u8 val)
 {
-	return mt312_write(state, reg, &val, 1);
+	u8 tmp = val; /* see gcc.gnu.org/bugzilla/show_bug.cgi?id=81715 */
+
+
+	return mt312_write(state, reg, &tmp, 1);
 }
 
 static inline u32 mt312_div(u32 a, u32 b)
--- a/drivers/media/dvb-frontends/stb0899_drv.c
+++ b/drivers/media/dvb-frontends/stb0899_drv.c
@@ -552,7 +552,8 @@ int stb0899_write_regs(struct stb0899_st
 
 int stb0899_write_reg(struct stb0899_state *state, unsigned int reg, u8 data)
 {
-	return stb0899_write_regs(state, reg, &data, 1);
+	u8 tmp = data;
+	return stb0899_write_regs(state, reg, &tmp, 1);
 }
 
 /*
--- a/drivers/media/dvb-frontends/stb6100.c
+++ b/drivers/media/dvb-frontends/stb6100.c
@@ -226,12 +226,14 @@ static int stb6100_write_reg_range(struc
 
 static int stb6100_write_reg(struct stb6100_state *state, u8 reg, u8 data)
 {
+	u8 tmp = data; /* see gcc.gnu.org/bugzilla/show_bug.cgi?id=81715 */
+
 	if (unlikely(reg >= STB6100_NUMREGS)) {
 		dprintk(verbose, FE_ERROR, 1, "Invalid register offset 0x%x", reg);
 		return -EREMOTEIO;
 	}
-	data = (data & stb6100_template[reg].mask) | stb6100_template[reg].set;
-	return stb6100_write_reg_range(state, &data, reg, 1);
+	tmp = (tmp & stb6100_template[reg].mask) | stb6100_template[reg].set;
+	return stb6100_write_reg_range(state, &tmp, reg, 1);
 }
 
 
--- a/drivers/media/dvb-frontends/stv0367.c
+++ b/drivers/media/dvb-frontends/stv0367.c
@@ -804,7 +804,9 @@ int stv0367_writeregs(struct stv0367_sta
 
 static int stv0367_writereg(struct stv0367_state *state, u16 reg, u8 data)
 {
-	return stv0367_writeregs(state, reg, &data, 1);
+	u8 tmp = data; /* see gcc.gnu.org/bugzilla/show_bug.cgi?id=81715 */
+
+	return stv0367_writeregs(state, reg, &tmp, 1);
 }
 
 static u8 stv0367_readreg(struct stv0367_state *state, u16 reg)
--- a/drivers/media/dvb-frontends/stv090x.c
+++ b/drivers/media/dvb-frontends/stv090x.c
@@ -761,7 +761,9 @@ static int stv090x_write_regs(struct stv
 
 static int stv090x_write_reg(struct stv090x_state *state, unsigned int reg, u8 data)
 {
-	return stv090x_write_regs(state, reg, &data, 1);
+	u8 tmp = data; /* see gcc.gnu.org/bugzilla/show_bug.cgi?id=81715 */
+
+	return stv090x_write_regs(state, reg, &tmp, 1);
 }
 
 static int stv090x_i2c_gate_ctrl(struct stv090x_state *state, int enable)
--- a/drivers/media/dvb-frontends/stv6110x.c
+++ b/drivers/media/dvb-frontends/stv6110x.c
@@ -97,7 +97,9 @@ static int stv6110x_write_regs(struct st
 
 static int stv6110x_write_reg(struct stv6110x_state *stv6110x, u8 reg, u8 data)
 {
-	return stv6110x_write_regs(stv6110x, reg, &data, 1);
+	u8 tmp = data; /* see gcc.gnu.org/bugzilla/show_bug.cgi?id=81715 */
+
+	return stv6110x_write_regs(stv6110x, reg, &tmp, 1);
 }
 
 static int stv6110x_init(struct dvb_frontend *fe)
--- a/drivers/media/dvb-frontends/zl10039.c
+++ b/drivers/media/dvb-frontends/zl10039.c
@@ -138,7 +138,9 @@ static inline int zl10039_writereg(struc
 				const enum zl10039_reg_addr reg,
 				const u8 val)
 {
-	return zl10039_write(state, reg, &val, 1);
+	const u8 tmp = val; /* see gcc.gnu.org/bugzilla/show_bug.cgi?id=81715 */
+
+	return zl10039_write(state, reg, &tmp, 1);
 }
 
 static int zl10039_init(struct dvb_frontend *fe)


