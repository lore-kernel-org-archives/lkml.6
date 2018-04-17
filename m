Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/oxzFR+WQ+JTGWCH9OVbxiza3ydERxkVYV4+pf0yRGwjlylJR5NRLNYL1oAMHUQJwzLQI0
ARC-Seal: i=1; a=rsa-sha256; t=1523981415; cv=none;
        d=google.com; s=arc-20160816;
        b=cZcBdTWlT1SnE5CA3eQLlrL3ta3FsCDTkJNzuVHy4lFouc1t9JfAYqzl39pn083C/y
         5SJAycEz4S5WnQCEqA8wsKfFjsu8Vnx/SOGJ7Q8CYrmThk+XaL4n4VKyuJzXz72wPVhI
         Tp/RYaNDZHvbfZ65zU6cfHokL/fYYbPCe6zWKyAKK3T6ssimoSdpDU+CkdJUaWol5WB1
         SYLUw+UaGgLUTZ26p8gS6TaEQHhbJBUCPmRtlrV6L5d7xqgGe+bxRte7qpNeH6p71Wwu
         3R1blwX9gkVrdu0ad2aKUZSalLPppfQONqPz/8m18ykormFFmt+l8L//6J2Ov5WBZuNw
         fhWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uhWWYePmNX/RmUD1xaOlWNBPi2oIwJ4UXfPY5aKnouI=;
        b=ZVlhjjgQWziSj8UmaUjdfFEPTQx884G02GtyqHZ/C0ku2Kzcs5keCgaQHoo0AaQD3/
         0PTDDR581FCS28IWwFfASB+f21Hcol6gy6e1N/OqJAdZNCaBARep26+fOzF+R/D/rhpD
         ljujqzrRM+Dq04pr88qucppzoq5VE62ikoaqv8MFKkvg2vgrTpAX/LIcUp0gBmHZaZXk
         Yz+BXypvsmym6w4D9YPp++JKEWoynq6SsCdeF9UjjGsIgUPYyc9jXUvSsHGbIiwM0X3H
         l9vSTToIsuudAVeMpw135tbiPlkdcMLoa2V5AJ+sMxcKBnKbqKMROJs2U2tYaToZ4RMW
         DD2w==
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
Subject: [PATCH 4.9 54/66] nfit: fix region registration vs block-data-window ranges
Date: Tue, 17 Apr 2018 17:59:27 +0200
Message-Id: <20180417155648.232411368@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009840996584111?=
X-GMAIL-MSGID: =?utf-8?q?1598010336902557309?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2547,15 +2547,21 @@ static void acpi_nfit_scrub(struct work_
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
 
 	queue_work(nfit_wq, &acpi_desc->work);
 	return 0;
