Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoPcKmZExnMiO63pzHgIz1VGuI/8/glwHVv4FyO/ahpgg4zDP4OVdnRn5OndnMi6CMR+dS4
ARC-Seal: i=1; a=rsa-sha256; t=1525767349; cv=none;
        d=google.com; s=arc-20160816;
        b=ix6LnThyhdKZk8XOH4pNeBx/h9GJk+0ogMMGar7ZlD/Kp7vJcKX2KdFp7ByD9CtGh+
         7QXCeH6rBtdXdvGq0RIMlOhaqQTnAoZ43vxjpmr+RPTUlgwobTWPi3ZEvIxXcIcoP+vY
         dtD0alnMrYSwaqnw7pf7AZSWgd/KctH8ssy8MfGnYIo80OZqPfYMQsPe4SeZxqxIQ0/K
         z46x/AYdlzgaSfdotmVPuvUJo+fZpPu6wXfjF1Que/7B+dLxQobvnTp1DxNgG0KytfwV
         0KvU5a322rCiIVnJDTOuRO6eFXRtXwBob8LP1F3MiZowQhp+K5XPu7x0bm1ywRZrGutB
         NtWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=LMQUnEFfdHQkLfBzRPx0hbYgIphGbVRx4JfPUixIY18=;
        b=HsY9Q/JR4JEm3SF699f3gPG/5xcyd1lADygJUgHFNMRexozcIOa2g7wmUKlohDNBwk
         x3LhxWVn6/IZg7nS2ybU39mLoVhZX4RYy65tXZtp2t3Ab4YUIT7Ve8nRGBnS0ypqhBbI
         eU2DMW66DjbNHDtPmDxkHBJCN+NU5jvAK5Tv/+ErpHQcWJWIUxA5bYZEH5oO/63s6ibV
         hw44rD4VHgELaNXwGzisdPYZRIRRHjJGJIISQTJ/0YHtIDL+03TDpsk99Doj4A4rpqfC
         5FnTVOdDQYCWT9PNjFDNQNMBgO1jN2Xmc/tofm5AOcbmmZVd3wFlND6ahHtr85bZmZA/
         Aj7g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Ng6m/zs2;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Ng6m/zs2;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.14 39/43] usb: musb: host: fix potential NULL pointer dereference
Date: Tue,  8 May 2018 10:10:58 +0200
Message-Id: <20180508074010.170952362@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882910647736531?=
X-GMAIL-MSGID: =?utf-8?q?1599883024353977488?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1023,7 +1023,9 @@ static void musb_bulk_nak_timeout(struct
 			/* set tx_reinit and schedule the next qh */
 			ep->tx_reinit = 1;
 		}
-		musb_start_urb(musb, is_in, next_qh);
+
+		if (next_qh)
+			musb_start_urb(musb, is_in, next_qh);
 	}
 }
 
