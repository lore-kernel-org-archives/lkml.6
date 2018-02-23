Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvKIMUzOEpfPKbcUEQ5XLWn5aDGba4u2dxGf0djuM06cxzJT+AueHQShkAjLFxcsv4ZdYtn
ARC-Seal: i=1; a=rsa-sha256; t=1519410623; cv=none;
        d=google.com; s=arc-20160816;
        b=KsdBU1Yrfo+/KJlQoI9xRmPoPGAQzl7f1Hq6w9Mxv97qs9XVCPCybAHnevDxUklmb8
         d84buGvSGlKKb9EqXIdvmXh0+JAyqgaD592qQUc3k062+000CYjJknDNsl0CBs1fh+R9
         1WYRajNYtn0HaNmpbvRgGlRN1HJkbNFIdrrCAar/dBU9M+2wjOh1J+E9kRNoqyAJyJS4
         McXzb+h84LWxCwGYr2kBb/KVsJStx5rARTuoHCr6k2pJdYqgbHBm9SzRagFgZjfZVW4y
         6dqdR8dyrBfeRcyX1WckPFn2lWTzRhvZGO/j06YpUcWdJH4uTY/UBB1rc2XiNsdo/z5e
         9uWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2A5GWvS2pw85G0P41jDoPYnILk3RDXoJ3uK1UFRLSYM=;
        b=X/JpNzITTlsAbTgZmhwx3HAa59Y/x+T/MmY+AXSH1dwvwK08S8ODQ5MASLFeKKxLqa
         fNRiukAzAoG0C+cGelL4z+aVp7vVJJCPPNI+lm/ot9rt7zc4qURmL070d9pBj/6MJgP2
         KiC0VAlIg0cVzb7nmeu+4bz9jYQUbBFrbTF7SOvt8rJKjO48aXXz+ZFkiVHae5x6HhDN
         /XHIZHDBDRniWlcdHf1S1ePJfqGIOrWf4Zeu+osfAe2audIcwugCXkC1/B1pMhMbCFDl
         IjkkFo5A/k8YZ3dadZjddwcA3ucQZNd9rcN2h/J2HW8TJsJ5Q/XbIi+BkLvwVSpq8FGb
         temA==
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
Subject: [PATCH 3.18 17/58] media: r820t: fix r820t_write_reg for KASAN
Date: Fri, 23 Feb 2018 19:26:16 +0100
Message-Id: <20180223170209.376322771@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217513589327182?=
X-GMAIL-MSGID: =?utf-8?q?1593217513589327182?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -410,9 +410,11 @@ static int r820t_write(struct r820t_priv
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
@@ -425,17 +427,18 @@ static int r820t_read_cache_reg(struct r
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
