Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A548CC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4402120851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4402120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ze-it.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbeLLWx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:53:56 -0500
Received: from vie01a-dmta-pe05-2.mx.upcmail.net ([84.116.36.12]:46389 "EHLO
        vie01a-dmta-pe05-2.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726253AbeLLWxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:53:55 -0500
Received: from [172.31.216.234] (helo=vie01a-pemc-psmtp-pe11.mail.upcmail.net)
        by vie01a-dmta-pe05.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <thomas.zeitlhofer@ze-it.at>)
        id 1gXDO4-0005nH-Rh
        for linux-kernel@vger.kernel.org; Wed, 12 Dec 2018 23:53:52 +0100
Received: from localhost.localdomain ([80.108.25.171])
        by vie01a-pemc-psmtp-pe11.mail.upcmail.net with ESMTP
        id XDO4gRILm5WeQXDO4gdQ7n; Wed, 12 Dec 2018 23:53:52 +0100
X-Env-Mailfrom: thomas.zeitlhofer@ze-it.at
X-Env-Rcptto: linux-kernel@vger.kernel.org
X-SourceIP: 80.108.25.171
X-CNFS-Analysis: v=2.3 cv=YaJsGDZf c=1 sm=1 tr=0
 a=cw3iLm2b3cPoAt0NIr38/g==:117 a=cw3iLm2b3cPoAt0NIr38/g==:17
 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8 a=RvV4eICekhzAAghNzbEA:9 a=CjuIK1q_8ugA:10
Date:   Wed, 12 Dec 2018 23:53:34 +0100
From:   Thomas Zeitlhofer <thomas.zeitlhofer@ze-it.at>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH 4.19 014/110] usb: xhci: Prevent bus suspend if a port
 connect change or polling state is detected
Message-ID: <20181212225334.GA2651@x1>
References: <20181129135921.231283053@linuxfoundation.org>
 <20181129135921.817957465@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129135921.817957465@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Envelope: MS4wfDiElrT7biCsVgaJuiDAbQVEz6WFUbgUZDFJFEoqTRB76V/T9c4+d0ldTaaRmCpEh6mh/PwaZeGEVam8kiezxq4n1512bgGQEtYVNIW50/mtW5rof/5t
 v3eg+rLwY/K/0PQSwI1eiEU5mnEKE0fvdv0q/gVwSPWrgRgZvhaLk1YytCdn9u6PBMXwBaDlMCgwcMlTChmOkjUpakT6pyt5RVAkzCqQ/0XOaQI1Ofkdh+EN
 HC+zab3Bly5OMu0SEsJOaiN3N3ajr+UwxP3kQF8+yc1QwPC1SRcfrhjkoOWO53JT9X6RcBqo+MsUON23a3itfQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Nov 29, 2018 at 03:11:45PM +0100, Greg Kroah-Hartman wrote:
> 4.19-stable review patch.  If anyone has any objections, please let me
> know.
> 
> ------------------
> 
> From: Mathias Nyman <mathias.nyman@linux.intel.com>
> 
> commit 2f31a67f01a8beb22cae754c53522cb61a005750 upstream.
[...]

on a current Thinkpad X1 Yoga, this breaks resume from hibernate such
that opening the lid has (in the regular use case, see below) no effect
any more: 

The system is configured to hibernate when the lid is closed. So, the
expected behavior, which is restored by reverting this patch, is:

	close lid => system hibernates
	open lid => system resumes

With this patch, the following two cases are observed:

	1)
		close lid => system hibernates
		open lid => system stays off
		press power button => system boots and resumes

	2)
		# systemctl hibernate => system hibernates
		close lid 
		open lid => system resumes

Regards,

Thomas
