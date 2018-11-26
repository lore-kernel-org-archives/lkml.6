Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC25BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFAD20865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFAD20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeKZX7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 18:59:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:45771 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbeKZX7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 18:59:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 05:04:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,282,1539673200"; 
   d="scan'208";a="111585278"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 26 Nov 2018 05:04:53 -0800
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gRGZI-0001Cj-D7; Mon, 26 Nov 2018 15:04:52 +0200
Date:   Mon, 26 Nov 2018 15:04:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] ACPI: property: Add acpi_fwnode_name()
Message-ID: <20181126130452.GG10650@smile.fi.intel.com>
References: <20181126114752.69597-1-heikki.krogerus@linux.intel.com>
 <20181126114752.69597-3-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126114752.69597-3-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 02:47:51PM +0300, Heikki Krogerus wrote:
> This implements the get_name fwnode op for ACPI.

> +static int
> +acpi_fwnode_get_name(const struct fwnode_handle *fwnode, char *buf, size_t len)
> +{
> +	struct acpi_buffer buffer;
> +	acpi_handle handle;
> +	acpi_status status;
> +
> +	if (is_acpi_data_node(fwnode)) {
> +		snprintf(buf, len, "%s", to_acpi_data_node(fwnode)->name);

Same question as per patch 1. How are we going to handle bigger strings?

> +		return 0;
> +	}
> +
> +	handle = to_acpi_device_node(fwnode)->handle;
> +

> +	buffer.length = min((size_t)ACPI_NAME_SIZE + 1, len);

Hmm...

 min_t(size_t, ...) ?


> +	buffer.pointer = buf;
> +
> +	status = acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);

And same question here. Is it possible to get length of the name and check?

Perhaps, I would return -ENAMETOOLONG (-EOVERFLOW) or alike for such cases.

> +	if (ACPI_FAILURE(status))
> +		return -ENXIO;
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


