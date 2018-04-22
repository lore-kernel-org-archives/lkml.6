Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48kJ36t1t1ectXLlTb9na4jfSZmN5oADj88S5aNgSo4U5EI4BTE9Q/0pGoEkDKTd0u3tjzW
ARC-Seal: i=1; a=rsa-sha256; t=1524406061; cv=none;
        d=google.com; s=arc-20160816;
        b=db5ZyRwVeGd87GwX9Ic5I/fkBZKQRCbP9NwN/ZsswaBp9xCN6YQvVUZceL5bBtPKu3
         nIwp8RZWwn0evoHdcsxMciG/8qvVShngd/xD0lyStwpHUN+iRGuv9KYvPozVyb6sZfDA
         IJ9+bIjhDRsjlWMTzXkJAepfOyLrHgPepOHrncbD3+srL9Klg3Jxd/iEdKNpR4xzhikV
         Xbh9392XzcG4ZgkzjrJUp10p7a8SfAuK9ja6+WNPCwe4wXrERp1RQWLjI9rHqkqnEAXd
         M2c7JybRcwtfNKnNtTTO3KbKpIXw+Ua3/aH/Sa6aI6DFs39zMgq6XW/soveJaMLoWUWy
         zG1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tOfVHlQNR9JsBmZ72t+ktUKwqA5lpI0pjIYb+f5BJkE=;
        b=KMZg3M5CtcKiX5h/wODWiA6Vr5SpFdXoxwJQK6QD7P+awbGaVMVeeHcKtAeo1O1Qul
         5kqZKlurn4A8X7bpaLBxs+CYfL3t4rDt0iPsg+IAn7Tt2mvhV4q7jFd8gyI7Sd3HmxRP
         aD1Hu+kzCJRFW4wsh2Fuk5GAKeHGa2FzRPKxGymSKRWo+7UM9wHGh+S0kfuUgf4Oj05O
         tPVvxnZ9zEA7J5aZu3ftquC4Jso8+k+1wIzuAHkuZT5HASBtNWgSbkXv6Ig8t8hUxNGH
         57CJo7F62ybBRb6yRGELuqj3F4OKu/QLY8PQUytA9wJNlE0kXLSpQ3OpnsBehOSipT4u
         2/3Q==
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
Subject: [PATCH 4.14 097/164] nfit, address-range-scrub: fix scrub in-progress reporting
Date: Sun, 22 Apr 2018 15:52:44 +0200
Message-Id: <20180422135139.388141124@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455224806694139?=
X-GMAIL-MSGID: =?utf-8?q?1598455609942311595?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1022,8 +1022,11 @@ static ssize_t scrub_show(struct device
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
