Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBF2C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 19:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366422086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 19:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MDq2tzgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366422086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755621AbeFQTHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 15:07:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53836 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754049AbeFQTHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 15:07:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 056DBFC13A;
        Sun, 17 Jun 2018 15:07:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gYnnEYNhXXOY
        c/dhDYQ0CEf0XAk=; b=MDq2tzgRfYImV/AVUB7ZRmsp82hVNmOdlv9HMqCcaC9F
        VK9Ualr7M0cIWlXNdXDAszrB6NGLyo+L8+Erldc0l6qXjObeK/pSOPt4OLHgIRpE
        unGZO15onvOdw5NyApjwKd9HzcaiFGjORLpc85RVtxSo5dzY3nvgJyypjIX5Lpc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED91CFC139;
        Sun, 17 Jun 2018 15:07:09 -0400 (EDT)
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 773B5FC131;
        Sun, 17 Jun 2018 15:07:09 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTP id AEA332DA063B;
        Sun, 17 Jun 2018 15:07:08 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] vt: introduce unicode mode for /dev/vcs
Date:   Sun, 17 Jun 2018 15:07:04 -0400
Message-Id: <20180617190706.14614-3-nicolas.pitre@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617190706.14614-1-nicolas.pitre@linaro.org>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: A24B4672-7261-11E8-B727-44CE1968708C-78420484!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the core vt code knows how to preserve unicode values for each
displayed character, it is then possible to let user space access it via
/dev/vcs*.

Unicode characters are presented as 32 bit values in native endianity
via the /dev/vcsu* devices, mimicking the simple /dev/vcs* devices.
Unicode with attributes (similarly to /dev/vcsa*) is not supported at
the moment.

Data is available only as long as the console is in UTF-8 mode. ENODATA
is returned otherwise.

This was tested with the latest development version (to become
version 5.7) of BRLTTY. Amongst other things, this allows =E2=A0=8B=E2=A0=
=95=E2=A0=97 =E2=A0=9E=E2=A0=93=E2=A0=8A=E2=A0=8E
=E2=A0=83=E2=A0=97=E2=A0=81=E2=A0=8A=E2=A0=87=E2=A0=87=E2=A0=91=E2=A0=80=E2=
=A0=9E=E2=A0=91=E2=A0=AD=E2=A0=9E=E2=A0=80to appear directly on braille d=
isplays regardless of the
console font being used.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Tested-by: Dave Mielke <Dave@mielke.cc>
---
 drivers/tty/vt/vc_screen.c | 89 ++++++++++++++++++++++++++++++++------
 drivers/tty/vt/vt.c        | 61 ++++++++++++++++++++++++++
 include/linux/selection.h  |  5 +++
 3 files changed, 141 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index e4a66e1fd0..9c44252e52 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -10,6 +10,12 @@
  *	Attribute/character pair is in native endianity.
  *            [minor: N+128]
  *
+ * /dev/vcsuN: similar to /dev/vcsaN but using 4-byte unicode values
+ *	instead of 1-byte screen glyph values.
+ *            [minor: N+64]
+ *
+ * /dev/vcsuaN: same idea as /dev/vcsaN for unicode (not yet implemented=
).
+ *
  * This replaces screendump and part of selection, so that the system
  * administrator can control access using file system permissions.
  *
@@ -51,6 +57,26 @@
=20
 #define CON_BUF_SIZE (CONFIG_BASE_SMALL ? 256 : PAGE_SIZE)
=20
+/*
+ * Our minor space:
+ *
+ *   0 ... 63	glyph mode without attributes
+ *  64 ... 127	unicode mode without attributes
+ * 128 ... 191	glyph mode with attributes
+ * 192 ... 255	unused (reserved for unicode with attributes)
+ *
+ * This relies on MAX_NR_CONSOLES being  <=3D 63, meaning 63 actual cons=
oles
+ * with minors 0, 64, 128 and 192 being proxies for the foreground conso=
le.
+ */
+#if MAX_NR_CONSOLES > 63
+#warning "/dev/vcs* devices may not accommodate more than 63 consoles"
+#endif
+
+#define console(inode)		(iminor(inode) & 63)
+#define use_unicode(inode)	(iminor(inode) & 64)
+#define use_attributes(inode)	(iminor(inode) & 128)
+
+
 struct vcs_poll_data {
 	struct notifier_block notifier;
 	unsigned int cons_num;
@@ -102,7 +128,7 @@ vcs_poll_data_get(struct file *file)
 	poll =3D kzalloc(sizeof(*poll), GFP_KERNEL);
 	if (!poll)
 		return NULL;
-	poll->cons_num =3D iminor(file_inode(file)) & 127;
+	poll->cons_num =3D console(file_inode(file));
 	init_waitqueue_head(&poll->waitq);
 	poll->notifier.notifier_call =3D vcs_notifier;
 	if (register_vt_notifier(&poll->notifier) !=3D 0) {
@@ -140,7 +166,7 @@ vcs_poll_data_get(struct file *file)
 static struct vc_data*
 vcs_vc(struct inode *inode, int *viewed)
 {
-	unsigned int currcons =3D iminor(inode) & 127;
+	unsigned int currcons =3D console(inode);
=20
 	WARN_CONSOLE_UNLOCKED();
=20
@@ -164,7 +190,6 @@ static int
 vcs_size(struct inode *inode)
 {
 	int size;
-	int minor =3D iminor(inode);
 	struct vc_data *vc;
=20
 	WARN_CONSOLE_UNLOCKED();
@@ -175,8 +200,12 @@ vcs_size(struct inode *inode)
=20
 	size =3D vc->vc_rows * vc->vc_cols;
=20
-	if (minor & 128)
+	if (use_attributes(inode)) {
+		if (use_unicode(inode))
+			return -EOPNOTSUPP;
 		size =3D 2*size + HEADER_SIZE;
+	} else if (use_unicode(inode))
+		size *=3D 4;
 	return size;
 }
=20
@@ -197,12 +226,10 @@ static ssize_t
 vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos=
)
 {
 	struct inode *inode =3D file_inode(file);
-	unsigned int currcons =3D iminor(inode);
 	struct vc_data *vc;
 	struct vcs_poll_data *poll;
-	long pos;
-	long attr, read;
-	int col, maxcol, viewed;
+	long pos, read;
+	int attr, uni_mode, row, col, maxcol, viewed;
 	unsigned short *org =3D NULL;
 	ssize_t ret;
 	char *con_buf;
@@ -218,7 +245,8 @@ vcs_read(struct file *file, char __user *buf, size_t =
count, loff_t *ppos)
 	 */
 	console_lock();
=20
-	attr =3D (currcons & 128);
+	uni_mode =3D use_unicode(inode);
+	attr =3D use_attributes(inode);
 	ret =3D -ENXIO;
 	vc =3D vcs_vc(inode, &viewed);
 	if (!vc)
@@ -227,6 +255,10 @@ vcs_read(struct file *file, char __user *buf, size_t=
 count, loff_t *ppos)
 	ret =3D -EINVAL;
 	if (pos < 0)
 		goto unlock_out;
+	/* we enforce 32-bit alignment for pos and count in unicode mode */
+	if (uni_mode && (pos | count) & 3)
+		goto unlock_out;
+
 	poll =3D file->private_data;
 	if (count && poll)
 		poll->seen_last_update =3D true;
@@ -266,7 +298,27 @@ vcs_read(struct file *file, char __user *buf, size_t=
 count, loff_t *ppos)
 		con_buf_start =3D con_buf0 =3D con_buf;
 		orig_count =3D this_round;
 		maxcol =3D vc->vc_cols;
-		if (!attr) {
+		if (uni_mode) {
+			unsigned int nr;
+
+			ret =3D vc_uniscr_check(vc);
+			if (ret)
+				break;
+			p /=3D 4;
+			row =3D p / vc->vc_cols;
+			col =3D p % maxcol;
+			nr =3D maxcol - col;
+			do {
+				if (nr > this_round/4)
+					nr =3D this_round/4;
+				vc_uniscr_copy_line(vc, con_buf0, row, col, nr);
+				con_buf0 +=3D nr * 4;
+				this_round -=3D nr * 4;
+				row++;
+				col =3D 0;
+				nr =3D maxcol;
+			} while (this_round);
+		} else if (!attr) {
 			org =3D screen_pos(vc, p, viewed);
 			col =3D p % maxcol;
 			p +=3D maxcol - col;
@@ -375,7 +427,6 @@ static ssize_t
 vcs_write(struct file *file, const char __user *buf, size_t count, loff_=
t *ppos)
 {
 	struct inode *inode =3D file_inode(file);
-	unsigned int currcons =3D iminor(inode);
 	struct vc_data *vc;
 	long pos;
 	long attr, size, written;
@@ -396,7 +447,7 @@ vcs_write(struct file *file, const char __user *buf, =
size_t count, loff_t *ppos)
 	 */
 	console_lock();
=20
-	attr =3D (currcons & 128);
+	attr =3D use_attributes(inode);
 	ret =3D -ENXIO;
 	vc =3D vcs_vc(inode, &viewed);
 	if (!vc)
@@ -593,9 +644,15 @@ vcs_fasync(int fd, struct file *file, int on)
 static int
 vcs_open(struct inode *inode, struct file *filp)
 {
-	unsigned int currcons =3D iminor(inode) & 127;
+	unsigned int currcons =3D console(inode);
+	bool attr =3D use_attributes(inode);
+	bool uni_mode =3D use_unicode(inode);
 	int ret =3D 0;
-=09
+
+	/* we currently don't support attributes in unicode mode */
+	if (attr && uni_mode)
+		return -EOPNOTSUPP;
+
 	console_lock();
 	if(currcons && !vc_cons_allocated(currcons-1))
 		ret =3D -ENXIO;
@@ -628,6 +685,8 @@ void vcs_make_sysfs(int index)
 {
 	device_create(vc_class, NULL, MKDEV(VCS_MAJOR, index + 1), NULL,
 		      "vcs%u", index + 1);
+	device_create(vc_class, NULL, MKDEV(VCS_MAJOR, index + 65), NULL,
+		      "vcsu%u", index + 1);
 	device_create(vc_class, NULL, MKDEV(VCS_MAJOR, index + 129), NULL,
 		      "vcsa%u", index + 1);
 }
@@ -635,6 +694,7 @@ void vcs_make_sysfs(int index)
 void vcs_remove_sysfs(int index)
 {
 	device_destroy(vc_class, MKDEV(VCS_MAJOR, index + 1));
+	device_destroy(vc_class, MKDEV(VCS_MAJOR, index + 65));
 	device_destroy(vc_class, MKDEV(VCS_MAJOR, index + 129));
 }
=20
@@ -647,6 +707,7 @@ int __init vcs_init(void)
 	vc_class =3D class_create(THIS_MODULE, "vc");
=20
 	device_create(vc_class, NULL, MKDEV(VCS_MAJOR, 0), NULL, "vcs");
+	device_create(vc_class, NULL, MKDEV(VCS_MAJOR, 64), NULL, "vcsu");
 	device_create(vc_class, NULL, MKDEV(VCS_MAJOR, 128), NULL, "vcsa");
 	for (i =3D 0; i < MIN_NR_CONSOLES; i++)
 		vcs_make_sysfs(i);
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 7b636638b3..062ce6be79 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -481,6 +481,67 @@ static void vc_uniscr_copy_area(struct uni_screen *d=
st,
 	}
 }
=20
+/*
+ * Called from vcs_read() to make sure unicode screen retrieval is possi=
ble.
+ * This will initialize the unicode screen buffer if not already done.
+ * This returns 0 if OK, or a negative error code otherwise.
+ * In particular, -ENODATA is returned if the console is not in UTF-8 mo=
de.
+ */
+int vc_uniscr_check(struct vc_data *vc)
+{
+	struct uni_screen *uniscr;
+	unsigned short *p;
+	int x, y, mask;
+
+	if (__is_defined(NO_VC_UNI_SCREEN))
+		return -EOPNOTSUPP;
+
+	WARN_CONSOLE_UNLOCKED();
+
+	if (!vc->vc_utf)
+		return -ENODATA;
+
+	if (vc->vc_uni_screen)
+		return 0;
+
+	uniscr =3D vc_uniscr_alloc(vc->vc_cols, vc->vc_rows);
+	if (!uniscr)
+		return -ENOMEM;
+
+	/*
+	 * Let's populate it initially with (imperfect) reverse translation.
+	 * This is the next best thing we can do short of having it enabled
+	 * from the start even when no users rely on this functionality. True
+	 * unicode content will be available after a complete screen refresh.
+	 */
+	p =3D (unsigned short *)vc->vc_origin;
+	mask =3D vc->vc_hi_font_mask | 0xff;
+	for (y =3D 0; y < vc->vc_rows; y++) {
+		char32_t *line =3D uniscr->lines[y];
+		for (x =3D 0; x < vc->vc_cols; x++) {
+			u16 glyph =3D scr_readw(p++) & mask;
+			line[x] =3D inverse_translate(vc, glyph, true);
+		}
+	}
+
+	vc->vc_uni_screen =3D uniscr;
+	return 0;
+}
+
+/*
+ * Called from vcs_read() to get the unicode data from the screen.
+ * This must be preceded by a successful call to vc_uniscr_check() once
+ * the console lock has been taken.
+ */
+void vc_uniscr_copy_line(struct vc_data *vc, void *dest,
+			 unsigned int row, unsigned int col, unsigned int nr)
+{
+	struct uni_screen *uniscr =3D get_vc_uniscr(vc);
+
+	BUG_ON(!uniscr);
+	memcpy(dest, &uniscr->lines[row][col], nr * sizeof(char32_t));
+}
+
=20
 static void con_scroll(struct vc_data *vc, unsigned int t, unsigned int =
b,
 		enum con_scroll dir, unsigned int nr)
diff --git a/include/linux/selection.h b/include/linux/selection.h
index 5b278ce99d..2b34df9f1e 100644
--- a/include/linux/selection.h
+++ b/include/linux/selection.h
@@ -42,4 +42,9 @@ extern u16 vcs_scr_readw(struct vc_data *vc, const u16 =
*org);
 extern void vcs_scr_writew(struct vc_data *vc, u16 val, u16 *org);
 extern void vcs_scr_updated(struct vc_data *vc);
=20
+extern int vc_uniscr_check(struct vc_data *vc);
+extern void vc_uniscr_copy_line(struct vc_data *vc, void *dest,
+				unsigned int row, unsigned int col,
+				unsigned int nr);
+
 #endif
--=20
2.17.1

