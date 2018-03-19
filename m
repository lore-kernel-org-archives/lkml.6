Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtnXNiSz/kWSonGKAx6/bzZ23v8jhWGyC58nkK5RdJkAFEvagSow5EFKBI1lxmjGXqjwRLO
ARC-Seal: i=1; a=rsa-sha256; t=1521483225; cv=none;
        d=google.com; s=arc-20160816;
        b=DTR85SSBjGA99SmZtwKXYQY+6bwY5DqJoO3dOun40pscvR2s+yQmvzqf2aWmXF86Zj
         lFmC3CSgAIHJbR16/HKeiRjqfLECXxkwnfZyolNwgy37Ub2RPglUP9taXPqAFMR+CVov
         aCk++zpEMzeffgSFN1Hy7DfhGeGb9SGbEb5BQbIF2X82TwNq4XqD463A+ayzBYWS7wQX
         YSvplV7fsbXSotGw9umBEhhyR/O8BSjXGit17qGf3OdKINwKWVj/ml3/JNiOnmNTyQkm
         3Gr1emdNTfcQCE3wDzpU5nAjXe3Aaw5HqihErx3fCMMTzXdQ45Rd328JSvsAuCkJEWBq
         UOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jyUtGWnLHAtnPjp6Rp5AjDqHozdB64dhUM/SDORUCgY=;
        b=SSlubnaoTrImNqU6Nf42M1C9TAEdCUHL5Ydo6p1PR7lkZ9GCH0S9Q7N7TgUzoQcseF
         OFyzuupDkWZKATS5AgnargYIqF0dwDwu03ZmcPcQfN1GHi/g6cgPKHh5c1y+xhaaPz0q
         1/M0It6Q3pYgKJqYEICo21I46ceclsYX5+T000wLjZEvmxuB+J7ufsVKIODAdXpRBKhq
         AW1PVOafBYa4gr1k8cTKTTYqf1WQWjcXVz3V+ORciH2ZK/I7l1QSoelp2YG5IfHm4kKG
         MNeH7S4KMZXwAf1GPnGSgO15cJmEY0aNxTGUSOq01gEngTTPtdnZgiiZ9YF2WcPdLztj
         3i6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 046/134] NFC: nfcmrvl: double free on error path
Date: Mon, 19 Mar 2018 19:05:29 +0100
Message-Id: <20180319171856.024098991@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390794553494961?=
X-GMAIL-MSGID: =?utf-8?q?1595390794553494961?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit ca42fb9e52d155547e6cf18cf26bce3e1a6af4ea ]

The nci_spi_send() function calls kfree_skb(skb) on both error and
success so this extra kfree_skb() is a double free.

Fixes: caf6e49bf6d0 ("NFC: nfcmrvl: add spi driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nfc/nfcmrvl/spi.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/nfc/nfcmrvl/spi.c
+++ b/drivers/nfc/nfcmrvl/spi.c
@@ -96,10 +96,9 @@ static int nfcmrvl_spi_nci_send(struct n
 	/* Send the SPI packet */
 	err = nci_spi_send(drv_data->nci_spi, &drv_data->handshake_completion,
 			   skb);
-	if (err != 0) {
+	if (err)
 		nfc_err(priv->dev, "spi_send failed %d", err);
-		kfree_skb(skb);
-	}
+
 	return err;
 }
 
