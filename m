Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+HaMbbEBdcpb5Rlb7lfcvCcy5WI4B00W3EaU/OXNB64WD8vcocS544X1UpsmiezYryKi+O
ARC-Seal: i=1; a=rsa-sha256; t=1524406075; cv=none;
        d=google.com; s=arc-20160816;
        b=DRQcDNJeybWRh4LNomHSLbPdNKCAN5tCHTdsPhaIt/CtHrP/NDhcl6/S5JgAvkRhfH
         VnxOxmu+pfLnXvxzn5mVKruS6GXq81v5zU9AhO+7EdllcH4n7ISHAWmVVBfb3wDElhKw
         SJOA7S1Ufs5SuR9n+vPSJdcwdjDBoRRb1a+z2q/pI9o34zx1tD7ylr7Fr9K/HBFpAd5v
         vl8RyriN/UBMUdUfwj1JRd1VK0A351t+qdlz3zQjxWkbSHD1YZIBx45IkJxiEqbK4Kxo
         8uMEGyI6YDjCAGH2RPK6svTJjiXDEb76hEszMon84nyA8dSYPqbTA87qkcUdXKnjfjnt
         jquA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wzzfRSYo7rFML6llWJGTQPYQcIKuqJ/qVAVHD5Cq1vg=;
        b=PspSC3XTCSZXo/gVue8ggcAGAf8DHFUwDjptr+6yuLN3agyk4x3vLPirt8lk9ie/aT
         riv4wy8YPwIHw18D1a/99GptyWZtSpDs0Nw2bUYSdUNBDifmkPQFm37cOIHg3KSPm3Up
         SAPMwSwoWZ7C7szD2tVdG2lL0bKnpUnDnWt2MVXznrcDR1zfx7JAgPwVgGsvRdytn2eH
         cRk3yUL2//v54BKrEkv1NqEmZ+tCTB23nOt1pRXhTNiWWH/nVZzedz1i257R6ZKFyAvV
         A6Ij/EpPJM13yXt+jIAvmxhceGMV3lGGkMsbaIC+qSO00wBPrCzpNjk6QQWw2wGz7Kyw
         w65A==
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
Subject: [PATCH 4.14 102/164] iommu/vt-d: Fix a potential memory leak
Date: Sun, 22 Apr 2018 15:52:49 +0200
Message-Id: <20180422135139.579271245@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455137609680426?=
X-GMAIL-MSGID: =?utf-8?q?1598455624519067309?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -382,6 +382,7 @@ int intel_svm_bind_mm(struct device *dev
 				pasid_max - 1, GFP_KERNEL);
 		if (ret < 0) {
 			kfree(svm);
+			kfree(sdev);
 			goto out;
 		}
 		svm->pasid = ret;
