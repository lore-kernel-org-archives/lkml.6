Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526036977; cv=none;
        d=google.com; s=arc-20160816;
        b=V6MQhM7edxOdI0edNtj6QKcODCGQ8glI1xLAmtL69AufGr39nqZCC5SUgzW61lXfPi
         ilVEQRmccAB/pYOiCmRXF3VYX15/R8dOb1Fl4BncbM5qeYiIcgYNzYGNjUS6avhHPoas
         LyH+h0h3jisZO69Z5dg0K5FHy+BBjuAuvg07Q7Z4+Bf4d02RaHpVFzf3PP5MKutCX6F6
         cR8M4cX/hfcy4QArqaFbFFVv70squIyW4ffqap9pcxcx3JDB8RA2rWt2X7VDhFM3GQxB
         LyXmScuadLyGVSZTFIID47NO1Xz2wJvRxBvAQxFIA85Z/i9v9teFGKlh+OTQa2GAn7j9
         HmtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=w5TjQwKiVwpDnrp/KCzD6gMlzqCUY8K4AVpRvmhKkF0=;
        b=iwNEAWQllu1rzQAn9ZfHcY/V0eG7Mz2eINjAK9K+QVkEuQM0eRFONU3/y2jkT+UcPv
         7ndWS8kesQKNkebbt58j57X6irZtG6n8MZp/OvokZ4oWnSOn+Ph28xqcniKYWwXHuPGB
         JeqOVkn4EYdx6xluUXCDf5NxwEK5DJ3+9uTEjCSXgCI3LjEqBfa3fumDNyrhCUnKblvW
         I5OnTRXTkB3HI86rwg0l40VH1lNqMDH3YMCNDnWUZvSUhLxecD4UkQGefFJWo2v3I/T4
         0RaHm/H6d1q5RgBvrcoJw0OxdaTXw9tiloFDHiAXb/4IUtbXYKMQNbnzoMRPXY42aWxE
         fqnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=iYYkLbiT;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=iYYkLbiT;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpRZYy4hj0IlraJQkPuOzTHQ/w2b4Mqq+LkiC2PeC6U5vsC+63hoFWJjb8TNPFMQSeCTbMVaA==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 8/8] nvmem: properly handle returned value nvmem_reg_read
Date: Fri, 11 May 2018 12:07:03 +0100
Message-Id: <20180511110703.4924-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180511110703.4924-1-srinivas.kandagatla@linaro.org>
References: <20180511110703.4924-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600165749609590574?=
X-GMAIL-MSGID: =?utf-8?q?1600165749609590574?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mathieu Malaterre <malat@debian.org>

Function nvmem_reg_read can return a non zero value indicating an error.
This returned value must be read and error propagated to
nvmem_cell_prepare_write_buffer. Silence the following gcc warning (W=1):

drivers/nvmem/core.c:1093:9: warning: variable 'rc' set but
 not used [-Wunused-but-set-variable]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 36361044ddbe..b5b0cdc21d01 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1119,6 +1119,8 @@ static void *nvmem_cell_prepare_write_buffer(struct nvmem_cell *cell,
 
 		/* setup the first byte with lsb bits from nvmem */
 		rc = nvmem_reg_read(nvmem, cell->offset, &v, 1);
+		if (rc)
+			goto err;
 		*b++ |= GENMASK(bit_offset - 1, 0) & v;
 
 		/* setup rest of the byte if any */
@@ -1137,11 +1139,16 @@ static void *nvmem_cell_prepare_write_buffer(struct nvmem_cell *cell,
 		/* setup the last byte with msb bits from nvmem */
 		rc = nvmem_reg_read(nvmem,
 				    cell->offset + cell->bytes - 1, &v, 1);
+		if (rc)
+			goto err;
 		*p |= GENMASK(7, (nbits + bit_offset) % BITS_PER_BYTE) & v;
 
 	}
 
 	return buf;
+err:
+	kfree(buf);
+	return ERR_PTR(rc);
 }
 
 /**
-- 
2.16.2
