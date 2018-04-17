Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/MXraAdlMh2MozgiwKIymEtashTsTXZxvcORcHRVL/4pgGOYnDdCIu8zVtfu8nZH0PNEeM
ARC-Seal: i=1; a=rsa-sha256; t=1523981363; cv=none;
        d=google.com; s=arc-20160816;
        b=qabJCGhd5CmSuwRU+iN1MAZHtRJQJpQ2znnUlmtsFtACl9gCw/yTywxnuNmhGEzNE1
         E17Lgbiv28bGv4nHMP6ts/mjnnANgIqBAKYTOI17OsYoja+9EmrIhX4QxPCv5dpMdH1O
         Xrkx/7tU8C1AIDJ8CeRlKT6/VItb13fiTsJWn0LweQZcGuUJebCiJuVpBrDFpnxTEHEF
         AnZApBKyzEpyuZ4d5CcvxahjUM7mTKHf/K/GR6oiPtvDjp3ZIUMr+bIzzWINDp/PlzBw
         cBoXp6gUBT4Q5JZxUdKFgPXlEF5zS+w0SX+iURoz1htOxSvj+FC0oS2Ye74vXCG1/WpM
         8d+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4rH6KBcTQLLTn1mSaH5xIuz/92wpV8xOKMH4VgKABY4=;
        b=vvUV8Zk3bugjYVuS3Q1gnXGqeUsuUvaJsoTPCa4ImA7uhaeFq0mg7H9fmb7TRaKRoj
         FwT/WmfM2lSINjxoqnX84MmSPqvaAXK+6GazAJYKMLelwvqhdzf9Tb2d5LEotOMCHzyB
         PTxQPq2TmS+atF2QZ0MulYsvoN5huVWXlLRVjm3Y1rP+Z+i356dDEdEt8Gfp4bD+GJTi
         JYbewjDoqPT/9qnUpR7WF9aInAwl/liB8ff213jsm0qJs1gXWVdNrSwCCkpx2zi7B52d
         4yeM5hVzL7bcLCH+Zo1FW9pB5ZDdB8y6lUQ4zGN6HDDuG/jVNkAZFiCzoSPqzw2Lyziy
         VKwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.9 09/66] radeon: hide pointless #warning when compile testing
Date: Tue, 17 Apr 2018 17:58:42 +0200
Message-Id: <20180417155646.242666420@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009827562745795?=
X-GMAIL-MSGID: =?utf-8?q?1598010281399810132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
