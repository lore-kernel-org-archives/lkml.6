Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49TgL1QhxSuMCWxrL2bSShgqwvcaI3gU3/6Cv+coC191iK5jeuxrC6nTCB4abFwCf72CD9b
ARC-Seal: i=1; a=rsa-sha256; t=1524652793; cv=none;
        d=google.com; s=arc-20160816;
        b=bmF3GtCbOEZs3FJNrHUmgb5L5pm+HlBop1dyVXlJNHY8IatpHE09FAjJ3LyGwMK2mQ
         g9KJWLxFYbfkMrg58twdwq7obErAaX6h5+V/e1vuv9nwds4gu8lNFW0KTuwwGbQALzqx
         I4b3g/rWcndKh1FG1tfACNVhhFhg8pnCdH6+lIXvwy1c1P38CLwBRvin73x9fKzlfysf
         1nU6eLYaKXySmy013W+pkj5u21g3PctJST0fwZWntA2XNACwl6FO3lF9QbM5PUvN/Xmf
         bhcRbYJ5RVylN9OYhoDREoCdfBTw4eMKVUex1Kw0XZDzwXB4zTGRXXW6UAso5A3/FTFL
         KlrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HLFKMPyE3sU7W5inqK4f6TuvV38gA2wImnOzZ4tbgjc=;
        b=kVZrRa10t2PsP8a5zGt9dzCcpXR7Mhm+xvee3caG6cqtwkunt10iJmDmUVoN9genMD
         8zshizYDeHfZFDvEYugmqUhhqBh9MxK4JCgeSmW68EuOElZJod195VvHV8t5QSb/Xokz
         Nmij/VstwqGKKWSbAn7nFGqcKMkuHcS679dhx8ssA6rXSfnVuyzrlgC3zCL2W8vCz+6v
         z+aQNT2qmsb8hhOYELyEKL901On00izjv7xxsJfTXrjPsW5euMRPrwvSgc9lpIoiDtcQ
         TflJprhTCCQILIVNBA+3GyTjPfwZljXHz/XzNTIDrTEQ/JVqQ4Qxxx4zyzUz62upZPN5
         GH8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 034/183] Input: synaptics - reset the ABS_X/Y fuzz after initializing MT axes
Date: Wed, 25 Apr 2018 12:34:14 +0200
Message-Id: <20180425103243.953529860@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714327550950138?=
X-GMAIL-MSGID: =?utf-8?q?1598714327550950138?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Hutterer <peter.hutterer@who-t.net>


[ Upstream commit 19eb4ed1141bd1096b9bc84ba9c4d03d5830c143 ]

input_mt_init_slots() resets the ABS_X/Y fuzz to 0 and expects the driver
to call input_mt_report_pointer_emulation(). That is based on the MT
position bits which are already defuzzed - hence a fuzz of 0.

In the case of synaptics semi-mt devices, we report the ABS_X/Y axes
manually.  This results in the MT position being defuzzed but the
single-touch emulation missing that defuzzing.

Work around this by re-initializing the ABS_X/Y axes after the MT axis to
get the same fuzz value back.

https://bugs.freedesktop.org/show_bug.cgi?id=104533

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/mouse/synaptics.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1280,6 +1280,16 @@ static void set_input_params(struct psmo
 				    INPUT_MT_POINTER |
 				    (cr48_profile_sensor ?
 					INPUT_MT_TRACK : INPUT_MT_SEMI_MT));
+
+		/*
+		 * For semi-mt devices we send ABS_X/Y ourselves instead of
+		 * input_mt_report_pointer_emulation. But
+		 * input_mt_init_slots() resets the fuzz to 0, leading to a
+		 * filtered ABS_MT_POSITION_X but an unfiltered ABS_X
+		 * position. Let's re-initialize ABS_X/Y here.
+		 */
+		if (!cr48_profile_sensor)
+			set_abs_position_params(dev, &priv->info, ABS_X, ABS_Y);
 	}
 
 	if (SYN_CAP_PALMDETECT(info->capabilities))
