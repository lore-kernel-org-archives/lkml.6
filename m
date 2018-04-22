Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49R+I93CK/1QTtYfxChVK/33j3sSA9QRUpcnJdGK9It4iSLvevKFrx4JQlOSPs8ufZPpVU3
ARC-Seal: i=1; a=rsa-sha256; t=1524406604; cv=none;
        d=google.com; s=arc-20160816;
        b=Wg+fEhMCkG8V6FFQ6M33J6MCYceBQv5N1C8OA2cAlo2S2/5DvnSrDuTt60YUJOT4jq
         U4z0a+YQ06aYv7UlPB/cQ9IodE3WKRmW0m2+6J/BnSsSqTTubHakH0KyUlmuPiUDRjMI
         +kdO3mHfrZLX4HIiW90dwskUs3a9UV66H5sJwD+hAXZ0S379Qz1VKzngfRfodC2cLYnl
         dyRckFcYVD/Zj6SOHh9KXmT9DnoYFaDWmTzzmBx+eycIvn0xZKfBTkLX5aYwpzPYuMM0
         jOsKWfyWpz+bFDqKsXdbuAyJ9KxV6r6OBGN39j2pjRGH+XqdTtB8u4N8ko24wwrNARcF
         d/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GkcB3CXYS6B4QqRuCnP3qS6DgB4FCh+M+B17H0tDqUQ=;
        b=YT15n2HTLt74bHqZBhuNqAqfZvzTfr2isskSPFHuFTbPg1TJNaw9D6Yq9BhFbHs5sE
         MjgefzQm//UAMGw5PjLzBYvQbzfLYdYqL/hmVIWd+puDYzFI/7JUMZsKO4nhsv7odNV8
         jIwRYPJvd34iNpCOx26hirc16BxPH4UsR5OOKH6rHi4eWF5cQNpf0DkDew1Tgk7QECc3
         uMWtlBfU8kKZQDtsbvIYstg5IrQwvUDcTpGJd6nGo+NZikLUbSgn+EfwQ+eX0kkTLkHu
         YnUt6BSEDgUvp7oL2BOi1vqV4tflsWQLLJ8N/7N7Ozeq7YjEQg6us6Tz1M43snzuNXtW
         1YRw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.4 07/97] radeon: hide pointless #warning when compile testing
Date: Sun, 22 Apr 2018 15:52:45 +0200
Message-Id: <20180422135305.049009498@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598456179535450107?=
X-GMAIL-MSGID: =?utf-8?q?1598456179535450107?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit c02216acf4177c4411d33735c81cad687790fa59 upstream.

In randconfig testing, we sometimes get this warning:

drivers/gpu/drm/radeon/radeon_object.c: In function 'radeon_bo_create':
drivers/gpu/drm/radeon/radeon_object.c:242:2: error: #warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance thanks to write-combining [-Werror=cpp]
 #warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance \

This is rather annoying since almost all other code produces no build-time
output unless we have found a real bug. We already fixed this in the
amdgpu driver in commit 31bb90f1cd08 ("drm/amdgpu: shut up #warning for
compile testing") by adding a CONFIG_COMPILE_TEST check last year and
agreed to do the same here, but both Michel and I then forgot about it
until I came across the issue again now.

For stable kernels, as this is one of very few remaining randconfig
warnings in 4.14.

Cc: stable@vger.kernel.org
Link: https://patchwork.kernel.org/patch/9550009/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/radeon_object.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -238,9 +238,10 @@ int radeon_bo_create(struct radeon_devic
 	 * may be slow
 	 * See https://bugs.freedesktop.org/show_bug.cgi?id=88758
 	 */
-
+#ifndef CONFIG_COMPILE_TEST
 #warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance \
 	 thanks to write-combining
+#endif
 
 	if (bo->flags & RADEON_GEM_GTT_WC)
 		DRM_INFO_ONCE("Please enable CONFIG_MTRR and CONFIG_X86_PAT for "
