Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688A4C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3159820700
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jchIsAKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3159820700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbeKFELb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:11:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbeKFELb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:11:31 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F04972085A;
        Mon,  5 Nov 2018 18:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541443827;
        bh=UXwisoTq6PDPqDxDy5qx1oZRQvxJ9vQoINcQFbIXI8w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jchIsAKJjFxAzE5kmGaewRa6ozxjtIy+B8YN3WBhhoHKn21RZ6wKi0Jwn7KH9otaI
         gLEmhXt4Vay1Qf0Mo532WBwct/EpCtlb9aLOVoQWPM7/N4uR+Nh/+JJ/y4OpeDtaWt
         SdYFtxfaJDMmT4aVIEYnvSFBzl6NghtacE87bxhc=
Received: by mail-qk1-f181.google.com with SMTP id r71so16611896qkr.10;
        Mon, 05 Nov 2018 10:50:26 -0800 (PST)
X-Gm-Message-State: AGRZ1gLGgnbGbKE+UoBa8eKRkrq7omJqygFrW6yCym0ZVwlbgmLBnvYW
        KESLb9iNdjVMItffH1jwK9ppwxKBJxW//pjqrw==
X-Google-Smtp-Source: AJdET5fX6wInugbtK0yK5dXF6Bw+e76HfDfpa9l8K6NGDBtZwDhq2YvUh8OFjLlBKyspn423cm/lExzpyUSKVz6OjeI=
X-Received: by 2002:ae9:edd8:: with SMTP id c207mr20932106qkg.184.1541443814083;
 Mon, 05 Nov 2018 10:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20181105091727.25544-1-heikki.krogerus@linux.intel.com> <20181105091727.25544-4-heikki.krogerus@linux.intel.com>
In-Reply-To: <20181105091727.25544-4-heikki.krogerus@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 5 Nov 2018 12:50:02 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+aRAv+9gDKwVi9xYQPYzXK4NMPjzfkuYB08+K6KTYXFg@mail.gmail.com>
Message-ID: <CAL_Jsq+aRAv+9gDKwVi9xYQPYzXK4NMPjzfkuYB08+K6KTYXFg@mail.gmail.com>
Subject: Re: [PATCH 3/4] of/property: Introduce of_fwnode_name()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 3:17 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Instead of always being forced to read the "name" property
> in fwnode_name() with of_nodes, implementing the fwnode
> operation meant for getting the node name.
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/property.c | 6 ++++++

Please Cc the DT list for DT changes.

>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index f46828e3b082..ac7b0b6c2d4d 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -823,6 +823,11 @@ static void of_fwnode_put(struct fwnode_handle *fwnode)
>         of_node_put(to_of_node(fwnode));
>  }
>
> +static const char *of_fwnode_name(const struct fwnode_handle *fwnode)
> +{
> +       return to_of_node(fwnode)->name;

I'm trying to get rid of the DT name ptr, so please don't add one. You
can use of_node_full_name() here instead if "<name>@<unit-address>"
instead of <name> is fine. Otherwise, you've got to allocate your own
storage and use "%pOFn" printf specifier.

Rob
