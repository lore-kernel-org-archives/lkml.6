Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrBgeU8QjD9aa+pnKiGIBZqJae3hrbc9qNBSM9H3vDeAA8BYh1V8QjRIR75C6hz/q9Es5n8
ARC-Seal: i=1; a=rsa-sha256; t=1525767241; cv=none;
        d=google.com; s=arc-20160816;
        b=dcYvQIW4kigLFH5ZPpQoLB6gz40xlt7haFeIg2cGMU5U2pQD/vqe5Jm1uV38HW+NoU
         RPqJQeWSJH65YKAxUS0asALmk94/MNNQscDGMuLvQ7GjBYoAZhBZop5fpmoHkugGl06R
         2HDph+ik+VRHD7L8OKjh4fd73i0hyoJnFOtcdYkmVG9TNIXM38IstXIFfuUSUSe3clK7
         FfJ9F9aXOKqFK7hBkZgDnkSs8IXohSIFrDiQNySP7rjHiKZR9X7ekZfwi8tfA7TT4Zq3
         IskFPzxZItt7A/0hmpiGSbXju5WyFIpoqqbn7J0zgW5004ZWQ0TJjaLPqlPUl0NIyH2J
         i7dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=wVarb8H+OcLb4ibPDyBH4JGwAmX3f/3BLhZIlwGo+Vo=;
        b=fxbUNxvhAok1h4aZbQWZ0E6gLPuvP3ofY8J2MfS67ro7wdtZwq2zoEhHRro9iq3F0D
         bTztmxBECctDgs/gu86s5pUj5+7PHUM+LSJAr+xT8nMl3V6yxzZCtPS2d+iiulgDEJRn
         94WbhQvxNtPMegLu/fwSGL9QGKR2ayvyDjZBMh5zaZHmCDHQWB1XiaKpkPFlsvsJKY0M
         NGshgvYCY8ueE7jbF6F5OKe51YEAZW/VshARIa2o3sG41DCq9SlmHMLAw8e0t8BQp1mb
         n3XAaOcbRXf4i1cvVvAiJU9B8Q+wcHunreE8I7xfm7qVnqgHT0JhysqvJ3IUbYOpC4q2
         5S2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Dq0gTDuo;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Dq0gTDuo;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.16 41/52] usb: musb: host: fix potential NULL pointer dereference
Date: Tue,  8 May 2018 10:10:39 +0200
Message-Id: <20180508073933.893538391@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882910647736531?=
X-GMAIL-MSGID: =?utf-8?q?1599882910647736531?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -996,7 +996,9 @@ static void musb_bulk_nak_timeout(struct
 			/* set tx_reinit and schedule the next qh */
 			ep->tx_reinit = 1;
 		}
-		musb_start_urb(musb, is_in, next_qh);
+
+		if (next_qh)
+			musb_start_urb(musb, is_in, next_qh);
 	}
 }
 
