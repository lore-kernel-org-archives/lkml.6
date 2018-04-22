Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49cMw6QMgAMesf9umdcsRgErygNLPMVAY0kGkWaX9Aw2Wwm/z56U/IjyR7S6W4kvEJBDp7U
ARC-Seal: i=1; a=rsa-sha256; t=1524405597; cv=none;
        d=google.com; s=arc-20160816;
        b=yZWd6VJ3X904ELLnswf/eKu5+XmW5CIgY69zhXET7odKjhcjnB9Xb3UlByncfd+4Gr
         8LW5E924NOr4g2WWFplPAEeDoKVHsihX2NKdg77J7mUfgEwPAb5soanrCM3ICaBXRFRL
         U12sS46T+o5KhCU2VD/0pTGhp4jZPGglTSK9Ftg9l43I+6JWMSPz3yCzj4MSBnZ9w2l9
         9wnMNejNW61U4OYDO7iGqD0ZpSyCRzRzHb4x5dg6VlqIlcRQ2cakWNyVSeK6cNGjNntY
         Tz0hOlRwLSQPCgceuUofeR6PlTScdf3x6ou1MMNvggA7HewLSYDBO4NlyIN2bjDxeXLo
         bD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GD1lhrV3Q9scGgWu4kpDs8syjfrptmAASjaLhE7vLhk=;
        b=V/d1ruQ+nQT1qAAUuW+Ht9gyS7K6aN5dprxBzP6+kOFR4umGJCSaLIVPbY8kA+MR3f
         NlPvArdm+vWoDw7mqm+J2YH5PIx908LlZHqSU9VqZILRuyNRq++w0O+7C1CtTiHmYQo2
         e02OeUDS+Qo76EjczvWl265YDVFNL/c02qzk5K7ncvm16/26qEaXqPBSV1wm88O/mYXE
         OR1J51VHby7i8qq6okmZA4r0iUm4Yifl6jNQ2BD+F88tgUZXqjTgjD4+lp7hc6bM+umo
         jUMVbkmmFB0MbkZkfA9X2nM5tnLTYIcDpxJ9lM6PLtKReAVLCImtceddBErX5+tqntQB
         /s+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>,
	Chen Feng <puck.chen@hisilicon.com>
Subject: [PATCH 4.16 081/196] random: use a tighter cap in credit_entropy_bits_safe()
Date: Sun, 22 Apr 2018 15:51:41 +0200
Message-Id: <20180422135108.495597846@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455123510525294?=
X-GMAIL-MSGID: =?utf-8?q?1598455123510525294?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 9f886f4d1d292442b2f22a0a33321eae821bde40 upstream.

This fixes a harmless UBSAN where root could potentially end up
causing an overflow while bumping the entropy_total field (which is
ignored once the entropy pool has been initialized, and this generally
is completed during the boot sequence).

This is marginal for the stable kernel series, but it's a really
trivial patch, and it fixes UBSAN warning that might cause security
folks to get overly excited for no reason.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reported-by: Chen Feng <puck.chen@hisilicon.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/random.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -732,7 +732,7 @@ retry:
 
 static int credit_entropy_bits_safe(struct entropy_store *r, int nbits)
 {
-	const int nbits_max = (int)(~0U >> (ENTROPY_SHIFT + 1));
+	const int nbits_max = r->poolinfo->poolwords * 32;
 
 	if (nbits < 0)
 		return -EINVAL;
