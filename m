Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2262jGV+geA2/zN5E0oy/A3k33ObKyHsotT2oQwkm5+UU8Wy/5ifOi6oAb1USYWGFLklq2C/
ARC-Seal: i=1; a=rsa-sha256; t=1519218581; cv=none;
        d=google.com; s=arc-20160816;
        b=C2JMsfS82IUc6/tfNPUNYMUrmVhrbqiPAcI+hWbzdzrr/2a56X8KGsbsvRWZizvPYR
         UZQHf7KRYZ7fl0h30ZWx/M0nXBbyjDO7Kb/efgaX8thRsTPzplw/cJD4Dx9nezTW7Q5Y
         Lvx67Im9wh6OSAw/MtVQiNImvZlKzGjhyoGhaiZeQI1BFr8QuOzL5bFuc/f1fHMQyZPr
         kiv9dW66QUfecr4k5l1i/HDAsKJrtEPW92nohfgu380Mafb4LUayQXVOKCoX/MjlleXN
         E2qI6a0um5aaAaFHLWVJ5F/YeGuERR/AP2VN6BWANVGMmGu31XbTZnLmIMG9SC2Mj3ND
         QHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qS4HaN609jSGzK7ADWuylKtZDIG7+T+kmsoBGmVqiSM=;
        b=vbCW5xoxSNkGPDgBUMFxv6gUNudNYLVXo2wX4fwduTMS7J13uQkG3ZM7juELwwSmLG
         g7SBcgDkCGQXrZ4xSk4ABRxundvjH6fnwOBAARcPdCf77e2+NBQQnqkb3D57bjoHytt9
         tHet0M3WryXuojGNYQ/QyO7fdcTy+F6lXnBMD7dXNN3uCI1C3YmWEZ6hQ8ngOCb6gbHF
         RpWg7j1foBXOtaGkJKXb2PU+RPpxlhXRbKTmeM6ZnUMTAoVk3Pog56G11JuHaMYPhdM9
         DbiVXeeYuOGF3IhCB07TSiN3LXz/lzP0gvNKi4vYjFjyLcCJ6+QPD62UpGR/Z8aouB4L
         dvLQ==
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
Subject: [PATCH 4.15 089/163] drm/ttm: Fix buf pointer update in ttm_bo_vm_access_kmap() (v2)
Date: Wed, 21 Feb 2018 13:48:38 +0100
Message-Id: <20180221124535.274708159@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015655908445899?=
X-GMAIL-MSGID: =?utf-8?q?1593016143468251144?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
