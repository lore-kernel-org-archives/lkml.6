Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtpaKtVhElnVTjl06SJcqqRlRouRJd9ND1mZbXBehZaCuD+C5d4eyzb46v4ULnPi1QmmPBY
ARC-Seal: i=1; a=rsa-sha256; t=1521214712; cv=none;
        d=google.com; s=arc-20160816;
        b=XI5QGyQQAQT++BKo56U6UlqHGlqebkTxgRtamm78eccrJufkEYACeoKHqove8Tp9LQ
         otdMLVdSvdBMaqV1zjLH7AEmHXkqJPM3SddIIGXpP02usdpP5S/tMo2G3AWLbRpHDnX5
         8ghXKH5n6YhmMxMID5sS4a9bMVuHuu0lVN+iFebFJyBzwhlD560jXxPpe+rAH2gFYfSo
         p1Z3+jOKA/HEL8dzqPnX3A36TwXx2SRSmucfB4Ss0u8AuMej3SxT8P5y1iM1rtGFTCBn
         u2nZ6lJYdtGx9MSmkeu/5fpAmmbgSaEpI9yPHRJaFNLchPCkkfyUo66aWzUBV7nA2u5+
         rN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=t2cjLlGlYrDrBqkf4FWYqs5te+UOi9hAM2PMEchBKVQ=;
        b=pEIiwRY8w/88fgYVMFvogfUVYrq3X3XwKVAzzVtw4JDtX55MLuAQjrbHEGYLDPVeLq
         BomyNc8f8EY4YfI+dj60MlVKfNNqUHLPbDKhy9aVPtjVhwv4UNx4/qgFquNgkaTas0IF
         bs1a29UMhTmR4JMhdTyGOAAgyQ4D/uaOMrALRr0fI4TYJNOMuUnVDOLJi1Pc//+YgDdv
         CFbkRUW5IUhPZ0ChjSmIFpjMvmQCXtjgVL96K174wcGzE0V+HCR+lMEvlmWfOwF0JnCi
         709jh6LMeu+Csvfib61t/USshkcvsXo8OmrgFqTNFIDPzl3RcNXyAWTHXSv79F4jr/tN
         AxNA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 101/109] mmc: mmc_test: Ensure command queue is disabled for testing
Date: Fri, 16 Mar 2018 16:24:10 +0100
Message-Id: <20180316152335.354584095@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109237925237332?=
X-GMAIL-MSGID: =?utf-8?q?1595109237925237332?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>


[ Upstream commit 23a185254ace8e63dc4ca36e0315aed9440ae749 ]

mmc_test disables the command queue because none of the tests use the
command queue. However the Reset Test will re-enable it, so disable it in
that case too.

Fixes: 9d4579a85c84 ("mmc: mmc_test: Disable Command Queue while mmc_test is used")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/mmc_test.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -2328,10 +2328,17 @@ static int mmc_test_reset(struct mmc_tes
 	int err;
 
 	err = mmc_hw_reset(host);
-	if (!err)
+	if (!err) {
+		/*
+		 * Reset will re-enable the card's command queue, but tests
+		 * expect it to be disabled.
+		 */
+		if (card->ext_csd.cmdq_en)
+			mmc_cmdq_disable(card);
 		return RESULT_OK;
-	else if (err == -EOPNOTSUPP)
+	} else if (err == -EOPNOTSUPP) {
 		return RESULT_UNSUP_HOST;
+	}
 
 	return RESULT_FAIL;
 }
