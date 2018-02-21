Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2268dQS759C+/fnFUR9M7ZVZzKETd1+w60W6Lp/2j0K6LCkSBnWiNSYuhhpmIy465dJhdJrp
ARC-Seal: i=1; a=rsa-sha256; t=1519218638; cv=none;
        d=google.com; s=arc-20160816;
        b=r0dgUNE04yvCP0sBHPUPP3nFXM7psi679rwMzRIgX8pkD5sdj2CpdhvckY/Kks6IZI
         9aAeJqC81SvCkAlYF3ZszdbBukR94lPT9bbM96w32M17Lyh8B/3vFp/oRPnnA//iutsb
         AUdX6IEarOBZFWk4MSS3lhOsVI+wdt8NFePg8zo5zSvcpRUVJeDE/6N8Xub29I9vFwJq
         cs1OXdqRnFcI1gWieQUb5+1H9116Fb0zrfniam2Ife5qLt0cmZsz2d2soWkAHhY2bj8E
         Lj0ZJW6xAMSaI9+qNlROATeJnha5ig+5QdcDKLW1YC37iAbZVjlRgGKV8h8J3hxJSPSH
         jVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jGdBkl9nvwYxJNtw1LpBOgcyYKw/wdQ/4sWgJes14Kg=;
        b=IkOhMh5Uskxg/xIvcBj7/Bl1xekA7WZWWokYHIj5W2iGYLvVmoYJZQ/48jwodFwkoX
         5+epV5XImhFFDY2Yy4aO+Ugc7pmV0G9AyCsIDIDzvHC3MQ9toBINnGiEDlpAYeK1PWWM
         dC31wNTnyQxD1h3A5LXKbsTpPD8mgilbqn2xMh8YBR4h9/Z1PfC6EVQfx7f3EApFNAIZ
         e6mjLWnZfxMv0/ugEXHVShNrM3WS0LMAOwSpC/fUmDGN/DglCSWk4Qf5NnvwIeftvL3P
         irMs+P8KiojFH8RK174M7nrT8S4xBg4uTAiWFVRRkS++AWbs3Jz3bBgLrSdVI7wa3ghN
         hflA==
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
Subject: [PATCH 4.15 093/163] drm/ast: Load lut in crtc_commit
Date: Wed, 21 Feb 2018 13:48:42 +0100
Message-Id: <20180221124535.470997389@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015659831429852?=
X-GMAIL-MSGID: =?utf-8?q?1593016202397867723?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
 
