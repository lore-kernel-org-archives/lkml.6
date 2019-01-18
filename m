Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7DAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0002086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PYfEWPpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfARQJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:09:37 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43014 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfARQJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:09:37 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0IG9VY1116565;
        Fri, 18 Jan 2019 10:09:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547827771;
        bh=kdnsi1vWOwdZ5miOnYpGyxAuJdw0eHG3tnXCtnQUav4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PYfEWPpI6QILU7Q/S2BT6f965xY1ZaazR3eKw+RsALGenel5iMpW9IWC0ew5wbO+6
         oQl1JNCzSTWF/Y38zj2qzBk+rWc4n7DW+aEmII1S5K5HxeyzDaEtFL4D6yNUaWBRwK
         K+Sha7PFFz62qjFIbglLqwG09JIb8kBxAn+uuVdc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0IG9VGW091978
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jan 2019 10:09:31 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 18
 Jan 2019 10:09:30 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 18 Jan 2019 10:09:30 -0600
Received: from [172.22.101.212] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0IG9U1P008823;
        Fri, 18 Jan 2019 10:09:30 -0600
Subject: Re: [PATCH 12/14] staging: android: ion: Declare helpers for carveout
 and chunk heaps
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20190111180523.27862-1-afd@ti.com>
 <20190111180523.27862-13-afd@ti.com> <20190118095909.GB28982@kroah.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <f06330ff-6319-3d80-fd70-654cf6681144@ti.com>
Date:   Fri, 18 Jan 2019 10:09:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190118095909.GB28982@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 3:59 AM, Greg Kroah-Hartman wrote:
> On Fri, Jan 11, 2019 at 12:05:21PM -0600, Andrew F. Davis wrote:
>> When enabled the helpers functions for creating carveout and chunk heaps
>> should have declarations in the ION header.
> 
> Why?  No one calls these from what I can tell.
> 
> Which makes me believe we should just delete the
> drivers/staging/android/ion/ion_carveout_heap.c and
> drivers/staging/android/ion/ion_chunk_heap.c files as there are no
> in-tree users?
> 
> Any objection to me doing that?
> 

I use those when creating carveout heaps. My exporter is out of tree
still as it uses DT and the proper bindings have not been agreed upon
yet. These helpers also make good heap creation references, even if not
called by anyone in-tree right now.

Thanks,
Andrew

> thanks,
> 
> greg k-h
> 
