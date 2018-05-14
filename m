Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZogjS1USRUNx1ZTqtgyxT1P+sfav0oZjUczS1onhtOd3vQ8yoZLSbPZPUiqYa4ikzxGmAUL
ARC-Seal: i=1; a=rsa-sha256; t=1526280957; cv=none;
        d=google.com; s=arc-20160816;
        b=gFITTgH8MSKVzkZqPeS3AyfINgjBA2/2C4MpZRsQOqObK6jy7vKptasMF0dMHPL+7n
         5iZM/4+ZGv/eg5aBn6KV94vsW/KQEP97HabbAvhLTc1dNuPkvyJF5SBKHbutjiTOOztg
         2iI9EpRCZfLd1c69jaIh3zgCp4Ki5U42zMfi72dH3aa1E7z/o6r2SZXIS13do2Y4k6OO
         rmNlPUw0Q8jl1k4wlFBPdAQcX9+Hhx26j7l1oNEjHO5Q9cWWVaSs38RkIm5pjh9yazgR
         Gnnipmlc0EojlyXCSi8Lp7w3h98a6LVoZnm95W6BpphRUujKcDJUNOuDFbqvUdi9Vwy0
         03Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=kQz4XnB9eG0Wos0E2qditGWn/3OKLOnJszx19+IQd/g=;
        b=iuR02KoNStuR2rB+ZRa4hMnk9v21kaKG+EQs+v/3vBiLlBfyEOcGdHp+dS5qQXwpnb
         Ykb9PukE0llqyP1n+FpelLbVDfNLshuXycJOmGpGFqdLXPdGMH1eAn1elpcVZ00BKghE
         bQkWE5dBeWgomm4kshqTKVYbjTJmYtZPX2iZrNvFQm4PrRDZHYiUHXTLwLkUZDDCK7x9
         LjFZ5yw3xS4gLK/KJBaqTR64SGweTFTIIGjDjr49k8GffRifjyKgSnlXVCgP+U10PrX9
         8NwbAj8HApJZZ36VSqjO/mqCqj2w+8MIpR9fTnZsriCyMTBkUGQjPvCCe3l21UZjkdgG
         b2mA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=z9HjT7pi;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=z9HjT7pi;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+88dfb55e4c8b770d86e3@syzkaller.appspotmail.com,
	Tom Herbert <tom@quantonium.net>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 03/62] kcm: Call strp_stop before strp_done in kcm_attach
Date: Mon, 14 May 2018 08:48:19 +0200
Message-Id: <20180514064816.634407998@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421436477651736?=
X-GMAIL-MSGID: =?utf-8?q?1600421581754841710?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
