Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/b//wMZ5ddTpC76M+lqsRnwgs5VxYlaWjF3wz6klwkye8q8em6MU1ElvyVKuA9g0UrhdhL
ARC-Seal: i=1; a=rsa-sha256; t=1524406055; cv=none;
        d=google.com; s=arc-20160816;
        b=yxB8ukeoW9GejvFlfXJTdF1y3nU20V5/V9EDIllbD3zDrqCf1ldiQl3Zv58pU1OMXy
         D4ADAtng52Z9H2zrXvsAH38qzXAb4z/JF6eDCEQR+suRtpZK96O2EdhbS+tzS3nzU0Gi
         TTgrn4yYm9fFk38ttdQAbNeaKjQoWEt1IHFTW6/mngQDHV3pkDugQ+0Pc9BAUqqOu0Jd
         yMPJNjb4sfj/ZjOs0L8gYhRd9aJrC4CagrRWwCH5EBz65Xw64MfENz566DeWcIO2+RJV
         zGl+ujx/CUrwqsXFG6VIWKxCxgU8GFdUW7PGNe2U5oWPPZqDW9c2sGH6gVfMiux/rsqB
         SH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UOw4BKdnEaiawxhiniZx4CREvRjDWfVL+a6vwKXGFr4=;
        b=T7w7HML7erUq5dsGHZ1MgYms6n7zbVfqbA+vi/ojgy/zZjOg2HheePKa6OpPHWfct0
         EToYd0pfuNzzfB1zKe91vac3B1AxWjSkWwGhYtJ75w6wB26xFnaVe6PwRosBCtoQRhZH
         l52TcctyHtEp72G0XZSRHr4smm+kc8WtdM9FqMVMNN+xVYKXRvBeSPpyqZR2Be4KFCFo
         VDhU357m6LlYNTL4CqK0WSkymI44xr/EqX008ahVbTN0ue5Pi/JZuLcrAQDYX4BCgjRX
         Nmun1p3tlkxFo380vbOSMrIT5MueSpyTB5+0GMhlGwukbqInO9xNJQObkBELkH9MqNDI
         4Ytg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.14 096/164] libnvdimm, namespace: use a safe lookup for dimm device name
Date: Sun, 22 Apr 2018 15:52:43 +0200
Message-Id: <20180422135139.351581555@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455219044935426?=
X-GMAIL-MSGID: =?utf-8?q?1598455604683470974?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 4f8672201b7e7ed4f5f6c3cf6dcd080648580582 upstream.

The following NULL dereference results from incorrectly assuming that
ndd is valid in this print:

  struct nvdimm_drvdata *ndd = to_ndd(&nd_region->mapping[i]);

  /*
   * Give up if we don't find an instance of a uuid at each
   * position (from 0 to nd_region->ndr_mappings - 1), or if we
   * find a dimm with two instances of the same uuid.
   */
  dev_err(&nd_region->dev, "%s missing label for %pUb\n",
                  dev_name(ndd->dev), nd_label->uuid);

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
 IP: nd_region_register_namespaces+0xd67/0x13c0 [libnvdimm]
 PGD 0 P4D 0
 Oops: 0000 [#1] SMP PTI
 CPU: 43 PID: 673 Comm: kworker/u609:10 Not tainted 4.16.0-rc4+ #1
 [..]
 RIP: 0010:nd_region_register_namespaces+0xd67/0x13c0 [libnvdimm]
 [..]
 Call Trace:
  ? devres_add+0x2f/0x40
  ? devm_kmalloc+0x52/0x60
  ? nd_region_activate+0x9c/0x320 [libnvdimm]
  nd_region_probe+0x94/0x260 [libnvdimm]
  ? kernfs_add_one+0xe4/0x130
  nvdimm_bus_probe+0x63/0x100 [libnvdimm]

Switch to using the nvdimm device directly.

Fixes: 0e3b0d123c8f ("libnvdimm, namespace: allow multiple pmem...")
Cc: <stable@vger.kernel.org>
Reported-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvdimm/namespace_devs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1926,7 +1926,7 @@ struct device *create_namespace_pmem(str
 	}
 
 	if (i < nd_region->ndr_mappings) {
-		struct nvdimm_drvdata *ndd = to_ndd(&nd_region->mapping[i]);
+		struct nvdimm *nvdimm = nd_region->mapping[i].nvdimm;
 
 		/*
 		 * Give up if we don't find an instance of a uuid at each
@@ -1934,7 +1934,7 @@ struct device *create_namespace_pmem(str
 		 * find a dimm with two instances of the same uuid.
 		 */
 		dev_err(&nd_region->dev, "%s missing label for %pUb\n",
-				dev_name(ndd->dev), nd_label->uuid);
+				nvdimm_name(nvdimm), nd_label->uuid);
 		rc = -EINVAL;
 		goto err;
 	}
