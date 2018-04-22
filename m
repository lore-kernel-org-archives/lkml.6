Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Ujr70r5sFpc1+0MRHy6N6vYTkglerk7N2nu2/8TzzMY/ly0e5W5zsa3W5P3alDcp98S0j
ARC-Seal: i=1; a=rsa-sha256; t=1524406686; cv=none;
        d=google.com; s=arc-20160816;
        b=g7Ig+43VX2PEjdJ/GLhjOQPLkWoHeB3eFIJ89lsNd1kqU6srMocxA0tIWfNmUtqtUG
         1fwcR0LdHI0vPT8Ws2/WROf9HbeiKwjHfllJ3RHX41xdacUUppdxYZOaTL6uVwM9zT4/
         M0l8ItmJsIwysTyzPRuX5MqWucSxAvBpJeCyxn84dB88nYlO3FIduuZ7mpRu2mMWJqmQ
         kH/3HimqaNFt+c3o+g1GPWKn/axCrw9Ojn4cp15o8K9yNYKWtWF1aedajwBIjBD8mxfE
         hEy9v8qke2zFFs7RjX4YHd5tbZoon7nMdKjDUsWGi6Si/41pracCSBAuIRfNdBFMuBMI
         B1WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yfcdhMvFbMEVLPWUadKwR2zzfsC3vx8SNhLK851DzcQ=;
        b=Z+SwB9XtPgeseFV7Txg4eiS4mVTN92HOj2s4HA53Q70Y9p5G2LZ+ms/Eb0HYMaoyQt
         lgk5jrQ+vCq96zuA0LiePuY2rVmK6ngZf7pJVOcI9Ioc0cA/8WBF6PyXIjQstWgungx6
         EZGd4uKbXWOWc8UzT11Ot5JVmjR/mSauKqyzt0P2Dt7JZw8CcplT/Aa+2ChMY/eYOYo7
         XJV0s/lYiMU/m2au1Ei6vHTz/PRnBw+qBIx1gs6Oudd5KJwM8ZuSJwXi+L+QYRdhjeFX
         G+Zaa+PXzBMwgiMM8iUK/emy8lah2On3kSZCg6ExCUSn90O9upnP3ZFnBj/zR7sOLyu0
         275w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nicholas Mc Guire <hofrat@osadl.org>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 65/97] ALSA: oss: consolidate kmalloc/memset 0 call to kzalloc
Date: Sun, 22 Apr 2018 15:53:43 +0200
Message-Id: <20180422135308.843923639@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598456265424903999?=
X-GMAIL-MSGID: =?utf-8?q?1598456265424903999?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Mc Guire <hofrat@osadl.org>

commit 46325371b230cc66c743925c930a17e7d0b8211e upstream.

This is an API consolidation only. The use of kmalloc + memset to 0
is equivalent to kzalloc.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/oss/pcm_oss.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -853,7 +853,7 @@ static int snd_pcm_oss_change_params(str
 			return -EAGAIN;
 	} else if (mutex_lock_interruptible(&runtime->oss.params_lock))
 		return -EINTR;
-	sw_params = kmalloc(sizeof(*sw_params), GFP_KERNEL);
+	sw_params = kzalloc(sizeof(*sw_params), GFP_KERNEL);
 	params = kmalloc(sizeof(*params), GFP_KERNEL);
 	sparams = kmalloc(sizeof(*sparams), GFP_KERNEL);
 	if (!sw_params || !params || !sparams) {
@@ -991,7 +991,6 @@ static int snd_pcm_oss_change_params(str
 		goto failure;
 	}
 
-	memset(sw_params, 0, sizeof(*sw_params));
 	if (runtime->oss.trigger) {
 		sw_params->start_threshold = 1;
 	} else {
