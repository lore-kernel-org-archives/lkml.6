Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Cf3u2mHgwnjHPR/saamV+8bDSex4kyglQkX3vb/Z+kpAu7UYvIpW0Vje0NCBpMS0RgTBc
ARC-Seal: i=1; a=rsa-sha256; t=1522346692; cv=none;
        d=google.com; s=arc-20160816;
        b=EkwNLHYhR+zQ/AL4NmGWzHtl8KoRKASiwZp6Zip82dVd9H22iOB72/N/WmNRPDEL8r
         W4xWCa46AhqGTfGiCniTxdRmHqflDkYfa4Sqfsw6HUkomIJY62K37WNPlQk+/M/7YRBD
         Z3F7dZWQ8d+GwfxsmB0gMh3v/GtllUJSvL1fB8xEnMxzawCsCK6058AFLNiktHpb4sz3
         HuyQnawAeRbOS+9X8IQLhBQOwWrPrfpzCwfvaiAQMUTAFFe47gtwwIXlJ4yfA2uSv066
         1qayFP80mm14pjBp6hf68rXLAuGVgoJMZER4CAcav8V+YYdAXcrzNk4zg9wCZDj37Qv3
         L+Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=g53IMIwZKHRvtC59iKLQZ8f3q+igmjvmeVNeDN4USW0=;
        b=GPMowtv63QNwQZ6r0lxxVtL6co8zlzN12jV2s5qIgNmB3gmrNA1AweBGaDO7Ho4KaL
         DGhDxBL352KG35mWwcytmjQnWwx1QHpb8o4IRPSNHEzI/0bm0z+gS4nX7M6ATZdG/8aY
         iO01L6PzxNmWsxz1yIz5GeQxec/P1Vm62TME3G/dKMBdSjaYItn5B9/r1hMKYiVHTBsK
         KaTazj8p3EZqGYFeVZK8VE7gTkkKLc2rDJtsGNKB90DWccU+WPps0GFAWGk2FvCPHhmd
         kN6giXgxTiUqV+udJdbDEgRBt5YE2slNUMulFAuC15VXnqZa3rF0GLJo7Eh7RSIHFXdI
         5zQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexey Kodanev <alexey.kodanev@oracle.com>,
	Shannon Nelson <shannon.nelson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 07/43] macvlan: filter out unsupported feature flags
Date: Thu, 29 Mar 2018 20:00:02 +0200
Message-Id: <20180329175730.856662053@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296092990311959?=
X-GMAIL-MSGID: =?utf-8?q?1596296205140872159?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shannon Nelson <shannon.nelson@oracle.com>


[ Upstream commit 13fbcc8dc573482dd3f27568257fd7087f8935f4 ]

Adding a macvlan device on top of a lowerdev that supports
the xfrm offloads fails with a new regression:
  # ip link add link ens1f0 mv0 type macvlan
  RTNETLINK answers: Operation not permitted

Tracing down the failure shows that the macvlan device inherits
the NETIF_F_HW_ESP and NETIF_F_HW_ESP_TX_CSUM feature flags
from the lowerdev, but with no dev->xfrmdev_ops API filled
in, it doesn't actually support xfrm.  When the request is
made to add the new macvlan device, the XFRM listener for
NETDEV_REGISTER calls xfrm_api_check() which fails the new
registration because dev->xfrmdev_ops is NULL.

The macvlan creation succeeds when we filter out the ESP
feature flags in macvlan_fix_features(), so let's filter them
out like we're already filtering out ~NETIF_F_NETNS_LOCAL.
When XFRM support is added in the future, we can add the flags
into MACVLAN_FEATURES.

This same problem could crop up in the future with any other
new feature flags, so let's filter out any flags that aren't
defined as supported in macvlan.

Fixes: d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
Reported-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/macvlan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1037,7 +1037,7 @@ static netdev_features_t macvlan_fix_fea
 	lowerdev_features &= (features | ~NETIF_F_LRO);
 	features = netdev_increment_features(lowerdev_features, features, mask);
 	features |= ALWAYS_ON_FEATURES;
-	features &= ~NETIF_F_NETNS_LOCAL;
+	features &= (ALWAYS_ON_FEATURES | MACVLAN_FEATURES);
 
 	return features;
 }
