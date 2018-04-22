Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+pb898Oe6XVwIbFlu3GLR7tTWr6IKyqUKyMvnVhz/Hn436IMRtXU8Wl4sNWWw8Hdt5EaTu
ARC-Seal: i=1; a=rsa-sha256; t=1524406664; cv=none;
        d=google.com; s=arc-20160816;
        b=MQuFkP0Wr/3xy1aqc5S7rZcZD8VMBrMjV8aoPN4pWTOhLze/DtruiTt+daSQ517oOd
         Wk+u4u3YWEF0NBiBO/brZLiLAkTZwY4GqConoj/M1ByuU2EN9Gt5HjLjfRTodt9oGZOK
         avYXJQ/gChMSkCAXLdCtViAtYUfErMvuy1/IdXP8t62IMAlRdugCS0FYO66KvxrxO4lr
         jfeKVxqKnQbfyNcPhXsf78jsaxa2p+ACPDMTypMVh0V0aNOw0mLOTaXJDvpcpSv/ApbY
         r0ghKvj3uykk2QK4dRiXygOCO1Z6GiByedRcLCF4YPh2yvXo0PvDPZToyDR6pu9h8Ifa
         obUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qKUsjk+zymU0VcYPy3fuJUv3AJ2WBWbSIYqWR01jg5s=;
        b=cubUl4JY+mfoq57GknOOuZhibp1QFAjeTWPGHcn8GmDKgpoaUPuLqcPaYSwOWj8yaZ
         KWL/wn7aEZ7SOPuxe5Q5qEudJ+pqnNLIcEvPxljp1eJofpRQHpN+4Uc+PUkKMi2tebqT
         ITLt89S+bNGvwXlLLj5FBe3T3ATLjiNT2OLzf+98OoF43rsE8XhTC0IWyEpx7jWsJJPK
         FBHu6LXEOhIemkK78KZXvhCis2iTDmLWaxABetrH2WvLvEvGj6ZZBhPrHuBreUWKECmk
         aiZ8LpgwYDyFMppdvY6I9X89dkx2QT0pTtuau/af06Fh5b7zbkXSvs3fF9mG6tVIPWO4
         eT4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ashok Raj <ashok.raj@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4.4 58/97] iommu/vt-d: Fix a potential memory leak
Date: Sun, 22 Apr 2018 15:53:36 +0200
Message-Id: <20180422135308.500756058@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455137609680426?=
X-GMAIL-MSGID: =?utf-8?q?1598456242818996057?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lu Baolu <baolu.lu@linux.intel.com>

commit bbe4b3af9d9e3172fb9aa1f8dcdfaedcb381fc64 upstream.

A memory block was allocated in intel_svm_bind_mm() but never freed
in a failure path. This patch fixes this by free it to avoid memory
leakage.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Fixes: 2f26e0a9c9860 ('iommu/vt-d: Add basic SVM PASID support')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/intel-svm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -389,6 +389,7 @@ int intel_svm_bind_mm(struct device *dev
 				pasid_max - 1, GFP_KERNEL);
 		if (ret < 0) {
 			kfree(svm);
+			kfree(sdev);
 			goto out;
 		}
 		svm->pasid = ret;
