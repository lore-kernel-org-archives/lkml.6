Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2256q2/Y7EKQqGkdyXGwB0er6RtTu4f4OeVWdnabKg+LfiqiGSL9Q3oF4GfrwuDuJaXk2itq
ARC-Seal: i=1; a=rsa-sha256; t=1519217847; cv=none;
        d=google.com; s=arc-20160816;
        b=O/MUC1ZxFgvxGTEi4Vau3fOiT9PctGkmBGXiTUY/wSCvvP8t5eNE/HKXNRGU5cPAkc
         Ww5xOLSubaF9bFS5U2kzdN/7W4J8iAx02PD5sXH+EA33oHb9x5KCaZypJEZ7n74nvEYg
         hvESZr5H/Wg4oE3CCvPhVXi+axckm/FZezGlyBUF6kDbs2HDJa27Rch5/yTGzei0naDl
         bpiRJVO+cj+vNLSxuyvVFS244KPLnHu9wkeT6GMp2PXsBxiNrbeTEi8Q5rP+MP4qF4Wi
         hguNfulNsi7c4Qs4ER64Yb1DGhbXYH8A3LGK6QAkZfDo0/j/rudFdfgLJVQoly1Bu60m
         vbLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6szMVwqh4/mDvg6vizrdByo8Nnd5YTsldoi4JDmWIqI=;
        b=0ZnJbSLgNuz5yx+j7/6Ib+QcCDQKN4wqTrJV/sWAHXfECGs2nWOskYJQ7KcOLrmsTi
         5+LRx2tKKSC2WFyNnJln+yybST2yRdZ7D6Cn+tl2RJyphaKh9S2GdPR0K8T/odWN3KOa
         JfaersaD9ZbGvR7sescgVLYIoCcrqsinBGnIvtm2pqydF1udYiyZEVykpqKBX4hfMVOg
         Ux0nF2xbt2f/qR1iAKlHzDW5InLH7a16SpfQwm36ZCzNCi5LTovZq+dmDuFyxQTkQbAh
         z01irXPHO7ci2uaRVSJxEyuPjP5EtBTBv8BUlhGtbLZxEPZ+ZevbIMdAPploDPTJ8Q8D
         MNQA==
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
Subject: [PATCH 4.9 75/77] media: r820t: fix r820t_write_reg for KASAN
Date: Wed, 21 Feb 2018 13:49:24 +0100
Message-Id: <20180221124435.339734334@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014700913189109?=
X-GMAIL-MSGID: =?utf-8?q?1593015373907239465?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 16c3ada89cff9a8c2a0eea34ffa1aa20af3f6008 upstream.

With CONFIG_KASAN, we get an overly long stack frame due to inlining
the register access functions:

drivers/media/tuners/r820t.c: In function 'generic_set_freq.isra.7':
drivers/media/tuners/r820t.c:1334:1: error: the frame size of 2880 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]

This is caused by a gcc bug that has now been fixed in gcc-8.
To work around the problem, we can pass the register data
through a local variable that older gcc versions can optimize
out as well.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/tuners/r820t.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/media/tuners/r820t.c
+++ b/drivers/media/tuners/r820t.c
@@ -396,9 +396,11 @@ static int r820t_write(struct r820t_priv
 	return 0;
 }
 
-static int r820t_write_reg(struct r820t_priv *priv, u8 reg, u8 val)
+static inline int r820t_write_reg(struct r820t_priv *priv, u8 reg, u8 val)
 {
-	return r820t_write(priv, reg, &val, 1);
+	u8 tmp = val; /* work around GCC PR81715 with asan-stack=1 */
+
+	return r820t_write(priv, reg, &tmp, 1);
 }
 
 static int r820t_read_cache_reg(struct r820t_priv *priv, int reg)
@@ -411,17 +413,18 @@ static int r820t_read_cache_reg(struct r
 		return -EINVAL;
 }
 
-static int r820t_write_reg_mask(struct r820t_priv *priv, u8 reg, u8 val,
+static inline int r820t_write_reg_mask(struct r820t_priv *priv, u8 reg, u8 val,
 				u8 bit_mask)
 {
+	u8 tmp = val;
 	int rc = r820t_read_cache_reg(priv, reg);
 
 	if (rc < 0)
 		return rc;
 
-	val = (rc & ~bit_mask) | (val & bit_mask);
+	tmp = (rc & ~bit_mask) | (tmp & bit_mask);
 
-	return r820t_write(priv, reg, &val, 1);
+	return r820t_write(priv, reg, &tmp, 1);
 }
 
 static int r820t_read(struct r820t_priv *priv, u8 reg, u8 *val, int len)
