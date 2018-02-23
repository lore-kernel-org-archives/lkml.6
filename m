Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv78hVY0PZYM7BnGP1zk37b3ElvNoZhlB2DWTcxvSNSHCohs6kZzy97+rHc+m/k1S5vD6vQ
ARC-Seal: i=1; a=rsa-sha256; t=1519411123; cv=none;
        d=google.com; s=arc-20160816;
        b=DICnIlkoBfPgIxdjW90syAfaO8zGjuj+KObyrIquHokhi1MAXMQUz5UhphgmhGikUT
         wOjndaWrD0fWBbQYlYHQ0ux+vnwIwArodplaU2zzjPuBUdQdW8KymUL51s69HWF7V1sF
         0YHl4rMq1SdRaqVFwHhb1X1CU7HQB+2dzROLmIEHR21SwuSNDVY7fraF1sSwJuxuXiRr
         NKomh3hoAu3A3hMRaPkJavh1+UxXm2fGZakzMpIivTn5IrmrfeyspoD4q/88ycK6YWuR
         f/f3qMBoxYf5kou4HPvfhdPBMKnekanl3b0KYP9g/+AHJNBWLyeXlMEaE80YIBvFlfK7
         vEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1PaKlv1PWLdkC9AaepMJpWUYwBxFeP16AptJDIazUps=;
        b=a76S9Mp8qzeTE5cq3Ucuu53zx0wVNu2p+L2bfMAuXaoTMpjifPdiYey8oAfuQiDq8M
         XjLEegAhq9Z+H1pdXw7lOdGg1oYgDNi4nmqGof6ovi6X7QdAwdZuSe28VbGvj6M++Evd
         BcvC4y09+VGghSpPqO7lC/oUmVCFkISgWu5xN8n66uMI/0P9tr+aXhJfv5cW6JOeDCa/
         zK4wWX90gX/BMJ0vZGZvX2jULMqOOUSSn9is9lj9gG0UN85ogFIOU2cJ7qMtIa7ZgL8I
         1ieOHvKgOsBuQ84VXbDoQ/C3WMymBnuJhTn1amwPPQd8cD8DGwWGn91cSwkcQhDgbpmq
         LqMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.4 130/193] [media] tc358743: fix register i2c_rd/wr functions
Date: Fri, 23 Feb 2018 19:26:03 +0100
Message-Id: <20180223170346.213655459@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218037881404003?=
X-GMAIL-MSGID: =?utf-8?q?1593218037881404003?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 3538aa6ecfb2dd727a40f9ebbbf25a0c2afe6226 upstream.

While testing with CONFIG_UBSAN, I got this warning:

drivers/media/i2c/tc358743.c: In function 'tc358743_probe':
drivers/media/i2c/tc358743.c:1930:1: error: the frame size of 2480 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]

The problem is that the i2c_rd8/wr8/rd16/... functions in this driver pass
a pointer to a local variable into a common function, and each call to one
of them adds another variable plus redzone to the stack.

I also noticed that the way this is done is broken on big-endian machines,
as we copy the registers in CPU byte order.

To address both those problems, I'm adding two helper functions for reading
a register of up to 32 bits with correct endianess and change all other
functions to use that instead. Just to be sure we don't get the problem
back with changed optimizations in gcc, I'm also marking the new functions
as 'noinline', although my tests with gcc-7 don't require that.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/i2c/tc358743.c |   46 +++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -197,57 +197,61 @@ static void i2c_wr(struct v4l2_subdev *s
 	}
 }
 
-static u8 i2c_rd8(struct v4l2_subdev *sd, u16 reg)
+static noinline u32 i2c_rdreg(struct v4l2_subdev *sd, u16 reg, u32 n)
 {
-	u8 val;
+	__le32 val = 0;
 
-	i2c_rd(sd, reg, &val, 1);
+	i2c_rd(sd, reg, (u8 __force *)&val, n);
 
-	return val;
+	return le32_to_cpu(val);
+}
+
+static noinline void i2c_wrreg(struct v4l2_subdev *sd, u16 reg, u32 val, u32 n)
+{
+	__le32 raw = cpu_to_le32(val);
+
+	i2c_wr(sd, reg, (u8 __force *)&raw, n);
+}
+
+static u8 i2c_rd8(struct v4l2_subdev *sd, u16 reg)
+{
+	return i2c_rdreg(sd, reg, 1);
 }
 
 static void i2c_wr8(struct v4l2_subdev *sd, u16 reg, u8 val)
 {
-	i2c_wr(sd, reg, &val, 1);
+	i2c_wrreg(sd, reg, val, 1);
 }
 
 static void i2c_wr8_and_or(struct v4l2_subdev *sd, u16 reg,
 		u8 mask, u8 val)
 {
-	i2c_wr8(sd, reg, (i2c_rd8(sd, reg) & mask) | val);
+	i2c_wrreg(sd, reg, (i2c_rdreg(sd, reg, 2) & mask) | val, 2);
 }
 
 static u16 i2c_rd16(struct v4l2_subdev *sd, u16 reg)
 {
-	u16 val;
-
-	i2c_rd(sd, reg, (u8 *)&val, 2);
-
-	return val;
+	return i2c_rdreg(sd, reg, 2);
 }
 
 static void i2c_wr16(struct v4l2_subdev *sd, u16 reg, u16 val)
 {
-	i2c_wr(sd, reg, (u8 *)&val, 2);
+	i2c_wrreg(sd, reg, val, 2);
 }
 
 static void i2c_wr16_and_or(struct v4l2_subdev *sd, u16 reg, u16 mask, u16 val)
 {
-	i2c_wr16(sd, reg, (i2c_rd16(sd, reg) & mask) | val);
+	i2c_wrreg(sd, reg, (i2c_rdreg(sd, reg, 2) & mask) | val, 2);
 }
 
 static u32 i2c_rd32(struct v4l2_subdev *sd, u16 reg)
 {
-	u32 val;
-
-	i2c_rd(sd, reg, (u8 *)&val, 4);
-
-	return val;
+	return i2c_rdreg(sd, reg, 4);
 }
 
 static void i2c_wr32(struct v4l2_subdev *sd, u16 reg, u32 val)
 {
-	i2c_wr(sd, reg, (u8 *)&val, 4);
+	i2c_wrreg(sd, reg, val, 4);
 }
 
 /* --------------- STATUS --------------- */
@@ -1240,7 +1244,7 @@ static int tc358743_g_register(struct v4
 
 	reg->size = tc358743_get_reg_size(reg->reg);
 
-	i2c_rd(sd, reg->reg, (u8 *)&reg->val, reg->size);
+	reg->val = i2c_rdreg(sd, reg->reg, reg->size);
 
 	return 0;
 }
@@ -1266,7 +1270,7 @@ static int tc358743_s_register(struct v4
 	    reg->reg == BCAPS)
 		return 0;
 
-	i2c_wr(sd, (u16)reg->reg, (u8 *)&reg->val,
+	i2c_wrreg(sd, (u16)reg->reg, reg->val,
 			tc358743_get_reg_size(reg->reg));
 
 	return 0;
