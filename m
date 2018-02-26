Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225MLNIIFy0RwIjJPr00rN1edB/3u27wUHEXHK1qe45KcbuXtiSLqqDi44JB7PxZDvyvOvd4
ARC-Seal: i=1; a=rsa-sha256; t=1519676529; cv=none;
        d=google.com; s=arc-20160816;
        b=XpOwUJ3ghNvRYKnlzHzAhhuWQIcYAB4iVS0BoN2/Mq53l7UVKEUi7U8c2bYqCtMU5K
         ZHFguw4A31YvYmn5u7XnXSO9cgUBg7a2zB6WuL6Vn+uw4ZZnkjXwmopJcG5bslO5O4/i
         Pc+i3d77juFxx+UZTIe8gL6xU7N/xB8Mi+jDPO7Ja9WqwdUW++AgccScPyGjMKDmQxce
         tL/dl3tGk46Zo9RIqz4Lyb37/zcTNLRkRfRabWdJclMLrpdtE4ZK1tJrXzYf/r1Wv6kP
         am7nu0XT5ndTw0EXVYaqw6EPIgdUv1CUubMkzY/8quZbrOERv94K9WvnZGpZEuJ+Mh5v
         9Qqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7K/q5vbge+h9li2umH0MTp6KagsE6tJJ9TRssD3wQ8o=;
        b=nRECxPxxRjEnDIt5KFhpLTlIOAcJIMrZQtjLwzqFdeYbC+pTd9o5+AU1V+o2U5UQ/I
         5fPrUGlA3e967avBO9EP4g2Ud7u7fln0dO2KsMA9mh/ksYxLKMoDQf2kUnZtqM8KQE4M
         nCzYVIzABa13x/IB75huce2m8P1zINpiZIOV9KbIQrUHRuIiVckjE2LFDwMT7/oU++Z4
         It8NuoR6G/+3O1yBQht1UPyjtz15+dU1FxVkmoxXmYK2bJbxpXi4pElRhhr7IKmOw97H
         DRlTL53M12QLHYeJCFiyR/i626+a4jA4w+XjcHVVFfJW8cCz4KPHxfFzvwHkPhRJFhEq
         JWqQ==
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
Subject: [PATCH 4.9 23/39] drm/amdgpu: Add dpm quirk for Jet PRO (v2)
Date: Mon, 26 Feb 2018 21:20:44 +0100
Message-Id: <20180226201644.686950325@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496336623972311?=
X-GMAIL-MSGID: =?utf-8?q?1593496336623972311?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3507,6 +3507,11 @@ static void si_apply_state_adjust_rules(
 			max_sclk = 75000;
 			max_mclk = 80000;
 		}
+		if ((adev->pdev->revision == 0xC3) ||
+		    (adev->pdev->device == 0x6665)) {
+			max_sclk = 60000;
+			max_mclk = 80000;
+		}
 	} else if (adev->asic_type == CHIP_OLAND) {
 		if ((adev->pdev->revision == 0xC7) ||
 		    (adev->pdev->revision == 0x80) ||
