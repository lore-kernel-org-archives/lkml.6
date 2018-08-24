Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BC2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1942098B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FSRYwW+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1942098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeHXUoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 16:44:14 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:43540 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeHXUoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 16:44:14 -0400
Received: by mail-lf1-f52.google.com with SMTP id h64-v6so5704117lfi.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 10:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yUfcJ+Bqgppto5dxuzgmtd0d+gtbEj/nBoLQWXosG64=;
        b=FSRYwW+v79avpYXl9bxcVdIdJ7ylHe/oEcwX43B+4aogYNljzjxDsuvUaWSdn8JBST
         6V5PFuDXlckrmeFdZn+HKMpm+yyU4peAT8t4gfj06hCAJ09HVPngmB1RQWdDZOUDhlPp
         iEbgAEAIKt373ujBGA+FGm7EjgjNBY0AM8EkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yUfcJ+Bqgppto5dxuzgmtd0d+gtbEj/nBoLQWXosG64=;
        b=O34KSXeN2qjSsTfrm40dTc70pxXXYrKw+cs1anoloNZY7UlNzFs9Eaq27G2hurHK12
         JOLsSE3Nd/FqJtCAkeCIF/Vw/1f8nULDhJzeDCaQjYqwElQN0y5tux+UVZr5G3G79l59
         aJNr0KHNq9RfKBwnv0XKyes5CfwPT/diySAighFZv7KqfSLLh1TRTb/tP8zNe+H9xyCu
         PDY67N5Mfs1fOkmBJ1Kjz02f9aYPYpETbNlhoa7lXWNkX4xXjj5mZMXJsFx0dKkGJA2B
         be9kwdsDDeV8PH1tyc5JM1HMMyhL1LQWQ9m+0sf1CGUKitCNid8GkMvMyiaQeEyXlvCV
         hX9g==
X-Gm-Message-State: APzg51DkPh8nllulQHEjIbwZ+qcEQaT/sSjlzPcyZiYCYX4mbm6VL8Yz
        zlDWgGj1r8OU3f8mgAUezVwL9vS/geHkSJpWCBqzyw==
X-Google-Smtp-Source: ANB0VdY5dYQipRyS9a6jI/iYawhRUsS8EG/89h9NtsqdMGOMr6WEIcaiRgf+n903zB377rPTuPXNwGDzHGUhqjImqKY=
X-Received: by 2002:a19:2a91:: with SMTP id q17-v6mr1983244lfq.74.1535130521525;
 Fri, 24 Aug 2018 10:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20171215092305.994559179@linuxfoundation.org> <20171215092311.347628971@linuxfoundation.org>
 <CAL1RGDVgShymmT+TJ3mAHEL7n+qoisk6mQ=Tji_T=0d_QA=VKw@mail.gmail.com> <1535129126.2902.36.camel@codethink.co.uk>
In-Reply-To: <1535129126.2902.36.camel@codethink.co.uk>
From:   Roland Dreier <roland@purestorage.com>
Date:   Fri, 24 Aug 2018 10:08:28 -0700
Message-ID: <CAL1RGDW1Lo+F5D479Jsi-AFsmjVpdDre_qOFSCwWubG6U=bxeQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 103/105] Revert "x86/mm/pat: Ensure cpa->pfn only
 contains page frame numbers"
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        matt@codeblueprint.co.uk, bp@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, luto@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, bp@alien8.de,
        brgerst@gmail.com, davej@codemonkey.org.uk, dvlasenk@redhat.com,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        sai.praneeth.prakhya@intel.com, sds@tycho.nsa.gov,
        Thomas Gleixner <tglx@linutronix.de>, toshi.kani@hp.com,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Yazen.Ghannam@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> See
> <https://lore.kernel.org/lkml/1512686629.18523.217.camel@codethink.co.uk/T/#u>.

Thanks!  I'm not using SGI UV and I'm not using kexec, so I guess I
sidestepped most of those issues.  Greg, I think we need to unrevert
the cpa->pfn change (otherwise the L1TF fix probably gets pretty
messy) and I guess pull in the other patches that Ben mentions.

 - R.
