Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225aJQi9C8rAqhRjAfl1WOIrPL/vKuWo3Uz/ov1NO3Vu63NTvSNl05F3IV8g/6drW4gVTPAI
ARC-Seal: i=1; a=rsa-sha256; t=1519218116; cv=none;
        d=google.com; s=arc-20160816;
        b=iVuDjRIlULi19HLbIczzV++RduCy//LS0SESf0S6Tm82X7zOhhiRv90tkhVlFORWJ9
         qTEZAC+LugWqvLnZvcX1LVnJCIqUJBKHtcE85ocNaxmFgAQe0hr3aczJu3wkR4Rz+SKg
         ZYTNX575DRONfh7OPgT6frAGi8LmtU4Q2p0fezPuOgfvgaDFIUfrUtRfgunAzupdwZs9
         2k0eH+G1MiKTkMQp+GP9dQeRaWKeWSNmxKye5B9RA9MQnF3NXfICjnpAYtNUFyMUOE+e
         R3h/iAFupFR5sjHnSHJWxwx9jnNNVOWacKyg3wnt0TP+xutwdBmsNf9lEzsLN52PNGVG
         A1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+6LCxXoPhtLbFY8cKoqz+I4sPa6sEhrw3Uw2Y7sWJBc=;
        b=PHvNZJmim2xGOxXO2gPDg1gDpQq+P550Bb/etEjBCSqb9/69SNvNXHu0nmz3NrxvLe
         pJgU6Id7HGGJqgWE8ibttc2OzxNh3kMvaPVM4pq31Plisii42SHYeOpgsgEkMjxoA8XQ
         nzQXVSJvurL3DaZOgmgQPAQC3PUxqTkiAZTYhCFZqClqzZVVZYuI6cT4n5s6UJRrWKJr
         JEBgE/jVHnkTa6lSDIu3Kt+66a1XqwBk1gI+zSG3Q+2OJRHVoN6QA8ZDnPJVZRy8p7wq
         fIcvEK8A0cJF7vzJLbnVGZCJoIQRRTHmpPW+5cWYGnroPFbCv3dEvCAsQPp1dYLoIFpg
         uFnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tom St Denis <tom.stdenis@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 091/167] drm/ttm: Fix buf pointer update in ttm_bo_vm_access_kmap() (v2)
Date: Wed, 21 Feb 2018 13:48:22 +0100
Message-Id: <20180221124529.357764492@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015655908445899?=
X-GMAIL-MSGID: =?utf-8?q?1593015655908445899?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom St Denis <tom.stdenis@amd.com>

commit 95244db2d3f743f37e69446a2807dd1a42750542 upstream.

The buf pointer was not being incremented inside the loop
meaning the same block of data would be read or written
repeatedly.
(v2) Change 'buf' pointer to uint8_t* type

Cc: stable@vger.kernel.org
Fixes: 09ac4fcb3f25 ("drm/ttm: Implement vm_operations_struct.access v2")

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/ttm/ttm_bo_vm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -299,7 +299,7 @@ static void ttm_bo_vm_close(struct vm_ar
 
 static int ttm_bo_vm_access_kmap(struct ttm_buffer_object *bo,
 				 unsigned long offset,
-				 void *buf, int len, int write)
+				 uint8_t *buf, int len, int write)
 {
 	unsigned long page = offset >> PAGE_SHIFT;
 	unsigned long bytes_left = len;
@@ -328,6 +328,7 @@ static int ttm_bo_vm_access_kmap(struct
 		ttm_bo_kunmap(&map);
 
 		page++;
+		buf += bytes;
 		bytes_left -= bytes;
 		offset = 0;
 	} while (bytes_left);
