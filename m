Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E13EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47179214F1
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OKJExGFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47179214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387979AbeKNBzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:55:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34261 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387693AbeKNBzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:55:15 -0500
Received: by mail-pg1-f196.google.com with SMTP id 17so5624818pgg.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 07:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZwdiLk1Ogd6EQgRPw19evHZbWF2zlePnZN3SSzewlw=;
        b=OKJExGFXW20zeFSihqjTfXrcHXioDgZ7gQO8TGtlkPJDJn0CiO2TSPudUVYgcA8SZU
         vQzeSL3kdtAMVrRiJpPCE+r8LJ4Yt5oTXZh5DftAD6grgpMG8ecw2+7rf57uZnhFVD9v
         WDwg4EyWKAOTmIQ1sjioCofG+BSQCBfO2/ZP9kuwgJCfwKMEGYaupAYS9Ja1HPqqQSG/
         qYHs2IEa5AEJ2KhEUnhyoHlN9sFui5OcK2evWJ8Dbie6eBPfDrye5YNpDXBwna7zvuBU
         Clqvl+9kx8UJJPV0UAuBnhnuDNrJ6ymwU0xYk65y7cycyMW0WCh+P65zMv4mGlXFf1MV
         YE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZwdiLk1Ogd6EQgRPw19evHZbWF2zlePnZN3SSzewlw=;
        b=AyfTNQKZPkYFM74Zwj49Fk0HiW4b8AbIpSPyFo+OoS8NfAy9ex0kCDhIeAcp9KOsaO
         /UsJXMY7aQJzMdj3ib8IsQ/c/npcAV1XAEi5wLHNDhFlUPbebINB+dsN4snWtN9ntaLy
         8t15isI3BCdS8pDBOXuZ5DclK/pdXqMIU6Wrc3xbU0oiI/pFW5layGQuZ1jPaNpmGrZk
         +pyhGP/WDnmWtfWzEIzCP8oizTQKmMFil75GQAj+PRlvs/T+BdUJAyPljoie22d7vr/I
         jzWdDVs5SJxDP2u6SOV68w8yDiEUwBhgIQm5XjdRR77mUQh1dbpyeBNaOTmnc6lV6XT9
         Clcw==
X-Gm-Message-State: AGRZ1gIsFfFmfHxnRJh5/TWHOiQAXMBpTb2SREu767ZRVW18Yj576XU5
        GmP1D4W5f70kLXksCDTu8kAmpg==
X-Google-Smtp-Source: AJdET5dQ+Ethvyd1I0gnTW6ZrlL6zU+zL9N1nu7xS5hQjIbJaOM4tl3gPUOsU5MA2X+OKOWz27yPeg==
X-Received: by 2002:a62:7d10:: with SMTP id y16-v6mr5619214pfc.245.1542124593435;
        Tue, 13 Nov 2018 07:56:33 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.gmail.com with ESMTPSA id d8-v6sm23918471pfj.106.2018.11.13.07.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 07:56:32 -0800 (PST)
Date:   Tue, 13 Nov 2018 10:56:28 -0500
From:   Barret Rhoden <brho@google.com>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, yu c zhang <yu.c.zhang@intel.com>,
        yi z zhang <yi.z.zhang@intel.com>
Subject: Re: [PATCH 2/2] kvm: Use huge pages for DAX-backed files
Message-ID: <20181113105628.37449f52@gnomeregan.cam.corp.google.com>
In-Reply-To: <286665658.33247363.1542103353780.JavaMail.zimbra@redhat.com>
References: <20181109203921.178363-1-brho@google.com>
        <20181109203921.178363-3-brho@google.com>
        <043a592d-6592-3053-15a0-68cc54a26deb@redhat.com>
        <286665658.33247363.1542103353780.JavaMail.zimbra@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-13 at 05:02 Pankaj Gupta <pagupta@redhat.com> wrote:
> As this patch is dependent on PageReserved patch(which is in progress), just 
> wondering if we are able to test the code path for hugepage with DAX.

For testing, I used the following patch.  It's not 100%, since it
intercepts at kvm_is_reserved_pfn(), and not PageReserved() directly.
The only difference is with kvm_set_pfn_dirty() I think.

I also have a nasty module that would dump the EPT's and the host page
table's mappings so I could confirm that the huge pages are being mapped
correctly.

-----------------------
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2679e476b6c3..1b394a0752a0 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -148,6 +148,10 @@ __weak int kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
 
 bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
 {
+	// XXX hack
+	if (is_zone_device_page(pfn_to_page(pfn)))
+		return false;
+
 	if (pfn_valid(pfn))
 		return PageReserved(pfn_to_page(pfn));
 
-----------------------

Thanks,

Barret

