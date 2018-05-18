Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqckcoENv+7/MztsHmEnIORqasBXEyF0ngi1W9QzvNytDUeWeeLWp7t43CQ3j3Bn3OR1DJv
ARC-Seal: i=1; a=rsa-sha256; t=1526631670; cv=none;
        d=google.com; s=arc-20160816;
        b=ggGNrwWd9++gJbeSltloxTLIoQaqX9t1p4dVL6M6kvptV2S9dm6usjl+6Ipk7c1oLC
         teO4fpnMG9zpsyQBwohzCjH6s7KlEFQ15MZ9RN8lB4BsdC3f6D5TXL2AfFC+lHVe4ZHT
         layoQexe9XgxNFtIOXsFH/z8umfsjUXcZHau3OFozDQ8DJntY0U/shJUnRBIhAn6ht90
         DB26NFy48auyBaQwnPusgABNNfYs9FwoKqegGi67GIb8SoNqu/01/hSctdVMKorNgPM4
         am660JwQEqY2Uw0yWjNAclapuv2oPZvyOfoCRNdD4ykacz071FC5u2wFZ7JS/Ol7o/uz
         aqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=QVI/hOX8OoKsUP+gtUZrP6MixWhGsPGE4DmdA0mSPuQ=;
        b=UMtGY5kQNJsG3F6DrP+hPmI13OBkFG9c5PHISF0RLDCL+Og/jkjqB7EJpqC+gG8WLA
         RoOCPvPcLD3yxwDAOw5yBU45X6uZclG4LGWjQE7r8SQ6U5BC/cdnYvI4DU70xBga4G9S
         MfQ/mqg6XSZb2l/yX/9ZA+WLmwRfQ/6pH89JAb9O8WK7/+NxLtGVEN0fajDfoD7AlKY0
         YQeaWqHAY18lh2YxyWf+QWdoYP4S3CE/U+op8+9T/ColrQaQVbBsUiMQVacXoDm9eb0t
         jCjLT8cf7d8X4XXRuMux8jHv8K7vK0K1QQ3xCE63NZn7zsorAM+Ow269R46dkL6m0STD
         Z98w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NfbUJtK6;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=NfbUJtK6;
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
Subject: [PATCH 4.14 25/45] sctp: remove sctp_chunk_put from fail_mark err path in sctp_ulpevent_make_rcvmsg
Date: Fri, 18 May 2018 10:15:42 +0200
Message-Id: <20180518081531.619661054@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789103167895925?=
X-GMAIL-MSGID: =?utf-8?q?1600789330229525800?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -717,7 +717,6 @@ struct sctp_ulpevent *sctp_ulpevent_make
 	return event;
 
 fail_mark:
-	sctp_chunk_put(chunk);
 	kfree_skb(skb);
 fail:
 	return NULL;
