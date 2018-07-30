Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA6DFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7878D20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7878D20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbeG3NTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:19:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60012 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbeG3NTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:19:13 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7314ECD3;
        Mon, 30 Jul 2018 11:44:37 +0000 (UTC)
Date:   Mon, 30 Jul 2018 13:44:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: Re: [PATCH 4.17 55/66] ACPICA: AML Parser: ignore dispatcher error
 status during table load
Message-ID: <20180730114433.GA19558@kroah.com>
References: <20180727093809.043856530@linuxfoundation.org>
 <20180727093815.227850545@linuxfoundation.org>
 <307694d7-2af3-9c74-6d12-3a2a73137606@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <307694d7-2af3-9c74-6d12-3a2a73137606@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:52:17AM +0200, Rafael J. Wysocki wrote:
> On 7/27/2018 11:45 AM, Greg Kroah-Hartman wrote:
> > 4.17-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Schmauss, Erik <erik.schmauss@intel.com>
> > 
> > commit 73c2a01c52b657f4a0ead6c95f64c5279efbd000 upstream.
> > 
> > The dispatcher and the executer process the parse nodes During table
> > load. Error status from the evaluation confuses the AML parser. This
> > results in the parser failing to complete parsing of the current
> > scope op which becomes problematic. For the incorrect AML below, _ADR
> > never gets created.
> > 
> > definition_block(...)
> > {
> >     Scope (\_SB)
> >     {
> >       Device (PCI0){...}
> >       Name (OBJ1, 0x0)
> >       OBJ1 = PCI0 + 5 // Results in an operand error.
> >     } // \_SB not closed
> > 
> >     // parser looks for \_SB._SB.PCI0, results in AE_NOT_FOUND error
> >     // Entire scope block gets skipped.
> >     Scope (\_SB.PCI0)
> >     {
> >         Name (_ADR, 0x0)
> >     }
> > }
> > 
> > Fix the above error by properly completing the initial \_SB scope
> > after an error by clearing errors that occur during table load. In
> > the above case, this means that OBJ1 = PIC0 + 5 is skipped.
> > 
> > Fixes: 5088814a6e93 (ACPICA: AML parser: attempt to continue loading table after error)
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=200363
> > Tested-by: Bastien Nocera <hadess@hadess.net>
> > Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> > Cc: 4.17+ <stable@vger.kernel.org> # 4.17+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Has this gone in already?  If not, please hold on.
> 
> There is a fix on top of this that will go to Linus tomorrow:
> https://patchwork.kernel.org/patch/10548059/

Yes, it did, it is in 4.17.11, and I've already gotten a report about it :(

greg k-h
