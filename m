Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu7LcFR/s81DK/pU5KXhdmQERD1mtVyjJyka6bVb745UKmiUat6VwiZYe5fDJma3Wujxwca
ARC-Seal: i=1; a=rsa-sha256; t=1521800290; cv=none;
        d=google.com; s=arc-20160816;
        b=XqSxQfIfF7vzzr+id3CA2Y7Cb7XiiX+Se0/pt89kmaB3l425WQshG44ngfqCmb4VE+
         eOVr1kZtkDZC0RZfHKx/v/lWk+AFaDAiCbxh/BemMhD4gox/1kjKo23mzqFtIUsNnKdP
         WhmaD45BDFoKopOPUZnR/cpEqnz25IN5LOiOIMWq20ExOGVyT+dmIaqxh4ApTdj1ZHkn
         PJs1hWwlbk5E3PHfNpBNI5JUxrqqu8zuR4G9R0S1q6MgAYom2GEvkPUSEMo98h2cqg5i
         BC60uMWlhpzM8cFr3snHAUKHFa3e9TeuosLyRoG1BJJ623joiyJqov95pbUSCAg9b3Sx
         ZeVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DWd1jaWBRJljtxJJbVTsRmfsibmDcx0wjYQaku7KMeU=;
        b=trJsV/EFhtjzk+xHeO6wmT+GjQMkbc8VCSjwuwio44Sbwf+w9sPWxUIiU9oJE3k2N+
         F5lgqKzj/dKmE2sXlOEoTT3uYoM7UQyCoBA6wcm+Rk+dHBENVUYPTstsX7CCtWBXgm7c
         YzyYLS6bN2LU6ZjmsaU1GwEayV0ph9KlDCgNG/EunBbpd138U1Z9kIYG60cjxJUAVHTQ
         pxQXHwbpIaYT03QzciuE5MnWWHCcxAWhJkiKkYZEWWQG9G1eh+akZUTuDVueekNZ2cmQ
         LSdbh5bbvczP8TwMkR6US8gd4YS9m5Lsfj2ktIOeAoydzWFh0IQ2RMmOuGbLrg6hP2B3
         W2NQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mikhail Paulyshka <me@mixaill.tk>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 16/47] ALSA: hda - Fix headset microphone detection for ASUS N551 and N751
Date: Fri, 23 Mar 2018 10:55:07 +0100
Message-Id: <20180323094248.824914528@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722525822159800?=
X-GMAIL-MSGID: =?utf-8?q?1595723260790384958?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikhail Paulyshka <me@mixaill.tk>


[ Upstream commit fc7438b1eb12b6c93d7b7a62423779eb5dfc673c ]

Headset microphone does not work out of the box on ASUS Nx51
laptops. This patch fixes it.

Patch tested on Asus N551 laptop. Asus N751 part is not tested, but
according to [1] this laptop uses the same audiosystem.

1. https://bugzilla.kernel.org/show_bug.cgi?id=117781

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195437
Signed-off-by: Mikhail Paulyshka <me@mixaill.tk>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6493,6 +6493,7 @@ enum {
 	ALC668_FIXUP_DELL_DISABLE_AAMIX,
 	ALC668_FIXUP_DELL_XPS13,
 	ALC662_FIXUP_ASUS_Nx50,
+	ALC668_FIXUP_ASUS_Nx51_HEADSET_MODE,
 	ALC668_FIXUP_ASUS_Nx51,
 };
 
@@ -6740,14 +6741,21 @@ static const struct hda_fixup alc662_fix
 		.chained = true,
 		.chain_id = ALC662_FIXUP_BASS_1A
 	},
+	[ALC668_FIXUP_ASUS_Nx51_HEADSET_MODE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_headset_mode_alc668,
+		.chain_id = ALC662_FIXUP_BASS_CHMAP
+	},
 	[ALC668_FIXUP_ASUS_Nx51] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
-			{0x1a, 0x90170151}, /* bass speaker */
+			{ 0x19, 0x03a1913d }, /* use as headphone mic, without its own jack detect */
+			{ 0x1a, 0x90170151 }, /* bass speaker */
+			{ 0x1b, 0x03a1113c }, /* use as headset mic, without its own jack detect */
 			{}
 		},
 		.chained = true,
-		.chain_id = ALC662_FIXUP_BASS_CHMAP,
+		.chain_id = ALC668_FIXUP_ASUS_Nx51_HEADSET_MODE,
 	},
 };
 
