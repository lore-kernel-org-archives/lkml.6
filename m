Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELubJr4BdeIt3otBhJd70qdHtBbJPnOfEdE9QiOJtX8RCnEfzbdRiTMIMIBtiQJLiIjotiTp
ARC-Seal: i=1; a=rsa-sha256; t=1519676717; cv=none;
        d=google.com; s=arc-20160816;
        b=nbJDFFFTk/jMX7LpDnf2C0DJhdA+UihzL9BA7nTRDmtgn8BHm2OaUVBNmbbRhSNa9U
         ShwlXEjbX+oXgpcm3E2ottmOZEedj+PsqpR/wTn8Y8ofjXKOW4BhQ+t1CVJ0dzRMmS+a
         MJBrASjQSD5Qb70j+TdY4Qjw8XdSWusWeErJ4FxcJDYlVF89AwEJYGVMNpO+Qhbu4Nj2
         wRx+GYpxhlqaUpNL8NMl9Fqkmj+MW25NbgJ9XoW2mmVOdCS1/1b3BNttqIxKO+3en70u
         KJG0wnKtfS+iQucfjut2yfJXsHmikJV2EfWhkcj+aZmiaSuI5iWnbLqRCE74KfbNU+Ge
         Q9Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KaQNHOvOv0zuG2WQ1kK9V8mtdU/EB/j2jkIjSB0nB2I=;
        b=E3PD1Sfj9G17Br06HGDweCYjxN36t99kHZQO/h3cqtgbBcFC5S1f1+WKC9pd/fFwFO
         JqWmDCgm9xKEOp0wQzvBcoQ/VQ5qTMS5tm4KQuzaL2UNjqGLeAgG0HeDXbFFthBrxw95
         0t8tTO2iLofCa7J5KX5PVKMcjd54syxSW3FwB8IIXPai0HlHT2RxqkCZsernVJcWzek3
         TLPJIMxUiKyTXKykNyZ6dtwwumuzrvf+z39zlWuN7wlQr7BDe7Uo4ciC0Cgp1fC6TKrK
         9Bikt6vxxnKiwx0aNCYQ1JYQnxSbRm0xqN4t5F0uAofukqbVG5XdO7ft7BSy//eI+G7r
         bIVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 49/54] drm/amdgpu: Add dpm quirk for Jet PRO (v2)
Date: Mon, 26 Feb 2018 21:22:26 +0100
Message-Id: <20180226202147.032414063@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496533849968794?=
X-GMAIL-MSGID: =?utf-8?q?1593496533849968794?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit f2e5262f75ecb40a6e56554e156a292ab9e1d1b7 upstream.

Fixes stability issues.

v2: clamp sclk to 600 Mhz

Bug: https://bugs.freedesktop.org/show_bug.cgi?id=103370
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/si_dpm.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -3465,6 +3465,11 @@ static void si_apply_state_adjust_rules(
 		    (adev->pdev->device == 0x6667)) {
 			max_sclk = 75000;
 		}
+		if ((adev->pdev->revision == 0xC3) ||
+		    (adev->pdev->device == 0x6665)) {
+			max_sclk = 60000;
+			max_mclk = 80000;
+		}
 	} else if (adev->asic_type == CHIP_OLAND) {
 		if ((adev->pdev->revision == 0xC7) ||
 		    (adev->pdev->revision == 0x80) ||
