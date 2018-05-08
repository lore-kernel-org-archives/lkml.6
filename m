Return-Path: <oneukum@suse.com>
X-Google-Smtp-Source: AB8JxZqDfITQ0Q8JjU/wL+sVvXhEAgrmvRp5uM4RpMQ5pYAMffSBzqcg7v5wGlUwbmx0J+M1+vwV
ARC-Seal: i=1; a=rsa-sha256; t=1525768469; cv=none;
        d=google.com; s=arc-20160816;
        b=WPMUdCEloX2g9gG+XPVPREq9aQad0DN1YI6XqahResNqYPosXyCATgiNMg4d0n/P/I
         1MbZH/EvG5Wbe+aAspvND+ssOrSyFs9rQmjMVRIx2EWpeWZk8bfFL3JjOJSRIYDkGkNL
         rAKuK08tDoavcTm2hKZO/F5sJYFzoJUsofaoBtMttMF3IuYpFDq6YMbf/UX7eNop+/zq
         qBRDktQcy6dRW8p/v7npzFbTMcAoSTzsrbpzko+aAucYZ5pKFuZcy+iLonmUGEs9eAL+
         LEaUO07x6Woqn4GEfjCoHfh6qC38hu5Qck1gUiKTrmNa5sl7oQEZ27WhJAmtmTmoUwxz
         y0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=r57l+jRsG9JJtYtduHQE8eGhrJcp9/Be/qZu/aMxkVs=;
        b=nLZoIzi3xcYzaITjiAl0l/1Yw9jPgonlijHRrTWSL4WNThNbIeJoF8aYVcvltIbjky
         AAtLUDaO4WH1rjKD5GpwkDFCcHJD2ImHYxe+0WZM7RZ7Z5IX3g/fl4iT0juJcvy3isth
         lINswaJkmcfsb0gxFQBqOv2i/iUcV2je8+bB3JZjTqMO+5QFTxEOwMobrXC569CYYIhh
         ZPU5JmZyU53BxUaynIjryDJchvjr1pHibrfxD5iFTlqJnSdizVZQy1zu3heKyM2n7TKa
         m1xmPFP/0Qrp55MKPksb624/dSmJyS1+khAZNAaxTAy3Q9wHjGEuXFvhNrUES0L8r0p5
         Z/1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of oneukum@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=oneukum@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of oneukum@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=oneukum@suse.com
Message-ID: <1525768070.24345.8.camel@suse.com>
Subject: Re: [usb-storage] [PATCH] usb: storage: Fix a possible data race in
 uas_queuecommand_lck
From: Oliver Neukum <oneukum@suse.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>, stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Date: Tue, 08 May 2018 10:27:50 +0200
In-Reply-To: <20180508074743.13622-1-baijiaju1990@gmail.com>
References: <20180508074743.13622-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599881266623115421?=
X-GMAIL-MSGID: =?utf-8?q?1599884199170837581?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Dienstag, den 08.05.2018, 15:47 +0800 schrieb Jia-Ju Bai:
> The write operations to "cmnd->result" and "cmnd->scsi_done" 
> are protected by the lock on line 642-643, but the write operations 
> to these data on line 634-635 are not protected by the lock.
> Thus, there may exist a data race for "cmnd->result" 
> and "cmnd->scsi_done".

No,

the write operations need no lock. The low level driver at this point
owns the command. We cannot race with abort() for a command within
queuecommand(). We take the lock where we take it to protect
dev->resetting.

I don't see why the scope of the lock would need to be enlarged.

	Regards
		Oliver

> To fix this data race, the write operations on line 634-635 
> should be also protected by the lock.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Nacked-by: Oliver Neukum <oneukum@suse.com>
