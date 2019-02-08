Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4D1C282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547F321916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfBHLfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:35:10 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42992 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfBHLfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:35:10 -0500
Received: from 79.184.254.36.ipv4.supernova.orange.pl (79.184.254.36) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id d036c7c9eb97d42b; Fri, 8 Feb 2019 12:35:07 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jeremy Linton <jeremy.linton@arm.com>,
        John Garry <john.garry@huawei.com>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] ACPI/PPTT: Add acpi_pptt_warn_missing() to consolidate logs
Date:   Fri, 08 Feb 2019 12:33:54 +0100
Message-ID: <2085072.OaQc2ZMdL6@aspire.rjw.lan>
In-Reply-To: <05990286-4b66-2879-f066-b4ab558f7385@arm.com>
References: <1549556061-107418-1-git-send-email-john.garry@huawei.com> <05990286-4b66-2879-f066-b4ab558f7385@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 7, 2019 5:21:35 PM CET Jeremy Linton wrote:
> Hi,
> 
> On 2/7/19 10:14 AM, John Garry wrote:
> > For a system using ACPI-based FW without a PPTT, we may get many warnings
> > about the lack of a PPTT, as shown:
> > 
> > root@(none)$ dmesg | grep -i pptt
> > [    0.010125] ACPI PPTT: No PPTT table found, cpu topology may be inaccurate
> > [    7.138339] ACPI PPTT: No PPTT table found, cache topology may be inaccurate
> > [    7.145368] ACPI PPTT: No PPTT table found, cache topology may be inaccurate
> > 
> > These logs are generated with pr_warn_once(), so the intention was for a
> > single log, but the logs overlap, so consolidate them.
> > 
> > Signed-off-by: John Garry <john.garry@huawei.com>
> > 
> > diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> > index da031b1df6f5..ad31c50de3be 100644
> > --- a/drivers/acpi/pptt.c
> > +++ b/drivers/acpi/pptt.c
> > @@ -451,6 +451,11 @@ static struct acpi_pptt_processor *acpi_find_processor_package_id(struct acpi_ta
> >   	return cpu;
> >   }
> >   
> > +static void acpi_pptt_warn_missing(void)
> > +{
> > +	pr_warn_once("No PPTT table found, cpu and cache topology may be inaccurate\n");
> > +}
> > +
> >   /**
> >    * topology_get_acpi_cpu_tag() - Find a unique topology value for a feature
> >    * @table: Pointer to the head of the PPTT table
> > @@ -498,7 +503,7 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
> >   
> >   	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> >   	if (ACPI_FAILURE(status)) {
> > -		pr_warn_once("No PPTT table found, cpu topology may be inaccurate\n");
> > +		acpi_pptt_warn_missing();
> >   		return -ENOENT;
> >   	}
> >   	retval = topology_get_acpi_cpu_tag(table, cpu, level, flag);
> > @@ -531,7 +536,7 @@ int acpi_find_last_cache_level(unsigned int cpu)
> >   	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> >   	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> >   	if (ACPI_FAILURE(status)) {
> > -		pr_warn_once("No PPTT table found, cache topology may be inaccurate\n");
> > +		acpi_pptt_warn_missing();
> >   	} else {
> >   		number_of_levels = acpi_find_cache_levels(table, acpi_cpu_id);
> >   		acpi_put_table(table);
> > @@ -563,7 +568,7 @@ int cache_setup_acpi(unsigned int cpu)
> >   
> >   	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> >   	if (ACPI_FAILURE(status)) {
> > -		pr_warn_once("No PPTT table found, cache topology may be inaccurate\n");
> > +		acpi_pptt_warn_missing();
> >   		return -ENOENT;
> >   	}
> >   
> > @@ -617,7 +622,7 @@ int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
> >   
> >   	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> >   	if (ACPI_FAILURE(status)) {
> > -		pr_warn_once("No PPTT table found, topology may be inaccurate\n");
> > +		acpi_pptt_warn_missing();
> >   		return -ENOENT;
> >   	}
> >   
> > 
> 
> This all looks fine to me,
> 
> Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> 
> Thanks!
> 

Patch applied, thanks!


