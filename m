Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227Z3mmipMx879MQCa5grXXfbS+I8bBiGzhpHu7Pqslz2/FACatCLaCiKx8TsRVIg/bUDZ09
ARC-Seal: i=1; a=rsa-sha256; t=1517590899; cv=none;
        d=google.com; s=arc-20160816;
        b=xGbya6dpYVa3sMLGg2DqBMN/P4nlUgTMNEzLCfoQQWXdYiILaO0YEbtX0pyRDtvIJ+
         ykDfLOBiFY6JkoDQLM+BNxVil54DQ6N5WERj3wLcWiVhhgt7phBw1BCq/Ga2ftgyeY9o
         TwY+sfytR6mRCOF9xkNnscIC5rL+nXbkefROzAnk7QFjOW1Idu7u+CYB/0C3OQMwT9Tb
         yEOLyBcDhp2kBIklYVGwkQ9CgDGXcVLf79QlrsdaW/+DYT2Xn2LHM2fBGbrBHINslCKm
         qjfXpLCabMZbm1VVwWundO0B+BMSsPWpjPYqzRQmlKmq7qUOExeuC2skvzNtAvha/O51
         DG9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=x9yQFKgaxbxxj3Euz8WorR89oraqtBQzeMzVgs5Gz7g=;
        b=YdTTKq9FNm5Tg7uNXV9siSh1EmeH/EALZhLp+kWNz7KJU0Yoph1nSBpOoyKEQAI1dU
         Zuif/NlC25HZLrzvGNJBuUpBkDPNdDg5lXyEnWQVCfuEACX1dcyK4gqogdj/1vNKQkr4
         11EdAGm9AWZSdgx+Qw+wJMN6Ot05/gVwDatm8De8LOZ7H1bTzCmzWhH8f8OOhi6BUHs/
         62YD6irWp23yuppciObhcDctOkrFo7XkqPALhSoqS6Y5nkJRk4oVC25GTR2vMjNwKGTj
         ABuGR+0eeBZGDU9tVQahCfPamu5bI7181urjYYHDMfEImnfmHuSLrQFMW7JDCyRjeVEc
         NRlg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>,
	Subhash Jadavani <subhashj@codeaurora.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 51/67] scsi: ufs: ufshcd: fix potential NULL pointer dereference in ufshcd_config_vreg
Date: Fri,  2 Feb 2018 17:58:20 +0100
Message-Id: <20180202140820.995188551@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309395625912256?=
X-GMAIL-MSGID: =?utf-8?q?1591309395625912256?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>


[ Upstream commit 727535903bea924c4f73abb202c4b3e85fff0ca4 ]

_vreg_ is being dereferenced before it is null checked, hence there is a
potential null pointer dereference.

Fix this by moving the pointer dereference after _vreg_ has been null
checked.

This issue was detected with the help of Coccinelle.

Fixes: aa4976130934 ("ufs: Add regulator enable support")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/ufs/ufshcd.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4392,12 +4392,15 @@ static int ufshcd_config_vreg(struct dev
 		struct ufs_vreg *vreg, bool on)
 {
 	int ret = 0;
-	struct regulator *reg = vreg->reg;
-	const char *name = vreg->name;
+	struct regulator *reg;
+	const char *name;
 	int min_uV, uA_load;
 
 	BUG_ON(!vreg);
 
+	reg = vreg->reg;
+	name = vreg->name;
+
 	if (regulator_count_voltages(reg) > 0) {
 		min_uV = on ? vreg->min_uV : 0;
 		ret = regulator_set_voltage(reg, min_uV, vreg->max_uV);
