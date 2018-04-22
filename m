Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/QUO5Eumw9g77jy77TPZjT8G6ebe1BVOcn7isnoSeEajFshYIFPikb0pFi7A6a9+ZhPufn
ARC-Seal: i=1; a=rsa-sha256; t=1524405688; cv=none;
        d=google.com; s=arc-20160816;
        b=ozFWJHPQnsEqItNDvURkJTqumZngCTFEi5Pz2mouvAS6vjFUbQxTOQXExhicPxmp6s
         ZnQsmCH8vramH+Y2EWgnFXTHRSk1PGuCbDcLK4tFCP0Kl+X48kR9GiqHUb74JoJYV/br
         /1aiSEn41s6a1mb8Wp3pX6hnCA/i449QeLEzC3lQzopNKiF7+aQxUMvCq862B2O5lzIt
         b6+zs5sZYn4GibytsCVTlovhFvJ9gkmSKWMe9Cz8hFYJdmPeqNSiFGZ+CP8gmdVV6nkq
         a9gYChKPmtkUSHsqHJnl4rfl79sOQ+6NjoLGSqBF34kIfh3v04+WJ0RobwD2smAn6Bt2
         +ShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=t9t7HSfXuEQ7nZOme7R/qdGuF+sEx8nnB1beu8+Y/8U=;
        b=TFqlHJbK3ysmZML0kfoQi/3CM1lU6+JQ/89ryvXRJsbdYnX7hPC99NwneuOq8QCRlb
         EAXPS/vHX1PDA8PE5gUxHnDKbRRvsw9JOVCZroXlXPWXNFqdfVL4uAcwe5U3hB0GnMYP
         mOXYiHgbBvqHvPEomHLprBHL45NQKCkhJgnHIFpoi3fhcnV/5RoM355V2mdVDRkouS1E
         fIQ97nd/CNwOAApR619tHkggPc+oiAJ9zWo4NIU8aC5o3tIuiacjDckeSz90xZgAJirM
         WKfodFx/QAZTbDjPqPnzQqYjpQqG+U/bpB1AboIbwiAQD42eGZYk8mFDhYu+hJ4+m2lM
         bPgg==
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
Subject: [PATCH 4.16 123/196] libnvdimm, namespace: use a safe lookup for dimm device name
Date: Sun, 22 Apr 2018 15:52:23 +0200
Message-Id: <20180422135110.617420376@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455219044935426?=
X-GMAIL-MSGID: =?utf-8?q?1598455219044935426?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1926,7 +1926,7 @@ static struct device *create_namespace_p
 	}
 
 	if (i < nd_region->ndr_mappings) {
-		struct nvdimm_drvdata *ndd = to_ndd(&nd_region->mapping[i]);
+		struct nvdimm *nvdimm = nd_region->mapping[i].nvdimm;
 
 		/*
 		 * Give up if we don't find an instance of a uuid at each
@@ -1934,7 +1934,7 @@ static struct device *create_namespace_p
 		 * find a dimm with two instances of the same uuid.
 		 */
 		dev_err(&nd_region->dev, "%s missing label for %pUb\n",
-				dev_name(ndd->dev), nd_label->uuid);
+				nvdimm_name(nvdimm), nd_label->uuid);
 		rc = -EINVAL;
 		goto err;
 	}
