Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2250o0f+AvD4z1mMPDlvBajG8cfgzCwg+cCBN/TFk0gWH8MBLuWmiuBDDRDj4SqPwEs+Lj0q
ARC-Seal: i=1; a=rsa-sha256; t=1517591671; cv=none;
        d=google.com; s=arc-20160816;
        b=I2RhJcyN7yixZAHhqOM5/dI2zIxVpfea03sVn+TlMFGK4j1pLrNP/S+bzYfBsDJejL
         vHKEE3PWU6PHxcuDxiYCjUWBC5qa9MfQMuiNCNE0MjeBqGmR1a1JyjJhTbfc+/HpjYCs
         59b5yiustGB1C55jBu4dqd7M158HZz7A8DqYerGhxXZsF3uXTCgKLvyWtqnV52I/Ydwd
         ZqHcbspcOXPFGLVYi+0mmtfzUqCgJd5pr3VCDRR/nzZF8C4BcI5HZXq5Pr15fhEn0NCE
         ZWmRNn/2We517Sz3stedhjcTNElIfpEy2pNHAmxxm5GcfevN5it9Q1E+V39awAYVUeiQ
         AsEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2Zb8igdi0JyRObo3AwsgrsUyTHKN+wbMZuZdTJmCYsg=;
        b=ap+d09QmIShD6ARL+W59boV4Ruksf6qKYoMTgxna2ifVRhIocA+KN9zUKlGKw/ISig
         LtG4S1sVMt+OrdorJJLKh8qBj4Tf2fpJD+Br91cLB2Knr+AUNxX2iJyOo7YXB8/1UgZU
         x1a3zCHDI8sohm5HjSCNJc3L9XMZfua0E/igYyM6q39mrWuoA0krhh+EQOH/0tBSbw/h
         s8uBbQ9DG882E348pYhAXf8Vf5IBUama3BD5/fCInizRBBJs66XNR2XP/jq/YsNT2UWT
         PUXEzhdhLzyjY6Fa5m73df1utQdnGSjYOJnPYXjg/hF1CoWLPYTi5gDXs5chnrb7bFa+
         K9jQ==
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
Subject: [PATCH 4.14 137/156] USB: serial: io_edgeport: fix possible sleep-in-atomic
Date: Fri,  2 Feb 2018 17:58:38 +0100
Message-Id: <20180202140846.572241771@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309422775128641?=
X-GMAIL-MSGID: =?utf-8?q?1591310204376445180?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2286,7 +2286,6 @@ static int write_cmd_usb(struct edgeport
 		/* something went wrong */
 		dev_err(dev, "%s - usb_submit_urb(write command) failed, status = %d\n",
 			__func__, status);
-		usb_kill_urb(urb);
 		usb_free_urb(urb);
 		atomic_dec(&CmdUrbs);
 		return status;
