Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/5m8ArA3PXdezz83LV3AVsRBIdLlkizTBXLWk1v462egJKn8VgVBPWujJaAUryH9vuPWfD
ARC-Seal: i=1; a=rsa-sha256; t=1523021472; cv=none;
        d=google.com; s=arc-20160816;
        b=LJlImlX+4t0hEHhFfGJd31UMN7ytuWlWM6McZwQjqtQj7Viu7knZnDpguolYHc8tZy
         l7pOm7X3A6vB/0KSq6SB8XEUsqZ6T7w9NENbJSVgaoXf82DDf9DUBBNq732ACbJqckuq
         pKQ5yEFee17zOlUR1SvLYBxydEZazLLGd5zZxWcQK5VOvR/PiaDYYXlT+cAWIH6tXGWV
         iuKEWyprYoLGmQCkZtxcFJzU7J8daH9WEjl2sxC1lYA5gimiSGhS6sEhq6GLytvexsIt
         otYxQSOevdO2FtCdvICBdolw88ts0XD+aKu2CGfMbce6Vp18tTXleiX+Fr0qyfC5RxL9
         fFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Wzme5nQKmY0Oxc/UWp0+2YY9DXTf2I35uoymYBWsm5A=;
        b=kH2oRCj5W6TgbqsxyavPxAmYIL6SYLy3CpWPR5aXeEULK+fyAgw+u2HahMXh16VrWO
         ASmHnsJyKUneYqvnVJNtc6KxD9GW4NxX2N+5SGH7tZZbu3UJIdl5///nn9WXqMfHYtBa
         iOnNqJ8sjhFcDWshZrflugRkgTYiKMJT7uibVb0Wfi7O2J1yvJ43upXpC4/iaMWdj5Cj
         GkpCq6T9y0wWjELkKv1FJxziDyMoAXY3JBKpvabBmUTijzVk8iuJR/D1jA2U5Ny+KKiL
         TAD3ALTzF6QYxluKVO4KJSfYMd9T/WYqmnobed/ZeK7RPgTO8xRDo1U4gPFaHPyW73j0
         IGlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nick Desaulniers <nick.desaulniers@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 16/72] Input: mousedev - fix implicit conversion warning
Date: Fri,  6 Apr 2018 15:23:17 +0200
Message-Id: <20180406084306.408404467@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003763722752102?=
X-GMAIL-MSGID: =?utf-8?q?1597003763722752102?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nick Desaulniers <nick.desaulniers@gmail.com>

commit dae1a432ab1fe79ae53129ededeaece35a2dc14d upstream.

Clang warns:

drivers/input/mousedev.c:653:63: error: implicit conversion from 'int'
to 'signed char' changes value from 200 to -56
[-Wconstant-conversion]
  client->ps2[1] = 0x60; client->ps2[2] = 3; client->ps2[3] = 200;
                                                            ~ ^~~
As the PS2 data is really a stream of bytes, let's switch to using u8 type
for it, which silences this warning.

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mousedev.c |   62 +++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -15,6 +15,7 @@
 #define MOUSEDEV_MINORS		31
 #define MOUSEDEV_MIX		63
 
+#include <linux/bitops.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
@@ -103,7 +104,7 @@ struct mousedev_client {
 	spinlock_t packet_lock;
 	int pos_x, pos_y;
 
-	signed char ps2[6];
+	u8 ps2[6];
 	unsigned char ready, buffer, bufsiz;
 	unsigned char imexseq, impsseq;
 	enum mousedev_emul mode;
@@ -291,11 +292,10 @@ static void mousedev_notify_readers(stru
 		}
 
 		client->pos_x += packet->dx;
-		client->pos_x = client->pos_x < 0 ?
-			0 : (client->pos_x >= xres ? xres : client->pos_x);
+		client->pos_x = clamp_val(client->pos_x, 0, xres);
+
 		client->pos_y += packet->dy;
-		client->pos_y = client->pos_y < 0 ?
-			0 : (client->pos_y >= yres ? yres : client->pos_y);
+		client->pos_y = clamp_val(client->pos_y, 0, yres);
 
 		p->dx += packet->dx;
 		p->dy += packet->dy;
@@ -571,44 +571,50 @@ static int mousedev_open(struct inode *i
 	return error;
 }
 
-static inline int mousedev_limit_delta(int delta, int limit)
-{
-	return delta > limit ? limit : (delta < -limit ? -limit : delta);
-}
-
-static void mousedev_packet(struct mousedev_client *client,
-			    signed char *ps2_data)
+static void mousedev_packet(struct mousedev_client *client, u8 *ps2_data)
 {
 	struct mousedev_motion *p = &client->packets[client->tail];
+	s8 dx, dy, dz;
+
+	dx = clamp_val(p->dx, -127, 127);
+	p->dx -= dx;
+
+	dy = clamp_val(p->dy, -127, 127);
+	p->dy -= dy;
 
-	ps2_data[0] = 0x08 |
-		((p->dx < 0) << 4) | ((p->dy < 0) << 5) | (p->buttons & 0x07);
-	ps2_data[1] = mousedev_limit_delta(p->dx, 127);
-	ps2_data[2] = mousedev_limit_delta(p->dy, 127);
-	p->dx -= ps2_data[1];
-	p->dy -= ps2_data[2];
+	ps2_data[0] = BIT(3);
+	ps2_data[0] |= ((dx & BIT(7)) >> 3) | ((dy & BIT(7)) >> 2);
+	ps2_data[0] |= p->buttons & 0x07;
+	ps2_data[1] = dx;
+	ps2_data[2] = dy;
 
 	switch (client->mode) {
 	case MOUSEDEV_EMUL_EXPS:
-		ps2_data[3] = mousedev_limit_delta(p->dz, 7);
-		p->dz -= ps2_data[3];
-		ps2_data[3] = (ps2_data[3] & 0x0f) | ((p->buttons & 0x18) << 1);
+		dz = clamp_val(p->dz, -7, 7);
+		p->dz -= dz;
+
+		ps2_data[3] = (dz & 0x0f) | ((p->buttons & 0x18) << 1);
 		client->bufsiz = 4;
 		break;
 
 	case MOUSEDEV_EMUL_IMPS:
-		ps2_data[0] |=
-			((p->buttons & 0x10) >> 3) | ((p->buttons & 0x08) >> 1);
-		ps2_data[3] = mousedev_limit_delta(p->dz, 127);
-		p->dz -= ps2_data[3];
+		dz = clamp_val(p->dz, -127, 127);
+		p->dz -= dz;
+
+		ps2_data[0] |= ((p->buttons & 0x10) >> 3) |
+			       ((p->buttons & 0x08) >> 1);
+		ps2_data[3] = dz;
+
 		client->bufsiz = 4;
 		break;
 
 	case MOUSEDEV_EMUL_PS2:
 	default:
-		ps2_data[0] |=
-			((p->buttons & 0x10) >> 3) | ((p->buttons & 0x08) >> 1);
 		p->dz = 0;
+
+		ps2_data[0] |= ((p->buttons & 0x10) >> 3) |
+			       ((p->buttons & 0x08) >> 1);
+
 		client->bufsiz = 3;
 		break;
 	}
@@ -714,7 +720,7 @@ static ssize_t mousedev_read(struct file
 {
 	struct mousedev_client *client = file->private_data;
 	struct mousedev *mousedev = client->mousedev;
-	signed char data[sizeof(client->ps2)];
+	u8 data[sizeof(client->ps2)];
 	int retval = 0;
 
 	if (!client->ready && !client->buffer && mousedev->exist &&
