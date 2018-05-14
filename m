Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqzRGhpTpML/UyOisPwQ/ibYyuNI1tr5PtJYpDix73vU2u5NoFbuuulJgDcT5LjoJRLOGHp
ARC-Seal: i=1; a=rsa-sha256; t=1526281142; cv=none;
        d=google.com; s=arc-20160816;
        b=SIoC88G5gU9WEnucNQHdP375gVmlcV1HAWwA74m7eFvkU5vq9cPU/lBk9MrgHc0ytO
         EZwALkz7sCVCOvMfRGnjmDG7yuyq6sT/wVsXGJ3HA0G0QZEkIVR1jrWtOnkyhajW4oBk
         V1TpTnqKc2QgzbfF/U7QGY0BRRSMyRBA6YEFDki9LPbXVLjT0tqILQEGEGeRAHUIp+zT
         ODSjjh7EqkgHpDsTCUI062QRVpoqmDRUUI12qzW0yEqZwyWdBf0PBrc9mz35MntCd+Cr
         IH/mgP756z+qb99okRK0HHKcAiAy3K9jV6Esdsah5y3kARQNHvaK2i+DKScxed+FIOl+
         zDOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=yOqcCFWxbwPko9xXvNtm1zmkJbqhTl0VzvnTB+MfzXo=;
        b=sKfDxkyljnPOVftmHF/+M/x5PCfCwb7B2IUSKZlSewW6kJ25B/2EojGr2tQtoqwVjT
         QOvJuOENmfeJx3bW4zEzkhhT+e3iGreUqU0m32MZqeyktRQ/W8pCeboHkT48tx56K7WP
         5hfYH2Ohv6FlDMi6qXVogNiUkDf7t+VX1/91pkPF8rdMw3BJK5AiWYk39AzTNwRtZ7WQ
         9xaSWbtjfFpirBOd1FEsKG/aMdColu7bW9oAa0ZqXt/+y6m3Gh873e6S1knwX2cryrQn
         iQPxWV568RU5Bzd1U11ZKxJI4Lgu7MRTH4Pz7bxUaHj5IPybfKZskD+vvnMitWKmmNwE
         e2Bw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=uwxSU+4w;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=uwxSU+4w;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+88dfb55e4c8b770d86e3@syzkaller.appspotmail.com,
	Tom Herbert <tom@quantonium.net>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 04/72] kcm: Call strp_stop before strp_done in kcm_attach
Date: Mon, 14 May 2018 08:48:21 +0200
Message-Id: <20180514064823.222665881@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421436477651736?=
X-GMAIL-MSGID: =?utf-8?q?1600421775971383664?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Herbert <tom@quantonium.net>

commit dff8baa261174de689a44572d0ea182d7aa70598 upstream.

In kcm_attach strp_done is called when sk_user_data is already
set to fail the attach. strp_done needs the strp to be stopped and
warns if it isn't. Call strp_stop in this case to eliminate the
warning message.

Reported-by: syzbot+88dfb55e4c8b770d86e3@syzkaller.appspotmail.com
Fixes: e5571240236c5652f ("kcm: Check if sk_user_data already set in kcm_attach"
Signed-off-by: Tom Herbert <tom@quantonium.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/kcm/kcmsock.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1425,6 +1425,7 @@ static int kcm_attach(struct socket *soc
 	 */
 	if (csk->sk_user_data) {
 		write_unlock_bh(&csk->sk_callback_lock);
+		strp_stop(&psock->strp);
 		strp_done(&psock->strp);
 		kmem_cache_free(kcm_psockp, psock);
 		err = -EALREADY;
