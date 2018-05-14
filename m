Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqtAs/MUW5b5w8uXnu+Y0cO0TnWcqYptszLBTpaJQa0Qnf0Hj5ghqEID9gib8ihyGqgUUU7
ARC-Seal: i=1; a=rsa-sha256; t=1526280655; cv=none;
        d=google.com; s=arc-20160816;
        b=Q77PDfQk8aSvz35qjxnPF2McFh342aA50xXz2v/27JnpTcPipFtbzUHrgx4m/QLXyj
         EGHjNHX4+o50Zse3KcN1JeczdeXLy/Dqp+yz2U2tieJHWup9391sqCIJTkgthDWJ+pj3
         j/MqkXU5gnOfvgL604btXMM0gTkYHF7vBnpXQUgqA7F78E40TXWmE8tPnsib0WOAFjUc
         KJNi1SiQ8BSOEDP0JCnPPikCUQsFscvEnxWOemuA/lMkRw9uPHB8M+sKQdvFSoJwzcAG
         JtuqPP1LziSbqUCx6L72pH+ljdDwuY8qHS2KDrzVPAMCFncZQ7xIDg2cH8b28fZCVT6C
         B/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=HULEOkqJA9+WXIUEnom4jRudNobmNGdIC30lM51kEnc=;
        b=nNNQcYYBWiDx7jUY9NrPdvjuSMO7lZAmx2wxuTeNvwZQsSyMfAkwZ9DTrV9QGtaobC
         AVD1cUkZ3MH/qg7lFQB0glDauSvZf+A/u5aMtEts/jGiyPLVKiMMyHKZ1MzUU8qlQZf5
         JlsTwqy7lP5dNhhcVs4OD20JAvGmS8l2yrGKyAJI6OOmiN05Ppzurs/KW9+fUJRvkHcw
         JiD2+/g2H0QyGYELQ529RNs2GndIt1qz9B1XEiN363tzXZJC8jFpJndWaj9m1h2hls45
         MQZaFOEyaxM9xdVa9HfsBtut46CM4GcczXW0hfmNr+ZofKREznLqw3oqpCBe3WkdMgd8
         o3uQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=mjK1ZBJ6;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=mjK1ZBJ6;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bin Liu <b-liu@ti.com>
Subject: [PATCH 3.18 11/23] usb: musb: host: fix potential NULL pointer dereference
Date: Mon, 14 May 2018 08:48:40 +0200
Message-Id: <20180514064704.533830969@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
References: <20180514064704.046463679@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421264645591183?=
X-GMAIL-MSGID: =?utf-8?q?1600421264645591183?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1002,7 +1002,9 @@ static void musb_bulk_nak_timeout(struct
 			/* set tx_reinit and schedule the next qh */
 			ep->tx_reinit = 1;
 		}
-		musb_start_urb(musb, is_in, next_qh);
+
+		if (next_qh)
+			musb_start_urb(musb, is_in, next_qh);
 	}
 }
 
