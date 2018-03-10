Return-Path: <kernel-hardening-return-12366-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELt/czJ/NQK9qkojfnZ7qDpolDXcT6WEGLaNjpm5fCQ4+NpTHoX/JRrwdm720SjEkyhiYtOJ
ARC-Seal: i=1; a=rsa-sha256; t=1520664088; cv=none;
        d=google.com; s=arc-20160816;
        b=RFBGQfxKa0icZBlvm2Ot3nG7VrclFUCi47rKBOFZ2TWDp9yLqL+bDSR9p9cM9gNOVy
         tuXoehh9ow0tR5TmuCFQRq/gn054qVBfk76/eHf+CrQT9uOMOJ088YnYUBcGI9Y0sb/c
         dOmJMRp1w3QY/KmJtBJ/7yN0shqx6KTCQ1SQ7UhEsaA0LW2gd7n7MZluEnxrSivvK0Wa
         TxpaL5sIRruF3z6etdnvR6gqzFy0o6wB/5mehadyfuUW5eNpcETneHpV6qyOre4bp8au
         dZtU1cfn38KHZ1VuP8RoWuPozC74VbrpPUYHA1kkWJom1R0/sOmH5e3IiVUJtqEKbQ8F
         2jhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=6DG54/6NtFjptAO1iMN704UbU2ZHSp5KmmuFLSDvj5g=;
        b=DqA0h/AJEfsOUpdO9NHa0FDVgl5xrmixNeqCLxLYDX13DCDFLukIF7BI70iJ1L8xW/
         +9VoRB5XiUmOXv6XhCwn3ixIwvHYuE1PIyNHLqf1CAZxRbwAANK7SdUT7Wwxd1C+pdXq
         lLMu37QE8Pnx6FBqGc1T9TOz15B9FxnX4G0vwC4ciuEy/6qsxhgszn5KWFqRt71/TeYv
         1Dte4f2wQQYU2UmPNtHPK/IFzG5y5OwmIdb39uOLMGlum8tysK0Cc0uBysm/VJqmSLvt
         797MzLHeiyr2RugPz69uICcSTtk1jcWkJXofcVvUzE30AElOn4Z8pr2p5SjE6o2TzKl0
         p73w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12366-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12366-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12366-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12366-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Joao Moreira <jmoreira@suse.de>
To: kernel-hardening@lists.openwall.com
Cc: linux-kernel@vger.kernel.org,
	danielmicay@gmail.com,
	keescook@chromium.org
Subject: [PATCH] vgacon: fix function prototypes
Date: Sat, 10 Mar 2018 03:40:59 -0300
Message-Id: <20180310064059.12720-1-jmoreira@suse.de>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594531866995400675?=
X-GMAIL-MSGID: =?utf-8?q?1594531866995400675?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It is possible to indirectly invoke functions with prototypes that do not
match those of the respectively used function pointers by using void types.
Despite widely used as a feature for relaxing function invocation, this
should be avoided when possible as it may prevent the use of heuristics
such as prototype matching-based Control-Flow Integrity, which can be used
to prevent ROP-based attacks.

Given the above, the current efforts to improve the Linux security, and the
upcoming kernel support to compilers with CFI features, fix prototypes in
vgacon console driver.

Another similar fix can be seen in [1].

[1] https://android-review.googlesource.com/c/kernel/common/+/602010

Signed-off-by: João Moreira <jmoreira@suse.de>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/console/vgacon.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index a17ba1465815..f00b630f6839 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -1407,21 +1407,29 @@ static bool vgacon_scroll(struct vc_data *c, unsigned int t, unsigned int b,
  *  The console `switch' structure for the VGA based console
  */
 
-static int vgacon_dummy(struct vc_data *c)
+static int vgacon_clear(struct vc_data *c)
 {
 	return 0;
 }
 
-#define DUMMY (void *) vgacon_dummy
+static void vgacon_putc(struct vc_data *c, int a, int b, int d)
+{
+	return;
+}
+
+static void vgacon_putcs(struct vc_data *c, ushort *s, int a, int b, int d)
+{
+	return;
+}
 
 const struct consw vga_con = {
 	.owner = THIS_MODULE,
 	.con_startup = vgacon_startup,
 	.con_init = vgacon_init,
 	.con_deinit = vgacon_deinit,
-	.con_clear = DUMMY,
-	.con_putc = DUMMY,
-	.con_putcs = DUMMY,
+	.con_clear = vgacon_clear,
+	.con_putc = vgacon_putc,
+	.con_putcs = vgacon_putcs,
 	.con_cursor = vgacon_cursor,
 	.con_scroll = vgacon_scroll,
 	.con_switch = vgacon_switch,
-- 
2.13.6
