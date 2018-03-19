Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt08r8GRXjY7z5J16UkRMK3FZvJPoRRXiNbg3z3+NGZL+I8EPAj85p7+SFDAAhh04Mz11T7
ARC-Seal: i=1; a=rsa-sha256; t=1521483774; cv=none;
        d=google.com; s=arc-20160816;
        b=gOGS/z5y+O42pbLtYos9dRoVZETjO8INLD9jXOjk31ASrcfhYAm4OBhk30tn3Ykvdr
         6sdj2PRFWSG+2SUX5wGg7sgyr9hYkNOxSX7qPWWdBHFqYzA0WbomiCKV4OahEFOxRjsT
         EzswEIGDey/g75R90FTrzhuhz3M2oNF8zPh9XAk6NeufIOYho21IZG3IbAa1sTobvcoY
         GtG62jAhv17DVgZA853zWn+A3GVcaHLu0rP0FlH+9OevqAXUftfrf8hURDMd+LhnzwLt
         YHfYqG7DelVQ50UVi5RUYraGlfI4zBqeP9ZkFnN0bU+w7zS/CfGQP+faTmBIU66NPy9I
         MAbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=D/neUQz4H+XneK3fuw9+g9WPJDdpmIul8lb/ZsG9c1k=;
        b=wk9q4lkW9aFqjZdeNHmWmqrrNgBTsGfSJf2H3crgzk3Q7bkUGxJnte3JfLHeJwxCiG
         cPob+DlmVgIQFn9qJ1xm/iaGQOXHSHApixX0vawzm8MizSutnF8P1ejhPTVE4xfxIxTl
         bjGeGW1avRHq2I1yoltabMFYBiPLb/Kop323HSw/MI6GY82hnJk+e7yxee6gP9y2emul
         1NqmaCEngF7Z+GGP4Y6S50WbgXZNBg59DLX60xNKFIGmj5w+zKtPOMFksSfLrCQnLJVs
         G0qs1wEBmsOpFCn8LW9rwlPeupdAQlv/B4Rgk4xTGnIGsst5mPxpP1Sf1IUpG0rJpYun
         1k0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thor Thayer <thor.thayer@linux.intel.com>,
	linux-edac <linux-edac@vger.kernel.org>,
	Borislav Petkov <bp@suse.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 113/241] EDAC, altera: Fix peripheral warnings for Cyclone5
Date: Mon, 19 Mar 2018 19:06:18 +0100
Message-Id: <20180319180755.884323785@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391369791014448?=
X-GMAIL-MSGID: =?utf-8?q?1595391369791014448?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thor Thayer <thor.thayer@linux.intel.com>


[ Upstream commit 25b223ddfe2a557307c05fe673e09d94ae950877 ]

The peripherals' RAS functionality only exist on the Arria10 SoCFPGA.
The Cyclone5 initialization generates EDAC warnings when the peripherals
aren't found in the device tree. Fix by checking for Arria10 in the init
functions.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/1491415262-5018-1-git-send-email-thor.thayer@linux.intel.com
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/altera_edac.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1020,13 +1020,23 @@ out:
 	return ret;
 }
 
+static int socfpga_is_a10(void)
+{
+	return of_machine_is_compatible("altr,socfpga-arria10");
+}
+
 static int validate_parent_available(struct device_node *np);
 static const struct of_device_id altr_edac_a10_device_of_match[];
 static int __init __maybe_unused altr_init_a10_ecc_device_type(char *compat)
 {
 	int irq;
-	struct device_node *child, *np = of_find_compatible_node(NULL, NULL,
-					"altr,socfpga-a10-ecc-manager");
+	struct device_node *child, *np;
+
+	if (!socfpga_is_a10())
+		return -ENODEV;
+
+	np = of_find_compatible_node(NULL, NULL,
+				     "altr,socfpga-a10-ecc-manager");
 	if (!np) {
 		edac_printk(KERN_ERR, EDAC_DEVICE, "ECC Manager not found\n");
 		return -ENODEV;
@@ -1542,8 +1552,12 @@ static const struct edac_device_prv_data
 static int __init socfpga_init_sdmmc_ecc(void)
 {
 	int rc = -ENODEV;
-	struct device_node *child = of_find_compatible_node(NULL, NULL,
-						"altr,socfpga-sdmmc-ecc");
+	struct device_node *child;
+
+	if (!socfpga_is_a10())
+		return -ENODEV;
+
+	child = of_find_compatible_node(NULL, NULL, "altr,socfpga-sdmmc-ecc");
 	if (!child) {
 		edac_printk(KERN_WARNING, EDAC_DEVICE, "SDMMC node not found\n");
 		return -ENODEV;
