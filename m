Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvlsQbJx9kZBo+Zg6bybuSXv3khduDxR2jbuk0dPtSRnbwip/BQ+GxlBV5t7yJ4Eb6EzPW2
ARC-Seal: i=1; a=rsa-sha256; t=1521483903; cv=none;
        d=google.com; s=arc-20160816;
        b=hJaUObwF+F+MLlj3jqmpiwTUYZAn5zyBcuFuJFjsGwj4wpPcCyX3CpsZ4cA2JeTTBy
         UoNWiCAySOqGEQMnr/MtoMt+wwWO/VpSkGcOnqFupY6jSsj+DLhpNU3FrSnqsHhLdy5E
         le2IhxcCyPDc9wO+rBYi0C/2A2Gs/qan+svWqblmJ+l6Y8zZpkxPbDZs6cMzSqCnf5Zj
         HTMdxCEmydFyliIW1IpMwS2qJ2j9g1JNhhhbA+FIRoLvkyKGgwmQaeskSec7nioHndoV
         ihWTWFJ09VnynYAp7MOAWByvrfOXdnzhmy2/Zy+U2Ty6BcTA48DbKjlQ0GwIDyInKYO3
         uSvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sRgtz8BxhObzQxQksFUzqwlO/vJFumKFt1fkR0fs0us=;
        b=mJeUYhmiVUTNAnT6Y8KeVosL+9ZIFUC8dkyhBFMXMXnMQx5/rCIPVQ5vZeg48awzvH
         F/YPgsyXZKSk9l3PGWPmyxZC7vqEEVnsiKUT0kgg9tQXYKnPVJw/ofqq7WRb+cfl1q07
         w0Yx5IoTPxQqPRYvkft1us8Fz5dGQ41hnkcVnEg/XVl28M3hVbZr6JKrVBojitpmLsp5
         oLvMW9Su7KltV+F5HNRKevinBtHCjfhU8A1zfAsCJLWQRwjwkBHLmHTiXM+sRq1F8wLB
         yqoX+F8p2sjSB8vhiquqxKmHsCCUUnvX+69CGbmMq+6VvuYAeVPHSBGBByTG3AwgO8Oo
         W2Vw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michal Kazior <michal.kazior@tieto.com>,
	Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 159/241] ath10k: fix compile time sanity check for CE4 buffer size
Date: Mon, 19 Mar 2018 19:07:04 +0100
Message-Id: <20180319180757.744894218@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391505357964669?=
X-GMAIL-MSGID: =?utf-8?q?1595391505357964669?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>


[ Upstream commit 62ca0690cd495bb7c1414cdf0cf790c2922a1d79 ]

In 'ath10k_ce_alloc_pipe' the compile time sanity check to
ensure that there is sufficient buffers in CE4 for HTT Tx
MSDU descriptors, but this did not take into account of the
case with 'peer flow control' enabled, fix this.

Cc: Michal Kazior <michal.kazior@tieto.com>
Signed-off-by: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/ce.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -1059,7 +1059,7 @@ int ath10k_ce_alloc_pipe(struct ath10k *
 	 */
 	BUILD_BUG_ON(2 * TARGET_NUM_MSDU_DESC >
 		     (CE_HTT_H2T_MSG_SRC_NENTRIES - 1));
-	BUILD_BUG_ON(2 * TARGET_10X_NUM_MSDU_DESC >
+	BUILD_BUG_ON(2 * TARGET_10_4_NUM_MSDU_DESC_PFC >
 		     (CE_HTT_H2T_MSG_SRC_NENTRIES - 1));
 	BUILD_BUG_ON(2 * TARGET_TLV_NUM_MSDU_DESC >
 		     (CE_HTT_H2T_MSG_SRC_NENTRIES - 1));
