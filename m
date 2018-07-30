Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FD3FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4891420873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4891420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeG3L0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:26:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:27140 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbeG3L0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:26:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 02:52:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="68589752"
Received: from frcorrad-mobl.amr.corp.intel.com (HELO [10.249.128.161]) ([10.249.128.161])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jul 2018 02:52:18 -0700
Subject: Re: [PATCH 4.17 55/66] ACPICA: AML Parser: ignore dispatcher error
 status during table load
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Erik Schmauss <erik.schmauss@intel.com>
References: <20180727093809.043856530@linuxfoundation.org>
 <20180727093815.227850545@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <307694d7-2af3-9c74-6d12-3a2a73137606@intel.com>
Date:   Mon, 30 Jul 2018 11:52:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180727093815.227850545@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/2018 11:45 AM, Greg Kroah-Hartman wrote:
> 4.17-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Schmauss, Erik <erik.schmauss@intel.com>
>
> commit 73c2a01c52b657f4a0ead6c95f64c5279efbd000 upstream.
>
> The dispatcher and the executer process the parse nodes During table
> load. Error status from the evaluation confuses the AML parser. This
> results in the parser failing to complete parsing of the current
> scope op which becomes problematic. For the incorrect AML below, _ADR
> never gets created.
>
> definition_block(...)
> {
>     Scope (\_SB)
>     {
>       Device (PCI0){...}
>       Name (OBJ1, 0x0)
>       OBJ1 = PCI0 + 5 // Results in an operand error.
>     } // \_SB not closed
>
>     // parser looks for \_SB._SB.PCI0, results in AE_NOT_FOUND error
>     // Entire scope block gets skipped.
>     Scope (\_SB.PCI0)
>     {
>         Name (_ADR, 0x0)
>     }
> }
>
> Fix the above error by properly completing the initial \_SB scope
> after an error by clearing errors that occur during table load. In
> the above case, this means that OBJ1 = PIC0 + 5 is skipped.
>
> Fixes: 5088814a6e93 (ACPICA: AML parser: attempt to continue loading table after error)
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200363
> Tested-by: Bastien Nocera <hadess@hadess.net>
> Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> Cc: 4.17+ <stable@vger.kernel.org> # 4.17+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Has this gone in already?  If not, please hold on.

There is a fix on top of this that will go to Linus tomorrow: 
https://patchwork.kernel.org/patch/10548059/

> ---
>   drivers/acpi/acpica/psloop.c |   26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>
> --- a/drivers/acpi/acpica/psloop.c
> +++ b/drivers/acpi/acpica/psloop.c
> @@ -497,6 +497,18 @@ acpi_status acpi_ps_parse_loop(struct ac
>   			status =
>   			    acpi_ps_create_op(walk_state, aml_op_start, &op);
>   			if (ACPI_FAILURE(status)) {
> +				/*
> +				 * ACPI_PARSE_MODULE_LEVEL means that we are loading a table by
> +				 * executing it as a control method. However, if we encounter
> +				 * an error while loading the table, we need to keep trying to
> +				 * load the table rather than aborting the table load. Set the
> +				 * status to AE_OK to proceed with the table load.
> +				 */
> +				if ((walk_state->
> +				     parse_flags & ACPI_PARSE_MODULE_LEVEL)
> +				    && status == AE_ALREADY_EXISTS) {
> +					status = AE_OK;
> +				}
>   				if (status == AE_CTRL_PARSE_CONTINUE) {
>   					continue;
>   				}
> @@ -694,6 +706,20 @@ acpi_status acpi_ps_parse_loop(struct ac
>   			    acpi_ps_next_parse_state(walk_state, op, status);
>   			if (status == AE_CTRL_PENDING) {
>   				status = AE_OK;
> +			} else
> +			    if ((walk_state->
> +				 parse_flags & ACPI_PARSE_MODULE_LEVEL)
> +				&& ACPI_FAILURE(status)) {
> +				/*
> +				 * ACPI_PARSE_MODULE_LEVEL means that we are loading a table by
> +				 * executing it as a control method. However, if we encounter
> +				 * an error while loading the table, we need to keep trying to
> +				 * load the table rather than aborting the table load. Set the
> +				 * status to AE_OK to proceed with the table load. If we get a
> +				 * failure at this point, it means that the dispatcher got an
> +				 * error while processing Op (most likely an AML operand error.
> +				 */
> +				status = AE_OK;
>   			}
>   		}
>   
>
>

