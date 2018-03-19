Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsGTHfh/A2Ea5udHNKLEnHvl65Wlj/vb+Hb3Ipcf4wYW2/hrUbXEW+v7WnXBfY2JGCoHlDD
ARC-Seal: i=1; a=rsa-sha256; t=1521483201; cv=none;
        d=google.com; s=arc-20160816;
        b=oYefBoSIsjUSK7jkuVG2Y5I8VJaUqnSyDQi/nuI9TDpW8TH4i67hqV19TQKV6lCsb0
         AugfSjUjjbvNUFM0Tm68yTji4EMa4SNXXt2GTkKbIfq/oMKdZpDCI611ZkjPc9ayK6XW
         6TtkIgMXrsOqNXbYX0WQFTNlgwt3AyBfLjOsSiLyOKvevPgePJpYvXVWjm7t+YQfrRdn
         t8b+9APkQVll7XKP3ykoN8owQGBjJfqADpF/JZxRNrVo6Cra1dx9JN9xr4iAwk6+jjDG
         cJ11S7ZGU64h+gBgRulEPj8CmcCWYLPKlFkpyNG1efQNSP+hyFBEZFIMlfANU+bwHlgY
         myDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4n7ZkLlMQJMMtq7vibI8oyTKM7ord5wzWEfKbQz4Qes=;
        b=SINTb2DcUKkxBkqLP8Tii2wbgC4qi+HgEsIeQaRaWepIv1wMKu3blEfLq6F0j8Dglz
         pGPdr3bRjAX2tqvWkNboKuGMFjmyr6q54w4N/FDoybGa+RrPQRjXyZmHcGPKavmk9zML
         8BOHRb9fcq6yhsimNThdDV5zNGbABj+3ho3spIsSVMDPoZUIty2HQtIEYeUZJvSOr6Cf
         PrbaD8NY7s/zrk5wY8JuWtJjgSug3MC8fCs+KSSG8zefNIwUi8K3P+XGnJvVaW+1wTo3
         l48Nd84EwT71Rm+c5xyh6DSO56tnff1GgC3L0Em7Xr6IeQvJ4dzJqe1MiCqZ6MR6l+1O
         LgTA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 004/134] staging: wilc1000: add check for kmalloc allocation failure.
Date: Mon, 19 Mar 2018 19:04:47 +0100
Message-Id: <20180319171849.680994638@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390769061869990?=
X-GMAIL-MSGID: =?utf-8?q?1595390769061869990?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>


[ Upstream commit 6cc0c259d034c6ab48f4e12f505213988e73d380 ]

Add a sanity check that wid.val has been allocated, fixes a null
pointer deference on stamac when calling ether_add_copy.

Detected by CoverityScan, CID#1369537 ("Dereference null return value")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/wilc1000/host_interface.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/staging/wilc1000/host_interface.c
+++ b/drivers/staging/wilc1000/host_interface.c
@@ -2179,6 +2179,8 @@ static s32 Handle_Get_InActiveTime(struc
 	wid.type = WID_STR;
 	wid.size = ETH_ALEN;
 	wid.val = kmalloc(wid.size, GFP_KERNEL);
+	if (!wid.val)
+		return -ENOMEM;
 
 	stamac = wid.val;
 	memcpy(stamac, strHostIfStaInactiveT->mac, ETH_ALEN);
