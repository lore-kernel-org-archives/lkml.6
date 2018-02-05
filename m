Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2278Tr1q+QjjuyX5NYc7YFaLVZuXKkQJZBlB+1wFP6+yIWN4lKcXZgcpHfC5ETwTNwe1GZth
ARC-Seal: i=1; a=rsa-sha256; t=1517855202; cv=none;
        d=google.com; s=arc-20160816;
        b=mqhhAlLUVQcfeopHLs2tGY3d3mTZvs5pw1co/FG4PRRKQYnYofz9xUb4uclkYBMme8
         n8To4WXSwsevQtFO+F2FAKNPm0d/yeQiucVBBUAgG3xhHmErVgG48JJOsaL8NwDlQ9fa
         T+sLPOh42l+wG4xZbFmoupg2wW11QV9PQ6H5U5oiL+Ufuc+srAvBVv4Dp9ZGqVLOiOoC
         Xr4s38MbYbqoAAvxJq3acCuHwKRNf3ybpXayM5UcGpV4q64o/d4BRv5AHlh6xFou5VoM
         A8Rli7tdn8DfNiUQu4W3FnTH5KZmfxNTjqRykrXc+262OuWYFZSmdwegWBusUNQJiFpf
         yxOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BryjAROTk3op3XlqgJM6hcD/kwKlz4EquuHTahXRcUU=;
        b=e7/Ev7JjwzgjjT7PtAwh/DItKLw+kYRVnB7qBfN/ac8x5PoKESYO24xGQnMSpXOs4C
         RCOlDH3V0DHtViYTCozO9A56KhsD3ciirN7oMTalE8CNcGkW3k32NB3phPorl6CweizF
         4z+51mNUhfRF+M88QBUl7Q0HkIdgJGDaG6IxLXTTtaiOda/EHmu19bzdOXCQPjTTuxCA
         XJa4jU6v58eeEsNjO5pZaImiONe9OfbNbCKDson8Hm41I5mMs7ChWA83l73uTk/QztkI
         rNsaq54n45H5zKqvm1HslPQc2BUi8u8djs2QXI28EjZZjvIYjT167huxcr5NwFEsrEvj
         WwRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 3.18 28/36] USB: serial: io_edgeport: fix possible sleep-in-atomic
Date: Mon,  5 Feb 2018 10:23:56 -0800
Message-Id: <20180205182352.930525626@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586537099525145?=
X-GMAIL-MSGID: =?utf-8?q?1591586537099525145?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
