Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48EDcUmeLBGPd/08LtO8iaR3kcrNq4c5oV+4hqyX65XB5F4VBCQWw6egTtCchIy0YA9Em6I
ARC-Seal: i=1; a=rsa-sha256; t=1523981272; cv=none;
        d=google.com; s=arc-20160816;
        b=bgQ7y7ZpQLqOd9Twr8XJSomdRnTH7u5hgt8xynAjmA1Kx7SlIFoHAE/gGNqRyInXVN
         +2R3KyUv/ZGhhNUmj/Fp4dG/9Q6srzFXj+PkCXvO9ALSDU9b0/rtB+uZot56bbWma3Xq
         cOOf41F0RkazwiGYE9omIdcFAz3YQ6wFu3iOptvDf3A/ceqp26JT0AXmWysQkynMXObJ
         DxwXvIS6ArW4v0vglyiwI+jDORG7aOLi0XuZ6awYfMdKt+xzoS6N29O6bojYyY4HvGDk
         88cHLcvLocWph5jK+oII+Wkoc7pxWyZG7K4KNoh5za6O8aEQSpF8mHIg6v28aPKvgGm3
         DUTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RHPUp5O2QGTrfVsuCNHUdiNtzdny0kqrTb3pZhEQvBk=;
        b=F9OdNJhYLLr4ivaZ/LxhmUdD4KzU2VKQxM5P9Hdu8UbYmYg1vTq+KGCe5dDWJNiy+W
         qJPSyxNGiLe4o1aelMZM/cy/3zlcU4C1wILfTFm+X5qmwAkdvVD2Y8lZ3hXiLY2WHUw5
         LIZxwJ7CQeovQC/Q4HXK/jIuD76XBDs/DiHuZQyZpp1Rqyf/CN48vW38/ZlZR6dTq0fG
         MHCmIxAI+Z02hrnKr9HogticAhU5qqrbWFvGuBq1dp1HF2JC9JWL+zG3v7l4OVA6l1Jx
         a5prA9M8ss3zuz9SNf3bItZPsBhM3Owk2qmpZfNr7dQ47evmMEmeZrC55plhLauxbx5w
         LR1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.14 32/49] getname_kernel() needs to make sure that ->name != ->iname in long case
Date: Tue, 17 Apr 2018 17:59:11 +0200
Message-Id: <20180417155716.555089785@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009878581722556?=
X-GMAIL-MSGID: =?utf-8?q?1598010186587209360?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 30ce4d1903e1d8a7ccd110860a5eef3c638ed8be upstream.

missed it in "kill struct filename.separate" several years ago.

Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/namei.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/namei.c
+++ b/fs/namei.c
@@ -222,9 +222,10 @@ getname_kernel(const char * filename)
 	if (len <= EMBEDDED_NAME_MAX) {
 		result->name = (char *)result->iname;
 	} else if (len <= PATH_MAX) {
+		const size_t size = offsetof(struct filename, iname[1]);
 		struct filename *tmp;
 
-		tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
+		tmp = kmalloc(size, GFP_KERNEL);
 		if (unlikely(!tmp)) {
 			__putname(result);
 			return ERR_PTR(-ENOMEM);
