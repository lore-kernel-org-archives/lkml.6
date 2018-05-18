Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo+18GWxhd0714kmc9ZBPwRGTKQfwAukOZPdi4PnIXkj//g6xasXsCiyaCL/4Def85fZ10R
ARC-Seal: i=1; a=rsa-sha256; t=1526631699; cv=none;
        d=google.com; s=arc-20160816;
        b=KvUG38AqffZymrfZkiruZNGAhLZt1ya+XLMKKq9kuMP6SNgtbeGbbHirU5jBOyrqUM
         tkN0GDVlY2v6p0slnjPAvATKbFlsmgF3sVFAfvmx44RVMAjOQufjNXxagIOpqcxrmiBA
         Pz5Pil/SwqWLE0H0pHTzJbKAXToprJKabKYEgFctdCR73nq/g95HNSd0Dt8aKhXzHnyw
         LN3jTpAHn91A9xQiTNpzeGnsfB7P//60erdmZ+Ij43SijGdL2/HDY+nilKeOhaCSA46W
         Zj5Y9QorAxAn09OV0UqscVNN4FByHW8yXLMow+j/f1PY1/A808GNzvFrz+r1wA2OzFxW
         VbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=7sDV/pp5D2+lVmas4h+Ahl71kbwK60bvhAKDRbGdMmY=;
        b=FKkpBnOkBSLnxRpE/NfAiYyAdFQ0AbqLKuGL8QUHeqWBHkHaTXmWyKX9AtQmiMejqV
         IPLMgxJJ7N78ntDrmLRLhKuLaeErXpddmWolYGtV34DTYiGeHSj7xvg7jTLkrzVwxxrK
         ++Z3xhlDVyIV9yKT7srncMQ3v8A05lv13pUNHvIj2YrJnNaqVjHD/F6J6w8q8oulPBdg
         52Jbdrk7oBoc7/zwiQvq5uexGqUNfjUQijRa82vpwvXbePUYL93jJhm1ZgQTf7tevavZ
         Zu0OsFYhdtgzbgK5SKnBBaAAQXTMx1YzGQt5m34EL2kdMQPP1BSed6TA8qA5Es6mjiiA
         auRw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dH5jCcA+;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=dH5jCcA+;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+141d898c5f24489db4aa@syzkaller.appspotmail.com,
	Xin Long <lucien.xin@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 16/33] sctp: remove sctp_chunk_put from fail_mark err path in sctp_ulpevent_make_rcvmsg
Date: Fri, 18 May 2018 10:15:55 +0200
Message-Id: <20180518081535.758371040@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789103167895925?=
X-GMAIL-MSGID: =?utf-8?q?1600789360583571306?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 6910e25de2257e2c82c7a2d126e3463cd8e50810 ]

In Commit 1f45f78f8e51 ("sctp: allow GSO frags to access the chunk too"),
it held the chunk in sctp_ulpevent_make_rcvmsg to access it safely later
in recvmsg. However, it also added sctp_chunk_put in fail_mark err path,
which is only triggered before holding the chunk.

syzbot reported a use-after-free crash happened on this err path, where
it shouldn't call sctp_chunk_put.

This patch simply removes this call.

Fixes: 1f45f78f8e51 ("sctp: allow GSO frags to access the chunk too")
Reported-by: syzbot+141d898c5f24489db4aa@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/ulpevent.c |    1 -
 1 file changed, 1 deletion(-)

--- a/net/sctp/ulpevent.c
+++ b/net/sctp/ulpevent.c
@@ -723,7 +723,6 @@ struct sctp_ulpevent *sctp_ulpevent_make
 	return event;
 
 fail_mark:
-	sctp_chunk_put(chunk);
 	kfree_skb(skb);
 fail:
 	return NULL;
