Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7245ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4CD2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="qrzTrxFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4CD2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbeJaTeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:34:03 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37106 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbeJaTeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:34:02 -0400
Received: by mail-yw1-f67.google.com with SMTP id v77-v6so6227952ywc.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 03:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E4hlYcAfrnMiHB/q+G9qBdD3RdnyOP28Cp+SSPnWYcQ=;
        b=qrzTrxFKQ4A25+TG3O0IzG6S9jGRb8qS4JS3Mo6M67hfoQi3fyxYdYnuQnzSUY0S+k
         95aw0NeB4eSXzzPhhl39dGWblCc92JUPFq7+Fl82N4fmwSWKdgQhFKQDu2xPhcSEa+Yy
         nKLDWWwylKTl7JZljLSPwlKPhM946kyorUHkgV/RyPNSUGInuGvM6ifW4tc+xg20YZxZ
         95mSzw8BRMj4c2HF8sJnVj5OeVGGw9rxpYpD8bWdCyZr8pOyeGTNOXuv4/ts8ILEOmgj
         Jl1D04dAQG1xcLA6jLkKSZXjMHOGzq4SrVXROsCgf2jlChLGOwIZ9P3qgeYYD2cWt88F
         qOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E4hlYcAfrnMiHB/q+G9qBdD3RdnyOP28Cp+SSPnWYcQ=;
        b=ntWUV2TtScNuFODc2iaJsuNP+BEm19svKgOkXXW+z5JWSCahPPYbKF6ZQZaMnVaLJ1
         oWQoX8a/88xZGtPeMLWfEJ/KQTkK8BHxVGVUIb1OGeMK4EWDX0CJrWijvke4TVgh80wK
         PVIbn8pElP2TxX/CEv7QkAeX8SK6yxZXH3w67Gijaxti/Az9fi5npphBGWeZo/HlSphe
         hRwQBGCHnD0DWSQaLl/xhxKIIugfWs++x8rxNrkwuQCVz8UPL5RRTCtcrB1sgvJcPalI
         TxKiD/4Co4joPGxKTN+heFIMGcQINMw+tX8d34Q2I7xctEfT9wiir10hbUFsn1+Qi9sM
         g3rQ==
X-Gm-Message-State: AGRZ1gKybhGrSIVfX/ViAJex62CPZySl2mQw5cruN49Tj3T1LTadL29v
        /WHcSOmx3neTCRmnVMvkYu/+Kw==
X-Google-Smtp-Source: AJdET5eEsHGkyJNS0/DctrV+2k0x0qmRzF5xO6PU6Z+fMf05zHkReXHBPLZPLJ+QGHq/D1e7dqVx0g==
X-Received: by 2002:a81:a243:: with SMTP id z64-v6mr2261954ywg.42.1540982189233;
        Wed, 31 Oct 2018 03:36:29 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id t65-v6sm6083506ywa.99.2018.10.31.03.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 03:36:28 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 74840301604; Wed, 31 Oct 2018 13:36:23 +0300 (+03)
Date:   Wed, 31 Oct 2018 13:36:23 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Li Wang <liwang@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 3/3] s390/mm: fix mis-accounting of pgtable_bytes
Message-ID: <20181031103623.6ykzsjdenrpeth7x@kshutemo-mobl1>
References: <1539621759-5967-1-git-send-email-schwidefsky@de.ibm.com>
 <1539621759-5967-4-git-send-email-schwidefsky@de.ibm.com>
 <CAEemH2cHNFsiDqPF32K6TNn-XoXCRT0wP4ccAeah4bKHt=FKFA@mail.gmail.com>
 <20181031073149.55ddc085@mschwideX1>
 <20181031100944.GA3546@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031100944.GA3546@osiris>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 11:09:44AM +0100, Heiko Carstens wrote:
> On Wed, Oct 31, 2018 at 07:31:49AM +0100, Martin Schwidefsky wrote:
> > Thanks for testing. Unfortunately Heiko reported another issue yesterday
> > with the patch applied. This time the other way around:
> > 
> > BUG: non-zero pgtables_bytes on freeing mm: -16384
> > 
> > I am trying to understand how this can happen. For now I would like to
> > keep the patch on hold in case they need another change.
> 
> FWIW, Kirill: is there a reason why this "BUG:" output is done with
> pr_alert() and not with VM_BUG_ON() or one of the WARN*() variants?
> 
> That would to get more information with DEBUG_VM and / or
> panic_on_warn=1 set. At least for automated testing it would be nice
> to have such triggers.

Stack trace is not helpful there. It will always show the exit path which
is useless.

-- 
 Kirill A. Shutemov
