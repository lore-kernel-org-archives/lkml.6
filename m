Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsc1rRGiTTl0oYnIYsuk3V9gU6eJCDjguGuHsF8kAxpEPmh58NjKBbxj59ApbqlxVrx8QGg
ARC-Seal: i=1; a=rsa-sha256; t=1519410704; cv=none;
        d=google.com; s=arc-20160816;
        b=PLhKsxrGSIX60NrA2S5D1pi70ZDxMzTl8ZLHrJ3c58Q6T0ycngXDdkrZKsmOeQFXnU
         9JljWH34aJuNVWl4CN5wp0d9mgnZLXyYepygq736rA9jmzoVR0D35dRc7bjqTKpYHzlk
         jsjiaGRBoSwYhJmHnHjAwVcPKUiUvJl/uBPTB/ShMmJ/AouuUcAu5+uaOsmnWs0dAZy6
         MDZS5MZGYnls0ur8WGFFv/+Kq6dfBNUQ2uJIyvTkgtmyaUNnAWD+BIWwI8WriX/5LkGC
         ZTH66lbLhgwmmbsG81C+wfO/SgC6uoNNNoZRBBnuyUcwFoE++FUAuvhWLxiNJID696sm
         b+uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bY83WQTmTYq1cR0vy64TxhGGujhdSpGCO5Ziu9mtpG8=;
        b=lerp71MecaXS1PXgZ1fKgLGI0cDlLGPSZg3GAV1K0CtBoSS0pfFOdgGrzpUKWFAmJq
         RWCVxPbuIfU5/gzv+Xy/vvxmz/YRICEUuk9H4MY6p/wU/eqdy5jVMQdQGomgp6vmW7xC
         Qbd7xDzLs0yuep57ylkS1GrJhZ2W/zZ82yjT8a8OjpA4/0KtJxJzprto/fdTk70HnZ2t
         TQ7U9JVZL4uJjkhW06MYdbuHilUa8COyvubORj9vLtBQCSB0CsG8G38rQ0geA9eKa/Rq
         aRvCA8eHV59TZ5sCGmZfNVvLbRiBmebD3cITwtWssEPCG9vGbjP6Dz9GTb3sJqDGRx6Z
         ZLuw==
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
Subject: [PATCH 3.18 08/58] drm/radeon: adjust tested variable
Date: Fri, 23 Feb 2018 19:26:07 +0100
Message-Id: <20180223170207.967288140@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217598843962176?=
X-GMAIL-MSGID: =?utf-8?q?1593217598843962176?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -947,7 +947,7 @@ int radeon_uvd_calc_upll_dividers(struct
 		/* calc dclk divider with current vco freq */
 		dclk_div = radeon_uvd_calc_upll_post_div(vco_freq, dclk,
 							 pd_min, pd_even);
-		if (vclk_div > pd_max)
+		if (dclk_div > pd_max)
 			break; /* vco is too big, it has to stop */
 
 		/* calc score with current vco freq */
