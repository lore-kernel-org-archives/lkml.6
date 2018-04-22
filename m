Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/yCtMVbDu1A7Oblx6Xt1eNApY9o4D9OP+AkGvz1G5fLKCMkmsXPi2Gok24f/hQ5QmrPr4N
ARC-Seal: i=1; a=rsa-sha256; t=1524406367; cv=none;
        d=google.com; s=arc-20160816;
        b=xH7q/j1Yi0XLARa2Seh+YfZhQUanmI7Id4toTKS+oPimWIrinOZYanyLBOiNOkyi5i
         Y9nnz+rWSM85JAZg1l+z1MxF3q94CY5S8JNsgnxCSU4BtaFSX/nI4PKkrpAGUWWF8nPd
         srFgv86X/Bgckz7xtwNHPSsIoh/fJkkHr5xfkJgpiVQELEWl+mgnJnTK4+7VqYuGiolX
         lx2qCF3+qyAixN44at0hvZ7+ETj5Oe9XJh8/T7h8tbAg3npCCCkVmM/Lb/MKhLwyDgnO
         huFPS4CBdfgGW/Vt25cQdiQXEr10gBWNRRJd+Oeqc2MTlKQEwTj4TtXEOrohJY3LmjiL
         jo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KD1i+Ox0iv3abT5PSjdoQgx4+i6Fup1F85wl11wHpGY=;
        b=jLyJUhc70Xoexz471F4TpSmFWWjHaOkXLG7MrX3PTCEHlqNf9Ua19CBkbk2wGyuwLQ
         UEdnS3ZjVNRKRLPx+dG9Lo0m0O1VeCrwXtXjSlXTcozJFABc3i6+W8j+bEV8WrLYsJp5
         /EbezhWKlqmWdK3uFtMSGJZh1jmVZBQeiHvKSwNlwvnybxkOptUDrtct9YWBwDJ5Uqi9
         51wMtv0Y97onx22XtL6Ion+eu50baOW+BXVyncM8yN3dqWLo+25xN9rTUI4ZJQITwqMC
         8I2mqMcxrqVfh9xTPAPYE4u5r2gzxmDfuikjh6rolxFXIGlzZaZx7Pf8jEazmPUOuqMp
         JX3g==
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
Subject: [PATCH 4.9 45/95] libnvdimm, namespace: use a safe lookup for dimm device name
Date: Sun, 22 Apr 2018 15:53:14 +0200
Message-Id: <20180422135212.258941698@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455219044935426?=
X-GMAIL-MSGID: =?utf-8?q?1598455931843293707?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1747,7 +1747,7 @@ struct device *create_namespace_pmem(str
 	}
 
 	if (i < nd_region->ndr_mappings) {
-		struct nvdimm_drvdata *ndd = to_ndd(&nd_region->mapping[i]);
+		struct nvdimm *nvdimm = nd_region->mapping[i].nvdimm;
 
 		/*
 		 * Give up if we don't find an instance of a uuid at each
@@ -1755,7 +1755,7 @@ struct device *create_namespace_pmem(str
 		 * find a dimm with two instances of the same uuid.
 		 */
 		dev_err(&nd_region->dev, "%s missing label for %pUb\n",
-				dev_name(ndd->dev), nd_label->uuid);
+				nvdimm_name(nvdimm), nd_label->uuid);
 		rc = -EINVAL;
 		goto err;
 	}
