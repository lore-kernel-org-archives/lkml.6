Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx485LrKM982q+FCW8KrpVmBATc+OP7odaBk7SNN80Q+kEWA0TF4nhiFpaELmAj4+0D96V3ko
ARC-Seal: i=1; a=rsa-sha256; t=1524406859; cv=none;
        d=google.com; s=arc-20160816;
        b=uAAiTON87IxDThOP8q+0bq1Ro3VtfIGRPEqnRUdzyIhbv1KQHDPt2E3X+gHr8CuavO
         RfdSMWBNEi+nV2Cqlg17SwXCN4y58M7F9GyV+RIIwFvqfshDxFrbMxi4W4cw0krT3NyO
         zr7WGMBORdrfDy6DSJCNOLpkT1kKs9JVBGBcVNLanHPV5J8TSEkRtYP1EDJPrIs0rnn1
         FogYXCEC6RF1hPfW8GsljxPMUrEG3eYkPS7ioRzLTJnn15EbDf8aac7Qwp8Bbz4i6kt7
         mtacWH3WmQqpotNw7IISllvQah3HG/34SwFfVNAkNoNENY25TsLx+N8PPqBjbjOwrQSE
         KAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AK3T54C6H7fsiu2Q5bpmfbnaIeExZZaldEzcvaX4y5Y=;
        b=IXAE+D3wtnmoTavX0nxxMEYEf+QViRFJAVOBxURs96FoalmiF7Cz/Yjq4WrdkYz9n7
         VoLZwWG4L1L7TrgZGQLojETIbBFe2wntuywOYV6u1mCLRG+n8ROQxEzEIjynOmDJ9GTz
         um7G6AElmsXf0q+k8l10L9tJ8s8EKjbKyk0h/gF8iiDUepavGnX02b9Lf5+Ff4/knxpJ
         QznPKCRlFLMv8RHGdWQKRqO+zwzmXmOgDRuo10aMMnkiKqI23RZn7olD6yfU9hJvGXlS
         YmiigbXxBnueuWtlXCWepeShLk0X7deyL8ERzT6DPyU9yGTyqAo19Qa7bgYAIyXkisBp
         KgVQ==
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
Subject: [PATCH 3.18 31/52] ALSA: oss: consolidate kmalloc/memset 0 call to kzalloc
Date: Sun, 22 Apr 2018 15:54:04 +0200
Message-Id: <20180422135316.882635597@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598456265424903999?=
X-GMAIL-MSGID: =?utf-8?q?1598456446360732750?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -992,7 +992,6 @@ static int snd_pcm_oss_change_params(str
 		goto failure;
 	}
 
-	memset(sw_params, 0, sizeof(*sw_params));
 	if (runtime->oss.trigger) {
 		sw_params->start_threshold = 1;
 	} else {
