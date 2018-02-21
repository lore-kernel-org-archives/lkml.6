Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226oq+rQbc+3ccKA18MEIUTx7/xpdsGNoEljxLiBRFHms+BEtdRlKCLpg3FTAXXF1UK/7vB6
ARC-Seal: i=1; a=rsa-sha256; t=1519218120; cv=none;
        d=google.com; s=arc-20160816;
        b=tZASmvwVwP0Qjy7iPhhlI9U/ewAuP+p4cvFrY4iiPdm61ZoNCOS0xDK/HpVwGiM9yD
         Vecpm6qGQT6Fny3MJo+ATgYaleRcqqH1Jwv5Dyp7BY7TOQgwP7yiFn2ME6EOxqJqKyws
         +kIB1pUsJqCzFjqjMXohgjUWxmPF5c6E812j8fIDLct9mzXxZrhlomaDOVcbzqKnUyf2
         jtFD+8+c1CwqEnZLF4MSulHNp3Gv/beBomYZiz8HOF2GDSWJ0ZhbMSXAE5s3TIqJBKr3
         mvfHpuOtJyXcGCWkKRQD3Rk7ASPqL0/MO+mVA6Hmxyyam2aVQKKsDrZLEUcUg82lLf7k
         Hc4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=I/rPmDYEkvkd9S0c+FNMFw6rFzmGqoWQFqFyQ6I99J0=;
        b=T0eUbDzLdpTMg6oPC5eSKyRzkVQLP8T9cvi0mOoSD8A4jwJPFQU5GyAkR1WyfbWk2m
         d4yn93TCfMEZ7pqRMnQy9h6I7NHaxG6u3TKIE9X5E2ch/4UD2LWR+1hejWf8Wc4wFH6R
         HrPHAUYh/dXOR2Ppkoh79u6iiZoBmhCsydcAm5n6RwXoVN+xl3J1078M70SXMS4IB+WI
         mdkrMJUV27Wd1boPIN2zZpAJi23owVEQrf0JB75Z1lNazNAmQIi0DgKlK+vJ8iTkXLjR
         K54nHUnedKDBXo9sGKfR6bHnSDsm7fkY9Yl3eOdp5jMaP3y0jirc/m0qFbVFIvsm73Gt
         e9yw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Peter Rosin <peda@axenita.se>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Bill Fraser <bill.fraser@gmail.com>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Dave Airlie <airlied@redhat.com>
Subject: [PATCH 4.14 094/167] drm/ast: Load lut in crtc_commit
Date: Wed, 21 Feb 2018 13:48:25 +0100
Message-Id: <20180221124529.494334996@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015659831429852?=
X-GMAIL-MSGID: =?utf-8?q?1593015659831429852?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Vetter <daniel.vetter@ffwll.ch>

commit 24b8ef699e8221d2b7f813adaab13eec053e1507 upstream.

In the past the ast driver relied upon the fbdev emulation helpers to
call ->load_lut at boot-up. But since

commit b8e2b0199cc377617dc238f5106352c06dcd3fa2
Author: Peter Rosin <peda@axentia.se>
Date:   Tue Jul 4 12:36:57 2017 +0200

    drm/fb-helper: factor out pseudo-palette

that's cleaned up and drivers are expected to boot into a consistent
lut state. This patch fixes that.

Fixes: b8e2b0199cc3 ("drm/fb-helper: factor out pseudo-palette")
Cc: Peter Rosin <peda@axenita.se>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: <stable@vger.kernel.org> # v4.14+
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198123
Cc: Bill Fraser <bill.fraser@gmail.com>
Reported-and-Tested-by: Bill Fraser <bill.fraser@gmail.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/ast/ast_mode.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -644,6 +644,7 @@ static void ast_crtc_commit(struct drm_c
 {
 	struct ast_private *ast = crtc->dev->dev_private;
 	ast_set_index_reg_mask(ast, AST_IO_SEQ_PORT, 0x1, 0xdf, 0);
+	ast_crtc_load_lut(crtc);
 }
 
 
