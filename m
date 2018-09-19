Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74636C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3063020880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3063020880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbeISOos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:44:48 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:18745 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbeISOos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:44:48 -0400
X-IronPort-AV: E=Sophos;i="5.53,393,1531785600"; 
   d="scan'208";a="79268465"
Date:   Wed, 19 Sep 2018 11:05:26 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC:     George Dunlap <George.Dunlap@citrix.com>,
        Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        Jan Beulich <JBeulich@suse.com>,
        Juergen Gross <jgross@suse.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH V3 2/2] Xen/PCIback: Implement PCI
 flr/slot/bus reset with 'reset' SysFS attribute
Message-ID: <20180919090526.s3ahnemrt2ik2tx3@mac.bytemobile.com>
References: <5A2A6AB10200007800195D4F@prv-mh.provo.novell.com>
 <8a3bc517-1255-4547-d244-5c400e44cc77@Oracle.COM>
 <f19dbb09-ef22-2cf4-fb38-2a7c42b5dc48@Oracle.COM>
 <5A377E020200007800197FFA@prv-mh.provo.novell.com>
 <559ffd12-b541-8a69-60bd-fbe10e3dc159@oracle.com>
 <20180916114306.GF18222@reaktio.net>
 <a726840b-8a5c-0890-73c6-3a95a7205153@oracle.com>
 <20180918071519.GG18222@reaktio.net>
 <5E7DDB68-4E68-48A5-AEEC-EE1B21A50E9E@citrix.com>
 <352310b3-ec9b-2ceb-83f0-4550718120c3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <352310b3-ec9b-2ceb-83f0-4550718120c3@oracle.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 02:09:53PM -0400, Boris Ostrovsky wrote:
> On 9/18/18 5:32 AM, George Dunlap wrote:
> >
> >> On Sep 18, 2018, at 8:15 AM, Pasi Kärkkäinen <pasik@iki.fi> wrote:
> >>
> >> Hi,
> >>
> >> On Mon, Sep 17, 2018 at 02:06:02PM -0400, Boris Ostrovsky wrote:
> >>> What about the toolstack changes? Have they been accepted? I vaguely
> >>> recall there was a discussion about those changes but don't remember how
> >>> it ended.
> >>>
> >> I don't think toolstack/libxl patch has been applied yet either.
> >>
> >>
> >> "[PATCH V1 0/1] Xen/Tools: PCI reset using 'reset' SysFS attribute":
> >> https://lists.xen.org/archives/html/xen-devel/2017-12/msg00664.html
> >>
> >> "[PATCH V1 1/1] Xen/libxl: Perform PCI reset using 'reset' SysFS attribute":
> >> https://lists.xen.org/archives/html/xen-devel/2017-12/msg00663.html
> 
> 
> Will this patch work for *BSD? Roger?

At least FreeBSD don't support pci-passthrough, so none of this works
ATM. There's no sysfs on BSD, so much of what's in libxl_pci.c will
have to be moved to libxl_linux.c when BSD support is added.

Thanks, Roger.
