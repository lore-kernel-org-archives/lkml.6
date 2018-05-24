Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoMSZYg42EDM8S235oixZI+FMsd0iRrojQEndi4HH7vKgZUl1VVFvRygWAkyNAhO3nFNHaW
ARC-Seal: i=1; a=rsa-sha256; t=1527156187; cv=none;
        d=google.com; s=arc-20160816;
        b=BhmP3/SlCn55rAFeSwkCLeeqVYupezAFBum/Uv1uKmw0FG7g+GwIq13BpC/wdCVhpw
         ynRXAwph5QlDp4CQdLpQVuMHxk4Xy1dCqG2sHMxlfi4Oykk1aWSR1NxfBEl8TL1aM2xw
         p6vyBfA+qfg73zsfZB3sWbcqPPbVr+sxzihvJgO4/uVy0BEfgLApaykfJy5rBkTHvMDb
         Us3lh1lTZGd48rq8vJcs3sY8XgqJ6wWCOC2jjTKS1CnNGJhoXPZNddsANmSf2OdSUndu
         YCc2PqeuSKkDo8Ar75GN4nXpLaxlZfNX+8y+ocXl4/dspqsC3OYfLZxqDnb+lAO3QtHD
         8dEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=kcSg4QVFZTlbn/28EmTV7Z0x5wmW68FaidsW8wRz9cc=;
        b=p8Dzg6nGhmBiE+k0J6hPhvSChHW61tLeIlq9/dLi9zjC/V4izlOV3Wz/oKNifnd0yC
         UjuEgNfdYN5mM7M0MkyYTHTVtLtoF9jQD+/5gc9PrJKNEO32YHLKB/6O2+793/OGFHkv
         ZfFBZiYPxkmoAVu+6hHL4hUrw1WcIFmTg7IyN84FdcEViPiJEClltVMJzyYnzw/UXrvT
         ZOeUH9KP2AOaUjYnlkNnI8mdL3T1o1pEbs6xwJkqG7NZxzKwkmzV2K5ZO53gU4JBbwrB
         5jX9aq9J7mRado+LoNa+qOO0VNfzH0qwW+4OMa1hDkMziACIthgXCS4QGw8WqFYy+d5n
         JqsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GpUO1uuD;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GpUO1uuD;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 094/161] staging: rtl8192u: return -ENOMEM on failed allocation of priv->oldaddr
Date: Thu, 24 May 2018 11:38:39 +0200
Message-Id: <20180524093029.668964876@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338432317674148?=
X-GMAIL-MSGID: =?utf-8?q?1601339327050803849?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit e1a7418529e33bc4efc346324557251a16a3e79b ]

Currently the allocation of priv->oldaddr is not null checked which will
lead to subsequent errors when accessing priv->oldaddr.  Fix this with
a null pointer check and a return of -ENOMEM on allocation failure.

Detected with Coccinelle:
drivers/staging/rtl8192u/r8192U_core.c:1708:2-15: alloc with no test,
possible model on line 1723

Fixes: 8fc8598e61f6 ("Staging: Added Realtek rtl8192u driver to staging")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8192u/r8192U_core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1706,6 +1706,8 @@ static short rtl8192_usb_initendpoints(s
 
 		priv->rx_urb[16] = usb_alloc_urb(0, GFP_KERNEL);
 		priv->oldaddr = kmalloc(16, GFP_KERNEL);
+		if (!priv->oldaddr)
+			return -ENOMEM;
 		oldaddr = priv->oldaddr;
 		align = ((long)oldaddr) & 3;
 		if (align) {
