Return-Path: <joeypabalinas@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521606874; cv=none;
        d=google.com; s=arc-20160816;
        b=NrJiV0cHOiGjkCMUL4IHObE70i+PVp/yZUsqJjrMQ7LORTD/3ReyPGGRhSOZ0tye5t
         fsWNHMsGn+2xZh37mLSZ47oPKOCCzW/ki0CUrp8nX16YWyDbvuTK/v2Rkk/hynUD5jTr
         OLHXS7tBUKk3Sjp4MRWR0VVNFwyfXPM9z53P8Ed/oVrDMiLT2No5reVfBdDf95UHq2yJ
         DJeTWTEmHGlIerr+KX1oxKsylLoJ8ExuQUgsB68KF4wf6B/ynh4WzgtmWS81xLANhrEu
         6rcJRO3a9g/Jh7E2y3Wv7xZcJuw+5EVdRP+YoFvxaiElQ8jCmAqVTch1xHvUCpTf94c5
         xYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=s5/uFu02S5PNzPQ1G43gaHDw58O2qtq3IuGC+iYf9BE=;
        b=Yr0OJZmjiPsID4OPZn7N84bu+ft9Yi/qn9wFKbXO17iu0NU+DgVntwGQQZFk/Du8ep
         qvH05tJySDEVZpGJJ2RFO2AQHU580Gmp/MRwuTtKvIHKk8DIkVMnmdu/vAUhFwQ2AoP6
         exo0hHyYzqQNGkMyiAsUTRWxy59hCtaRlGH6ofJFJm7W+VbtbtnYbIk0uX9FnyBhAuYz
         YhHSa0G4c8XArbAhx2WuKrnz3JkDDB0AhQzYiVMJRAKUMtYGC/75Qk9+KMiZi+4yYz5U
         MXLTaKiN4uln7iPr24vBIy1SimbhsSeCv9PY9fRBd7pDxsC2mCqEoITfPcwv9RyeuEjd
         3AYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Nc7Y5iHF;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Nc7Y5iHF;
       spf=pass (google.com: domain of joeypabalinas@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joeypabalinas@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuNju9phvrzzuSQjTnQJ6isGsag62IGkcpMNnKE2iNJQk5wV6Ci1KmTT79WnLArNxDZvp9Bfw==
Date: Tue, 20 Mar 2018 18:34:30 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Frank Seidel <fseidel@suse.de>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.cz>,
	Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH] tty/nozomi: refactor macros and functions
Message-ID: <20180321043430.lbvd4fpswl6cy2gq@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2qb2dkfdq5awvse7"
Content-Disposition: inline
User-Agent: NeoMutt/20180223
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520449932103210?=
X-GMAIL-MSGID: =?utf-8?q?1595520449932103210?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--2qb2dkfdq5awvse7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Cleanup a few messy sections of code by replacing constructs
like `len__ > TMP_BUF_MAX ? TMP_BUF_MAX : len__` with
`min_t(u32, len__, TMP_BUF_MAX)` and naming identifiers
more descriptively (where appropriate).

A few sections were nested pretty deeply and have been
replaced with shallower (but semantically equivalent) logic.

In addition, simplify and coalesce a few of the
return paths / loop conditionals and correct a few
pointless Initializations, redundant parentheses/break
statements, and inconsistently indented line.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 181 insertions(+), 181 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index b57b35066ebea94639..7b7474b8530d85e5d9 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -72,19 +72,19 @@ do {							\
=20
 #define TMP_BUF_MAX 256
=20
-#define DUMP(buf__,len__) \
-  do {  \
-    char tbuf[TMP_BUF_MAX] =3D {0};\
-    if (len__ > 1) {\
-	snprintf(tbuf, len__ > TMP_BUF_MAX ? TMP_BUF_MAX : len__, "%s", buf__);\
-	if (tbuf[len__-2] =3D=3D '\r') {\
-		tbuf[len__-2] =3D 'r';\
-	} \
-	DBG1("SENDING: '%s' (%d+n)", tbuf, len__);\
-    } else {\
-	DBG1("SENDING: '%s' (%d)", tbuf, len__);\
-    } \
-} while (0)
+#define DUMP(buf__, len__)						\
+	do {								\
+		char tbuf[TMP_BUF_MAX] =3D {0};				\
+		if (len__ > 1) {					\
+			u32 data_len =3D min_t(u32, len__, TMP_BUF_MAX);	\
+			strscpy(tbuf, buf__, data_len);			\
+			if (tbuf[data_len - 2] =3D=3D '\r')			\
+				tbuf[data_len - 2] =3D 'r';		\
+			DBG1("SENDING: '%s' (%d+n)", tbuf, len__);	\
+		} else {						\
+			DBG1("SENDING: '%s' (%d)", tbuf, len__);	\
+		}							\
+	} while (0)
=20
 /*    Defines */
 #define NOZOMI_NAME		"nozomi"
@@ -102,41 +102,41 @@ do {							\
 #define RECEIVE_BUF_MAX		4
=20
=20
-#define R_IIR		0x0000	/* Interrupt Identity Register */
-#define R_FCR		0x0000	/* Flow Control Register */
-#define R_IER		0x0004	/* Interrupt Enable Register */
+#define R_IIR			0x0000	/* Interrupt Identity Register */
+#define R_FCR			0x0000	/* Flow Control Register */
+#define R_IER			0x0004	/* Interrupt Enable Register */
=20
 #define NOZOMI_CONFIG_MAGIC	0xEFEFFEFE
 #define TOGGLE_VALID		0x0000
=20
 /* Definition of interrupt tokens */
-#define MDM_DL1		0x0001
-#define MDM_UL1		0x0002
-#define MDM_DL2		0x0004
-#define MDM_UL2		0x0008
-#define DIAG_DL1	0x0010
-#define DIAG_DL2	0x0020
-#define DIAG_UL		0x0040
-#define APP1_DL		0x0080
-#define APP1_UL		0x0100
-#define APP2_DL		0x0200
-#define APP2_UL		0x0400
-#define CTRL_DL		0x0800
-#define CTRL_UL		0x1000
-#define RESET		0x8000
+#define MDM_DL1			0x0001
+#define MDM_UL1			0x0002
+#define MDM_DL2			0x0004
+#define MDM_UL2			0x0008
+#define DIAG_DL1		0x0010
+#define DIAG_DL2		0x0020
+#define DIAG_UL			0x0040
+#define APP1_DL			0x0080
+#define APP1_UL			0x0100
+#define APP2_DL			0x0200
+#define APP2_UL			0x0400
+#define CTRL_DL			0x0800
+#define CTRL_UL			0x1000
+#define RESET			0x8000
=20
-#define MDM_DL		(MDM_DL1  | MDM_DL2)
-#define MDM_UL		(MDM_UL1  | MDM_UL2)
-#define DIAG_DL		(DIAG_DL1 | DIAG_DL2)
+#define MDM_DL			(MDM_DL1  | MDM_DL2)
+#define MDM_UL			(MDM_UL1  | MDM_UL2)
+#define DIAG_DL			(DIAG_DL1 | DIAG_DL2)
=20
 /* modem signal definition */
-#define CTRL_DSR	0x0001
-#define CTRL_DCD	0x0002
-#define CTRL_RI		0x0004
-#define CTRL_CTS	0x0008
+#define CTRL_DSR		0x0001
+#define CTRL_DCD		0x0002
+#define CTRL_RI			0x0004
+#define CTRL_CTS		0x0008
=20
-#define CTRL_DTR	0x0001
-#define CTRL_RTS	0x0002
+#define CTRL_DTR		0x0001
+#define CTRL_RTS		0x0002
=20
 #define MAX_PORT		4
 #define NOZOMI_MAX_PORTS	5
@@ -365,7 +365,7 @@ struct buffer {
 	u8 *data;
 } __attribute__ ((packed));
=20
-/*    Global variables */
+/* Global variables */
 static const struct pci_device_id nozomi_pci_tbl[] =3D {
 	{PCI_DEVICE(0x1931, 0x000c)},	/* Nozomi HSDPA */
 	{},
@@ -401,7 +401,7 @@ static inline struct port *get_port_by_tty(const struct=
 tty_struct *tty)
 static void read_mem32(u32 *buf, const void __iomem *mem_addr_start,
 			u32 size_bytes)
 {
-	u32 i =3D 0;
+	u32 nread =3D 0;
 	const u32 __iomem *ptr =3D mem_addr_start;
 	u16 *buf16;
=20
@@ -411,30 +411,27 @@ static void read_mem32(u32 *buf, const void __iomem *=
mem_addr_start,
 	/* shortcut for extremely often used cases */
 	switch (size_bytes) {
 	case 2:	/* 2 bytes */
-		buf16 =3D (u16 *) buf;
+		buf16 =3D (u16 *)buf;
 		*buf16 =3D __le16_to_cpu(readw(ptr));
 		goto out;
-		break;
 	case 4:	/* 4 bytes */
-		*(buf) =3D __le32_to_cpu(readl(ptr));
+		*buf =3D __le32_to_cpu(readl(ptr));
 		goto out;
-		break;
 	}
=20
-	while (i < size_bytes) {
-		if (size_bytes - i =3D=3D 2) {
+	for (; nread < size_bytes; buf++, ptr++) {
+		if (size_bytes - nread =3D=3D 2) {
 			/* Handle 2 bytes in the end */
-			buf16 =3D (u16 *) buf;
-			*(buf16) =3D __le16_to_cpu(readw(ptr));
-			i +=3D 2;
+			buf16 =3D (u16 *)buf;
+			*buf16 =3D __le16_to_cpu(readw(ptr));
+			nread +=3D 2;
 		} else {
 			/* Read 4 bytes */
-			*(buf) =3D __le32_to_cpu(readl(ptr));
-			i +=3D 4;
+			*buf =3D __le32_to_cpu(readl(ptr));
+			nread +=3D 4;
 		}
-		buf++;
-		ptr++;
 	}
+
 out:
 	return;
 }
@@ -447,7 +444,7 @@ static void read_mem32(u32 *buf, const void __iomem *me=
m_addr_start,
 static u32 write_mem32(void __iomem *mem_addr_start, const u32 *buf,
 			u32 size_bytes)
 {
-	u32 i =3D 0;
+	u32 nwritten =3D 0;
 	u32 __iomem *ptr =3D mem_addr_start;
 	const u16 *buf16;
=20
@@ -459,33 +456,33 @@ static u32 write_mem32(void __iomem *mem_addr_start, =
const u32 *buf,
 	case 2:	/* 2 bytes */
 		buf16 =3D (const u16 *)buf;
 		writew(__cpu_to_le16(*buf16), ptr);
-		return 2;
-		break;
+		nwritten =3D 2;
+		goto out;
 	case 1: /*
 		 * also needs to write 4 bytes in this case
 		 * so falling through..
 		 */
 	case 4: /* 4 bytes */
 		writel(__cpu_to_le32(*buf), ptr);
-		return 4;
-		break;
+		nwritten =3D 4;
+		goto out;
 	}
=20
-	while (i < size_bytes) {
-		if (size_bytes - i =3D=3D 2) {
+	for (; nwritten < size_bytes; buf++, ptr++) {
+		if (size_bytes - nwritten =3D=3D 2) {
 			/* 2 bytes */
 			buf16 =3D (const u16 *)buf;
 			writew(__cpu_to_le16(*buf16), ptr);
-			i +=3D 2;
+			nwritten +=3D 2;
 		} else {
 			/* 4 bytes */
 			writel(__cpu_to_le32(*buf), ptr);
-			i +=3D 4;
+			nwritten +=3D 4;
 		}
-		buf++;
-		ptr++;
 	}
-	return i;
+
+out:
+	return nwritten;
 }
=20
 /* Setup pointers to different channels and also setup buffer sizes. */
@@ -632,9 +629,10 @@ static int nozomi_read_config_table(struct nozomi *dc)
 		return 0;
 	}
=20
-	if ((dc->config_table.version =3D=3D 0)
-	    || (dc->config_table.toggle.enabled =3D=3D TOGGLE_VALID)) {
+	if (!dc->config_table.version
+			|| dc->config_table.toggle.enabled =3D=3D TOGGLE_VALID) {
 		int i;
+
 		DBG1("Second phase, configuring card");
=20
 		nozomi_setup_memory(dc);
@@ -659,12 +657,14 @@ static int nozomi_read_config_table(struct nozomi *dc)
=20
 		dc->state =3D NOZOMI_STATE_ALLOCATED;
 		dev_info(&dc->pdev->dev, "Initialization OK!\n");
+
 		return 1;
 	}
=20
-	if ((dc->config_table.version > 0)
-	    && (dc->config_table.toggle.enabled !=3D TOGGLE_VALID)) {
+	if (dc->config_table.version > 0
+			&& dc->config_table.toggle.enabled !=3D TOGGLE_VALID) {
 		u32 offset =3D 0;
+
 		DBG1("First phase: pushing upload buffers, clearing download");
=20
 		dev_info(&dc->pdev->dev, "Version of card: %d\n",
@@ -697,12 +697,13 @@ static void enable_transmit_ul(enum port_type port, s=
truct nozomi *dc)
 {
 	static const u16 mask[] =3D {MDM_UL, DIAG_UL, APP1_UL, APP2_UL, CTRL_UL};
=20
-	if (port < NOZOMI_MAX_PORTS) {
-		dc->last_ier |=3D mask[port];
-		writew(dc->last_ier, dc->reg_ier);
-	} else {
+	if (port >=3D NOZOMI_MAX_PORTS) {
 		dev_err(&dc->pdev->dev, "Called with wrong port?\n");
+		return;
 	}
+
+	dc->last_ier |=3D mask[port];
+	writew(dc->last_ier, dc->reg_ier);
 }
=20
 /* Disable uplink interrupts  */
@@ -711,12 +712,13 @@ static void disable_transmit_ul(enum port_type port, =
struct nozomi *dc)
 	static const u16 mask[] =3D
 		{~MDM_UL, ~DIAG_UL, ~APP1_UL, ~APP2_UL, ~CTRL_UL};
=20
-	if (port < NOZOMI_MAX_PORTS) {
-		dc->last_ier &=3D mask[port];
-		writew(dc->last_ier, dc->reg_ier);
-	} else {
+	if (port >=3D NOZOMI_MAX_PORTS) {
 		dev_err(&dc->pdev->dev, "Called with wrong port?\n");
+		return;
 	}
+
+	dc->last_ier &=3D mask[port];
+	writew(dc->last_ier, dc->reg_ier);
 }
=20
 /* Enable downlink interrupts */
@@ -724,12 +726,13 @@ static void enable_transmit_dl(enum port_type port, s=
truct nozomi *dc)
 {
 	static const u16 mask[] =3D {MDM_DL, DIAG_DL, APP1_DL, APP2_DL, CTRL_DL};
=20
-	if (port < NOZOMI_MAX_PORTS) {
-		dc->last_ier |=3D mask[port];
-		writew(dc->last_ier, dc->reg_ier);
-	} else {
+	if (port >=3D NOZOMI_MAX_PORTS) {
 		dev_err(&dc->pdev->dev, "Called with wrong port?\n");
+		return;
 	}
+
+	dc->last_ier |=3D mask[port];
+	writew(dc->last_ier, dc->reg_ier);
 }
=20
 /* Disable downlink interrupts */
@@ -738,12 +741,13 @@ static void disable_transmit_dl(enum port_type port, =
struct nozomi *dc)
 	static const u16 mask[] =3D
 		{~MDM_DL, ~DIAG_DL, ~APP1_DL, ~APP2_DL, ~CTRL_DL};
=20
-	if (port < NOZOMI_MAX_PORTS) {
-		dc->last_ier &=3D mask[port];
-		writew(dc->last_ier, dc->reg_ier);
-	} else {
+	if (port >=3D NOZOMI_MAX_PORTS) {
 		dev_err(&dc->pdev->dev, "Called with wrong port?\n");
+		return;
 	}
+
+	dc->last_ier &=3D mask[port];
+	writew(dc->last_ier, dc->reg_ier);
 }
=20
 /*
@@ -752,7 +756,7 @@ static void disable_transmit_dl(enum port_type port, st=
ruct nozomi *dc)
  */
 static int send_data(enum port_type index, struct nozomi *dc)
 {
-	u32 size =3D 0;
+	u32 size;
 	struct port *port =3D &dc->port[index];
 	const u8 toggle =3D port->toggle_ul;
 	void __iomem *addr =3D port->ul_addr[toggle];
@@ -762,7 +766,7 @@ static int send_data(enum port_type index, struct nozom=
i *dc)
 	size =3D kfifo_out(&port->fifo_ul, dc->send_buf,
 			   ul_size < SEND_BUF_MAX ? ul_size : SEND_BUF_MAX);
=20
-	if (size =3D=3D 0) {
+	if (!size) {
 		DBG4("No more data to send, disable link:");
 		return 0;
 	}
@@ -770,8 +774,8 @@ static int send_data(enum port_type index, struct nozom=
i *dc)
 	/* DUMP(buf, size); */
=20
 	/* Write length + data */
-	write_mem32(addr, (u32 *) &size, 4);
-	write_mem32(addr + 4, (u32 *) dc->send_buf, size);
+	write_mem32(addr, (u32 *)&size, 4);
+	write_mem32(addr + 4, (u32 *)dc->send_buf, size);
=20
 	tty_port_tty_wakeup(&port->port);
=20
@@ -781,13 +785,12 @@ static int send_data(enum port_type index, struct noz=
omi *dc)
 /* If all data has been read, return 1, else 0 */
 static int receive_data(enum port_type index, struct nozomi *dc)
 {
-	u8 buf[RECEIVE_BUF_MAX] =3D { 0 };
-	int size;
+	u8 buf[RECEIVE_BUF_MAX] =3D {0};
 	u32 offset =3D 4;
 	struct port *port =3D &dc->port[index];
 	void __iomem *addr =3D port->dl_addr[port->toggle_dl];
 	struct tty_struct *tty =3D tty_port_tty_get(&port->port);
-	int i, ret;
+	int size, ret, i;
=20
 	size =3D __le32_to_cpu(readl(addr));
 	/*  DBG1( "%d bytes port: %d", size, index); */
@@ -802,14 +805,14 @@ static int receive_data(enum port_type index, struct =
nozomi *dc)
 		goto put;
 	}
=20
-	if (unlikely(size =3D=3D 0)) {
+	if (unlikely(!size)) {
 		dev_err(&dc->pdev->dev, "size =3D=3D 0?\n");
 		ret =3D 1;
 		goto put;
 	}
=20
 	while (size > 0) {
-		read_mem32((u32 *) buf, addr + offset, RECEIVE_BUF_MAX);
+		read_mem32((u32 *)buf, addr + offset, RECEIVE_BUF_MAX);
=20
 		if (size =3D=3D 1) {
 			tty_insert_flip_char(&port->port, buf[0], TTY_NORMAL);
@@ -937,9 +940,7 @@ static int receive_flow_control(struct nozomi *dc)
 		DBG1("Disable interrupt (0x%04X) on port: %d",
 			enable_ier, port);
 		disable_transmit_ul(port, dc);
-
 	} else if (old_ctrl.CTS =3D=3D 0 && ctrl_dl.CTS =3D=3D 1) {
-
 		if (kfifo_len(&dc->port[port].fifo_ul)) {
 			DBG1("Enable interrupt (0x%04X) on port: %d",
 				enable_ier, port);
@@ -989,7 +990,7 @@ static enum ctrl_port_type port2ctrl(enum port_type por=
t,
 		return CTRL_APP2;
 	default:
 		dev_err(&dc->pdev->dev,
-			"ERROR: send flow control " \
+			"ERROR: send flow control "
 			"received for non-existing port\n");
 	}
 	return CTRL_ERROR;
@@ -1002,23 +1003,25 @@ static enum ctrl_port_type port2ctrl(enum port_type=
 port,
  */
 static int send_flow_control(struct nozomi *dc)
 {
-	u32 i, more_flow_control_to_be_updated =3D 0;
+	u32 more_flow_control_to_be_updated =3D 0;
+	u32 i;
 	u16 *ctrl;
=20
 	for (i =3D PORT_MDM; i < MAX_PORT; i++) {
 		if (dc->port[i].update_flow_control) {
-			if (more_flow_control_to_be_updated) {
-				/* We have more flow control to be updated */
+			/* We have more flow control to be updated */
+			if (more_flow_control_to_be_updated)
 				return 1;
-			}
+
 			dc->port[i].ctrl_ul.port =3D port2ctrl(i, dc);
 			ctrl =3D (u16 *)&dc->port[i].ctrl_ul;
-			write_mem32(dc->port[PORT_CTRL].ul_addr[0], \
-				(u32 *) ctrl, 2);
+			write_mem32(dc->port[PORT_CTRL].ul_addr[0],
+					(u32 *)ctrl, 2);
 			dc->port[i].update_flow_control =3D 0;
 			more_flow_control_to_be_updated =3D 1;
 		}
 	}
+
 	return 0;
 }
=20
@@ -1033,33 +1036,31 @@ static int handle_data_dl(struct nozomi *dc, enum p=
ort_type port, u8 *toggle,
 	if (*toggle =3D=3D 0 && read_iir & mask1) {
 		if (receive_data(port, dc)) {
 			writew(mask1, dc->reg_fcr);
-			*toggle =3D !(*toggle);
+			*toggle =3D !*toggle;
 		}
=20
-		if (read_iir & mask2) {
-			if (receive_data(port, dc)) {
-				writew(mask2, dc->reg_fcr);
-				*toggle =3D !(*toggle);
-			}
+		if (read_iir & mask2 && receive_data(port, dc)) {
+			writew(mask2, dc->reg_fcr);
+			*toggle =3D !*toggle;
 		}
+
+		return 1;
 	} else if (*toggle =3D=3D 1 && read_iir & mask2) {
 		if (receive_data(port, dc)) {
 			writew(mask2, dc->reg_fcr);
 			*toggle =3D !(*toggle);
 		}
=20
-		if (read_iir & mask1) {
-			if (receive_data(port, dc)) {
-				writew(mask1, dc->reg_fcr);
-				*toggle =3D !(*toggle);
-			}
+		if (read_iir & mask1 && receive_data(port, dc)) {
+			writew(mask1, dc->reg_fcr);
+			*toggle =3D !*toggle;
 		}
-	} else {
-		dev_err(&dc->pdev->dev, "port out of sync!, toggle:%d\n",
-			*toggle);
-		return 0;
+
+		return 1;
 	}
-	return 1;
+
+	dev_err(&dc->pdev->dev, "port out of sync!, toggle:%d\n", *toggle);
+	return 0;
 }
=20
 /*
@@ -1069,7 +1070,7 @@ static int handle_data_dl(struct nozomi *dc, enum por=
t_type port, u8 *toggle,
  */
 static int handle_data_ul(struct nozomi *dc, enum port_type port, u16 read=
_iir)
 {
-	u8 *toggle =3D &(dc->port[port].toggle_ul);
+	u8 *toggle =3D &dc->port[port].toggle_ul;
=20
 	if (*toggle =3D=3D 0 && read_iir & MDM_UL1) {
 		dc->last_ier &=3D ~MDM_UL;
@@ -1092,6 +1093,7 @@ static int handle_data_ul(struct nozomi *dc, enum por=
t_type port, u16 read_iir)
 			}
 		}
=20
+		return 1;
 	} else if (*toggle =3D=3D 1 && read_iir & MDM_UL2) {
 		dc->last_ier &=3D ~MDM_UL;
 		writew(dc->last_ier, dc->reg_ier);
@@ -1112,22 +1114,23 @@ static int handle_data_ul(struct nozomi *dc, enum p=
ort_type port, u16 read_iir)
 				*toggle =3D !*toggle;
 			}
 		}
-	} else {
-		writew(read_iir & MDM_UL, dc->reg_fcr);
-		dev_err(&dc->pdev->dev, "port out of sync!\n");
-		return 0;
+
+		return 1;
 	}
-	return 1;
+
+	writew(read_iir & MDM_UL, dc->reg_fcr);
+	dev_err(&dc->pdev->dev, "port out of sync!\n");
+	return 0;
 }
=20
 static irqreturn_t interrupt_handler(int irq, void *dev_id)
 {
 	struct nozomi *dc =3D dev_id;
-	unsigned int a;
 	u16 read_iir;
+	int i;
=20
-	if (!dc)
-		return IRQ_NONE;
+	if (unlikely(!dc))
+		goto no_id;
=20
 	spin_lock(&dc->spin_mutex);
 	read_iir =3D readw(dc->reg_iir);
@@ -1141,10 +1144,9 @@ static irqreturn_t interrupt_handler(int irq, void *=
dev_id)
 	 */
 	read_iir &=3D dc->last_ier;
=20
-	if (read_iir =3D=3D 0)
+	if (!read_iir)
 		goto none;
=20
-
 	DBG4("%s irq:0x%04X, prev:0x%04X", interrupt2str(read_iir), read_iir,
 		dc->last_ier);
=20
@@ -1235,20 +1237,21 @@ static irqreturn_t interrupt_handler(int irq, void =
*dev_id)
 exit_handler:
 	spin_unlock(&dc->spin_mutex);
=20
-	for (a =3D 0; a < NOZOMI_MAX_PORTS; a++)
-		if (test_and_clear_bit(a, &dc->flip))
-			tty_flip_buffer_push(&dc->port[a].port);
+	for (i =3D 0; i < NOZOMI_MAX_PORTS; i++)
+		if (test_and_clear_bit(i, &dc->flip))
+			tty_flip_buffer_push(&dc->port[i].port);
=20
 	return IRQ_HANDLED;
 none:
 	spin_unlock(&dc->spin_mutex);
+no_id:
 	return IRQ_NONE;
 }
=20
 static void nozomi_get_card_type(struct nozomi *dc)
 {
-	int i;
 	u32 size =3D 0;
+	int i;
=20
 	for (i =3D 0; i < 6; i++)
 		size +=3D pci_resource_len(dc->pdev, i);
@@ -1262,7 +1265,7 @@ static void nozomi_get_card_type(struct nozomi *dc)
 static void nozomi_setup_private_data(struct nozomi *dc)
 {
 	void __iomem *offset =3D dc->base_addr + dc->card_type / 2;
-	unsigned int i;
+	int i;
=20
 	dc->reg_fcr =3D (void __iomem *)(offset + R_FCR);
 	dc->reg_iir =3D (void __iomem *)(offset + R_IIR);
@@ -1318,10 +1321,8 @@ static int nozomi_card_init(struct pci_dev *pdev,
 				      const struct pci_device_id *ent)
 {
 	resource_size_t start;
-	int ret;
-	struct nozomi *dc =3D NULL;
-	int ndev_idx;
-	int i;
+	struct nozomi *dc;
+	int ndev_idx, ret, i;
=20
 	dev_dbg(&pdev->dev, "Init, new card found\n");
=20
@@ -1352,8 +1353,8 @@ static int nozomi_card_init(struct pci_dev *pdev,
=20
 	ret =3D pci_request_regions(dc->pdev, NOZOMI_NAME);
 	if (ret) {
-		dev_err(&pdev->dev, "I/O address 0x%04x already in use\n",
-			(int) /* nozomi_private.io_addr */ 0);
+		/* nozomi_private.io_addr */
+		dev_err(&pdev->dev, "I/O address 0x%04x already in use\n", 0);
 		goto err_disable_device;
 	}
=20
@@ -1429,19 +1430,18 @@ static int nozomi_card_init(struct pci_dev *pdev,
 		port->port.ops =3D &noz_tty_port_ops;
 		tty_dev =3D tty_port_register_device(&port->port, ntty_driver,
 				dc->index_start + i, &pdev->dev);
+		if (likely(!IS_ERR(tty_dev)))
+			continue;
=20
-		if (IS_ERR(tty_dev)) {
-			ret =3D PTR_ERR(tty_dev);
-			dev_err(&pdev->dev, "Could not allocate tty?\n");
-			tty_port_destroy(&port->port);
-			goto err_free_tty;
-		}
+		ret =3D PTR_ERR(tty_dev);
+		dev_err(&pdev->dev, "Could not allocate tty?\n");
+		tty_port_destroy(&port->port);
+		goto err_free_tty;
 	}
=20
 	return 0;
-
 err_free_tty:
-	for (i =3D 0; i < MAX_PORT; ++i) {
+	for (i =3D 0; i < MAX_PORT; i++) {
 		tty_unregister_device(ntty_driver, dc->index_start + i);
 		tty_port_destroy(&dc->port[i].port);
 	}
@@ -1463,18 +1463,19 @@ static int nozomi_card_init(struct pci_dev *pdev,
=20
 static void tty_exit(struct nozomi *dc)
 {
-	unsigned int i;
+	int i;
=20
 	DBG1(" ");
=20
-	for (i =3D 0; i < MAX_PORT; ++i)
+	for (i =3D 0; i < MAX_PORT; i++)
 		tty_port_tty_hangup(&dc->port[i].port, false);
=20
 	/* Racy below - surely should wait for scheduled work to be done or
 	   complete off a hangup method ? */
 	while (dc->open_ttys)
 		msleep(1);
-	for (i =3D 0; i < MAX_PORT; ++i) {
+
+	for (i =3D 0; i < MAX_PORT; i++) {
 		tty_unregister_device(ntty_driver, dc->index_start + i);
 		tty_port_destroy(&dc->port[i].port);
 	}
@@ -1483,9 +1484,9 @@ static void tty_exit(struct nozomi *dc)
 /* Deallocate memory for one device */
 static void nozomi_card_exit(struct pci_dev *pdev)
 {
-	int i;
-	struct ctrl_ul ctrl;
 	struct nozomi *dc =3D pci_get_drvdata(pdev);
+	struct ctrl_ul ctrl;
+	int i;
=20
 	/* Disable all interrupts */
 	dc->last_ier =3D 0;
@@ -1559,7 +1560,7 @@ static int ntty_install(struct tty_driver *driver, st=
ruct tty_struct *tty)
 	if (!port || !dc || dc->state !=3D NOZOMI_STATE_READY)
 		return -ENODEV;
 	ret =3D tty_standard_install(driver, tty);
-	if (ret =3D=3D 0)
+	if (!ret)
 		tty->driver_data =3D port;
 	return ret;
 }
@@ -1599,7 +1600,7 @@ static void ntty_shutdown(struct tty_port *tport)
=20
 	DBG1("close: %d", port->token_dl);
 	spin_lock_irqsave(&dc->spin_mutex, flags);
-	dc->last_ier &=3D ~(port->token_dl);
+	dc->last_ier &=3D ~port->token_dl;
 	writew(dc->last_ier, dc->reg_ier);
 	dc->open_ttys--;
 	spin_unlock_irqrestore(&dc->spin_mutex, flags);
@@ -1626,21 +1627,23 @@ static void ntty_hangup(struct tty_struct *tty)
 static int ntty_write(struct tty_struct *tty, const unsigned char *buffer,
 		      int count)
 {
-	int rval =3D -EINVAL;
 	struct nozomi *dc =3D get_dc_by_tty(tty);
 	struct port *port =3D tty->driver_data;
 	unsigned long flags;
+	int rval;
=20
 	/* DBG1( "WRITEx: %d, index =3D %d", count, index); */
=20
-	if (!dc || !port)
-		return -ENODEV;
+	if (unlikely(!dc || !port)) {
+		rval =3D -ENODEV;
+		goto out;
+	}
=20
 	rval =3D kfifo_in(&port->fifo_ul, (unsigned char *)buffer, count);
=20
 	spin_lock_irqsave(&dc->spin_mutex, flags);
 	/* CTS is only valid on the modem channel */
-	if (port =3D=3D &(dc->port[PORT_MDM])) {
+	if (port =3D=3D &dc->port[PORT_MDM]) {
 		if (port->ctrl_dl.CTS) {
 			DBG4("Enable interrupt");
 			enable_transmit_ul(tty->index % MAX_PORT, dc);
@@ -1653,6 +1656,7 @@ static int ntty_write(struct tty_struct *tty, const u=
nsigned char *buffer,
 	}
 	spin_unlock_irqrestore(&dc->spin_mutex, flags);
=20
+out:
 	return rval;
 }
=20
@@ -1722,11 +1726,10 @@ static int ntty_cflags_changed(struct port *port, u=
nsigned long flags,
 	const struct async_icount cnow =3D port->tty_icount;
 	int ret;
=20
-	ret =3D	((flags & TIOCM_RNG) && (cnow.rng !=3D cprev->rng)) ||
-		((flags & TIOCM_DSR) && (cnow.dsr !=3D cprev->dsr)) ||
-		((flags & TIOCM_CD)  && (cnow.dcd !=3D cprev->dcd)) ||
-		((flags & TIOCM_CTS) && (cnow.cts !=3D cprev->cts));
-
+	ret =3D	((flags & TIOCM_RNG) && (cnow.rng !=3D cprev->rng))
+		|| ((flags & TIOCM_DSR) && (cnow.dsr !=3D cprev->dsr))
+		|| ((flags & TIOCM_CD)  && (cnow.dcd !=3D cprev->dcd))
+		|| ((flags & TIOCM_CTS) && (cnow.cts !=3D cprev->cts));
 	*cprev =3D cnow;
=20
 	return ret;
@@ -1749,6 +1752,7 @@ static int ntty_tiocgicount(struct tty_struct *tty,
 	icount->parity =3D cnow.parity;
 	icount->brk =3D cnow.brk;
 	icount->buf_overrun =3D cnow.buf_overrun;
+
 	return 0;
 }
=20
@@ -1760,19 +1764,14 @@ static int ntty_ioctl(struct tty_struct *tty,
=20
 	DBG1("******** IOCTL, cmd: %d", cmd);
=20
-	switch (cmd) {
-	case TIOCMIWAIT: {
-		struct async_icount cprev =3D port->tty_icount;
-
-		rval =3D wait_event_interruptible(port->tty_wait,
-				ntty_cflags_changed(port, arg, &cprev));
-		break;
-	}
-	default:
+	if (cmd !=3D TIOCMIWAIT) {
 		DBG1("ERR: 0x%08X, %d", cmd, cmd);
-		break;
+		goto out;
 	}
=20
+	rval =3D wait_event_interruptible(port->tty_wait,
+			ntty_cflags_changed(port, arg, &port->tty_icount));
+out:
 	return rval;
 }
=20
@@ -1815,12 +1814,10 @@ static s32 ntty_chars_in_buffer(struct tty_struct *=
tty)
 	struct nozomi *dc =3D get_dc_by_tty(tty);
 	s32 rval =3D 0;
=20
-	if (unlikely(!dc || !port)) {
+	if (unlikely(!dc || !port))
 		goto exit_in_buffer;
-	}
=20
 	rval =3D kfifo_len(&port->fifo_ul);
-
 exit_in_buffer:
 	return rval;
 }
@@ -1862,8 +1859,10 @@ static __init int nozomi_init(void)
 	printk(KERN_INFO "Initializing %s\n", VERSION_STRING);
=20
 	ntty_driver =3D alloc_tty_driver(NTTY_TTY_MAXMINORS);
-	if (!ntty_driver)
-		return -ENOMEM;
+	if (!ntty_driver) {
+		ret =3D -ENOMEM;
+		goto no_mem;
+	}
=20
 	ntty_driver->driver_name =3D NOZOMI_NAME_TTY;
 	ntty_driver->name =3D "noz";
@@ -1895,6 +1894,7 @@ static __init int nozomi_init(void)
 	tty_unregister_driver(ntty_driver);
 free_tty:
 	put_tty_driver(ntty_driver);
+no_mem:
 	return ret;
 }
=20
--=20
2.16.2

--2qb2dkfdq5awvse7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlqx4NUACgkQruvLfWhy
VBn+ChAAuT1wUwoIeHj5MrIDwsd966sTQ06gvbbMnJMWcmX8wW1a+99YkYd0FH6N
Aqe2K10X0ON9AO+Iy87/0FC9/EOcpMcNm6CbYp/d4llwnsiS/OV5IuNQwL7D48eD
X8cN1CgZVHqoYIYmgIPElKWAaAqbOXyKicH3Cr4/tb/gaw4L91OQUvsyga5adVpI
/HEp58di+RhR0cvmHH7UP2CnXLoxqr0vF/04pF4Caz18XCrtfmmOYTjvxK+SJ/XX
/76xlaVhajc2bPuWmtOa0yHyprIu0vmAFYuR6MO5E9UZCW4zHYxF57GWKcMoh/Cy
cimA/s83/X6K7VSzicVLpsuYme4MVGxwgJCZeFfyH58u5LGafj5TnHx8gUzhDpp6
xxVVG0COzDxClxt655sZF59N45yxIGG5hPd9nTqrec7MYcSNBaNpCNUYZSX/H99f
cdD278/fIHfWf0W4bOkIjWP984NrF42r3154k6FTKXUIuV3SD+mwUDXam1X7iUwO
7qu4b0DDcX5mRyUigrEux+Wjvz4IeSdUEbEKTxfekJgp1o09lDjqtUo6trF+zdJ+
gNidYREuobJ9y+6seWaT56vrb/T+GVpXDkgugpssmhgweSi4JmfT8T5FK9P9ytSR
vF3Yg2dcS4iSqgO7eLAY7ffEQaPlVlR6QrdZdzl5VMIYI1YuJ3w=
=lyDY
-----END PGP SIGNATURE-----

--2qb2dkfdq5awvse7--
