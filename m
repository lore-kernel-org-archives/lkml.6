Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48icNIkJo3p5OGNm3PESHhTrLmAnXmaKbA/YgjUhqmZ5m1cMEJQ+RRlbLIFzBli6vMDaVZe
ARC-Seal: i=1; a=rsa-sha256; t=1523472954; cv=none;
        d=google.com; s=arc-20160816;
        b=IbikOU65Tp3sIppUKiKLTst8FETQgE+d1ERQfbIICG8sjV4J2qeKenmlFBHbOkXH+I
         Bar+kVIE63MmATwYAlgYXvkszWKqNAL100pc8YCMbfHi+YekvilNPCGe5hOtFshV0BIq
         LhdSLqUPBqX2f9r9VTAd8ThiZPz713Q+c+hFpAV9zCFjk30abM34dwUUSjutahYYBKLD
         1CcqmAnlNzwe9Jg1H6UxTDPr6XzsjAQ0T6GeOifc3jlOK8ULxIXW/UVw9VByBZ5A5PkF
         jYCj2PhXkAwelIvsnmvHs1Jjs9TSjdsaGIaX4Zy+w4XqwNp0k0eDOK3nL/kupxUWvsTK
         NoJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aWuYfEAw26cBsckVkSEoJwOTaP52fuC025Krp1xXyVY=;
        b=nCdqXwHu/47ky5KqNrZJNGQLBnr6gi7FoOVpkYhRBj03DR6zgS2eDSnXuMTlvqsgoB
         25U/GO2jRDD09Dfo6e0g89+TR8LIIZQKc1IghyaUrp9qdG8uc+kcEjHKvzQ+hWY8WDp8
         oVc+XxpcGvuY9gnQMo89MAPwRQtYk3CPkrJrqHG/iPtCea13UM4ox+/Na4LQxQ0gL+IE
         BYURfAFCLUX+iHK2WFLNZK2oewgUU19etQEhojKcXW2Kwlk4N2DFBJqhgE6neiObp0YH
         Rhd7Zns3EC7RL3Fzno9A9RMyIEsnmKtfwWd+zOxFK8j3RPO43M22Pp6KU/FoNeAODwrs
         gYQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Varun Prakash <varun@chelsio.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 077/310] scsi: csiostor: fix use after free in csio_hw_use_fwconfig()
Date: Wed, 11 Apr 2018 20:33:36 +0200
Message-Id: <20180411183625.620404828@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476529659078106?=
X-GMAIL-MSGID: =?utf-8?q?1597477176170801969?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Varun Prakash <varun@chelsio.com>


[ Upstream commit a351e40b6de550049423a26f7ded7b639e363d89 ]

mbp pointer is passed to csio_hw_validate_caps() so call mempool_free()
after calling csio_hw_validate_caps().

Signed-off-by: Varun Prakash <varun@chelsio.com>
Fixes: 541c571fa2fd ("csiostor:Use firmware version from cxgb4/t4fw_version.h")
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/csiostor/csio_hw.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/scsi/csiostor/csio_hw.c
+++ b/drivers/scsi/csiostor/csio_hw.c
@@ -1769,7 +1769,6 @@ csio_hw_use_fwconfig(struct csio_hw *hw,
 		goto bye;
 	}
 
-	mempool_free(mbp, hw->mb_mempool);
 	if (finicsum != cfcsum) {
 		csio_warn(hw,
 		      "Config File checksum mismatch: csum=%#x, computed=%#x\n",
@@ -1780,6 +1779,10 @@ csio_hw_use_fwconfig(struct csio_hw *hw,
 	rv = csio_hw_validate_caps(hw, mbp);
 	if (rv != 0)
 		goto bye;
+
+	mempool_free(mbp, hw->mb_mempool);
+	mbp = NULL;
+
 	/*
 	 * Note that we're operating with parameters
 	 * not supplied by the driver, rather than from hard-wired
