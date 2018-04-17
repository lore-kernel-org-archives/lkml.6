Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+hTIMvdLxN7HxB19DwusVFGcB+u+VVBB7Qjs9oNvwnBBo4NoDolXhveZyNgJ3Eg9cfHiVk
ARC-Seal: i=1; a=rsa-sha256; t=1523981244; cv=none;
        d=google.com; s=arc-20160816;
        b=y5z6yTYYtHFDYosq/pcW9zpMap/2wVmZCq6Oi+xgyUP5ZHDYaHPZjp1Zlv9CAFRBpZ
         c57VeDeqfPVHtPdCYZuWHQK2HzQXqd6T1SPiP+BHeDBVwTda3+01IDnxM1w0Rxd6LE/x
         USLak5Xu2XD0kccY6NxZKuGjB4vjj+IkqM8qCyx+x3jeRjPTH+SK0W09EfXNMyKpohPn
         Gz5AAFCygTWwtoKWmSyBLjEYV887UCAp4+pnHJLNlh5/KSe5mFBrwq4e8wBOK61NaYu+
         Mduz5Lmi9XQ2Ifrmrq7UuYbtVdN34j4sXPP3jncW8foSYumlzDxD0tFsE3JnCWDWyjU8
         Mu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YSFqXAhvHtmHIxisTYBHdISxKpMDHKAykRrwovjghz4=;
        b=xzNyjxiNc88FqPMAywvYIycXeIzME9NuPwR0l1U5zscmc+XZ9OrfNWxeviUjkjMSVP
         Kz1ingWudHYu16fxCs6fg5pDBDu3UPugrR8Oho6TuI0gH578zJzAsq3gTavkmdPGnMPb
         drZVLpa4B+cZGuUt+9JCTEpysb0HYBrS/8toFzuOJQRVy5bTrRFzb0UMP1e9RdGfYbVP
         oZMbJu1s/veIOwuW3noFwtUMRWuMiewPWFzh1mx/mS3A/a6a79KPmfhicvkI1Zf97me+
         AMydxDp8earAMaHPRsA1yyhiFL8JHSLDE8H8H62buCYzGYuEn498Zn3y2h5N9xAX80fS
         0hnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.14 27/49] nfit: fix region registration vs block-data-window ranges
Date: Tue, 17 Apr 2018 17:59:06 +0200
Message-Id: <20180417155716.314869745@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009840996584111?=
X-GMAIL-MSGID: =?utf-8?q?1598010157597585528?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 8d0d8ed3356aa9ed43b819aaedd39b08ca453007 upstream.

Commit 1cf03c00e7c1 "nfit: scrub and register regions in a workqueue"
mistakenly attempts to register a region per BLK aperture. There is
nothing to register for individual apertures as they belong as a set to
a BLK aperture group that are registered with a corresponding
DIMM-control-region. Filter them for registration to prevent some
needless devm_kzalloc() allocations.

Cc: <stable@vger.kernel.org>
Fixes: 1cf03c00e7c1 ("nfit: scrub and register regions in a workqueue")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/nfit/core.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2748,15 +2748,21 @@ static void acpi_nfit_scrub(struct work_
 static int acpi_nfit_register_regions(struct acpi_nfit_desc *acpi_desc)
 {
 	struct nfit_spa *nfit_spa;
-	int rc;
 
-	list_for_each_entry(nfit_spa, &acpi_desc->spas, list)
-		if (nfit_spa_type(nfit_spa->spa) == NFIT_SPA_DCR) {
-			/* BLK regions don't need to wait for ars results */
-			rc = acpi_nfit_register_region(acpi_desc, nfit_spa);
-			if (rc)
-				return rc;
-		}
+	list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
+		int rc, type = nfit_spa_type(nfit_spa->spa);
+
+		/* PMEM and VMEM will be registered by the ARS workqueue */
+		if (type == NFIT_SPA_PM || type == NFIT_SPA_VOLATILE)
+			continue;
+		/* BLK apertures belong to BLK region registration below */
+		if (type == NFIT_SPA_BDW)
+			continue;
+		/* BLK regions don't need to wait for ARS results */
+		rc = acpi_nfit_register_region(acpi_desc, nfit_spa);
+		if (rc)
+			return rc;
+	}
 
 	acpi_desc->ars_start_flags = 0;
 	if (!acpi_desc->cancel)
