Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226zexed7aIlSLj6pbwA/yhMnl2wxisUFLl8RIs+eM5+/zwYiL6ZyoYNQVpvnOogmWKNrlbu
ARC-Seal: i=1; a=rsa-sha256; t=1519218584; cv=none;
        d=google.com; s=arc-20160816;
        b=bLwZ26dCA7l4gDcSKRIA/jARVzIhxKmbEMbxYBS6meLVhb6ysXCSgFmNRGtTLZWsvO
         1CGsbqsqd5Yz2D4yMlQsKPfC8B+C7LicfhOBIC0gYQwPT3iddGC9YtIbsSX7cdDR/3cR
         EEA1g2Y/j1CRhe20g3mKTmI13zewafrE9ZPU/9do0fINqjyyyiwcfF9jhyC+OH2SD2Rw
         cpYfPNNgoakzIdQDBnWA4NWHU7EG6JnffKhDiFOvcvbkMTVCulgWVBvRyW7HSXbz2leW
         b00BcbRFEWXTW0V8e5xcXGSw6Ay6TGmqPtIn3Xjkq2ZCe5Xwa4owhtNBb2oQPc/xz+Mi
         JC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FX9Gcgkex8nJQ1N9d8P9QdFcWdTTm+k7yE4B3mEt+Is=;
        b=OOzE0nuDTwnkxo6B5advJz80K07LxPV23owc+qZJRvemoY2Ps0WIiI5Bc1zMgEmxMy
         QKnoDXs1mULSPwMMZveLGAvCfE3WZLSfUH2QLZ9A3wSU4PvvAe6jYMVJKBnrDVMT6GwS
         pELAiCmwEcXq13KdZgcJzmvFlXZwLw8g9kD+XGcID2JAEuwq00SRk0cLQHVXXZJXefiI
         yNUhHkG4PdO3OHieqDSohanez4WrLtTUnvGlvyqGHpt5/8DEmnjG8XXS+pohvcmy8z0W
         sL+yv0cEvByZEU7wpSsCgV5bFGhKKZ1H9Or9NWW1n4fctHyEC8PO3aD0xNZA/xUkrPl9
         RzLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ray Strode <rstrode@redhat.com>,
	Dave Airlie <airlied@redhat.com>
Subject: [PATCH 4.15 090/163] drm/qxl: unref cursor bo when finished with it
Date: Wed, 21 Feb 2018 13:48:39 +0100
Message-Id: <20180221124535.315936595@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015657382738159?=
X-GMAIL-MSGID: =?utf-8?q?1593016146949509969?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ray Strode <rstrode@redhat.com>

commit 16c6db3688734b27487a42d0c2a1062d0b2bad03 upstream.

qxl_cursor_atomic_update allocs a bo for the cursor that
it never frees up at the end of the function.

This commit fixes that.

Signed-off-by: Ray Strode <rstrode@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/qxl/qxl_display.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -575,7 +575,7 @@ static void qxl_cursor_atomic_update(str
 	struct qxl_cursor_cmd *cmd;
 	struct qxl_cursor *cursor;
 	struct drm_gem_object *obj;
-	struct qxl_bo *cursor_bo, *user_bo = NULL;
+	struct qxl_bo *cursor_bo = NULL, *user_bo = NULL;
 	int ret;
 	void *user_ptr;
 	int size = 64*64*4;
@@ -645,6 +645,8 @@ static void qxl_cursor_atomic_update(str
 	qxl_push_cursor_ring_release(qdev, release, QXL_CMD_CURSOR, false);
 	qxl_release_fence_buffer_objects(release);
 
+	qxl_bo_unref(&cursor_bo);
+
 	return;
 
 out_backoff:
