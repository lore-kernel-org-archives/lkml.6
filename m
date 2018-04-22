Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48ccSkSpndTHvKX3dLUwfm6dD31F3yCwFOqQo3cr3e80791XU7UsqxTBhr6dvCHf2QcLCgs
ARC-Seal: i=1; a=rsa-sha256; t=1524406378; cv=none;
        d=google.com; s=arc-20160816;
        b=ES8SiMxqA06Colvw4Cdb+a2MeXMmfhdhVbZbkvBRk9y8QJoy9dTKp28DTQvfYp1haF
         dx2SDMKK73uHpMwD+8yOUGEZSXHSJ5MnT5t/dJAoCkuvjjMOlXlO/F/zmUEsGmmi3YVy
         3b95lc72JnNRhTybZgDXlwTrK0IGbMlCWejOkkoCq9rJjONp+6MEwbatAP1BVkgLAFLk
         vKGtklTio+gvdHNVv9b9uFAjpDxr6LPGbzea0r0f6Wfr55V51zZ1/q9GhaBwhMVlUagF
         2o8ytdO7zyuYfKargyaqIb2grqxzxiYYHlzSDTr96PdSLMkA1y74mgdkjaqxY5ciCP89
         ASPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NAmjKsgDjyiJgsVpxTK7M89+WJ4hfekd3KycCqbHd+g=;
        b=T6vrZj6PJ6ZhTZJf3gVa2LooyGwwf9Nmgyriybcf1Ob9bRhAUzUngMjh9kJA9ppK+M
         j5LuzwFtngJ9Ns30vQP0wAanzrLWcUFYYq72SrAyFSWg6w5d9bi49qouxTkUbRPdV0K4
         CQIrgbqc9a4e4S8Q2vNOEnNqJtiT4jOH/MOBZsZpc5VjlhSg/KmPSLnP4TuU+nIsE9Lx
         opX8PRF4Vs2BMVcLHtRoFMeEsBj1P2aesnW2Mf9vmKu//Sv7/DaNfoEgbJywfxB58PQO
         fS5XGWjssNkFQ3XunsXYvckyWv/+LST5zPP3HzUECiB41b5rGvXWXlpl6E2vEgn08Vfi
         xg9A==
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
Subject: [PATCH 4.9 49/95] iommu/vt-d: Fix a potential memory leak
Date: Sun, 22 Apr 2018 15:53:18 +0200
Message-Id: <20180422135212.418543419@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455137609680426?=
X-GMAIL-MSGID: =?utf-8?q?1598455943135802557?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
