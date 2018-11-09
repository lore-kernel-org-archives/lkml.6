Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8965FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 00:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CFC20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 00:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CFC20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeKIKVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 05:21:40 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36865 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbeKIKVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 05:21:40 -0500
Received: by mail-yw1-f65.google.com with SMTP id v77-v6so278135ywc.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 16:43:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=UNQKHq5xefsCqx24zuxQQt3uvPpFB+toPb9b/E6sOHc=;
        b=QiylTd7jvzVFosEq1LRQBMfbioKKoW9Xs1s7G82h6oIiSQhM/RzvOiRm/UlSN6qgYW
         lcRiijEkE5dbzjWUVubI+k1yKohpdNwEKIZyQ8CaLVkMzNBwR1BwEBBMKac4Xur4TxWi
         TLHMg2xcMFM/NK60lYFUm/oPMU3wIYt1eVhG8Vo4Gj8eGXMUggH/ML/C2REIMHjaqJhb
         IyuJ5CjD+2hD8RVNZkRjjhEVM24cwZFBCufQduqnTMbuLcYU4ZoSvUPJY8k8cukCruTB
         p3d+PyQdSQCk6Nv3AHsMlzTlry/swEAX7ECAO7SZcAXZ82A6yvHmTVct7GZ2zyvz4kBY
         yYEA==
X-Gm-Message-State: AGRZ1gKjykAc8BYjYHAGC15PCRJOLLX7vjL6P8bn/b0BreWcAYcLJv3S
        hf4AmzEGDNpzaAA43yi/w8mxBw==
X-Google-Smtp-Source: AJdET5ca1QApgc56jobQbQ8/7U/mRUP8FFK9i9Nl3kGUvVXUMv+NTB2MCoUf+KCkQBQwgtMTCCWYWA==
X-Received: by 2002:a37:4116:: with SMTP id o22-v6mr6190559qka.107.1541724211729;
        Thu, 08 Nov 2018 16:43:31 -0800 (PST)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id q103sm4954105qkh.64.2018.11.08.16.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 16:43:31 -0800 (PST)
Message-ID: <a0646cacfbc4ed8ded12f15d7553c60553adac34.camel@redhat.com>
Subject: Re: [RESEND PATCH v2 1/2] drm/dp/mst: Reprobe EDID for MST ports on
 resume
From:   Lyude Paul <lyude@redhat.com>
To:     "Li, Juston" <juston.li@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Cc:     "Ciobanu, Nathan D" <nathan.d.ciobanu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Taylor, Clinton A" <clinton.a.taylor@intel.com>,
        "jared_dominguez@dell.com" <jared_dominguez@dell.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "cpaul@redhat.com" <cpaul@redhat.com>
Date:   Thu, 08 Nov 2018 19:43:29 -0500
In-Reply-To: <ee20a313fb63792c05ab1b67babf1fa9431ebcf8.camel@intel.com>
References: <20181024021925.27026-1-juston.li@intel.com>
         <20181024021925.27026-2-juston.li@intel.com>
         <f9b43dde4868d3c079b652b48babde9b8bebc728.camel@redhat.com>
         <ee20a313fb63792c05ab1b67babf1fa9431ebcf8.camel@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Are you still looking into this at all? Even if it's not the right approach
I'm still interested in seeing this get fixed as well/discussing what I said
before

On Wed, 2018-10-24 at 22:45 +0000, Li, Juston wrote:
> On Wed, 2018-10-24 at 18:09 -0400, Lyude Paul wrote:
> > Since there's going to be quite a number of changes I need to make to
> > this I'm
> > just going to make the changes myself! I'll make sure to Cc you with
> > the
> > respin
> 
> Sounds good, thanks for picking it up!
> 
> Juston
> 
-- 
Cheers,
	Lyude Paul

