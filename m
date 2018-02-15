Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224b7GmiwNe0TF8i8Kfdm4tq3c/w42y22e7EwIUCXp79RONvYgaf0f+Yct0W32IkrPB3s2wv
ARC-Seal: i=1; a=rsa-sha256; t=1518708501; cv=none;
        d=google.com; s=arc-20160816;
        b=ZLAXp6v+5W+WknkvZFOGRdcPsaDHgqoV85dtlX9qvBzsIriXJ3ncry88qurbsTF7mW
         bZHKPXZ6Qy4ATiTJZM25g1P6zakdJw7BfDv1nofGyjpZ6UyTXbJVjnSUYZLVxQxB4EKa
         Wub9cDs8suqeHRu+VMbaK1jqEZMW6vmNiM6N6Bc/O5X5stywB72/QtRRq6MrLqInnzG5
         +/F4KsFFLLrPIzbR7W/2Yhe4IGq/srwTumonLvf4DfsdFSEUjdgAjnkmwoTVLghi/Mnn
         Ms2nk8h4vBdJ6vTI4F0mQl+EyPlbppV4L3n6NPRcpEHjC9X9VubAEqxwr1KyafDo5ZrQ
         jjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k+JPd6edUarjKrVbQX7U/WCccV98wLMymlxYH7Oi5I4=;
        b=vR0x4G9+TvucIzOvTO6tZWAVqxt/74moYjzH8HiDybrTVsjFlOE4rvOTRLmQYhaQyn
         N5LrttZ8isBR2oJEtuZ5bBNYV/7wlsqv00lGIpAexkX+xKDIbSoBmWdwI8CUdeOKkN9J
         XNmgawipdkiLre8Izb249VTDjzUFFD5gFVxt74lE+7m7fcTKd1Sr2O2wWQTIEUD6xxOI
         9FZu5CMawqYUXkdbUFjP89KZs+s9S5ShBAX0ynW3MEzsa1lXEuMcVWE0KF/dbBwHjyL6
         xuj+QHXxvmQFFOaqpp3TfxasvpkfaO1wAYgnDA+aicgLpOW7s+/0YZeqvv8jHwiALvoc
         gL/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.9 58/88] media: dvb-frontends: fix i2c access helpers for KASAN
Date: Thu, 15 Feb 2018 16:17:25 +0100
Message-Id: <20180215151230.716225612@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481285676804604?=
X-GMAIL-MSGID: =?utf-8?q?1592481285676804604?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/dvb-frontends/ascot2e.c     |    4 +++-
 drivers/media/dvb-frontends/cxd2841er.c   |    4 +++-
 drivers/media/dvb-frontends/helene.c      |    4 +++-
 drivers/media/dvb-frontends/horus3a.c     |    4 +++-
 drivers/media/dvb-frontends/itd1000.c     |    5 +++--
 drivers/media/dvb-frontends/mt312.c       |    5 ++++-
 drivers/media/dvb-frontends/stb0899_drv.c |    3 ++-
 drivers/media/dvb-frontends/stb6100.c     |    6 ++++--
 drivers/media/dvb-frontends/stv0367.c     |    4 +++-
 drivers/media/dvb-frontends/stv090x.c     |    4 +++-
 drivers/media/dvb-frontends/stv6110x.c    |    4 +++-
 drivers/media/dvb-frontends/zl10039.c     |    4 +++-
 12 files changed, 37 insertions(+), 14 deletions(-)

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
@@ -261,7 +261,9 @@ static int cxd2841er_write_regs(struct c
 static int cxd2841er_write_reg(struct cxd2841er_priv *priv,
 			       u8 addr, u8 reg, u8 val)
 {
-	return cxd2841er_write_regs(priv, addr, reg, &val, 1);
+	u8 tmp = val; /* see gcc.gnu.org/bugzilla/show_bug.cgi?id=81715 */
+
+	return cxd2841er_write_regs(priv, addr, reg, &tmp, 1);
 }
 
 static int cxd2841er_read_regs(struct cxd2841er_priv *priv,
--- a/drivers/media/dvb-frontends/helene.c
+++ b/drivers/media/dvb-frontends/helene.c
@@ -331,7 +331,9 @@ static int helene_write_regs(struct hele
 
 static int helene_write_reg(struct helene_priv *priv, u8 reg, u8 val)
 {
-	return helene_write_regs(priv, reg, &val, 1);
+	u8 tmp = val; /* see gcc.gnu.org/bugzilla/show_bug.cgi?id=81715 */
+
+	return helene_write_regs(priv, reg, &tmp, 1);
 }
 
 static int helene_read_regs(struct helene_priv *priv,
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
