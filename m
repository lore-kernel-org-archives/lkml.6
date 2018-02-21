Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224DIdbPOohhHSmp15xA9NK1ArAySAUu07z1Eteya8uHy/YcCH6xLRaoRsQt/ftT0DV+0lsh
ARC-Seal: i=1; a=rsa-sha256; t=1519217184; cv=none;
        d=google.com; s=arc-20160816;
        b=UkaCCJyQAm8hxQBcSIl/QwtGOprQDjaVSLcztCZRfxBISPkwaI8xyuKc0Hw/x0gU8f
         8+u2l4IESbGJuam1UJpr2iThNEQBD55xbNxYKtcEpHtrRSaiVlQk+DacmHBSwId6lP97
         ke32nyu09oKWVOsuuaedePmPcBZXtz4gbFDQ1HEyL05LFMAA9lFh6+KK6FiTjHmXPDqb
         faCb259STz8vGSBq/6yHF3T8QnNNT+rQnjQGX/kbndqsuws8ArInWeyrB+27w0lsXXWU
         rIEZauZlx+FvRhwosTmf7qiG/HLnZYREux31RoXUNKtUf3arvdnxuAWwnYC0ilnptnG0
         7B+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sMKjsVnkLuOmu7cSNglGbH7XgXs+Oj2Xq63v+MfihE0=;
        b=kt4DnTjEwOv71S856puZdq+22bD7i4XquaFhmTon2gKMKLOZ+iFYHGWESEm21ClSF6
         mgz/oasV//26bKiWvhJDehxiJMKgIS/DGEWBCD2GjE96BE8LZ6xx0mQTvX0F1QjGN/pR
         xBPx6JCLsw8QXgQUsdQTBVHSR9O40FDr3UbiTa8f7J1FXWhXZzZSybncm/PGDNxXoHxw
         ukUcC/XV7ZAOpqhXV4SmfFA4bYvYF6V/QxDDolBJRb/D0fa3GJJdDMcTFt4+jyznD5bo
         uWeGdUFd2Ywfc3PpHCvqOhlRx5GtQVxq7MqS4P2AgDpE9uE5fzJLzYiMqDpCQ1S6qKql
         5Y8g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.4 11/33] drm/radeon: adjust tested variable
Date: Wed, 21 Feb 2018 13:44:54 +0100
Message-Id: <20180221124410.272681305@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014677867026600?=
X-GMAIL-MSGID: =?utf-8?q?1593014677867026600?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julia Lawall <Julia.Lawall@lip6.fr>

commit 3a61b527b4e1f285d21b6e9e623dc45cf8bb391f upstream.

Check the variable that was most recently initialized.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x, y, f, g, e, m;
statement S1,S2,S3,S4;
@@

x = f(...);
if (\(<+...x...+>\&e\)) S1 else S2
(
x = g(...);
|
m = g(...,&x,...);
|
y = g(...);
*if (e)
 S3 else S4
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/radeon_uvd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/radeon/radeon_uvd.c
+++ b/drivers/gpu/drm/radeon/radeon_uvd.c
@@ -946,7 +946,7 @@ int radeon_uvd_calc_upll_dividers(struct
 		/* calc dclk divider with current vco freq */
 		dclk_div = radeon_uvd_calc_upll_post_div(vco_freq, dclk,
 							 pd_min, pd_even);
-		if (vclk_div > pd_max)
+		if (dclk_div > pd_max)
 			break; /* vco is too big, it has to stop */
 
 		/* calc score with current vco freq */
