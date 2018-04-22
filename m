Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4800oZzT8o8PPOEHs+iLm/28hAsMCNS01LSaQStaj16IVO0L+JDJhJOcZ4YgFSgig19em6k
ARC-Seal: i=1; a=rsa-sha256; t=1524405611; cv=none;
        d=google.com; s=arc-20160816;
        b=BMC44MiRxFkq1y7pfH/aTDjSMSVcOP1TmPt5k35OvWJDCURS45LAq4RT56vzCnTaed
         4gVfX1bF6pIpty5YflHK4gA5CB+e8soVb44p6qKsVPTOzKb1qPicVak5Z0YdWjDtIrdp
         HVV/6JysnjL0eUtqhu8ezwvQe5r3Cu1sJtwmx1RGHqNid/diZFmIuiy3pjid89BuhaJ6
         G4wY0BFj6wITekxx7sN5mJoCItBqX5XaiQERWkiV2I/UN803TVkRQ5fjSjoLFsAx1xH5
         cmN5sfaz+ruugN85PX9Hb5nC7RVl33yX5/6KDv+UwtyaSUVfS2MQOeV8/FpepRBc3TMl
         xX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UMUnq+KbPTAvFfwcxPtecYCix0C0OrMKdejaMuIvpwo=;
        b=zgzQEy+TmrFFNaP9W0TpdIJm67dWSM6Lg0HB0z2J16q93Z9JY5EH8VvXnZ3L0se+RY
         PHqspkDfdhE/NbM7wApIYCCwc/1ymAHyMXmr8QFR0ala35keaqza3PcynIVxBsdHMt2f
         HudQZJGDQY706l9GShqwB1J092y++416MkqNpqDC+peG10+QKg9kmHuNVoJzK2idzIvL
         lLuXtaR+LG0KMiiFSjqTLA9sQ1Vg2TQdtA6B3bhg3RMOohE6TstXo+m61xFw0zM5HN7i
         9IIBcFgh1TdpiAi5fNETbrLBwdLteCJ6EOYt22Dv2RWGzwlMM4sgJVH4odG3oXXevPla
         uOZg==
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
Subject: [PATCH 4.16 130/196] iommu/vt-d: Fix a potential memory leak
Date: Sun, 22 Apr 2018 15:52:30 +0200
Message-Id: <20180422135110.974213585@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455137609680426?=
X-GMAIL-MSGID: =?utf-8?q?1598455137609680426?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -396,6 +396,7 @@ int intel_svm_bind_mm(struct device *dev
 				pasid_max - 1, GFP_KERNEL);
 		if (ret < 0) {
 			kfree(svm);
+			kfree(sdev);
 			goto out;
 		}
 		svm->pasid = ret;
