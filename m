Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225VIFP8V1++VRMfguaYTHk1u45nsyphCkFZK/+1xltL5Wz1CIMtgKqU4KIiqxIsJ3P+NRQj
ARC-Seal: i=1; a=rsa-sha256; t=1517855196; cv=none;
        d=google.com; s=arc-20160816;
        b=H2A40zQHcV8KIkiU1CNOPuEU+wJWK2ju8BnMS2GJ0H+Gs39tj0NoGUudH9blQHRDFP
         WkJA50torXM7KLy0dKQ8OBaTdceAsnO5SHi8HZzFQwYfzhZY6J7T1/cORgXi1ZOGRctQ
         Vm+tZys0tmN7VOpY5OI7hQzVuXximX9q8p1SMSjDNRAIEIlpoq+IpsJvyYO3bsjZAvxP
         uUrHTeyTfUj24gUlpedJZydBYR5/4MrjepembOI/5UFOkN56qpd+miep7PL7LH5GJ1N+
         GqlcPHtsm2NvCHXSlZbqUQLId9kmHGU4G2vI7u1seUVLKHwlfr4/cNZH66AX4bzOfhRa
         62kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sDhfQeAh+s4tf1BXbMDE1yiW24obADgkSzmzJtQ+VRQ=;
        b=cfBizMem95wAZY+rgA2suv/NWxWSLLdHD9j56EJs5i8EMZ6ESwDAMoxORRZ/0kfdld
         yKFIXKLLrn550q4ufr8B01TrNPlI2t2zrq8BQ0Zsp3R3WYSDVgvCVkkVye4Snzu4YCrC
         FXftGYNOZIXKAsnahaCqJZpdB0oRoR/uKUNkClL1Ntz8dbiOdxYpEhPrU5WHmuX2qd+t
         TeOXRhtPza8YZrHIkJ5qWZzA3mNDSmA7Q32KS/NZ1J9KrZtBrUTy6wiNNGjWBILfZgYd
         KyQROWthTxbCPDqrbTGV9ClpLPC+dftDBavjDjYn1LXH0ZCp4zg6xc/3xnILoZAJ89cX
         R/fA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>,
	Subhash Jadavani <subhashj@codeaurora.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 21/36] scsi: ufs: ufshcd: fix potential NULL pointer dereference in ufshcd_config_vreg
Date: Mon,  5 Feb 2018 10:23:49 -0800
Message-Id: <20180205182352.646980455@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586530787759656?=
X-GMAIL-MSGID: =?utf-8?q?1591586530787759656?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4287,12 +4287,15 @@ static int ufshcd_config_vreg(struct dev
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
