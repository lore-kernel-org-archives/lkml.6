Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDB4C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1738823D3D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1738823D3D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753707AbeGDKjk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:39:40 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53424 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753048AbeGDKjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:39:39 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id a92a950262f3c9f1; Wed, 4 Jul 2018 12:39:36 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        shunyong.yang@hxt-semitech.com, yu.zheng@hxt-semitech.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH] ACPI/PPTT: use ACPI ID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set
Date:   Wed, 04 Jul 2018 12:38:12 +0200
Message-ID: <3678832.fJrbWfqCFa@aspire.rjw.lan>
In-Reply-To: <8fe4ee5c-23b8-12bb-3f2e-5589ca4de24b@arm.com>
References: <1530289077-2444-1-git-send-email-sudeep.holla@arm.com> <CAJZ5v0gh0-psU7bbLf5zDGW5adQNALSdWdedbCgDoh1F-peh0g@mail.gmail.com> <8fe4ee5c-23b8-12bb-3f2e-5589ca4de24b@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, July 2, 2018 2:52:24 PM CEST Sudeep Holla wrote:
> 
> On 02/07/18 12:01, Rafael J. Wysocki wrote:
> > On Mon, Jul 2, 2018 at 11:57 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >>
> >>
> >> On 02/07/18 10:06, Rafael J. Wysocki wrote:
> >>> On Fri, Jun 29, 2018 at 6:17 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >>>> Currently we use the ACPI processor ID only for the leaf/processor nodes
> >>>> as the specification states it must match the value of ACPI processor ID
> >>>> field in the processor’s entry in the MADT.
> >>>>
> >>>> However, if a PPTT structure represents processors group, it match a
> >>>> processor container UID in the namespace and ACPI_PPTT_ACPI_PROCESSOR_ID_VALID
> >>>> flag describe whether the ACPI processor ID is valid.
> >>>>
> >>>> Lets use UID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set to be
> >>>> consistent instead of using table offset as it's currently done for non
> >>>> leaf nodes.
> >>>>
> >>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >>>> ---
> >>>>  drivers/acpi/pptt.c | 10 ++++++++--
> >>>>  1 file changed, 8 insertions(+), 2 deletions(-)
> >>>>
> >>>> Hi,
> >>>>
> >>>> There's ongoing discussion on assigning ID based in OS using simple
> >>>> counters. It can never be consistent with firmware's view. So if the
> >>>> firmware provides valid UID for non-processors node, we must use it.
> >>>
> >>> OK
> >>>
> >>> Do you regard this as a fix for the recently merged PPTT material?  If
> >>> so, I should apply it as a fix for 4.18.
> >>>
> >>
> >> Yes, it should be considered as fix IMO.
> > 
> > So any chance to provide a Fixes: tag?
> 
> Sure, since it was in the same release, I didn't add it.
> 
> Fixes: 2bd00bcd73e5 ("ACPI/PPTT: Add Processor Properties Topology Table
> parsing")
> 
> 

Applied now, thanks!


