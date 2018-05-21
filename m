Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqEWVfIXzZb5qIyEV4dOVA9o7A3lc630TQiXZAdTdwRvXMJeppHEreSiqm0y4uJvhNpD9K3
ARC-Seal: i=1; a=rsa-sha256; t=1526937787; cv=none;
        d=google.com; s=arc-20160816;
        b=WDAyj2oU/8LAuYmmnJBxg8SJUUCu0/XtbiLqM4+qOnXIubGhYbGzYIATdtRWPp+ooh
         DFBTNQndgZGvA/BexL/k9MSkg3X5IyWw/KRsVswAOcln8/gbtaGVTGrKn2UrohlRCUoh
         FbdBRJVmUBXyTyD4O9PwR2WF7GVyIgnuM3CHe1fW/pKR5hsK5Mk47iSJ2bj/GNtDR8rV
         mC9I14jO8ulDyUPOpvsijIpfOBrISk6FSF+xmklwKIAlOofgDHltPLNJG2NgjmAK+6HT
         yNG9j74dRqyMcMp6S+45QFwcDHNnkRnQC5FhSjClL74iomD6yNVCAmDBtrZLLVZnVExX
         dckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=PvLBWf0xdKI2JohKWJZgTukFy14ovpJT7RXSIPzd2Vc=;
        b=nemNxbS6JoLvdP/HZF5TpbLZJpiJ41Jf1ZvcLolaXR8+UvJhVzRJj0wFVgk9WeaZ5c
         bSlJo7F7OFRSu81rAo/L8ZbmDcE+iOpQytzzv2LvxxiMWt18hE74qQGy/6fqmvRt8OcE
         hlE2iiVnZC5yEwxGQPlNlqjY/KstrlWZawLTreEBmTB1Ml3zcTTSSDsZ1G3RLkmrFWdq
         AEj6fNGOtS5665LNdpeQFcysjkSdDM1VgY8BSFnPMrHwXNdbhw9cGBhLCKv6D7Zfvhwc
         oOkdUJ1HTcutBGHAIJtt4z9wg4QioIKFs5NlBIQlLFICCM9fW86Xeuscd0TeO4Bh/FGS
         lC4g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0+NcutDf;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0+NcutDf;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 4.16 025/110] tee: shm: fix use-after-free via temporarily dropped reference
Date: Mon, 21 May 2018 23:11:22 +0200
Message-Id: <20180521210506.066487309@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110016429100028?=
X-GMAIL-MSGID: =?utf-8?q?1601110317314625125?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit bb765d1c331f62b59049d35607ed2e365802bef9 upstream.

Bump the file's refcount before moving the reference into the fd table,
not afterwards. The old code could drop the file's refcount to zero for a
short moment before calling get_file() via get_dma_buf().

This code can only be triggered on ARM systems that use Linaro's OP-TEE.

Fixes: 967c9cca2cc5 ("tee: generic TEE subsystem")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tee/tee_shm.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -360,9 +360,10 @@ int tee_shm_get_fd(struct tee_shm *shm)
 	if (!(shm->flags & TEE_SHM_DMA_BUF))
 		return -EINVAL;
 
+	get_dma_buf(shm->dmabuf);
 	fd = dma_buf_fd(shm->dmabuf, O_CLOEXEC);
-	if (fd >= 0)
-		get_dma_buf(shm->dmabuf);
+	if (fd < 0)
+		dma_buf_put(shm->dmabuf);
 	return fd;
 }
 
