Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77DAC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D50208DA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D50208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeH1D4r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:56:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:48153 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbeH1D4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:56:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 17:07:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,297,1531810800"; 
   d="scan'208";a="80697217"
Received: from kmsmsx151.gar.corp.intel.com ([172.21.73.86])
  by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2018 17:07:43 -0700
Received: from pgsmsx112.gar.corp.intel.com ([169.254.3.58]) by
 KMSMSX151.gar.corp.intel.com ([169.254.10.96]) with mapi id 14.03.0319.002;
 Tue, 28 Aug 2018 08:07:42 +0800
From:   "Huang, Kai" <kai.huang@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "npmccallum@redhat.com" <npmccallum@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        Kai Huang <kai.huang@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v13 02/13] x86/cpufeature: Add SGX and SGX_LC CPU
 features
Thread-Topic: [PATCH v13 02/13] x86/cpufeature: Add SGX and SGX_LC CPU
 features
Thread-Index: AQHUPjeYRx2wMmEsxEKLT9SJazBQeaTUSTXA
Date:   Tue, 28 Aug 2018 00:07:41 +0000
Message-ID: <105F7BF4D0229846AF094488D65A09893540B623@PGSMSX112.gar.corp.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-3-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20180827185507.17087-3-jarkko.sakkinen@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDE3N2Y3OTQtNTk1OS00NmMxLTk5OWYtOGRlMDc5N2Y0MjAzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTjlQNGRYWWJYdDRHRXljMDk4ZXJGaGV2aUJMZERSUlNDODZDRWZDN1FmcmhUUmVQY0w0V0Y4NlpjZDlQWnFuSCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.30.20.205]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define X86_FEATURE_SGX_LC		(16*32+30) /* supports SGX launch
> configuration */

Sorry if it was me who wrote the comment "SGX launch configuration". I think we should just use "SGX launch control". :)

Thanks,
-Kai
> 
>  /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
>  #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow
> recovery support */
> --
> 2.17.1

