Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932619AbeE3V3S (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:29:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54855 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932402AbeE3V2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:28:21 -0400
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] vt: introduce unicode mode for /dev/vcs
Date: Wed, 30 May 2018 17:27:43 -0400
Message-Id: <20180530212745.10997-4-nicolas.pitre@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530212745.10997-1-nicolas.pitre@linaro.org>
References: <20180530212745.10997-1-nicolas.pitre@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 5EF23544-6450-11E8-B718-67830C78B957-78420484!pb-smtp2.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4ULTYut017886

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
version 5.7) of BRLTTY. Amongst other things, this allows ⠋⠕⠗ ⠞⠓⠊⠎
⠃⠗⠁⠊⠇⠇⠑⠀⠞⠑⠭⠞⠀to appear directly on braille displays regardless of the
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
+ * /dev/vcsuaN: same idea as /dev/vcsaN for unicode (not yet implemented).
+ *
  * This replaces screendump and part of selection, so that the system
  * administrator can control access using file system permissions.
  *
@@ -51,6 +57,26 @@
 
 #define CON_BUF_SIZE (CONFIG_BASE_SMALL ? 256 : PAGE_SIZE)
 
+/*
+ * Our minor space:
+ *
+ *   0 ... 63	glyph mode without attributes
+ *  64 ... 127	unicode mode without attributes
+ * 128 ... 191	glyph mode with attributes
+ * 192 ... 255	unused (reserved for unicode with attributes)
+ *
+ * This relies on MAX_NR_CONSOLES being  <= 63, meaning 63 actual consoles
+ * with minors 0, 64, 128 and 192 being proxies for the foreground console.
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
 	poll = kzalloc(sizeof(*poll), GFP_KERNEL);
 	if (!poll)
 		return NULL;
-	poll->cons_num = iminor(file_inode(file)) & 127;
+	poll->cons_num = console(file_inode(file));
 	init_waitqueue_head(&poll->waitq);
 	poll->notifier.notifier_call = vcs_notifier;
 	if (register_vt_notifier(&poll->notifier) != 0) {
@@ -140,7 +166,7 @@ vcs_poll_data_get(struct file *file)
 static struct vc_data*
 vcs_vc(struct inode *inode, int *viewed)
 {
-	unsigned int currcons = iminor(inode) & 127;
+	unsigned int currcons = console(inode);
 
 	WARN_CONSOLE_UNLOCKED();
 
@@ -164,7 +190,6 @@ static int
 vcs_size(struct inode *inode)
 {
 	int size;
-	int minor = iminor(inode);
 	struct vc_data *vc;
 
 	WARN_CONSOLE_UNLOCKED();
@@ -175,8 +200,12 @@ vcs_size(struct inode *inode)
 
 	size = vc->vc_rows * vc->vc_cols;
 
-	if (minor & 128)
+	if (use_attributes(inode)) {
+		if (use_unicode(inode))
+			return -EOPNOTSUPP;
 		size = 2*size + HEADER_SIZE;
+	} else if (use_unicode(inode))
+		size *= 4;
 	return size;
 }
 
@@ -197,12 +226,10 @@ static ssize_t
 vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
 	struct inode *inode = file_inode(file);
-	unsigned int currcons = iminor(inode);
 	struct vc_data *vc;
 	struct vcs_poll_data *poll;
-	long pos;
-	long attr, read;
-	int col, maxcol, viewed;
+	long pos, read;
+	int attr, uni_mode, row, col, maxcol, viewed;
 	unsigned short *org = NULL;
 	ssize_t ret;
 	char *con_buf;
@@ -218,7 +245,8 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	 */
 	console_lock();
 
-	attr = (currcons & 128);
+	uni_mode = use_unicode(inode);
+	attr = use_attributes(inode);
 	ret = -ENXIO;
 	vc = vcs_vc(inode, &viewed);
 	if (!vc)
@@ -227,6 +255,10 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	ret = -EINVAL;
 	if (pos < 0)
 		goto unlock_out;
+	/* we enforce 32-bit alignment for pos and count in unicode mode */
+	if (uni_mode && (pos | count) & 3)
+		goto unlock_out;
+
 	poll = file->private_data;
 	if (count && poll)
 		poll->seen_last_update = true;
@@ -266,7 +298,27 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 		con_buf_start = con_buf0 = con_buf;
 		orig_count = this_round;
 		maxcol = vc->vc_cols;
-		if (!attr) {
+		if (uni_mode) {
+			unsigned int nr;
+
+			ret = vc_uniscr_check(vc);
+			if (ret)
+				break;
+			p /= 4;
+			row = p / vc->vc_cols;
+			col = p % maxcol;
+			nr = maxcol - col;
+			do {
+				if (nr > this_round/4)
+					nr = this_round/4;
+				vc_uniscr_copy_line(vc, con_buf0, row, col, nr);
+				con_buf0 += nr * 4;
+				this_round -= nr * 4;
+				row++;
+				col = 0;
+				nr = maxcol;
+			} while (this_round);
+		} else if (!attr) {
 			org = screen_pos(vc, p, viewed);
 			col = p % maxcol;
 			p += maxcol - col;
@@ -375,7 +427,6 @@ static ssize_t
 vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct inode *inode = file_inode(file);
-	unsigned int currcons = iminor(inode);
 	struct vc_data *vc;
 	long pos;
 	long attr, size, written;
@@ -396,7 +447,7 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	 */
 	console_lock();
 
-	attr = (currcons & 128);
+	attr = use_attributes(inode);
 	ret = -ENXIO;
 	vc = vcs_vc(inode, &viewed);
 	if (!vc)
@@ -593,9 +644,15 @@ vcs_fasync(int fd, struct file *file, int on)
 static int
 vcs_open(struct inode *inode, struct file *filp)
 {
-	unsigned int currcons = iminor(inode) & 127;
+	unsigned int currcons = console(inode);
+	bool attr = use_attributes(inode);
+	bool uni_mode = use_unicode(inode);
 	int ret = 0;
-	
+
+	/* we currently don't support attributes in unicode mode */
+	if (attr && uni_mode)
+		return -EOPNOTSUPP;
+
 	console_lock();
 	if(currcons && !vc_cons_allocated(currcons-1))
 		ret = -ENXIO;
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
 
@@ -647,6 +707,7 @@ int __init vcs_init(void)
 	vc_class = class_create(THIS_MODULE, "vc");
 
 	device_create(vc_class, NULL, MKDEV(VCS_MAJOR, 0), NULL, "vcs");
+	device_create(vc_class, NULL, MKDEV(VCS_MAJOR, 64), NULL, "vcsu");
 	device_create(vc_class, NULL, MKDEV(VCS_MAJOR, 128), NULL, "vcsa");
 	for (i = 0; i < MIN_NR_CONSOLES; i++)
 		vcs_make_sysfs(i);
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 3a801a60f4..2cba6089ca 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -483,6 +483,67 @@ static void vc_uniscr_copy_area(struct uni_screen *dst,
 	}
 }
 
+/*
+ * Called from vcs_read() to make sure unicode screen retrieval is possible.
+ * This will initialize the unicode screen buffer if not already done.
+ * This returns 0 if OK, or a negative error code otherwise.
+ * In particular, -ENODATA is returned if the console is not in UTF-8 mode.
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
+	uniscr = vc_uniscr_alloc(vc->vc_cols, vc->vc_rows);
+	if (!uniscr)
+		return -ENOMEM;
+
+	/*
+	 * Let's populate it initially with (imperfect) reverse translation.
+	 * This is the next best thing we can do short of having it enabled
+	 * from the start even when no users rely on this functionality. True
+	 * unicode content will be available after a complete screen refresh.
+	 */
+	p = (unsigned short *)vc->vc_origin;
+	mask = vc->vc_hi_font_mask | 0xff;
+	for (y = 0; y < vc->vc_rows; y++) {
+		char32_t *line = uniscr->lines[y];
+		for (x = 0; x < vc->vc_cols; x++) {
+			u16 glyph = scr_readw(p++) & mask;
+			line[x] = inverse_translate(vc, glyph, true);
+		}
+	}
+
+	vc->vc_uni_screen = uniscr;
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
+	struct uni_screen *uniscr = get_vc_uniscr(vc);
+
+	BUG_ON(!uniscr);
+	memcpy(dest, &uniscr->lines[row][col], nr * sizeof(char32_t));
+}
+
 
 static void con_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 		enum con_scroll dir, unsigned int nr)
diff --git a/include/linux/selection.h b/include/linux/selection.h
index 5b278ce99d..2b34df9f1e 100644
--- a/include/linux/selection.h
+++ b/include/linux/selection.h
@@ -42,4 +42,9 @@ extern u16 vcs_scr_readw(struct vc_data *vc, const u16 *org);
 extern void vcs_scr_writew(struct vc_data *vc, u16 val, u16 *org);
 extern void vcs_scr_updated(struct vc_data *vc);
 
+extern int vc_uniscr_check(struct vc_data *vc);
+extern void vc_uniscr_copy_line(struct vc_data *vc, void *dest,
+				unsigned int row, unsigned int col,
+				unsigned int nr);
+
 #endif
-- 
2.17.0
