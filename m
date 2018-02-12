Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518412655; cv=none;
        d=google.com; s=arc-20160816;
        b=ZSasCunsHHdGpyjBBVSHU6f6OBycOKakmgcQfYTo+BrfyCe0WsBf5rAKNXPWXMWJOC
         JlKsvhJTj3Yr6Xe32Z6E174Dx0jmELtNsNaidKRHL21cva9su2pqRrDj/Ggev49jp729
         O6gAkFnLWwQhQsLnttLdNHVvNIRf+obpKul2z/c+EWjul1u4f9AOcDw2GCQJWtmzD+h4
         DJuYwD51QFV0okvVj6cwPhLJ+h00gclMyEtNVFxVqZqmx/pQ5Lh1F0CZYw4c6b+p1N1Q
         UYOIqKAqtNkVcwImudvLgofIwNcNTah0sL9xh47T/QOEjVufHevTUzf/z5mALsFEr1vM
         dMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=9HLKuK1/pBm+NbqrvAiLkuHp7HO92Uh28VXRPfqgPIM=;
        b=IiQTV2b0Vspu5D1LakPYLee+5Wmp234ZijoI4FgCj+tXuXB2heZNbY/W8ErXJp/zr/
         w5PoYSNDo3gNnoFT5YJqT3ZwJzn+vdXG1Wnz9ttqyfT74WNu2xpsuJsyf5Z7Ek87ouTk
         6IEnqzZduD70lAAzPZI4itf85n25+Zzr1qCub/WXlGc5IxO/XDbd7dEHMSXhrmviZDry
         o20WxV1dN3KG6Ay4C1VRABxSlCOLfBZiGwWlpqoxrWqG3ChiVhkCjdNGlcThfWfJ5SsH
         epPq3kz1pbKMUC9c6hCYguMRzibZG8L2vulgy0OKj+pm5UV7K8u5jtZB+zAKGUtSKl5T
         7aHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aRtIP4uI;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aRtIP4uI;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AH8x226Mvs/c2vuvlosF7901yGxHuR8aBEWjZzo72lqutiIM9sxi0+PxacU1HquDWdtiSnQ/4Fwrug==
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Christopher Bostic <cbostic@linux.vnet.ibm.com>,
	Jeremy Kerr <jk@ozlabs.org>,
	Brad Bishop <bradleyb@fuzziesquirrel.com>,
	Edward James <eajames@us.ibm.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 10/10] fsi: core: Add check for master property no-scan-on-init
Date: Mon, 12 Feb 2018 15:45:49 +1030
Message-Id: <20180212051549.8575-11-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212051549.8575-1-joel@jms.id.au>
References: <20180212051549.8575-1-joel@jms.id.au>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592171068695654219?=
X-GMAIL-MSGID: =?utf-8?q?1592171068695654219?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christopher Bostic <cbostic@linux.vnet.ibm.com>

Prior to scanning a master check if the optional property
no-scan-on-init is present.  If it is then avoid scanning.  This is
necessary in cases where a master scan could interfere with another
FSI master on the same bus.

Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Acked-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 8d8b25809452..4c03d6933646 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -901,6 +901,7 @@ static DEVICE_ATTR(break, 0200, NULL, master_break_store);
 int fsi_master_register(struct fsi_master *master)
 {
 	int rc;
+	struct device_node *np;
 
 	if (!master)
 		return -EINVAL;
@@ -928,7 +929,9 @@ int fsi_master_register(struct fsi_master *master)
 		return rc;
 	}
 
-	fsi_master_scan(master);
+	np = dev_of_node(&master->dev);
+	if (!of_property_read_bool(np, "no-scan-on-init"))
+		fsi_master_scan(master);
 
 	return 0;
 }
-- 
2.15.1
