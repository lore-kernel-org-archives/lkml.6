Return-Path: <jorge.sanjuan@codethink.co.uk>
X-Google-Smtp-Source: AB8JxZo3x5lrlzaTK/cjkeDNyUbZ5dOTN2RBLcdreBN7TtVSHOJQa6SLs0RhBUT5maTseaDvKcF+
ARC-Seal: i=1; a=rsa-sha256; t=1526052349; cv=none;
        d=google.com; s=arc-20160816;
        b=zGjYPiP2zphhbAqfdocjzw5RXBQNNh/2PtPfT7UioG6iwZfkFbTiaAxBjtcUvsnkin
         oPu/50vlcu7re9VweN62wLsB2/BrrDlba5dG8z7U2m19q1EeDfbHlN/N7AR8s7C8XRqr
         F4Kdo7q9vvgPbLMj6XelSfBMVizto/ibMA99JQPHpZHzROfb3PzZXV2e7sIfJnp79tiM
         Qb6xI1E+xi92wTW1HGzsujHOyEUVW3VkOnNXiQSTyPYp86nU8onn/LtHGcM4esG4/CQs
         IvIdPXi7BpLQR+pDrN57qBKRyKb86B4FbXdpXEA8jAIVf50BQUJcgRaQB9P/p8bBRA/x
         Q/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=WOSDtYMvQMrEs6RxWF/J9G/9gfWAbmu2JZP89cFqh7U=;
        b=ipYszT7j53M7Cp7B2WrCbMayCX3+wjaeUVv5ogcWvV+wV8A2ewmEOhmMPkiZFGDj9y
         vyT1ivXdrnNJ/HHtnsRpvLOIz8nnn6LVx6qMa54uS2RsHJR3HBTqzcgRpQ+vyTuz7AcN
         HtnX6NZvx8aHC3Qf2WvZOa1/y+7BMPGvnVgLXBXypmzR7JByUXu7OakFbGBELdI4P5gJ
         NZCac2JY+0VCSRb1P32tPN9ON4Ce65BLMwllXgLdwmWkaqTxv/Eq8x76/dQgNIOR8PV+
         3ZPsJCe27sIQ8cELUm9wuvnpiWPDBXUpkAY/Z4du/PWf9geezmAB+jJWPdqxJud8gSbx
         vyaQ==
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
Subject: [PATCH v4 4/4] ALSA: usb-audio: UAC3: Parse Input Terminal number of channels.
Date: Fri, 11 May 2018 16:25:37 +0100
Message-Id: <20180511152537.32267-5-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180511152537.32267-1-jorge.sanjuan@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
 <20180511152537.32267-1-jorge.sanjuan@codethink.co.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600181868703215105?=
X-GMAIL-MSGID: =?utf-8?q?1600181868703215105?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Obtain the number of channels for the Input Terminal from the
Logical Cluster Descriptor. This achieves a useful minimal parsing
of this unit so it can be used in other units in the topology.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 sound/usb/mixer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 431f3c319839..19b25fbc7437 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -903,9 +903,9 @@ static int check_input_term(struct mixer_build *state, int id,
 				 * recursion calls */
 				term->id = id;
 				term->type = le16_to_cpu(d->wTerminalType);
+				term->channels = get_cluster_channels_v3(state, d->wClusterDescrID);
 
-				/* REVISIT: UAC3 IT doesn't have channels/cfg */
-				term->channels = 0;
+				/* REVISIT: UAC3 IT doesn't have channels cfg */
 				term->chconfig = 0;
 
 				term->name = le16_to_cpu(d->wTerminalDescrStr);
-- 
2.11.0
