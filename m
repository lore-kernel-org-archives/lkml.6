Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224UNowIJRvdMsBH9wNWdfQPpyJWR6WBF0nmjTqxfUnZEcERc8rjnZlBwK23+lmJ0ZDp23as
ARC-Seal: i=1; a=rsa-sha256; t=1519217661; cv=none;
        d=google.com; s=arc-20160816;
        b=aZN8z6buVHsHedtEeYQh6N4lGYNGoD53dfflQaNg07Z3sWHlwD8aswjGeg7qJfUWBC
         FGEeQz0iPJVMqTy4yOEUMp2ZASxEsyE+AMsu0ouWf7sgAit8LnTuCnNFTnRPLwWV36q8
         TfJRE9fAd20hFvOlP2499fPjOuc2/f5B5LdezbLycbsDac8TA/2qg2Gy3KW4P90ZHJgD
         RRxPOdBsXF4W1rNx9SjD0oN/rW4iZAZ1lo8ZuTaljB/kAeOGL1d8ZDOJGtmoOpQR8Mf7
         BMnR56l9qjJomn7o1Yq4ZTQavFIOi8pMvwgc9zZ83ti5rSe0FLu5wjqyOjP2HEG9MjIH
         x98Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WronpInTAmIG5shApI4gxDUGyvo5FkixyApWXB+/W/8=;
        b=cDePrSBuXVs67EFE9leKRPZZT4Rjf8QpCJR7GYUZLKzn4fosl4XpOc2QMFn5AocLzr
         WM8Ljfkg0mMmkh+LH8vBjHumPrHLzkZu63cXhUZ3dntv8SQADOZFSk144dzpk66MkWcK
         1L4B9OcBv4vst7YUGnnYl413/i61bpIG7TF9GKfybweap0UhBFoAAB5hr3ONwq2CXyjG
         bXAolARYD/DqThwTFGkhqp61cGsl4K0ENQrsxKqQuNVwXiObDChQJG045Fy1HtRqlDGP
         Ut3ReVpHAMtM+Dvm8avyeddTQ9Ag7k1jYMrE3CcqhUd6abMAaKFcm5TPpviV2VvB83Ht
         Jqdw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.9 02/77] drm/radeon: Add dpm quirk for Jet PRO (v2)
Date: Wed, 21 Feb 2018 13:48:11 +0100
Message-Id: <20180221124432.271363768@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015178749380896?=
X-GMAIL-MSGID: =?utf-8?q?1593015178749380896?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 239b5f64e12b1f09f506c164dff0374924782979 upstream.

Fixes stability issues.

v2: clamp sclk to 600 Mhz

Bug: https://bugs.freedesktop.org/show_bug.cgi?id=103370
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/si_dpm.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -3029,6 +3029,11 @@ static void si_apply_state_adjust_rules(
 			max_sclk = 75000;
 			max_mclk = 80000;
 		}
+		if ((rdev->pdev->revision == 0xC3) ||
+		    (rdev->pdev->device == 0x6665)) {
+			max_sclk = 60000;
+			max_mclk = 80000;
+		}
 	} else if (rdev->family == CHIP_OLAND) {
 		if ((rdev->pdev->revision == 0xC7) ||
 		    (rdev->pdev->revision == 0x80) ||
