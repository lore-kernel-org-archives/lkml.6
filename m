Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48SzZlV6ztYE9sugdR6Ml0Ruwv7Kcbck7KhlDbt9pjE2ZMB6o1TU2/VZ5AjcVse+ETrPUzA
ARC-Seal: i=1; a=rsa-sha256; t=1524406370; cv=none;
        d=google.com; s=arc-20160816;
        b=W8E295H2KM/Dj1n2bAdRoSevYvgI09Jvdva2EDfI0k8zGBZp2elw7gIqtVRjeNCRo7
         viY05n6/3Xp/ZEm7TfWpLvnIYORJphosLWB8sC/wOJVVfj9v83kATeT/sBViCAJWqykb
         aahGuGlozVKGiW+ORUJj8E3XX5FfF0Xlbf2az8+0+qZcQBC+Sw0yaDEEtIonulvDmLtl
         48ElgG6es1RQ+yTCwgXoeSebxkarj1bPOW/RGyN3eZ9olZB5Z2BrjMDyvicDSX6qtFs/
         wO9Qn4usY0GivfgUq66+AgahDnFKLXm3aqwU6Hn0XTZd2ZRuQXfY+/jzRpA/IrG3wyL5
         5XSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=o3u3S0WNkzGvqwFqYaZE3f8mvbkwHB3h7kDRXwZtK5E=;
        b=Me1JDzLRo7ZVVrP3sYaeGyLi1kRDMVCIbrKQvCk+8Axh1edmHgUmhU2B0mSAxedZXw
         SqTiDVllZawxTzTBcmJCCb6hTNKH1eaX5mnTvMVwpET18+w2VXImm5SjVfNVt9mx+mfN
         YkLFYEiEawKGo3Yd90ekJ9QMrzxAjxLpLjIsS5gFEuKg26E/HrArs/B+g37RxLJ7IHmo
         diWJyyvnPmtbrUKAvIuHY14BZpx2LRZRRsAg3AQEb3uJwLkMblbWIYuWLsRNaBvmj/zn
         CXB03YVsO3vNLDASlg+7aLDA4Afjs8LuBhctKa8HLO9uXqFnybcfi7v5e03P5bY2HyCX
         bKUA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.9 46/95] nfit, address-range-scrub: fix scrub in-progress reporting
Date: Sun, 22 Apr 2018 15:53:15 +0200
Message-Id: <20180422135212.303990436@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455224806694139?=
X-GMAIL-MSGID: =?utf-8?q?1598455934298224182?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 78727137fdf49edf9f731bde79d7189067b4047a upstream.

There is a small window whereby ARS scan requests can schedule work that
userspace will miss when polling scrub_show. Hold the init_mutex lock
over calls to report the status to close this potential escape. Also,
make sure that requests to cancel the ARS workqueue are treated as an
idle event.

Cc: <stable@vger.kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Fixes: 37b137ff8c83 ("nfit, libnvdimm: allow an ARS scrub...")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/nfit/core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -967,8 +967,11 @@ static ssize_t scrub_show(struct device
 	if (nd_desc) {
 		struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 
+		mutex_lock(&acpi_desc->init_mutex);
 		rc = sprintf(buf, "%d%s", acpi_desc->scrub_count,
-				(work_busy(&acpi_desc->work)) ? "+\n" : "\n");
+				work_busy(&acpi_desc->work)
+				&& !acpi_desc->cancel ? "+\n" : "\n");
+		mutex_unlock(&acpi_desc->init_mutex);
 	}
 	device_unlock(dev);
 	return rc;
