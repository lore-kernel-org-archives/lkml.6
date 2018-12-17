Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37213C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104872133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeLQM4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:56:05 -0500
Received: from foss.arm.com ([217.140.101.70]:55512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbeLQM4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:56:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18AD5A78;
        Mon, 17 Dec 2018 04:56:05 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2FB03F6A8;
        Mon, 17 Dec 2018 04:56:03 -0800 (PST)
Date:   Mon, 17 Dec 2018 12:55:58 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 6/6] ACPI/IORT: Stub out ACS functions when
 CONFIG_PCI is not set
Message-ID: <20181217125558.GA20864@e107981-ln.cambridge.arm.com>
References: <20181215010247.26101-1-okaya@kernel.org>
 <20181215010247.26101-7-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215010247.26101-7-okaya@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 01:02:47AM +0000, Sinan Kaya wrote:
> Remove PCI dependent code out of iort.c when CONFIG_PCI is not defined.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/acpi/arm64/iort.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 70f4e80b9246..d0f68607efe6 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1437,6 +1437,7 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>  
>  static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
>  {
> +#ifdef CONFIG_PCI
>  	if (iort_node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
>  		struct acpi_iort_node *parent;
>  		struct acpi_iort_id_mapping *map;
> @@ -1462,6 +1463,7 @@ static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
>  			}
>  		}
>  	}
> +#endif
>  
>  	return false;
>  }
> -- 
> 2.19.0

I would prefer the ifdef to wrap the function rather than in the
function.

Anyway, as an alternative, what about this:

-- >8 --
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 70f4e80b9246..06d4cc888df6 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1435,8 +1435,14 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 	return ret;
 }
 
-static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
+#ifdef CONFIG_PCI
+static void __init iort_enable_acs(struct acpi_iort_node *iort_node)
 {
+	static bool acs_enabled __initdata = false;
+
+	if (acs_enabled)
+		return;
+
 	if (iort_node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
 		struct acpi_iort_node *parent;
 		struct acpi_iort_id_mapping *map;
@@ -1458,13 +1464,15 @@ static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
 			if ((parent->type == ACPI_IORT_NODE_SMMU) ||
 				(parent->type == ACPI_IORT_NODE_SMMU_V3)) {
 				pci_request_acs();
-				return true;
+				acs_enabled = true;
+				return;
 			}
 		}
 	}
-
-	return false;
 }
+#else
+static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
+#endif
 
 static void __init iort_init_platform_devices(void)
 {
@@ -1472,7 +1480,6 @@ static void __init iort_init_platform_devices(void)
 	struct acpi_table_iort *iort;
 	struct fwnode_handle *fwnode;
 	int i, ret;
-	bool acs_enabled = false;
 	const struct iort_dev_config *ops;
 
 	/*
@@ -1493,8 +1500,7 @@ static void __init iort_init_platform_devices(void)
 			return;
 		}
 
-		if (!acs_enabled)
-			acs_enabled = iort_enable_acs(iort_node);
+		iort_enable_acs(iort_node);
 
 		ops = iort_get_dev_cfg(iort_node);
 		if (ops) {
