Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrJztaXvpOr1Nb6RWc1tp044eyO3+nKt7niRsenMtxbHsR58D3Xs6mdevIe9Q/gxANKvzIG
ARC-Seal: i=1; a=rsa-sha256; t=1526281119; cv=none;
        d=google.com; s=arc-20160816;
        b=UYAIhwWSSm2WvXE/kRvRFT9AlOJUalGp1uFe3Ba8E9mjshLmSaUoxZATESGttoAqD/
         w/q1rI3hjxkuo9i+SHsfPIDK+WmhuoZdM9rI0i9QlWuhlCzCUSUulIrSPsU+ApBak3ve
         DIwTWFKp3mt2dFz79bhozmjQG1OtidfW7l4AnGfP1ZpuLtjzYN+7ZrqIMsyxbkKOaDa9
         2bOPI9f5FrosifESj9acltN0hKU9UKnOTmtfgo384Sc1nkCfye5HopbhMVNr53Byyaaz
         d69yZrBg/TIuzFZT7ZPSIUuy2yd46WFzWtXbLFMyGZi6AxXRQxefyOt/+GD7t7oUQSvF
         4PXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=5J1MWG+nVapnU9Svl0TIi1JMcVo4HhxNNVn8JzILU2I=;
        b=LiIxaaUsJHNdRgzEtRQM94ugO6NyWO4AYyuKdEkstUUlIWVvbiGtYw4k1x/AIZxTGe
         GUjyTn93v8Y2ngVaOBdSSe2guOlfijxt9ibl5TTxqiMaRwqaIXcrS8ayijA4/CbBskBC
         PdxIp1WdgD7eA0JonLWo9e+yXPbTgJ8m562Ik+DX7r7ZjOFtUBmcsY3qMG92QGqHJ1pd
         0/CYqdE0W/c4huHjMaovtUf3nerUdk/2PAXFwy1ChJrO31Yn2YJir4nn6SAUfmnpr1AK
         AkE8dcOcKHKHUWtCkjX9KoNXMtr6xmDcWSeVKTjfZEFWWXU0zWy6m7Vty9y4g/zNPYsf
         UZbA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=H9bfqDoN;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=H9bfqDoN;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Timur Tabi <timur@codeaurora.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.16 24/72] gpioib: do not free unrequested descriptors
Date: Mon, 14 May 2018 08:48:41 +0200
Message-Id: <20180514064824.052709896@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421513136982038?=
X-GMAIL-MSGID: =?utf-8?q?1600421751715232370?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -446,7 +446,7 @@ static int linehandle_create(struct gpio
 	struct gpiohandle_request handlereq;
 	struct linehandle_state *lh;
 	struct file *file;
-	int fd, i, ret;
+	int fd, i, count = 0, ret;
 	u32 lflags;
 
 	if (copy_from_user(&handlereq, ip, sizeof(handlereq)))
@@ -507,6 +507,7 @@ static int linehandle_create(struct gpio
 		if (ret)
 			goto out_free_descs;
 		lh->descs[i] = desc;
+		count = i;
 
 		if (lflags & GPIOHANDLE_REQUEST_ACTIVE_LOW)
 			set_bit(FLAG_ACTIVE_LOW, &desc->flags);
@@ -577,7 +578,7 @@ static int linehandle_create(struct gpio
 out_put_unused_fd:
 	put_unused_fd(fd);
 out_free_descs:
-	for (; i >= 0; i--)
+	for (i = 0; i < count; i++)
 		gpiod_free(lh->descs[i]);
 	kfree(lh->label);
 out_free_lh:
