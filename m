Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227gxBKss2ve3llkMZRXmMWsTBbSJuvRePbw/MnBmw+C1l7nps2NtsNFabTirVhlElZ1Po32
ARC-Seal: i=1; a=rsa-sha256; t=1518708558; cv=none;
        d=google.com; s=arc-20160816;
        b=uPpnnzNcQ5onVs4NDMN8wh5+IyYxHCvQe8wCY8bGdiotWMgIlzAr9BvjEkVK6b12bj
         3Dw1x8OJwftI9dT752BRWKkjZqn+RXoHrIBcu7EkO8zzth6KOFaqjNMRm5nJ1hTQ0qLQ
         sbZUVjDlS/BPMUfkvalXyT3uoZlKixLMezyKl7i9ElwMJYzvOtFwNsese+jSNNro+RwU
         ikh/b8iMtSfJERtx2Gcwku/3zxwgyFW6NQFTk4YWQ0Lao3dD6qel0gHy622UR8uOfVcA
         oz+rrZ4tQ4GNNiWMKic19CfFIwhmBkWaYWnaU5A8wORtF6795pdBpOV/G+/LBkUg43/c
         EOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+bNL1gLM0RTZ61VGFTWF5fQP9ya5uIr+gWeHKNULyG4=;
        b=Z+LFQR9hLkVXKni5+bHKB4bX/OfVItk3EGlhmJNbD2QdGw16HTAIOPEp9pxzKx+/EC
         3OVLOZdRUECeSV64xXApeMBeG7jjNI7I0M2yn21K/drHHZkoPrHhqmOCcr5LG9Luplhz
         Zkti+J6/100X8TMDpaeGMsbyqLr0GAgboPwTo2QEzT56c99m/PEzbOt1zWKiwfdncx5L
         FGBppzElKTsWK4TtkOvsE9ivw+nS8LQSCNbzDfsTkJFPsWrEQvL7AKCSnYP9FNFs9wWI
         7vz21NSCZnk1GJ8GmfBAE/d9cAKToILI0ztP8LL0JzkwLJs/PHWX4iyQ5uJCX3fqXzOm
         tiRA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Toshi Kani <toshi.kani@hpe.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.9 85/88] acpi, nfit: fix register dimm error handling
Date: Thu, 15 Feb 2018 16:17:52 +0100
Message-Id: <20180215151234.232466114@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481345316957816?=
X-GMAIL-MSGID: =?utf-8?q?1592481345316957816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toshi Kani <toshi.kani@hpe.com>

commit 23fbd7c70aec7600e3227eb24259fc55bf6e4881 upstream.

A NULL pointer reference kernel bug was observed when
acpi_nfit_add_dimm() called in acpi_nfit_register_dimms() failed. This
error path does not set nfit_mem->nvdimm, but the 2nd
list_for_each_entry() loop in the function assumes it's always set. Add
a check to nfit_mem->nvdimm.

Fixes: ba9c8dd3c222 ("acpi, nfit: add dimm device notification support")
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/nfit/core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1535,6 +1535,9 @@ static int acpi_nfit_register_dimms(stru
 		struct kernfs_node *nfit_kernfs;
 
 		nvdimm = nfit_mem->nvdimm;
+		if (!nvdimm)
+			continue;
+
 		nfit_kernfs = sysfs_get_dirent(nvdimm_kobj(nvdimm)->sd, "nfit");
 		if (nfit_kernfs)
 			nfit_mem->flags_attr = sysfs_get_dirent(nfit_kernfs,
