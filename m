Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1304C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1D120833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vojrzXJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1D120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeIOANt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 20:13:49 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:38012 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeIOANt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 20:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1536951482; x=1568487482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sA8qKkq54TsdfgA4cGgc3yjc0A30VSYglWhEoOYxjrk=;
  b=vojrzXJG2eGSo6dNND3BdMv052Rtmz8G154ti/Xt+LHIEleogZtdYYBJ
   lpRqifNLzai653PZqMGyx5yhMUGTrLl8e6tfjx7V+nyxIScZkRdW9yDhg
   lSufJ6YRaNduOsru+gJwlsNvcS5t3nmw7bQEXlgoOIHEOhew3NRei5NOy
   g=;
X-IronPort-AV: E=Sophos;i="5.53,374,1531785600"; 
   d="scan'208";a="357207084"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2018 18:58:00 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w8EIvvVs100430
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 14 Sep 2018 18:57:59 GMT
Received: from EX13D05UWB004.ant.amazon.com (10.43.161.208) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 14 Sep 2018 18:57:53 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D05UWB004.ant.amazon.com (10.43.161.208) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 14 Sep 2018 18:57:53 +0000
Received: from localhost (10.85.19.144) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 14 Sep 2018 18:57:53 +0000
Date:   Fri, 14 Sep 2018 11:57:53 -0700
From:   Eduardo Valentin <eduval@amazon.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Eduardo Valentin <eduval@amazon.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 4.14 103/115] x86/xen: dont write ptes directly in 32-bit
 PV guests
Message-ID: <20180914185753.GB9084@u40b0340c692b58f6553c.ant.amazon.com>
References: <20180913131823.327472833@linuxfoundation.org>
 <20180913131829.701763608@linuxfoundation.org>
 <20180914171222.GA30580@u40b0340c692b58f6553c.ant.amazon.com>
 <20180914181927.GA20957@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180914181927.GA20957@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 08:19:27PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 14, 2018 at 10:12:22AM -0700, Eduardo Valentin wrote:
> > Hello,
> > 
> > On Thu, Sep 13, 2018 at 03:32:03PM +0200, Greg Kroah-Hartman wrote:
> > > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Juergen Gross <jgross@suse.com>
> > > 
> > > commit f7c90c2aa4004808dff777ba6ae2c7294dd06851 upstream.
> > > 
> > > In some cases 32-bit PAE PV guests still write PTEs directly instead of
> > > using hypercalls. This is especially bad when clearing a PTE as this is
> > > done via 32-bit writes which will produce intermediate L1TF attackable
> > > PTEs.
> > > 
> > > Change the code to use hypercalls instead.
> > > 
> > 
> > Good that we got this in. Should we also take this one:
> > b2d7a075a1cc ("x86/pae: use 64 bit atomic xchg function in native_ptep_get_and_clear")
> > 
> > Which is under the line of the same issue?
> 
> It's also in this patch series, the very next one in fact :)

Cool! Missed that. Sorry for the noise.

Thanks for including the patches!

> 
> thanks,
> 
> greg k-h
> 

-- 
All the best,
Eduardo Valentin
