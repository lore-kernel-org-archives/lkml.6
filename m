Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvWubtdaOBk+VRg819X3FKE4/XeOWWc8ZXO0O2TleC4whc3/h3GLCyPM/hVkhOXd3r9U+4S
ARC-Seal: i=1; a=rsa-sha256; t=1521483120; cv=none;
        d=google.com; s=arc-20160816;
        b=rbXCfA2/gsf0/W4U2MW+TV2qfW5isbOGCxeqpPTgB3FKMUM3JtZyMQXEZcaO8dxH6G
         zG1tzs1CDnMcu7X+zcSZQ+sYCyfabeTEDcRf9LbdLsczhV/RK8M+zdTwbkU+pk0HTZzn
         EK2cqpf5qacmL1b0iUt41XmlBBgi1GtFIe+9zGMclg9RuljUw+8CxfamG9S9q64HjmYb
         N8SFVa30KzhkCQnjRd3K5EGaYPUUpsOD3tkShpSZgCA6UQzgWWO0Qa+0VIWhlPMpkrSY
         rhscQPe9FxZO3ViRDEGu133/Xd2HeFOfbAxIbzIlS5kiUxNf+HlseKdS9+PS4igz5eAo
         tYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EM+k4q5E7sdXQSNTIRhYGa2nAAs3CVkLytO52BKrEFE=;
        b=u8BRc6ChTenPQz1jVZzQt5X7DgrNpy9DJ6eTT53EJjQID+MhEz9O72jg7NkDF6lTON
         e2tAVm2F2hzRXb51kSW/oN0Z2+AobUYl323sOivIzucJ8F6qIQC28MDSM/ZQ4/StEbns
         QYjvqkdAJqOOJOF0Mn6vrMQnbxBXSoE7/VcRGF8FoEKXQzjHS3cTJa/tkxXvxkc+Q24P
         MiLKwPuTp42kBBVFIuxFBP5gMDmLV1jsV0UStSpL0uqtTjPAR5dk5oaNbjBDEjR3Floa
         AUlcsIvxCtkuDDB7DgMRu8LmKnSoQostkV/+5ITEOk5OIe/Lw6W6HOzV2hVE3yRj+0dv
         tmwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 44/68] HID: elo: clear BTN_LEFT mapping
Date: Mon, 19 Mar 2018 19:06:22 +0100
Message-Id: <20180319171834.056361950@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390684316858028?=
X-GMAIL-MSGID: =?utf-8?q?1595390684316858028?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Kosina <jkosina@suse.cz>


[ Upstream commit 9abd04af951e5734c9d5cfee9b49790844b734cf ]

ELO devices have one Button usage in GenDesk field, which makes hid-input map
it to BTN_LEFT; that confuses userspace, which then considers the device to be
a mouse/touchpad instead of touchscreen.

Fix that by unmapping BTN_LEFT and keeping only BTN_TOUCH in place.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-elo.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/hid/hid-elo.c
+++ b/drivers/hid/hid-elo.c
@@ -42,6 +42,12 @@ static void elo_input_configured(struct
 {
 	struct input_dev *input = hidinput->input;
 
+	/*
+	 * ELO devices have one Button usage in GenDesk field, which makes
+	 * hid-input map it to BTN_LEFT; that confuses userspace, which then
+	 * considers the device to be a mouse/touchpad instead of touchscreen.
+	 */
+	clear_bit(BTN_LEFT, input->keybit);
 	set_bit(BTN_TOUCH, input->keybit);
 	set_bit(ABS_PRESSURE, input->absbit);
 	input_set_abs_params(input, ABS_PRESSURE, 0, 256, 0, 0);
