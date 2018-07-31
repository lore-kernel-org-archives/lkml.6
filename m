Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB682C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E73520841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="qVcB7KuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E73520841
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732344AbeGaRQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:16:38 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:15323 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732013AbeGaRQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1533051345; x=1564587345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=oKbNj1laCpDLl15UaVPZTbHUxJnIvZ0fNVLkzetsCgE=;
  b=qVcB7KuBrrT43akx+9h6G09i9bFVQDJvSlgXauDZDgVhc6wT5HDA9o/x
   rH3t7GwcbVZnMdKHdURxX8Z2dnxZjYbYnQcT0GysLyWCa1oInSnKcm4fZ
   ZkOyXIcwYzv1vpaEfjjUXq4Kbxi9tVcCFhec2jxfUzWNH2OVYC5GVmmeN
   Y=;
X-IronPort-AV: E=Sophos;i="5.51,427,1526342400"; 
   d="scan'208";a="747197929"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jul 2018 15:32:27 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w6VFVFGI058010
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 31 Jul 2018 15:31:17 GMT
Received: from EX13D02EUC004.ant.amazon.com (10.43.164.117) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 31 Jul 2018 15:31:08 +0000
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
 EX13D02EUC004.ant.amazon.com (10.43.164.117) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 31 Jul 2018 15:31:07 +0000
Received: from EX13D02EUC001.ant.amazon.com ([10.43.164.92]) by
 EX13D02EUC001.ant.amazon.com ([10.43.164.92]) with mapi id 15.00.1367.000;
 Tue, 31 Jul 2018 15:31:07 +0000
From:   "Sironi, Filippo" <sironi@amazon.de>
To:     Borislav Petkov <bp@alien8.de>
CC:     Prarit Bhargava <prarit@redhat.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] arch/x86: Fix boot_cpu_data.microcode version output
Thread-Topic: [PATCH v2] arch/x86: Fix boot_cpu_data.microcode version output
Thread-Index: AQHUKMGCfQ0leZsXW0Wf4Hxme8bAMKSpNqAAgAAUp4CAACo0AA==
Date:   Tue, 31 Jul 2018 15:31:07 +0000
Message-ID: <8DCDB4EE-A8DC-4368-88C6-D70F8F98170E@amazon.de>
References: <20180601121939.GA23298@nazgul.tnic>
 <20180731112739.32338-1-prarit@redhat.com>
 <65549531-EA3A-49ED-BECA-D5F85B9F09E4@amazon.de>
 <20180731130003.GA22814@nazgul.tnic>
In-Reply-To: <20180731130003.GA22814@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.207]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <83529D250EC673408482B5DF981A84AC@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 31. Jul 2018, at 15:00, Borislav Petkov <bp@alien8.de> wrote:
> =

> On Tue, Jul 31, 2018 at 11:46:09AM +0000, Sironi, Filippo wrote:
>> There may be a chance of skipping this code, I think.
>> =

>> If the microcode is loaded on the hyperthread sibling of the boot cpu
>> before being loaded on the boot cpu, the boot cpu will exit earlier
>> from apply_microcode_intel() - in if (rev >=3D mc->hdr.rev) { ... }.
>> =

>> (This seems to be possible in apply_microcode_amd() as well.)
>> =

>> In my tree with the aforementioned change - Intel only - I also had
>> the following patch:
> =

> Yap, good catch.
> =

> -- =

> Regards/Gruss,
>    Boris.
> =

> ECO tip #101: Trim your mails when you reply.
> --
> =


Boris, Prarit,

I've sent the patch the I had in my tree and extended it to cover
apply_microcode_amd(). I don't have an AMD host available for testing,
can one of you give that a spin?

Thanks,
Filippo


Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

