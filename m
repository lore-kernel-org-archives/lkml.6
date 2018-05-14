Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZryzeBP7mCLUwgga4faEqQL09QMRBkRaM4eFwoAB+34HAcDT0JOp+WncGpO6I2BCcT0/j9P
ARC-Seal: i=1; a=rsa-sha256; t=1526280949; cv=none;
        d=google.com; s=arc-20160816;
        b=QXspvxFXGLcsvhdb590GpZ37vOQOvxZ8JgLfSSPclEDh7d3p9+Ag8iZCq3l/Te+fmU
         fmchyYIp18rtD0yumi88+3Y8X6J3LgzAW6aYCxo9bF8MFEoqGdDnbmrtG2vOia03Ezlh
         0QqdtWdve80/YVXQpCQszXOCEyhvmMrVk55A2fZVjGyEsIwRd72lGCpOL0YwV8k65eoY
         DV6ASFV618vQ6HVBp4tiE5up7udhFyB3S6d1fPAqE1YZ/pUdCqZ6LhxwkAtCd1t0xyLV
         pySCxoo27ILR6HEYmqjkg43X6nOhIB0Os2R2HS7S+MFQZ7+PacxSFK62KPxUD8NgdlNG
         Ziug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=OWZKo+DWNhD72scoHSpTAgCrspJgSWhVermf7x7jJKs=;
        b=g1RcGvdMOTQeQw+Cff0CCukX+L0gatZjlWZTaSq+pReJj3JCnKCZ7+oB+lNg7JU20T
         kW6m772MQmg3VueVj99SrrRDp3kQ4VMe3BMQt2MCOWgcmqvqZOt6b+8puYQ2z2Usg7SV
         eqVh3JB+yzYFubzlMUBsT/5qm1XdCAkQ8Hs7K++whUXyLx0aZnJ+cBCDF3Zx3aIEUZE4
         XUmFrmXHK0zxd5Xk8/kYeum4+Mi53uwzP7UyIZ80x1lOzrxNKxc7HOfBv4/hv3kXE1Ko
         8dSD/aivEEv75Les+1UIsCQFl9JFl5vSMAlv47GtDhJqjVNadOVD1ljMuF1vNOMoxXJu
         AtLw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=yi9HrwSh;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=yi9HrwSh;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Timur Tabi <timur@codeaurora.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.14 23/62] gpioib: do not free unrequested descriptors
Date: Mon, 14 May 2018 08:48:39 +0200
Message-Id: <20180514064817.687700979@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421513136982038?=
X-GMAIL-MSGID: =?utf-8?q?1600421572665182533?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -443,7 +443,7 @@ static int linehandle_create(struct gpio
 	struct gpiohandle_request handlereq;
 	struct linehandle_state *lh;
 	struct file *file;
-	int fd, i, ret;
+	int fd, i, count = 0, ret;
 
 	if (copy_from_user(&handlereq, ip, sizeof(handlereq)))
 		return -EFAULT;
@@ -489,6 +489,7 @@ static int linehandle_create(struct gpio
 		if (ret)
 			goto out_free_descs;
 		lh->descs[i] = desc;
+		count = i;
 
 		if (lflags & GPIOHANDLE_REQUEST_ACTIVE_LOW)
 			set_bit(FLAG_ACTIVE_LOW, &desc->flags);
@@ -555,7 +556,7 @@ static int linehandle_create(struct gpio
 out_put_unused_fd:
 	put_unused_fd(fd);
 out_free_descs:
-	for (; i >= 0; i--)
+	for (i = 0; i < count; i++)
 		gpiod_free(lh->descs[i]);
 	kfree(lh->label);
 out_free_lh:
