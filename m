Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9758C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB5E223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RwkjR1eb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB5E223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbeKNCUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:20:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44988 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbeKNCUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:20:42 -0500
Received: by mail-pf1-f194.google.com with SMTP id b81-v6so5801604pfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 08:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6JsbnoU4Aw76pDPxU5YxMsvwhrQ8iPsdY1+qhxQ6Ppc=;
        b=RwkjR1ebP9hB1Haw7oDY11DkD20eLNDpntQH7nibk6BDY2iosxIutC9BPC/zDXgwH/
         iluuy4xjTOZlaOnQbSb/SXW1mPQC3FdmwYvKKI5u/YqGOr+8EEDGIl1rcKt9xFIdS2th
         zd3qLcYY55b4JNJTf+IPtA4TJlaUPTpGB/6PAnx0sqLo+iLtgZ9YVmXzVi21r562XI+u
         WhTE184Z56ECzu9yYm+DxMNhy6R/W1mK+3lV3lBmzDqQtIlS7XZT7ot58K8wgkJqHv7K
         KWvbcWPduu1Yv+6UKxYK1nirKKj3U1qh3oeWfMK5O/k3g1XRzKuVEwBdimqc2QFWeuhY
         9teQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6JsbnoU4Aw76pDPxU5YxMsvwhrQ8iPsdY1+qhxQ6Ppc=;
        b=D1QQ6pi2LWFbUc2hzpXUs/6hl/04TMHcDdLwa89tXtkjahMIosy7gV1ZIU02DDIyzO
         yDC8sXTkPk/bEYqCV84khjb60YULbcz/1iBRHPgddryXgOIQs4L63bAqQOfmPhQuVPhT
         iU2pwAQvzaBAY3r3IOKTalY+SvptKicQUroIXlxnbkaldoeoPTk3QKN8+uiRmBGzt7EZ
         hKbLYL+QuoNsWnZJpPgh60+MEU+jDqF98TOaoAPN0A4/IdXNX0M7IAxrGylS1miyna2X
         OI124d91kEhGcX+AeybGERY3UzBjUbHWcrCFCIh0dmo/DIDu7Twy32sEYK0+iiGT74B7
         31Hw==
X-Gm-Message-State: AGRZ1gI/6xL+qKdhA5wFzH0F9169rzkjniZtJSrmi4KRyNnBRnABgh/O
        3c9eO3Gm8uatvcoZVD2mwDFCBQ==
X-Google-Smtp-Source: AJdET5cPSI4YfELk34E08geLd5S+Kz6az5caZanjoPgldhqXMfiK+npjKHu54+bYsl0NSpvbRSjabw==
X-Received: by 2002:a63:1a4b:: with SMTP id a11mr5352918pgm.254.1542126114194;
        Tue, 13 Nov 2018 08:21:54 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.gmail.com with ESMTPSA id o86-v6sm25032013pfk.8.2018.11.13.08.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 08:21:53 -0800 (PST)
Date:   Tue, 13 Nov 2018 11:21:48 -0500
From:   Barret Rhoden <brho@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, yu.c.zhang@intel.com, yi.z.zhang@intel.com
Subject: Re: [PATCH 2/2] kvm: Use huge pages for DAX-backed files
Message-ID: <20181113112148.6205fc56@gnomeregan.cam.corp.google.com>
In-Reply-To: <861c4adb-e2f0-2caf-8f6e-9f09ecb0b624@redhat.com>
References: <20181109203921.178363-1-brho@google.com>
        <20181109203921.178363-3-brho@google.com>
        <861c4adb-e2f0-2caf-8f6e-9f09ecb0b624@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-12 at 20:31 Paolo Bonzini <pbonzini@redhat.com> wrote:
> Looks good.  What's the plan for removing PageReserved from DAX pages?

I hear that's going on in this thread:

https://lore.kernel.org/lkml/154145268025.30046.11742652345962594283.stgit@ahduyck-desk1.jf.intel.com/

Though it looks like it's speeding up page initialization, and not
explicitly making the PageReserved change, yet.

Alternatively, I could change kvm_is_reserved_pfn() to single out
zone_device pages if we don't want to wait or if there is a concern
that it won't happen.

On a related note, there are two places in KVM where we check
PageReserved outside of kvm_is_reserved_pfn().

For reference:

bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
{
        if (pfn_valid(pfn))
                return PageReserved(pfn_to_page(pfn));

        return true;
}

One caller of PageReserved():

void kvm_set_pfn_dirty(kvm_pfn_t pfn)
{
        if (!kvm_is_reserved_pfn(pfn)) {
                struct page *page = pfn_to_page(pfn);

                if (!PageReserved(page))
                        SetPageDirty(page);
        }
}

In that one, the PageReserved() check looks redundant, since if the
page was PageReserved, then it would have been kvm_is_reserved.

The other is:

static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
{
        if (pfn_valid(pfn))
                return !is_zero_pfn(pfn) && PageReserved(pfn_to_page(pfn)) &&
                        /*
                         * Some reserved pages, such as those from NVDIMM
                         * DAX devices, are not for MMIO, and can be mapped
                         * with cached memory type for better performance.
                         * However, the above check misconceives those pages
                         * as MMIO, and results in KVM mapping them with UC
                         * memory type, which would hurt the performance.
                         * Therefore, we check the host memory type in addition
                         * and only treat UC/UC-/WC pages as MMIO.
                         */
                        (!pat_enabled() || pat_pfn_immune_to_uc_mtrr(pfn));

        return true;
}

Where the PAT stuff was motivated by DAX.  The PageReserved check here
looks like a broken-out version of kvm_is_reserved_pfn(), so that we can
make some extra checks around it.

Anyway, I can get rid of those two PageReserved checks and/or have
kvm_is_reserved_pfn() just check DAX pages, if everyone is OK with that.

Thanks,

Barret

