Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/wJDkNr0ir3zM2Zho3tgJyZXSkSoyhACcP38r35+FYM/bM0pPtllluJf//8xeDnZ3wQLjc
ARC-Seal: i=1; a=rsa-sha256; t=1524652899; cv=none;
        d=google.com; s=arc-20160816;
        b=m+fkkM9q2wpOI5VX+asUEyhtNG3wO1hZOeswqcDX1Xdn2b2PhcvVp/UxFBfHh4H9rW
         tMedyLCZQ+AEeWLT/620Re6eZfQfnD850APgAyaAP/q8VPEk377ySn1Mr5bmy/67Xbbm
         rZPJL+x1B/mAL7d7BPbdvfSKKPrUgEROHj6h6z1dSNwQrwS4LNOywoi2FCt/n/LXsMMA
         sMS3UtakPLYtiCLjeOrewiY7AJbxuf8ZzN3vf5PWQHJ4C+UKdCVGoczYpZ45dCzZIZox
         ZJzrJ3QnPMtyoVfwuQ9/yGA7GQ4mbU/6rZ28jjDL2cocdoxW+uQ4ynMBJ54upn2iU338
         k3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3/wOuH/uK930gu39Wp64NG+Hi+2VTGRxLtroj8Qw8iM=;
        b=yQX6npM6bH6I2DUULfADKpXglTs7iduFT48+gN6Hlg6ErC5xb861VQzGIsNctaY02f
         NirPIAXsfI/OMYoXq1HwfhWovkDq+94DYbsogAElf+N9i5FpNLrqK2VaZXVcPuSl7fOP
         NKBjWQU93m2Ks3S3bR5+0MK8mjVLlk0qFCqheDMYUQN3CfkkegBSq236bjI31/4GiJeC
         nMB8EMNi06EeEK5DYi4CDHq5AE0FgqVp1pYDtagIRyCzm3FjhRBS2u0EMW4WPKLMqZYY
         aFdWdUBz0sEQFW85UaOJCe3+h++ghF9D7+h61urloJ79/b+sF6m/nkBW3+n0V1pVyIua
         mWUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Silvan Jegen <s.jegen@gmail.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 074/183] HID: roccat: prevent an out of bounds read in kovaplus_profile_activated()
Date: Wed, 25 Apr 2018 12:34:54 +0200
Message-Id: <20180425103245.490352414@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714438274949546?=
X-GMAIL-MSGID: =?utf-8?q?1598714438274949546?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 7ad81482cad67cbe1ec808490d1ddfc420c42008 ]

We get the "new_profile_index" value from the mouse device when we're
handling raw events.  Smatch taints it as untrusted data and complains
that we need a bounds check.  This seems like a reasonable warning
otherwise there is a small read beyond the end of the array.

Fixes: 0e70f97f257e ("HID: roccat: Add support for Kova[+] mouse")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Silvan Jegen <s.jegen@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-roccat-kovaplus.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -37,6 +37,8 @@ static uint kovaplus_convert_event_cpi(u
 static void kovaplus_profile_activated(struct kovaplus_device *kovaplus,
 		uint new_profile_index)
 {
+	if (new_profile_index >= ARRAY_SIZE(kovaplus->profile_settings))
+		return;
 	kovaplus->actual_profile = new_profile_index;
 	kovaplus->actual_cpi = kovaplus->profile_settings[new_profile_index].cpi_startup_level;
 	kovaplus->actual_x_sensitivity = kovaplus->profile_settings[new_profile_index].sensitivity_x;
