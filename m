Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2249dAnDmTwpZQSHBav48yywNk9WdeSZ1pEIKlkqHdLYTbAExyK9BKzK/lMN/4Q0DSdZTlTf
ARC-Seal: i=1; a=rsa-sha256; t=1519412311; cv=none;
        d=google.com; s=arc-20160816;
        b=vht3q04W1aF0uBk3N30B+5OKjzSgCCplDvDJi7lDLRmwOK8qzkEONnSRO+5ni/2uX8
         jS6xqeOXCTIQjnW+vRxEH2Tl3sA79jqFE3+v817u1Ssue461pGz6HGSB2u95j8V47+AS
         9AuU+3ZmYEceyYrj4Ezrscdgvp8L+uPoC5t/WtxoPPEXXtPMr688+yz3q16KsgM/DzHw
         iXeK6miuaxdUkYDXiAaDKR/N584M8zF5H3UC9ZAjw/Fb+WXPX6yEv2tcyNMGC/PGv56S
         hjqbyyvIzQ6aQn8JdAujr+Mfcr0ipsGpQ4/h0GWqzMFYQBMrj67SxqYKb2trN5Oi+3mu
         Lviw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kZYzAc5xq9bhiEqmXqrTCdeZ50SlF/9RqAjNevb8v6o=;
        b=fwO3CsYjT89Pu/Uw04f1LzpkGeEJ+yRA1AB0fuN2JGRLa0EGgkHHvl77EZQJymZnSm
         IDvpRCZRUhkLlU6kBqtDC5IJRsZMVJr9ndYAH4bp9IFaOsXL0+x4AGhs1Dqc/ZKwZB1h
         DUPloLVung88L+NtfTvY8onPDHYWb3UJzsq25qG85uz/iSjA/2dha8Q9ZUhIM/sdFTH9
         D3UduBGRpp3D2w3IxQHR84qVhDt4/BbKI0ZR1PBR0eTdldGyIqqSlNdZEFFQPOdcYQXP
         6SfADqPtkle7uqW6GKlW6A88UaTzLchcfJdIhIZ+wDON3bfyHiHBPdpXzvcR4JT/2PIj
         lVbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.15 36/45] staging: iio: ad5933: switch buffer mode to software
Date: Fri, 23 Feb 2018 19:29:15 +0100
Message-Id: <20180223170721.085330906@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218366942317239?=
X-GMAIL-MSGID: =?utf-8?q?1593219283781598034?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

commit 7d2b8e6aaf9ee87910c2337e1c59bb5d3e3ba8c5 upstream.

Since commit 152a6a884ae1 ("staging:iio:accel:sca3000 move
to hybrid hard / soft buffer design.")
the buffer mechanism has changed and the
INDIO_BUFFER_HARDWARE flag has been unused.

Since commit 2d6ca60f3284 ("iio: Add a DMAengine framework
based buffer")
the INDIO_BUFFER_HARDWARE flag has been re-purposed for
DMA buffers.

This driver has lagged behind these changes, and
in order for buffers to work, the INDIO_BUFFER_SOFTWARE
needs to be used.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Fixes: 2d6ca60f3284 ("iio: Add a DMAengine framework based buffer")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/iio/impedance-analyzer/ad5933.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -648,8 +648,6 @@ static int ad5933_register_ring_funcs_an
 	/* Ring buffer functions - here trigger setup related */
 	indio_dev->setup_ops = &ad5933_ring_setup_ops;
 
-	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
-
 	return 0;
 }
 
@@ -762,7 +760,7 @@ static int ad5933_probe(struct i2c_clien
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &ad5933_info;
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->modes = (INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE);
 	indio_dev->channels = ad5933_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad5933_channels);
 
