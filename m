Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx493F9+EELTxL9aEM8/aB0i5AuELq/yrfTn042JpCC80JFQ0/C870/bGbT8M4GjaPzgmKYwF
ARC-Seal: i=1; a=rsa-sha256; t=1523981118; cv=none;
        d=google.com; s=arc-20160816;
        b=S3OqbEkV4j9sncJrZAlmr3ikiVlxr78BORQ1tbi2GDVz4UG7ePHR801w1TloYF7fuR
         X9bsau/v7ioNaG5Y+Ado8vylboq5Da6UPne3eTHjqv9ob09jg3XTw6JewG4TDUf/zN3H
         clPTbhyLpGreRhePxeixgVw9OwvPUUIi0mfW3z5HfCsM6F0uKrupLbcWV8tkCu3ZKNaA
         i8d2Vxf+ptuCO7Xns3L/m+adb9QrY6fyjIrZtHChIMuBpMhWf7YmEBqYt0Z62sYlOY/9
         4aTsAqNbXUtTQQ31Hv684Dc3CGTWefSgJ3pCqh59SLP7ifulVlanuro1YZDLA6osI90L
         Fj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=q5MdLp7PzUpaS4egQ4F1skYmP/1T93T2sBTkJksX1j8=;
        b=FuX0pyGtpp1gcEXKVTzpN3A06Di5AmOaEuGSXEnBvDC5jvU0uUVDy4fBj+A3WgIvTY
         yuBdHzJ20YMl6kn5LmT7vm3WxmeTwowwqhvTxtrSA0ytW6CA9uKD/L9YUIPAr9Bx2WAq
         sUNdFO/M7MvFz6Lw/hfISAwvN8/i4NUs9/BP81SWeJG8bOA3OQFwHzlbKscjjTL0OEFq
         JzfeGfIBdlX8Y0MUZ0qHVA8U1EBmfrdRbSqOqSSTtKrfUavenDHPvlF0y4HUC/VWQY2W
         1HRQYDVlQbKn+57PRZAcaP4llN6Xj850t7wV6Rq5FAzQWQ+7Zge+5Db8ZMpIBKuBI0VX
         wFgw==
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
Subject: [PATCH 4.15 42/53] nfit: fix region registration vs block-data-window ranges
Date: Tue, 17 Apr 2018 17:59:07 +0200
Message-Id: <20180417155725.152369306@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009840996584111?=
X-GMAIL-MSGID: =?utf-8?q?1598010025685969349?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2998,15 +2998,21 @@ static void acpi_nfit_scrub(struct work_
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
