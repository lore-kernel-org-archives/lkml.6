Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq+oe+Cb47Z9pDDdWPo39vEaphzO92JMkpTRDCVVILdevYXsfR9qLcsf056sZdIpx/rTBje
ARC-Seal: i=1; a=rsa-sha256; t=1526281069; cv=none;
        d=google.com; s=arc-20160816;
        b=ofnaWKKfOnkbY2jt7bCKK1+FWrfG5L68oHjxdZL/WgL7j02d37eekJhsV0rWTH2ZIw
         AlZyXTB63x4uLUINo1YQZHSdr6neYYsNIeTaWtMyhPMJLfp8xGTMU2KdxIURYpGMzFHd
         HyXrwGfYlGxOULlgvoG1ZS+szNoql20UymryAPPfG2dRJZ5zT5IwbSlu0YaKzQGZsVTD
         /lgMkCwvAkZRrP3nG9fITbCRLWwQAWxNoFfd2RUJT+omR+orFHvP9AQEABTexT0IXvSW
         BPb24UHA7wbmoVuc9lF0XG43c19b/6iL7KWIDjFzrSMGSbTo9zV6aVBnSbxExr49IXox
         F5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Jh9N+DdcMyctGCou6dFNlXbOg/XD/TTq/hagnsSrG+k=;
        b=vGl59UwUENRWCpYSpgaxkOhjJpnziEq76LNX4c5XZGgxQfHpmQXSutouU9XNVyPDL0
         vstWGCdg7TDZ+piFrK3e6KME1tXcJaDBlOwENv3q6z3QhDJXrerVe9OueO+A54+1KiVp
         gVbVPK1gDHAJQFAbuWB05Zv97/AsKX2KsExjQOfDIR3kLSzrTSMCFfHxp0kv7ythiDBb
         p/pPNZV8IrZnvn6fsbJijbn2/i0eXg888gK6o3UPdP5uUaj+4xnImgDVN7jKu00cIJ3q
         pJYRJ//Y50vb+0AJkI3MfQUWXKEj/kJ7SVyH7G/Oz5vWfUZ6jfdmJy30S2pr69bKQpwC
         sF8g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xYIqBhjy;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xYIqBhjy;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mathias Duckeck <m.duckeck@kunbus.de>,
	Akshay Bhat <akshay.bhat@timesys.com>,
	Casey Fitzpatrick <casey.fitzpatrick@timesys.com>,
	Stef Walter <stefw@redhat.com>,
	Karel Zak <kzak@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.14 35/62] can: hi311x: Acquire SPI lock on ->do_get_berr_counter
Date: Mon, 14 May 2018 08:48:51 +0200
Message-Id: <20180514064818.304559273@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421698501569047?=
X-GMAIL-MSGID: =?utf-8?q?1600421698501569047?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 5cec9425b41dcf834c3d48776900d6acb7e96f38 upstream.

hi3110_get_berr_counter() may run concurrently to the rest of the driver
but neglects to acquire the lock protecting access to the SPI device.
As a result, it and the rest of the driver may clobber each other's tx
and rx buffers.

We became aware of this issue because transmission of packets with
"cangen -g 0 -i -x" frequently hung.  It turns out that agetty executes
->do_get_berr_counter every few seconds via the following call stack:

    CPU: 2 PID: 1605 Comm: agetty
    [<7f3f7500>] (hi3110_get_berr_counter [hi311x])
    [<7f130204>] (can_fill_info [can_dev])
    [<80693bc0>] (rtnl_fill_ifinfo)
    [<806949ec>] (rtnl_dump_ifinfo)
    [<806b4834>] (netlink_dump)
    [<806b4bc8>] (netlink_recvmsg)
    [<8065f180>] (sock_recvmsg)
    [<80660f90>] (___sys_recvmsg)
    [<80661e7c>] (__sys_recvmsg)
    [<80661ec0>] (SyS_recvmsg)
    [<80108b20>] (ret_fast_syscall+0x0/0x1c)

agetty listens to netlink messages in order to update the login prompt
when IP addresses change (if /etc/issue contains \4 or \6 escape codes):
https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=e36deb6424e8

It's a useful feature, though it seems questionable that it causes CAN
bit error statistics to be queried.

Be that as it may, if hi3110_get_berr_counter() is invoked while a frame
is sent by hi3110_hw_tx(), bogus SPI transfers like the following may
occur:

    => 12 00             (hi3110_get_berr_counter() wanted to transmit
                          EC 00 to query the transmit error counter,
                          but the first byte was overwritten by
                          hi3110_hw_tx_frame())

    => EA 00 3E 80 01 FB (hi3110_hw_tx_frame() wanted to transmit a
                          frame, but the first byte was overwritten by
                          hi3110_get_berr_counter() because it wanted
                          to query the receive error counter)

This sequence hangs the transmission because the driver believes it has
sent a frame and waits for the interrupt signaling completion, but in
reality the chip has never sent away the frame since the commands it
received were malformed.

Fix by acquiring the SPI lock in hi3110_get_berr_counter().

I've scrutinized the entire driver for further unlocked SPI accesses but
found no others.

Cc: Mathias Duckeck <m.duckeck@kunbus.de>
Cc: Akshay Bhat <akshay.bhat@timesys.com>
Cc: Casey Fitzpatrick <casey.fitzpatrick@timesys.com>
Cc: Stef Walter <stefw@redhat.com>
Cc: Karel Zak <kzak@redhat.com>
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Akshay Bhat <akshay.bhat@timesys.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/spi/hi311x.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -427,8 +427,10 @@ static int hi3110_get_berr_counter(const
 	struct hi3110_priv *priv = netdev_priv(net);
 	struct spi_device *spi = priv->spi;
 
+	mutex_lock(&priv->hi3110_lock);
 	bec->txerr = hi3110_read(spi, HI3110_READ_TEC);
 	bec->rxerr = hi3110_read(spi, HI3110_READ_REC);
+	mutex_unlock(&priv->hi3110_lock);
 
 	return 0;
 }
