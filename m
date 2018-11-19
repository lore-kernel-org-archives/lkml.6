Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA109C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B532820817
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B532820817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeKSUVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:21:32 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45212 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeKSUVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:21:32 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so26517109ota.12;
        Mon, 19 Nov 2018 01:58:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBpd1ayW9T1ckYD5iDe8Lvs3BCmuYLUXB4WYHdw3A/0=;
        b=pa4JSMIDCgCoMjdqKzvX6ijShf9tpEZyvhB6yWaskrzsd3xD+KSmS7S1MqpaRjvubx
         hG883KeiaIfAkiCVbSDha3mWT2H5Wo42IYKcOWsWOpHpiksB7cxajnOVTfSo7cin4OU/
         KhfEdvgS7GyvjfpKoRKNWqs0iQrZoLik2VfMJ15k1CWy4LmCH6RAIr0J2ulJANlNeIn1
         PRZxLTbyEg3SbdbBlmnGNMwTGIBF9tdt3D1SZ1mzcT58AQTHgWFaH22Hsvgtekehzr1Y
         zFzF49laBN1jn87N09P6Ric5MbJSdUWxglqZGHLefiOh+vklf2hZF/QI3LcHyngRZ1DW
         RXCw==
X-Gm-Message-State: AGRZ1gKopM61GN7cczA69pD790qgw8UVSh9Zd08hMCoS73QEnLgU+EEo
        qHAMAXK5EkDMi7nk9LmLmbH03X8CY4fcDJtKdr8=
X-Google-Smtp-Source: AJdET5cbfLcygguZAdRDXWqFI2V3LLRo11/OU5/ndmsM0N9rf2i1WiMJK50X9SLRsao1A5hEn88tpZpaH4WDh2S4Ij0=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr13539827otl.343.1542621504252;
 Mon, 19 Nov 2018 01:58:24 -0800 (PST)
MIME-Version: 1.0
References: <20181114224921.12123-2-keith.busch@intel.com> <20181114224921.12123-7-keith.busch@intel.com>
In-Reply-To: <20181114224921.12123-7-keith.busch@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 19 Nov 2018 10:58:12 +0100
Message-ID: <CAJZ5v0gQCpmRHdSS=xxLSx-+1xbexSFQb_ZxMvZuKUjk6+w5ww@mail.gmail.com>
Subject: Re: [PATCH 6/7] acpi: Create subtable parsing infrastructure
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 11:53 PM Keith Busch <keith.busch@intel.com> wrote:
>
> Parsing entries in an ACPI table had assumed a generic header structure
> that is most common. There is no standard ACPI header, though, so less
> common types would need custom parsers if they want go walk their
> subtable entry list.
>
> Create the infrastructure for adding different table types so parsing
> the entries array may be more reused for all ACPI system tables.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/acpi/tables.c | 75 ++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 65 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 61203eebf3a1..15ee77780f68 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -49,6 +49,19 @@ static struct acpi_table_desc initial_tables[ACPI_MAX_TABLES] __initdata;
>
>  static int acpi_apic_instance __initdata;
>
> +enum acpi_subtable_type {
> +       ACPI_SUBTABLE_COMMON,
> +};
> +
> +union acpi_subtable_headers {
> +       struct acpi_subtable_header common;
> +};
> +
> +struct acpi_subtable_entry {
> +       union acpi_subtable_headers *hdr;
> +       enum acpi_subtable_type type;
> +};
> +
>  /*
>   * Disable table checksum verification for the early stage due to the size
>   * limitation of the current x86 early mapping implementation.
> @@ -217,6 +230,45 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>         }
>  }
>
> +static unsigned long __init
> +acpi_get_entry_type(struct acpi_subtable_entry *entry)
> +{
> +       switch (entry->type) {
> +       case ACPI_SUBTABLE_COMMON:
> +               return entry->hdr->common.type;
> +       }
> +       WARN_ONCE(1, "invalid acpi type\n");
> +       return 0;
> +}
> +
> +static unsigned long __init
> +acpi_get_entry_length(struct acpi_subtable_entry *entry)
> +{
> +       switch (entry->type) {
> +       case ACPI_SUBTABLE_COMMON:
> +               return entry->hdr->common.length;
> +       }
> +       WARN_ONCE(1, "invalid acpi type\n");

AFAICS this does a WARN_ONCE() on information obtained from firmware.

That is not a kernel problem, so generating traces in that case is not
a good idea IMO.  Moreover, users can't really do much about this in
the majority of cases, so a pr_info() message should be sufficient.

And similarly below.
