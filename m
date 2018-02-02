Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225/KIxKNJ9w+j6vTKGSpXk25jK2g7/qkZ+/huw6LxiX9gznOZ6A/+NeyGD9a9WNh6+ydOg7
ARC-Seal: i=1; a=rsa-sha256; t=1517590926; cv=none;
        d=google.com; s=arc-20160816;
        b=jh4yh7CEv4fTL5jJZtAOB7ST0g5oRKOa4qMtTDBN1EQFNOy+MTq3JjNuhfhDs59Ei5
         txb3m6/bibPY7HramCXwYQrLNZbjq7xqQAQSsLT0JrlMBpDJYWOsDEsPjrzV3pMjopdp
         67zpgEa4O6KleeS3BTZCfHAtUWrQeIU7vtqtMg+e4JKAky9drK4lw144N0ZtRIwRAkcg
         uYt9wGCbZ7ysHrOM7OxQ3QvINC2gemgB5OJ6Zy/mmUU2S1XDlVSryyPtaKwVgOjHKeJn
         bIFp/D1Y7tZtLkDhGtLCaIILIJuIPlYFj8qOQL1PbaUGjoD8tJ+0pd7yPk06zeMimdpS
         OyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k0GqFqEzJHtmb08p0s/k+15hv7pmeaKFGv3gG3wvK2U=;
        b=mrIbd3PIvCAXB/PbUJqubLgZHm+N3tXX28t+l1Y6HUioEHr1s8a9c6lfj+OAOstyOv
         q2Br1fT3ZFTyrW2sj9q3bt4CspMCaZpgOYQ90ZZ8LD8UKKCUoza0sAyUhjFrPXrUsfNs
         DR21Z1F6OFsSfNfFPYulwW1yDWqEqpa078jHq5KfcyJW2dXTqAaFiWodH0dBmGPpb0nB
         elrupPHTqohGD8LVPFewuK5e8yCsknxJoRp67BmL7X9GVbvdWy2T4CKn4IXlI0KJTlwh
         wbW2mC2RPZAlsHtQwl2MjZlkmYt8M7aLnMRfGSx28NbPhCbIymMRbWSih6l5pJQT8tRC
         9D7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 59/67] USB: serial: io_edgeport: fix possible sleep-in-atomic
Date: Fri,  2 Feb 2018 17:58:28 +0100
Message-Id: <20180202140821.795512462@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309422775128641?=
X-GMAIL-MSGID: =?utf-8?q?1591309422775128641?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jia-Ju Bai <baijiaju1990@gmail.com>

commit c7b8f77872c73f69a16528a9eb87afefcccdc18b upstream.

According to drivers/usb/serial/io_edgeport.c, the driver may sleep
under a spinlock.
The function call path is:
edge_bulk_in_callback (acquire the spinlock)
   process_rcvd_data
     process_rcvd_status
       change_port_settings
         send_iosp_ext_cmd
           write_cmd_usb
             usb_kill_urb --> may sleep

To fix it, the redundant usb_kill_urb() is removed from the error path
after usb_submit_urb() fails.

This possible bug is found by my static analysis tool (DSAC) and checked
by my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/io_edgeport.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -2219,7 +2219,6 @@ static int write_cmd_usb(struct edgeport
 		/* something went wrong */
 		dev_err(dev, "%s - usb_submit_urb(write command) failed, status = %d\n",
 			__func__, status);
-		usb_kill_urb(urb);
 		usb_free_urb(urb);
 		atomic_dec(&CmdUrbs);
 		return status;
