Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BED7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D053B204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D053B204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeIGVrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:47:17 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:52239 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeIGVrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:47:17 -0400
Received: from [148.252.241.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fyKCB-0003jr-RT; Fri, 07 Sep 2018 18:05:24 +0100
Message-ID: <1536339923.3024.112.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 31/43] mm: fix cache mode tracking in
 vm_insert_mixed()
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        David Airlie <airlied@linux.ie>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Date:   Fri, 07 Sep 2018 18:05:23 +0100
In-Reply-To: <20180814171519.142204859@linuxfoundation.org>
References: <20180814171517.014285600@linuxfoundation.org>
         <20180814171519.142204859@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-14 at 19:18 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Dan Williams <dan.j.williams@intel.com>
> 
> commit 87744ab3832b83ba71b931f86f9cfdb000d07da5 upstream
> 
> vm_insert_mixed() unlike vm_insert_pfn_prot() and vmf_insert_pfn_pmd(),
> fails to check the pgprot_t it uses for the mapping against the one
> recorded in the memtype tracking tree.  Add the missing call to
> track_pfn_insert() to preclude cases where incompatible aliased mappings
> are established for a given physical address range.
[...]

This apparently breaks a number of DRM drivers.  The upstream fixes
are:

8ef4227615e1 x86/io: add interface to reserve io memtype for a resource range. (v1.1)
7cf321d118a8 drm/drivers: add support for using the arch wc mapping API.

They appear to apply cleanly to 4.4-stable.  They are included in 4.9
so no other stable branch needs them.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
