Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0668EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DE2208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="nKTfWDW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DE2208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732108AbeGaN3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:29:54 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:16827 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732033AbeGaN3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1533037795; x=1564573795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=c+LIl6io1CTPZWH7XOj06thMQsJp9NMTTWjzYoOL2D8=;
  b=nKTfWDW66jn3AgMTsFCGzwxrdLCd3bv/xZemFrXFfAFwmhd55jjd0+Kw
   eiLoEUkDBBI6kffpjxHXZHb52R/gxpXREdkIv6gO9P1UKnxRjmpxQFS+X
   TkYDy9Sr2z5BqvyMwzTgzBLHmboOSqQ8u3xpiZbzJ/zmOusTaulYIkDk6
   0=;
X-IronPort-AV: E=Sophos;i="5.51,427,1526342400"; 
   d="scan'208";a="752356954"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jul 2018 11:46:45 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w6VBkBCR058941
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 31 Jul 2018 11:46:12 GMT
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 31 Jul 2018 11:46:12 +0000
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
 EX13D02EUC001.ant.amazon.com (10.43.164.92) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 31 Jul 2018 11:46:09 +0000
Received: from EX13D02EUC001.ant.amazon.com ([10.43.164.92]) by
 EX13D02EUC001.ant.amazon.com ([10.43.164.92]) with mapi id 15.00.1367.000;
 Tue, 31 Jul 2018 11:46:09 +0000
From:   "Sironi, Filippo" <sironi@amazon.de>
To:     Prarit Bhargava <prarit@redhat.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] arch/x86: Fix boot_cpu_data.microcode version output
Thread-Topic: [PATCH v2] arch/x86: Fix boot_cpu_data.microcode version output
Thread-Index: AQHUKMGCfQ0leZsXW0Wf4Hxme8bAMKSpNqAA
Date:   Tue, 31 Jul 2018 11:46:09 +0000
Message-ID: <65549531-EA3A-49ED-BECA-D5F85B9F09E4@amazon.de>
References: <20180601121939.GA23298@nazgul.tnic>
 <20180731112739.32338-1-prarit@redhat.com>
In-Reply-To: <20180731112739.32338-1-prarit@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.207]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BAFB089D346FA3409B0B21DA069913FF@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 31. Jul 2018, at 13:27, Prarit Bhargava <prarit@redhat.com> wrote:
> =

> I tested this on AMD Ryzen & Intel Broadwell system and dumped the
> boot_cpu_data before and after a microcode update.  On the Intel
> system I also did a fatal MCE using mce-inject to confirm the output
> from the mce handling code.
> =

> P.
> =

> ---8<---
> =

> On systems where a runtime microcode update has occurred the microcode
> version output in a MCE log record is wrong because
> boot_cpu_data.microcode is not updated during runtime.
> =

> Update boot_cpu_data.microcode when the BSP's microcode is updated.
> =

> Fixes: fa94d0c6e0f3 ("x86/MCE: Save microcode revision in machine check r=
ecords")
> Suggested-by: Borislav Petkov <bp@alien8.com>
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: stable@vger.kernel.org
> Cc: sironi@amazon.de
> Cc: tony.luck@intel.com
> ---
> Changes in v2: Use mc_amd->hdr.patch_id on AMD
> =

> arch/x86/kernel/cpu/microcode/amd.c   | 4 ++++
> arch/x86/kernel/cpu/microcode/intel.c | 4 ++++
> 2 files changed, 8 insertions(+)
> =

> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/mi=
crocode/amd.c
> index 0624957aa068..63b072377ba4 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -537,6 +537,10 @@ static enum ucode_state apply_microcode_amd(int cpu)
> 	uci->cpu_sig.rev =3D mc_amd->hdr.patch_id;
> 	c->microcode =3D mc_amd->hdr.patch_id;
> =

> +	/* Update boot_cpu_data's revision too, if we're on the BSP: */
> +	if (c->cpu_index =3D=3D boot_cpu_data.cpu_index)
> +		boot_cpu_data.microcode =3D  mc_amd->hdr.patch_id;
> +
> 	return UCODE_UPDATED;
> }
> =

> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/=
microcode/intel.c
> index 97ccf4c3b45b..256d336cbc04 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -851,6 +851,10 @@ static enum ucode_state apply_microcode_intel(int cp=
u)
> 	uci->cpu_sig.rev =3D rev;
> 	c->microcode =3D rev;
> =

> +	/* Update boot_cpu_data's revision too, if we're on the BSP: */
> +	if (c->cpu_index =3D=3D boot_cpu_data.cpu_index)
> +		boot_cpu_data.microcode =3D rev;
> +
> 	return UCODE_UPDATED;
> }

There may be a chance of skipping this code, I think.

If the microcode is loaded on the hyperthread sibling of the boot cpu
before being loaded on the boot cpu, the boot cpu will exit earlier
from apply_microcode_intel() - in if (rev >=3D mc->hdr.rev) { ... }.

(This seems to be possible in apply_microcode_amd() as well.)

In my tree with the aforementioned change - Intel only - I also had
the following patch:

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/mi=
crocode/intel.c
index 97ccf4c3b45b..4bc869e829eb 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -797,6 +797,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
        struct microcode_intel *mc;
        static int prev_rev;
        u32 rev;
+       enum ucode_state ret;
 =

        /* We should bind the task to the CPU */
        if (WARN_ON(raw_smp_processor_id() !=3D cpu))
@@ -817,9 +818,8 @@ static enum ucode_state apply_microcode_intel(int cpu)
         */
        rev =3D intel_get_microcode_revision();
        if (rev >=3D mc->hdr.rev) {
-               uci->cpu_sig.rev =3D rev;
-               c->microcode =3D rev;
-               return UCODE_OK;
+               ret =3D UCODE_OK;
+               goto out;
        }
 =

        /*
@@ -848,10 +848,12 @@ static enum ucode_state apply_microcode_intel(int cpu)
                prev_rev =3D rev;
        }
 =

+       ret =3D UCODE_UPDATED;
+out:
        uci->cpu_sig.rev =3D rev;
        c->microcode =3D rev;
 =

-       return UCODE_UPDATED;
+       return ret;
 }
 =

 static enum ucode_state generic_load_microcode(int cpu, void *data, size_t=
 size,

which prevents the issue.

> -- =

> 2.17.0
> =

> =


Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

