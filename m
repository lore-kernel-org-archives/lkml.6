Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D631C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102DB20881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102DB20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933213AbeGJLOv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:14:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50571 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbeGJLOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:14:49 -0400
Received: from 79.184.255.246.ipv4.supernova.orange.pl (79.184.255.246) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 17ad5040c1ea7f31; Tue, 10 Jul 2018 13:14:47 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: 4.18rc3 TX2 boot failure with "ACPICA: AML parser: attempt to continue loading table after error"
Date:   Tue, 10 Jul 2018 13:13:17 +0200
Message-ID: <3574827.zOC4apc8e1@aspire.rjw.lan>
In-Reply-To: <218e4339-477d-eb0d-6007-764c8e24229f@arm.com>
References: <c49a3666-7d23-6a05-703c-1273d79a00cd@arm.com> <CAJZ5v0gcr2JjgTe6VwtJxw3yY+ZiPOZpQyjR0FokPM+RzDXJpg@mail.gmail.com> <218e4339-477d-eb0d-6007-764c8e24229f@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 10, 2018 5:44:05 AM CEST Jeremy Linton wrote:
> Hi,
> 
> On 07/09/2018 04:28 PM, Rafael J. Wysocki wrote:
> > On Mon, Jul 9, 2018 at 10:45 PM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> >> Hi,
> >>
> >> First thanks for the patch..
> >>
> >> On 07/08/2018 04:14 AM, Rafael J. Wysocki wrote:
> >>>
> >>> On Monday, July 2, 2018 11:41:42 PM CEST Jeremy Linton wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> I'm experiencing two problems with commit 5088814a6e931 which is
> >>>> "ACPICA: AML parser: attempt to continue loading table after error"
> >>>>
> >>>> The first is this boot failure on a thunderX2:
> >>>>
> >>>> [   10.770098] ACPI Error: Ignore error and continue table load
> >>
> >>
> >> [trimming]
> >>
> >>>> ]---
> >>>>
> >>>> Which does appear to be the result of some bad data in the table, but it
> >>>> was working with 4.17, and reverting this commit solves the problem.
> >>>
> >>>
> >>> Does the patch below make any difference?
> >>>
> >>> ---
> >>>    drivers/acpi/acpica/psobject.c |    3 +++
> >>>    1 file changed, 3 insertions(+)
> >>>
> >>> Index: linux-pm/drivers/acpi/acpica/psobject.c
> >>> ===================================================================
> >>> --- linux-pm.orig/drivers/acpi/acpica/psobject.c
> >>> +++ linux-pm/drivers/acpi/acpica/psobject.c
> >>> @@ -39,6 +39,9 @@ static acpi_status acpi_ps_get_aml_opcod
> >>>          ACPI_FUNCTION_TRACE_PTR(ps_get_aml_opcode, walk_state);
> >>>          walk_state->aml = walk_state->parser_state.aml;
> >>> +       if (!walk_state->aml)
> >>> +               return AE_CTRL_PARSE_CONTINUE;
> >>> +
> >>
> >>
> >> Well this seems to avoid the crash, but now it hangs right after on the
> >> "Ignore error and continue table load" message.
> > 
> > Well, maybe we should just abort in that case.
> > 
> > I'm wondering what happens if you replace the return statement in the
> > patch above with
> > 
> > return_ACPI_STATUS(AE_AML_BAD_OPCODE)
> 
> Yes, that is where I went when I applied the patch but I used 
> AE_CTRL_TERMINATE, which terminates the loop in acpi_ps_parse_loop() and 
> that appears to successfully finish/terminate the initial parsing pass. 
> But, it then crashes in acpi_ns_lookup called via the 
> acpi_walk_resources sequences that goes through ut_evalute_object() due 
> to the path/scope_info->scope.node being ACPI_ROOT_OBJECT (-1) and 
> bypassing the null check. Adding a ACPI_ROOT_OBJECT check as well as the 
> null checks in acpi_ns_lookup results in a successful boot. Tracking 
> down how the terminate (or whatever) is leaving the info->prefix_node 
> (in acpi_ns_evaluate) set to ROOT_OBJECT instead of null, is something I 
> don't yet understand.
> 
> Anyway, I tried Using BAD_OPCODE rather than TERMINATE and it seems to 
> have the same basic result as PARSE_CONTINUE.

OK, thanks!

I evidently didn't look deep enough.

Can you please check the patch below?

I'm not sure if we can pass this broken state to
acpi_ps_complete_final_op(), so it may be necessary to return
an error directly when aml_op_start is NULL.

---
 drivers/acpi/acpica/psloop.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-pm/drivers/acpi/acpica/psloop.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/psloop.c
+++ linux-pm/drivers/acpi/acpica/psloop.c
@@ -493,6 +493,9 @@ acpi_status acpi_ps_parse_loop(struct ac
 		ASL_CV_CAPTURE_COMMENTS(walk_state);
 
 		aml_op_start = parser_state->aml;
+		if (!aml_op_start)
+			break;
+
 		if (!op) {
 			status =
 			    acpi_ps_create_op(walk_state, aml_op_start, &op);

