Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuB7U/mel13usZLX18MisZNV2l3wt1G0FssWFZiKfvOtUvDwwymnbN+ycytHrNRJrrzraGs
ARC-Seal: i=1; a=rsa-sha256; t=1520451662; cv=none;
        d=google.com; s=arc-20160816;
        b=E3aJ1Rk2iZPpWjEJ2ca7QovOMKKtuGw4pA1hMo3noKQBkAHgE5SkD/nQ0S1b2xaRj4
         k9t39IluGbbTSedBbvYjqcYjAbOzd7lpsQlNQ7IAKTewpMSgepm7iyuqgwvCyzi+m8qQ
         X/YEqLuwPPS09EJrDpO2cly4/25NdKfclNC3DFm0rMF84xM5qn7cmRU2n2lqr4l7jZ5B
         Sw9cc7Wny4orl/wBj1riLHHcrXFJRkmBWSC7+IwL1vtTytD18BiYR6rxZO2ngFM6t0Hs
         7hIS1wiaWqDx0bJNLSu6cCiJ0NJkrj1V8ccZMBc9HB0dcQG7qTG014rAfv3FmGCUkRsN
         HWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=x4Tv+fDvSaHFf5EGBJxN7d29IX47H/cRcSj9JFUWE6g=;
        b=smgl6x7IQP5rQcZFppAZc7uUtyaCyl161W/dG1KSt0lvvIgCg68ftozopQw7huE817
         zRwWA4+I4l+V4dH5i/Ux2FJ542AN42RBlejeSPyZ7+APtBpL64sFqA9sBLV5rzy+Ur5M
         Enq8O6g1KzF0n1LjhPJTBwkgSSZfj0VllrZPBtonpXNlFF+bKPJ81HkBT3RMrhHaze0n
         eJ4zm76aBckx0TE0BoFZ3sVg5gUofv29JfvotLDA6GftBoRjAfRfAmTJ5+hQfbs7q2MA
         8rM4Jm15nD4TOOynbr5ZF382ZEVLPs4NkYrHrHYJixboZYOUOilVob8hq3XXwgyq2cLA
         tvTA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 043/122] net: amd-xgbe: fix comparison to bitshift when dealing with a mask
Date: Wed,  7 Mar 2018 11:37:35 -0800
Message-Id: <20180307191735.248212817@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309121790243335?=
X-GMAIL-MSGID: =?utf-8?q?1594309121790243335?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>


[ Upstream commit a3276892db7a588bedc33168e502572008f714a9 ]

Due to a typo, the mask was destroyed by a comparison instead of a bit
shift.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -595,7 +595,7 @@ isr_done:
 
 		reissue_mask = 1 << 0;
 		if (!pdata->per_channel_irq)
-			reissue_mask |= 0xffff < 4;
+			reissue_mask |= 0xffff << 4;
 
 		XP_IOWRITE(pdata, XP_INT_REISSUE_EN, reissue_mask);
 	}
