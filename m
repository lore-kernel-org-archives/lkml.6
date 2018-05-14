Return-Path: <jorge.sanjuan@codethink.co.uk>
X-Google-Smtp-Source: AB8JxZphMt1Jn84ATpXKntoglXoYzNGRHsOrOlwMTRa0T/VCeNGpZKUtKN0hMp4Kz3x97cU8WNuf
ARC-Seal: i=1; a=rsa-sha256; t=1526295837; cv=none;
        d=google.com; s=arc-20160816;
        b=iZFuQ36pAZOXf+WHTX/iM/4P7GC2/fG+9md4TBdPWy+6EZOC9nNGzDY2If5Vra+/eJ
         6/3OmC9rJ01cd2jcP1E+PbEQ2zSRWcNj8p+p640TNe2tbv1sg2GeS1kBSxwRdjX0kbf3
         +p/Kq1eTrByRclpwv0I4CDo0M9OoFJ+5ipKGqJ6ZrVGK//PPxks108n9nDBynaMe5o/4
         XR5GyO7ZIWLWb37P/0s6oEM4Wd8qyhAEFlHideNmDJmQ9g6P2Y35WByiCWySTYALMX3E
         bldMfBQD9s+VG23TVUC5U1J8NMPqhhwu4btkTbh4v/yi0L9l0HG3XJ4PTQ0adUN3NZ55
         E2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=860prkDm7uuH0MiY0+X0IGeakckLa/tTCfYTdJF180k=;
        b=CJnkI4EXYMkcqfpbD5qMErA21QAJ65PPTe4uT1/770xIPZJHK3OTzegq41ghUHixt7
         DTGym7NRDqLsaAodm/UCSY1jkfOXZw8jVzViSBdkWU/LUP5NlgkKykfOjpQTVmv81UZ5
         7ajLc+rZ0geJBlpJs5rmne4ayC1PG6/+zmp/4q/fKnoiXE0iiCvR6EpB8S2zg/tLT2Zj
         0vKGMMAIWQU4/C63EmcVhMMhd7DyXm2Uq1KlSRz/Y7KjdJEqDNCKe4mBTNLBY2M/Ga+/
         hH24MyR5tLL8LK3m8uxGB+MwEewxeBORCQl+Q7+FEN1EaFThyb4+wIuS6w7L8xQcy4Co
         r1AA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jorge.sanjuan@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=jorge.sanjuan@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jorge.sanjuan@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=jorge.sanjuan@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	ruslan.bilovol@gmail.com,
	Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [RESEND PATCH v4 4/4] ALSA: usb-audio: UAC3: Parse Input Terminal number of channels.
Date: Mon, 14 May 2018 12:03:42 +0100
Message-Id: <20180514110342.23683-1-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180511152537.32267-5-jorge.sanjuan@codethink.co.uk>
References: <20180511152537.32267-5-jorge.sanjuan@codethink.co.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600181868703215105?=
X-GMAIL-MSGID: =?utf-8?q?1600437183903640918?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Obtain the number of channels for the Input Terminal from the
Logical Cluster Descriptor. This achieves a useful minimal parsing
of this unit so it can be used in other units in the topology.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/mixer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 431f3c319839..99804cd4aed6 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -904,8 +904,12 @@ static int check_input_term(struct mixer_build *state, int id,
 				term->id = id;
 				term->type = le16_to_cpu(d->wTerminalType);
 
-				/* REVISIT: UAC3 IT doesn't have channels/cfg */
-				term->channels = 0;
+				err = get_cluster_channels_v3(state, le16_to_cpu(d->wClusterDescrID));
+				if (err < 0)
+					return err;
+				term->channels = err;
+
+				/* REVISIT: UAC3 IT doesn't have channels cfg */
 				term->chconfig = 0;
 
 				term->name = le16_to_cpu(d->wTerminalDescrStr);
-- 
2.11.0
