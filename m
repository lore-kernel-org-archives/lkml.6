Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50364FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039C420861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039C420861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbeINN5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:57:16 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51638 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbeINN5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:57:16 -0400
Received: from 79.184.255.178.ipv4.supernova.orange.pl (79.184.255.178) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id ec50a3a110d924ad; Fri, 14 Sep 2018 10:43:47 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     ahs3@redhat.com, David Arcari <darcari@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] mailbox: PCC: handle parse error
Date:   Fri, 14 Sep 2018 10:41:06 +0200
Message-ID: <8358588.tR87Gxe1PI@aspire.rjw.lan>
In-Reply-To: <e9d05632-dae6-b904-fe62-d617b3dfe3fd@redhat.com>
References: <1535397548-69588-1-git-send-email-darcari@redhat.com> <e9d05632-dae6-b904-fe62-d617b3dfe3fd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 27, 2018 10:55:41 PM CEST Al Stone wrote:
> On 08/27/2018 01:19 PM, David Arcari wrote:
> > acpi_pcc_probe calls acpi_table_parse_entries_array but fails to check
> > for an error return.  This in turn can result in calling kcalloc with
> > a negative count as well as emitting the following misleading erorr
> > message:
> > 
> > [    2.642015] Could not allocate space for PCC mbox channels
> > 
> > Fixes: 8f8027c5f935 ("mailbox: PCC: erroneous error message when parsing ACPI PCCT")
> > 
> > Signed-off-by: David Arcari <darcari@redhat.com>
> > Cc: Al Stone <ahs3@redhat.com>
> > Cc: Jassi Brar <jassisinghbrar@gmail.com>
> > ---
> >  drivers/mailbox/pcc.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> > index 311e91b..256f18b 100644
> > --- a/drivers/mailbox/pcc.c
> > +++ b/drivers/mailbox/pcc.c
> > @@ -461,8 +461,11 @@ static int __init acpi_pcc_probe(void)
> >  	count = acpi_table_parse_entries_array(ACPI_SIG_PCCT,
> >  			sizeof(struct acpi_table_pcct), proc,
> >  			ACPI_PCCT_TYPE_RESERVED, MAX_PCC_SUBSPACES);
> > -	if (count == 0 || count > MAX_PCC_SUBSPACES) {
> > -		pr_warn("Invalid PCCT: %d PCC subspaces\n", count);
> > +	if (count <= 0 || count > MAX_PCC_SUBSPACES) {
> > +		if (count < 0)
> > +			pr_warn("Error parsing PCC subspaces from PCCT\n");
> > +		else
> > +			pr_warn("Invalid PCCT: %d PCC subspaces\n", count);
> >  		return -EINVAL;
> >  	}
> >  
> > 
> 
> Thanks, David.  Nice catch.
> 
> Reviewed-by: Al Stone <ahs3@redhat.com>

Patch applied, thanks!

