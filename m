Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/bqysVcQJcUeW/lWhR9I2GsA/pPjphrJ/MHQEIUNqZSuW66FgtetVjzc01i+vOVHvbASl6
ARC-Seal: i=1; a=rsa-sha256; t=1523022296; cv=none;
        d=google.com; s=arc-20160816;
        b=ZylKjUWnhza617z2f1ff+qNiPxKeqdD78+X7H43Ael09OEVZwWRxYzwiVbizv5XDh9
         lBT8e3HHWw7HunyHZGuZCtNDh7hCknoGyY1DVBvrupSZ4uYyUn/9DtoK3MM0e7G9b2qR
         Q6lb+VBONwXwvwND9qpIbkB/nGp8ZWer7RkIIuHmq4+LmyIT4KfkPjNOQKXte+8NdLCO
         X+u9YkMIgJY0hjbtZfm9bUL1y5nVS2UcZEGzy7T+rhOMmUr4RxfMjvxMfw+dGvTlYqbj
         24V1I2mdWjb9ZlzoJ4KPbWuYhd0HImmY6/yYRw1PBvZ5lG+bfD8czbMsoT83HK8ZPWPm
         sAjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qPktD6SuMxHeLHuzMKL50goTMZV4viyI/O7mOl01tOk=;
        b=hAPQmNfA8WmyvV7jMLkqdgukQPtfmAj0Er/TdQvZYdffgQJS0DBvUekRLlI3lI4Cjc
         OW3Kqq2hsHND+dKso0/zmXEFWgr5yNVeNqhT0WTAlh4TXOSIapAA41SvzKYatoeATORz
         0JEjX828KFV61iN8VTfoKwnsasVbSytxxcPJRn8oQC6+8I2/x7Ykfh8rRG6Z5TSRd/5Q
         9jSgNoAqyoQevhJflVcrx5AQHxVR+nuS9OVIqG+gjb45b2gUHe0lUfMuXBHejv8PzqDz
         +syUxPv9tR3kwXWOvRsuhp65PDUknpzVztVBLeHZXol63lHoHurt+t58fyKT2KKtw58f
         +UFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Binderman <dcb314@hotmail.com>,
	Gavin Schenk <g.schenk@eckelmann.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 4.16 23/31] siox: fix possible buffer overflow in device_add_store
Date: Fri,  6 Apr 2018 15:24:48 +0200
Message-Id: <20180406084344.136309882@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004627369683163?=
X-GMAIL-MSGID: =?utf-8?q?1597004627369683163?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gavin Schenk <g.schenk@eckelmann.de>

commit f87deada80fe483e2286e29cd866dc66ddc2b6bc upstream.

Width 20 given in format string is larger than destination
buffer 'type[20]', use %19s to prevent overflowing it.

Fixes: bbecb07fa0af ("siox: new driver framework for eckelmann SIOX")
Cc: stable <stable@vger.kernel.org>
Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Gavin Schenk <g.schenk@eckelmann.de>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/siox/siox-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/siox/siox-core.c
+++ b/drivers/siox/siox-core.c
@@ -594,7 +594,7 @@ static ssize_t device_add_store(struct d
 	size_t inbytes = 0, outbytes = 0;
 	u8 statustype = 0;
 
-	ret = sscanf(buf, "%20s %zu %zu %hhu", type, &inbytes,
+	ret = sscanf(buf, "%19s %zu %zu %hhu", type, &inbytes,
 		     &outbytes, &statustype);
 	if (ret != 3 && ret != 4)
 		return -EINVAL;
