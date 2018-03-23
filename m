Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsosReWPtcxksOMzxDWNoyjiH4B15NK6H40k/ePpQACyejvZe2dRHjVOmbd6JL6hicP4LZ6
ARC-Seal: i=1; a=rsa-sha256; t=1521800152; cv=none;
        d=google.com; s=arc-20160816;
        b=r62+nXipklR2lXDhZxJxtkgp0TkiEbz57xIDlP4rqgq4GsE6LSOWnBQqEad5rHGvsO
         uSLLGPy+sr429ycDXEqtxaHMMkMzGFUnEqkNR53P3u+yc7xGAQGBAfq+2LcZVAZ8k98Z
         VBp+3lKIHWrHZD0F/nq+kKWyPYEfJlxThb4UOt+e3QJANA7Lnh8ct2bt3N9REZFYfsGf
         HnRKrD1XH5chfQuluV1XdPH5UZnv7XDO6/f/rZZshlOLEi7S8mMLMtmIExRhdJWpUOuq
         nnk0uzbi6zZc7JycdjG2pkh2iCPYIKHgm31fnwo7wjXL2ftk3godfTIyfOOZIM4xuzbb
         9Yzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bRPmjbtaAqDRpTKEOQ4TL2Rtkt0nCQyzAYZQ0vFgHFc=;
        b=HbfPEaLcK9gOBFW2gfuuM48N6mQl3mzLyD9kIKyYrwmeenFyqf9h6rrcSkWrJPOrdl
         G/3egfQ4T6SE5zm+nRvuGzHzYrHVV5CZRzmKUBSJeNkqStqZCDbuLljiDoHI0jXaMzIh
         kDJQrBknT7KKbatRrU758D44uGy1gnQ1mFmZ0vwvAD172OYqUSYZ5wOFuSwHmHIiqKme
         q9i2229u9wSqPSv2a4j8QzKberzCaFMJR2v3dN+dUgfsfPtXcjTqOiUeUK/XPROoUQua
         26Sko5Mk3641w3caHe23eszAvQRpLaWi4aDksgFXbjBP5shpefLkU1DfDvIYLFiGKvRz
         GvkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pan Bian <bianpan2016@163.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 54/97] staging: wilc1000: fix unchecked return value
Date: Fri, 23 Mar 2018 10:54:41 +0100
Message-Id: <20180323094200.696341654@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722650670418248?=
X-GMAIL-MSGID: =?utf-8?q?1595723116571900256?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pan Bian <bianpan2016@163.com>


[ Upstream commit 9e96652756ad647b7bcc03cb99ffc9756d7b5f93 ]

Function dev_alloc_skb() will return a NULL pointer if there is no
enough memory. However, in function WILC_WFI_mon_xmit(), its return
value is used without validation. This may result in a bad memory access
bug. This patch fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/wilc1000/linux_mon.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/staging/wilc1000/linux_mon.c
+++ b/drivers/staging/wilc1000/linux_mon.c
@@ -251,6 +251,8 @@ static netdev_tx_t WILC_WFI_mon_xmit(str
 
 	if (skb->data[0] == 0xc0 && (!(memcmp(broadcast, &skb->data[4], 6)))) {
 		skb2 = dev_alloc_skb(skb->len + sizeof(struct wilc_wfi_radiotap_cb_hdr));
+		if (!skb2)
+			return -ENOMEM;
 
 		memcpy(skb_put(skb2, skb->len), skb->data, skb->len);
 
