Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2269l5AJ7V5LnLUTya4TWfl6tV6Oo5XMYza/ISfmJt8ToMDKhZji2xrSDWCtpqhq+CgyCsRL
ARC-Seal: i=1; a=rsa-sha256; t=1519218310; cv=none;
        d=google.com; s=arc-20160816;
        b=lE7287weYISTOPvUu6jAxY46vkMaiqrkwXiVkVFFoZDW5VY8ETcAJF/rSfRgLwuaDP
         rGBW2aT518FVHjjfSjCIw4wQ62Gb3jckftWvnzLJzZF8pJjcACMHj1sUoUNZtZL51KwI
         Gt+9AuIKKkqGKtUVb3/DkwtRZ0EmdaNuz4VVJp1RTfIXlMNHmKUvJZPHZFXYTId2Kyxe
         wUvpiY2W5ZtqS23X8qXPbrcnorIQ50LbpkOo3R/0EjKFRUwcDNSXZP/yZazGOmnB2CI2
         VPdKbbVRjopckbY3E/5vOQ40wQfMVAVSNK07CiU47dviJBurXxDDbc+BeBXCR0eCw0P9
         xuJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+AfJG9YcrQQ5Pu33rO4bjUv6YUC6mJ8syYge8Soy+5A=;
        b=MP1sDcDS/B/uW6mrludOkpCXCUz58cDW8+OtEB6HimN1Hv4ewxE1LpEyIWYpEGIYh1
         1x31DWvE2Qj4ZZCtyVwWWuDlCo64EH8aLHowkMC7qnfniyfz13X//7OxkNmBc+hbtlxr
         E499pGLztsxGyEyHvC4CWarWZR1iDNqhVzroc+9tOtpIDF+KnKesYj5ZT2RKr02IPHfE
         jIXej4YJkKbEcPttMt2nDcCXuz6t1Va/rLKHUD8LyhvGFNUvURQJgZO8sMtZHOsAm+Jr
         ImlIuBw5iKmQiaW1ZDIDIHhsyE87Vtkh5AiKSJnlYwalN4UoOFv/PiSWraHmDPcPM31U
         go/w==
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
Subject: [PATCH 4.14 162/167] media: r820t: fix r820t_write_reg for KASAN
Date: Wed, 21 Feb 2018 13:49:33 +0100
Message-Id: <20180221124533.710405666@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014700913189109?=
X-GMAIL-MSGID: =?utf-8?q?1593015859443966988?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
