Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqyZgOgHfP4XOQUNgeqC1XvZiVjT+QZRnHLrHHSDxaWdpiZTJpyX/TTuYWiPGgM5jzyTrNM
ARC-Seal: i=1; a=rsa-sha256; t=1526280892; cv=none;
        d=google.com; s=arc-20160816;
        b=UtC4oB2O8995kRFnYU/4KRQzfPhl7AbJ61ivI3AF/1FtdOnMSYjMsUANH5fEoF3FrS
         AQMz26y89fWslsy0nFIHEoKRG5aFwGmjvYyL9VMcrGwtY3gJvS8X8AAGXwHUkwuMyDu3
         BDGJB3wYH06oydE4Mt01vNuTm5y2I+ENWA2nmZZAl9lwrMUTQBTwIRfr2rjFe6Oe9+VT
         BHDB3uYhJkHqcg6vsMfg4VZFau5ZPczejSRZiE1WipTb1ksgXoqu5sWVgMUq9dhnAMG6
         JdEXy7P6mq2kAWMqR72X+WPqaUPhdfUzIXCXUBNvl6Q4fNs7Er+oKIDe8CrXIdfztnFp
         Au6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=1cf5LQhTOL2mkfkZJWM+dBlRmvV7/m48NfjE2AlHSz0=;
        b=qublyGeSROBr/4aQI8VVkgKXN29a8ZB6GkiEoRYnv3KH6zTA9BXAQniTEVTrAQcBA0
         yl8Q/PGHDmTr27q09nqbq+ACg+cp6riFbm9yRtX+JRzTduSYjvcX5yQ8dum3O2WPzXq5
         d9IO4CVkv8BG3cuo31dS1k9npNcexRoRHDPc3SZtm+mpFJ034q+sKAyg83OcmBCNdSns
         pRgYnmoQGJK/Ff/7M1NgaJj+tsqHiCZdhAZ5JV6ulnc20s6omK9+1MsulSjx9EX5/kLU
         DqS2Oi+YVOXrG3Y10jmiMu+nkgyJ4uK31+OFFv1sv2I8386tKsqIzqpV5HM/zntvDzw4
         I6sA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=WwXc7jVo;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=WwXc7jVo;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Timur Tabi <timur@codeaurora.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.9 17/36] gpioib: do not free unrequested descriptors
Date: Mon, 14 May 2018 08:48:51 +0200
Message-Id: <20180514064805.639791148@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421513136982038?=
X-GMAIL-MSGID: =?utf-8?q?1600421513136982038?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timur Tabi <timur@codeaurora.org>

commit ab3dbcf78f60f46d6a0ad63b1f4b690b7a427140 upstream.

If the main loop in linehandle_create() encounters an error, it
unwinds completely by freeing all previously requested GPIO
descriptors.  However, if the error occurs in the beginning of
the loop before that GPIO is requested, then the exit code
attempts to free a null descriptor.  If extrachecks is enabled,
gpiod_free() triggers a WARN_ON.

Instead, keep a separate count of legitimate GPIOs so that only
those are freed.

Cc: stable@vger.kernel.org
Fixes: d7c51b47ac11 ("gpio: userspace ABI for reading/writing GPIO lines")
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Timur Tabi <timur@codeaurora.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpiolib.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -425,7 +425,7 @@ static int linehandle_create(struct gpio
 	struct gpiohandle_request handlereq;
 	struct linehandle_state *lh;
 	struct file *file;
-	int fd, i, ret;
+	int fd, i, count = 0, ret;
 
 	if (copy_from_user(&handlereq, ip, sizeof(handlereq)))
 		return -EFAULT;
@@ -471,6 +471,7 @@ static int linehandle_create(struct gpio
 		if (ret)
 			goto out_free_descs;
 		lh->descs[i] = desc;
+		count = i;
 
 		if (lflags & GPIOHANDLE_REQUEST_ACTIVE_LOW)
 			set_bit(FLAG_ACTIVE_LOW, &desc->flags);
@@ -537,7 +538,7 @@ static int linehandle_create(struct gpio
 out_put_unused_fd:
 	put_unused_fd(fd);
 out_free_descs:
-	for (; i >= 0; i--)
+	for (i = 0; i < count; i++)
 		gpiod_free(lh->descs[i]);
 	kfree(lh->label);
 out_free_lh:
