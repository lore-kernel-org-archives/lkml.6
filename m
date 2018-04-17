Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/d+loWMgo8AylYFzaD6je8wnO5539vlcUtrMUeRiWb8mceiE/PTrm71wXtTNnPyhmymbIX
ARC-Seal: i=1; a=rsa-sha256; t=1523980929; cv=none;
        d=google.com; s=arc-20160816;
        b=01mAjO2KSxchjSkJA5FByfQ6Dx+GP8JZw13+lF8YyNOEVbCNT7kn182Dy9Iy1xjpEU
         vsNbGtu8SXFINHD6Frunr6y6y73AzUQQyxmcADmGlXIdGPByySR7qCTGvmtE3Mg1UUjo
         ZczmrplFZONsoJhb1tmJr/t9UY7SZfdpyM5ztqfHbrRbccqJZbPp6rVr+cInYBaNtXtC
         e15ecZjMcrpzOC/yOeVWfc9A5QSGiJzs7j3CSJ0/8TxhKd8k4QtjtHKlxu1awC9kiN4B
         v0Jzif2SuNZ19Z2JSpfNK0Aa7L9UGSuhZG/5vRoDmXxORYvtsdt9yxtXMUITTR9xgiHM
         0heQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=m7sqmyWIHdArHxl20yRHb8iJATFbvFpvLl14Doo4NoY=;
        b=dj7tn9Z6/ks+IRl14+wxCB3JDLINoCdJymhU0O3LcjBGqnHc+IBFoesbGnAZSne9ZO
         dix91TFrwQKyKbT1Pem1Vip28Zc0vY4QPwXPN34qDm82jpofKaWXPsqxiViKv1jWMh7O
         GRmINfqWMXVhvvfJxyGhrTf9Jnk+wqFSYCNv31/XW4SqL1sdpsozXze28UjCLoep1pSa
         Il0ujx720uOMrERq0BiIgIl6bVKZ51QmcxxjD4RrOf6fs0gg4F1kRc/Olk0M9RRSPm+Y
         K1yne2toPrQSQJWTd/oBarY22onL9azYBVN9Jsc6DlQ9MBBGq2yQ9ZXPtWwHaY05pngY
         qeFQ==
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
Subject: [PATCH 4.16 27/68] radeon: hide pointless #warning when compile testing
Date: Tue, 17 Apr 2018 17:57:40 +0200
Message-Id: <20180417155750.444229044@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009827562745795?=
X-GMAIL-MSGID: =?utf-8?q?1598009827562745795?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -240,9 +240,10 @@ int radeon_bo_create(struct radeon_devic
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
