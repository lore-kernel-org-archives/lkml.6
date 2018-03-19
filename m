Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtcMnYkzIA1XK6QYnbl//ZTp0YOuFsSlEgo56A7bru/+MJAesTnh7V854sAFZd93SyumzO6
ARC-Seal: i=1; a=rsa-sha256; t=1521483914; cv=none;
        d=google.com; s=arc-20160816;
        b=gOeh9+rR0DVVA2L4ONzO06s5CtelU23E4uarHxP/qCfNssQKzyvXMhoX8g7RiJVluu
         aAbVFd22GmLi/YILq5NyZH3Zbb6jV6t/dWLC0++z8FFof/JOUQ8MXUuSaqi8PlrQQwtQ
         G0itBJ373YeYHb86qKwV2TxASsny7nbL0WFpg0bsL6sHjXHL0Qcea5zxOrDLNAj1WSH6
         f90OHLllOexxLE5kf0Ah56A7ASxr/0QHGVQDgbSln6/Z3VYnmgu7PZ78I4Oe45I5V3xU
         QZzdv2kVcM3PgxT+YQQJglJ5trgn6CVH4mYdrSj6k88R9dGfsEgzEEhNp/Mfj/uEMTuO
         +kpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ppIAli9LbMoS+7JFpCpCvMENLjOoTRy+xb8UdB6ot8E=;
        b=dSnhcZbH6VvVuyZ9+jdmU241RM7sG/ihUIqrOeau2v/QNrUbDTgxETA22nztMxRaze
         AHI0fh/bCY6d7GCfXnYz9YQMzDWqNZpJsAXWHZjnoJclxqj/vj+u+UjR2VQonvsn9SV4
         wfGiGlWNtiOWusz/DkmuciXm922/6+aQWwJmV6bFOGA+lFyl1En9Hs+Pdo+BJqIMPn1d
         jdGRUF/0hnHupYPrXfEDXm4po9rbvjRJZmrlQ+iVG/ZJthuZIoBdt50HTUOr3oEQFqfk
         4PmEiE5bVNFnFCBxix8Hx72dN+fG5HM58HUUR5MilzZ3kDp8foHNfOga+/LL/UKTMpLv
         3yQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ganapathi Bhat <gbhat@marvell.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 163/241] mwifiex: Fix invalid port issue
Date: Mon, 19 Mar 2018 19:07:08 +0100
Message-Id: <20180319180757.913669758@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391517371177302?=
X-GMAIL-MSGID: =?utf-8?q?1595391517371177302?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ganapathi Bhat <gbhat@marvell.com>


[ Upstream commit ecd7eb7c2bcf99f6c23d68ad56ce15949da848a1 ]

We have to use start port, for TX/RX of single packet,
instead of current aggregating port. This will fix SDIO
CMD53(TX/RX) returning -ETIMEDOUT and halting the data path.

Fixes: 0cb52aac4d19 ("mwifiex: do not set multiport flag for tx/rx single packet")
Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/marvell/mwifiex/sdio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -1458,7 +1458,7 @@ static int mwifiex_sdio_card_to_host_mp_
 		}
 
 		if (card->mpa_rx.pkt_cnt == 1)
-			mport = adapter->ioport + port;
+			mport = adapter->ioport + card->mpa_rx.start_port;
 
 		if (mwifiex_read_data_sync(adapter, card->mpa_rx.buf,
 					   card->mpa_rx.buf_len, mport, 1))
@@ -1891,7 +1891,7 @@ static int mwifiex_host_to_card_mp_aggr(
 		}
 
 		if (card->mpa_tx.pkt_cnt == 1)
-			mport = adapter->ioport + port;
+			mport = adapter->ioport + card->mpa_tx.start_port;
 
 		ret = mwifiex_write_data_to_card(adapter, card->mpa_tx.buf,
 						 card->mpa_tx.buf_len, mport);
