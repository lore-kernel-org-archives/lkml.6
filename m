Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtdsOW3JW2RrCxkoXBd9uq0T520OodJrajaQkvEMSNr20lSYEVN6si5Hi1imFUWvnpxHhvy
ARC-Seal: i=1; a=rsa-sha256; t=1520955327; cv=none;
        d=google.com; s=arc-20160816;
        b=M0uBdA0kxauP571kR9CGqnIaTB0U0l+8VVaWgqB48BC0tEfPcvavjABWhjJX4HqrdV
         3O06FBBWq4PVof2Y8O/Yv2enPLN0iySG+Zyv5nS0yU2T+d8Y6on2SBmLf7hD7ium9o3m
         MrFrhwMpQmWWnkyUXz9n0Y9AHwOkcitL8EM6VDfw97JoAkEMBEC1pEWpiEs7JCs/zM4+
         30mAAy6u+ZIPv5kDc+UvUVw7Rt1HhS/Gkpf3DCcwo3m3PViSShw0KVykNrspqSF6OQHw
         IeLSvaFzpsQu/YmF/5CUJHC8HeJD0it48SqKjpcl5Ol7AaOyOhRkrqk7AoHXKMnAnQhL
         pFGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tKLaGFfUmZ4yKWOO99kexeYlHCVxQ7yg0w8tADSZhEg=;
        b=nUD87JuhpWtNZcXh2oUIdnT9ausWPL4bsxGGs5rGnMmytkBlSk+PulKLdduFQJrJP0
         x+8j3S4MimAhxVLPN52dvAGhV8E5PBH1RpobybbPxXYl/Z7YGQK9anr2R7mfPqH4pyOQ
         ZqvEDQoI1GDphYSiQt+L/MYJuneg9UTeVKTzGMyH2bBaPmmyZUFfthnpWtfJGQiFT07O
         ANJ6vSGXTdeexvyB6da76At9c7BLkGx1kBVGLMtCdfW/meOkYdugBmbQrapvVtt5YdjJ
         Gfpyx60B/dOvel4kBvMRyf7JycaDBr6hY9FxKDfgZaFT74OXWck4lrBdOtxx2NeUn04z
         gf1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chintan Patel <chintan.m.patel@intel.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 007/140] ASoC: Intel: Skylake: Fix jack name format substitution
Date: Tue, 13 Mar 2018 16:23:30 +0100
Message-Id: <20180313152458.653942801@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837253477394839?=
X-GMAIL-MSGID: =?utf-8?q?1594837253477394839?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chintan Patel <chintan.m.patel@intel.com>

commit d1c4cb447a7efcb5608a33cdfed8ab4234378b0a upstream.

Jack name is not getting formatted correctly hence resulting
in invalid name for HDMI/DP input devices.

This was recently exposed due changes brought by MST:
commit 3a13347f05fd ("ASoC: Intel: kbl: Add jack port initialize
in kbl machine drivers")

Signed-off-by: Chintan Patel <chintan.m.patel@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -604,6 +604,8 @@ static int kabylake_card_late_probe(stru
 
 	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
 		codec = pcm->codec_dai->codec;
+		snprintf(jack_name, sizeof(jack_name),
+			"HDMI/DP, pcm=%d Jack", pcm->device);
 		err = snd_soc_card_jack_new(card, jack_name,
 				SND_JACK_AVOUT, &ctx->kabylake_hdmi[i],
 				NULL, 0);
