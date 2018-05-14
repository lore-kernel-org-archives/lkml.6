Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr6XIi24sdIpcf3TP3UKMTV+qPGBXvv5orHBeJAARMeLziqkqmUChJIlXPpZQciOWVK9Dqn
ARC-Seal: i=1; a=rsa-sha256; t=1526280763; cv=none;
        d=google.com; s=arc-20160816;
        b=DvCKVj+1VWmfSzWbO7aEy8gEaq6aF6tWNv1M4OwQEVIieV6vCL1tvcWFtEZpdr3P0j
         Z9l/CeL+leX0ZppivZFuchD8nwrZ+KkaRybhlrQ2hc+F0BbP+2KlyUBaDHrxWuYVbBsv
         zol2FJGgfGmb2eIAKlrLpKg2YwmzcRhk7trs8O7zLG1ZCvuCFGU6tZINPFtUZbyDCG1m
         aZ/JrdtzEhi8Ggb2blY3/7yI/mzVag3XQI5kJYKLKlKDWqLmiRwpIHLipGQB0X+bbjwd
         VBpk2yMbMwhbSBgWwAHEoM4VQ17MMABEaDfmEhB9Zj6EQlTHBMF2hULVSOtr+Aqaazt+
         pF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Ck8WcJRntXffvYd23Qt5G6gbegBQSnFkxBoXIu3EDUY=;
        b=ruiIMkeMc7yur6LV3YxIAdTr7bHgB1McrNzmV4ZsijXrHey/h8Wqqg2jS2rPLzSe+A
         oH9H4VA5XDDQdHVuU6d6ZJg3xMcO3HKCLQ/MbGIRGsN7bs9S5xBp79EXNcQ120ijiKWM
         4SnSjolBfUbojCwr8b62YMk866wE+eXDboqfFUUwoMMekV7Llv/AENhcf8jvmhMF0PFN
         1yBjLPflxBjflnzEznUKXzJzqIlGktDoP7ibCP0IT/MXqFsk2OsqUEP5fEokJXRgLafr
         rPNBQCh2vGgKcdb682qDlIQH6zWxSDDDe2GD3kcmmD29nmI0FYUWei495YaKW3TYCtMu
         wMyA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=m8RqAaXV;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=m8RqAaXV;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.4 30/56] usb: musb: host: fix potential NULL pointer dereference
Date: Mon, 14 May 2018 08:48:35 +0200
Message-Id: <20180514064757.697430492@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421264645591183?=
X-GMAIL-MSGID: =?utf-8?q?1600421377733713671?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bin Liu <b-liu@ti.com>

commit 2b63f1329df2cd814c1f8353fae4853ace6521d1 upstream.

musb_start_urb() doesn't check the pass-in parameter if it is NULL.  But
in musb_bulk_nak_timeout() the parameter passed to musb_start_urb() is
returned from first_qh(), which could be NULL.

So wrap the musb_start_urb() call here with a if condition check to
avoid the potential NULL pointer dereference.

Fixes: f283862f3b5c ("usb: musb: NAK timeout scheme on bulk TX endpoint")
Cc: stable@vger.kernel.org # v3.7+
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_host.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1048,7 +1048,9 @@ static void musb_bulk_nak_timeout(struct
 			/* set tx_reinit and schedule the next qh */
 			ep->tx_reinit = 1;
 		}
-		musb_start_urb(musb, is_in, next_qh);
+
+		if (next_qh)
+			musb_start_urb(musb, is_in, next_qh);
 	}
 }
 
