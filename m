Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoRVLGVx6ZDVNH77W7/BsLFWhZFnfb1nUih/uc5gxPgu8JNqXTD1LHOF5bzU0dF+2mI33Jv
ARC-Seal: i=1; a=rsa-sha256; t=1526280819; cv=none;
        d=google.com; s=arc-20160816;
        b=Xl1a7DJVyU3wArhlqxVBf5DShNTOjz3cUy+gexPZPX4pjqLRqybRdJpljEw7++M/qh
         q8gTxDfP9IEuUMVui3y1sb9ClxmNW/nJRcI9jo3PcFv1OKqHbgAsRSAoaBSaq6aG4Q3h
         RguN9QSShKc8MrJcsJvJF99VL1vnOtVudOGvWFnRurpzdwXqkg1XZ7xvYQK+f06yB6j8
         LnBxKsryvkVAcmhWcwfR0mAKUEx8eShF3e+SKjYKwBYr6TkX+1eGfkQYcY/0+2a4lCsv
         jlY2rO+0gcOsJrZjXn+wBADyc2gDTF4Kn+q7dxPvYfDwMl9wjfucNPJesKLZuJn940CQ
         N3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=OUTiH1zNLBJOtgwYY++8EiMRviNukDU/NtI/LNe1uEk=;
        b=ZAz1xsjCsJziRMIvaDPqU3jYdiqGFKRbWi55CGnhEp+VM1B/0hpq2ZN3O9BY564MDs
         TaOLKgmx+eeR5fsUrkBQzPMfXbVapAMCDxUv4NDVGCaMzZBcg9IjqG+opUSUUYgy5vUm
         fjYsQ+QIbFt2pKweqzOu4vn2tb+ujSV96WmDZ2KBsZGAYkozZ1gaunutzXwHRg7G1BYE
         jziE+Tc39FwyoXg7TAt9O8Kti1QTjt5Gm4kISZ9vRGE/hD0hTZn3AYh9X36n3Fl8HMQj
         uSdY9IEb5v7suYxzoV30cnCqRFiTPAtzS6LKUKzNMgtfE4D1TZRYXpfX4byEmgOpxmFv
         Nlkw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qXOYIZOD;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qXOYIZOD;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+88dfb55e4c8b770d86e3@syzkaller.appspotmail.com,
	Tom Herbert <tom@quantonium.net>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 03/36] kcm: Call strp_stop before strp_done in kcm_attach
Date: Mon, 14 May 2018 08:48:37 +0200
Message-Id: <20180514064804.481050784@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421436477651736?=
X-GMAIL-MSGID: =?utf-8?q?1600421436477651736?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1424,6 +1424,7 @@ static int kcm_attach(struct socket *soc
 	 */
 	if (csk->sk_user_data) {
 		write_unlock_bh(&csk->sk_callback_lock);
+		strp_stop(&psock->strp);
 		strp_done(&psock->strp);
 		kmem_cache_free(kcm_psockp, psock);
 		err = -EALREADY;
