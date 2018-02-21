Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224lsqcxiKQUe1aHqslPszgFlDGNPmpdVpB6bDV+tEcSrFqIihJZiiBbDPWhw2i1FznlYl5d
ARC-Seal: i=1; a=rsa-sha256; t=1519218118; cv=none;
        d=google.com; s=arc-20160816;
        b=vDEr7pmkxzKd/GpuTNSfJ7wVfFR0G7yFFd1u0XTa/zH0jItgEn/bfOEt6rs5E+5MOq
         yrhkbx6zVTBixucZ3QriVYB8EJqtnKj9nt8VVmNkgNNZI59sPVbCBoO+r4Mc70ZrSgv4
         3rGM2J16cbgLyVDEgFk4uBhsPSUukvOA0Ra0pWYBye7ZygosvKOx+9GIAk6Az9gKHLKs
         PlDZzUc0SPiTrut5GDe8odR1IIspdLyQ5msB9Zakgpf8eWliAKKdTyb6WbOkK7xxX9Du
         b5j8bgQO36Bm//MaP77lPjdNhp9E7i9i7ZD6+voXYxeOAhivRZlGnoxRUJTt2+IcNvbi
         cU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yGHdZj3jvA/+pyYEet7cpbiFLHC+lpZR32+JunoDwoE=;
        b=R6E3U2kiRYuNops0Ot8FyH/DWb2oLijnNbIpVdFtrbn7lLmBo7lGCkelvMOj5SFISF
         D8Sp7ASRv6oMbMg6hn995x6FaeXUy7bnc7vt40j/RGM0000tLvi1Ji2kJXgOhmTW3mha
         7LSUPNafwKKQNZ8VMOdHNMHFcHRUcTS26vGOyob2fVpyjqCs1fQSxHQ1LjG0vGJQPrXa
         ptnj96v9PyEz11HZLv7kvuh8ghfF9ChcsY2kM0FrQcGF/AKxuHvJm5d1DY5FfZZYelhb
         jY1FY7aD81v8eQiqT53g4GQzHZSkN1x1EO9Nqcu7sgJxzVIAjzwDSClp96pAA9gttm1B
         bxrw==
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
Subject: [PATCH 4.14 092/167] drm/qxl: unref cursor bo when finished with it
Date: Wed, 21 Feb 2018 13:48:23 +0100
Message-Id: <20180221124529.402128391@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015657382738159?=
X-GMAIL-MSGID: =?utf-8?q?1593015657382738159?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -564,7 +564,7 @@ static void qxl_cursor_atomic_update(str
 	struct qxl_cursor_cmd *cmd;
 	struct qxl_cursor *cursor;
 	struct drm_gem_object *obj;
-	struct qxl_bo *cursor_bo, *user_bo = NULL;
+	struct qxl_bo *cursor_bo = NULL, *user_bo = NULL;
 	int ret;
 	void *user_ptr;
 	int size = 64*64*4;
@@ -634,6 +634,8 @@ static void qxl_cursor_atomic_update(str
 	qxl_push_cursor_ring_release(qdev, release, QXL_CMD_CURSOR, false);
 	qxl_release_fence_buffer_objects(release);
 
+	qxl_bo_unref(&cursor_bo);
+
 	return;
 
 out_backoff:
