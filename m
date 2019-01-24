Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38834C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA53218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfAXUOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:14:10 -0500
Received: from smtprelay0253.hostedemail.com ([216.40.44.253]:50950 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728921AbfAXUOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:14:07 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 9114818068BC9;
        Thu, 24 Jan 2019 20:14:05 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 52CA2180629FB;
        Thu, 24 Jan 2019 20:14:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: mouth64_7ab384578bb1a
X-Filterd-Recvd-Size: 2361
Received: from XPS-9350 (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Thu, 24 Jan 2019 20:14:03 +0000 (UTC)
Message-ID: <6ae5c389b98150341eceb4a2b9a457629e49edbc.camel@perches.com>
Subject: Re: [PATCH] of: Make of_node_name_eq() case insensitive
From:   Joe Perches <joe@perches.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     vivien.didelot@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>
Date:   Thu, 24 Jan 2019 12:14:01 -0800
In-Reply-To: <20190124200825.2611-1-f.fainelli@gmail.com>
References: <20190124200825.2611-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-24 at 12:08 -0800, Florian Fainelli wrote:
> Since c32569e358ad ("regulator: Use of_node_name_eq for node name
> comparisons") Vivien reported the mc13892-regulator complaining about
> not being able to find regulators.
> 
> This is because prior to that commit we used of_node_cmp() to compare
> the regulator array passed from mc13892_regulators down to
> mc13xxx_parse_regulators_dt() and they are all defined in uppercase
> letters by the MC13892_*_DEFINE* macros, whereas they are defined as
> lowercase in the DTS.
> 
> Fix this by use strncasecmp() since that makes sure the comparison is
> case insensitive like what of_node_cmp() did.
> 
> Reported-by: Vivien Didelot <vivien.didelot@gmail.com>
> Fixes: c32569e358ad ("regulator: Use of_node_name_eq for node name comparisons")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Then likely of_node_name_prefix should also use
case insensitive matching.

---
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 5226e898476e..87a0bd7ef45e 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -75,7 +75,8 @@ bool of_node_name_prefix(const struct device_node *np, const char *prefix)
 	if (!np)
 		return false;
 
-	return strncmp(kbasename(np->full_name), prefix, strlen(prefix)) == 0;
+	return strncasecmp(kbasename(np->full_name),
+			   prefix, strlen(prefix)) == 0;
 }
 EXPORT_SYMBOL(of_node_name_prefix);
 

