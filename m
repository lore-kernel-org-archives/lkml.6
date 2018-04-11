Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/9njcddO80G9BNSkvN24laXpyBSXoNny7W3GeadfDvyz6L8cmqreAvmEmhz6KV99Gup7lN
ARC-Seal: i=1; a=rsa-sha256; t=1523472989; cv=none;
        d=google.com; s=arc-20160816;
        b=mCmR/USscubf1Uuqkq09q57d6DvbTmlntme6w7MD/S9YEyO21svxFoDt2/yjiPZl0F
         O/AGqMj3sKwoGpcldcvcmhKjL8uvEwXIB2VzeWJeeuM63+0HvnR8/q4mBpyuonCDnWqq
         1xUOA7vpZk55WDfaTB6PD7FJtq9KFWibf1GLVIE4Vi4Z9KiK4qr/QHC6AkIS/uzaz7IG
         ORRFQ+J15nTfxmey4kgtc6IlCcKaoKvK8WgpgNaEr+dBK0XwpEOpKp0sUczBzFrg9AZR
         Z0tYMMP16Gh5uOJIz0vPLn6p2NAUV56r4tP9r7AGaiAcMDWV2Kh8zU+e9/FFAwNmsQoB
         hXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oFB7r9Lo3pa4McnUftIMkEebKxaL74jCzUItfxJFrNU=;
        b=RyIvW6gpxPl+2J/maqJxIPZkyGEucuKJVbYNIFzD/E/X0UG07zWyN6C5DgSn2Dpzdu
         bN2/hKxaN/L7pVll0M98X2A1uwI2Ja3wOZPy1nWcptN5EHM4KQSBtsYPHN+Ch3NGD0xt
         m5xWO9MHFCk8uKNlxaA+EiudlacmPX2vwfJEBOj7ShawmQXtKRCp0XpkHRYwD3Q1DM0Z
         esYFMuppFZA/TJIp4D7xMb8kiNJo+NSwRdp139fBlMikrDnHzT+hy3+W1TqUivVDfk3P
         gTevJ/dw3CNLs6+VrQBGCOGh6DAz/6rERHHXrYJiTyP1s8YvoIZ+DxzIsKDU+mImWlzL
         tnFg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel Micay <danielmicay@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Kalle Valo <kvalo@codeaurora.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 089/310] ray_cs: Avoid reading past end of buffer
Date: Wed, 11 Apr 2018 20:33:48 +0200
Message-Id: <20180411183626.084276851@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476131371214930?=
X-GMAIL-MSGID: =?utf-8?q?1597477213772809186?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>


[ Upstream commit e48d661eb13f2f83861428f001c567fdb3f317e8 ]

Using memcpy() from a buffer that is shorter than the length copied means
the destination buffer is being filled with arbitrary data from the kernel
rodata segment. In this case, the source was made longer, since it did not
match the destination structure size. Additionally removes a needless cast.

This was found with the future CONFIG_FORTIFY_SOURCE feature.

Cc: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ray_cs.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/ray_cs.c
+++ b/drivers/net/wireless/ray_cs.c
@@ -247,7 +247,10 @@ static const UCHAR b4_default_startup_pa
 	0x04, 0x08,		/* Noise gain, limit offset */
 	0x28, 0x28,		/* det rssi, med busy offsets */
 	7,			/* det sync thresh */
-	0, 2, 2			/* test mode, min, max */
+	0, 2, 2,		/* test mode, min, max */
+	0,			/* rx/tx delay */
+	0, 0, 0, 0, 0, 0,	/* current BSS id */
+	0			/* hop set */
 };
 
 /*===========================================================================*/
@@ -598,7 +601,7 @@ static void init_startup_params(ray_dev_
 	 *    a_beacon_period = hops    a_beacon_period = KuS
 	 *//* 64ms = 010000 */
 	if (local->fw_ver == 0x55) {
-		memcpy((UCHAR *) &local->sparm.b4, b4_default_startup_parms,
+		memcpy(&local->sparm.b4, b4_default_startup_parms,
 		       sizeof(struct b4_startup_params));
 		/* Translate sane kus input values to old build 4/5 format */
 		/* i = hop time in uS truncated to 3 bytes */
