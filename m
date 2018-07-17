Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4083ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D27208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D27208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbeGQMaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:30:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33753 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731175AbeGQMaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:30:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id g6-v6so994027wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tyc14wxRCNCNPOBFh0CGc/GvJYimr0Gn2AUEf56nqAw=;
        b=tSso/Xx6lFKlgmBZbbM/d0vdjWApByq0xo6GCbRiOUwf7XTkuTU1StOGld/n26rwg5
         5XprThcsKntT9OK+mgVj1O07ogDmPBaLOmM3Tx7H8qHBs3gKp9Hd//esEZkbA/GLBqlz
         cl4NPx5TqOf9gEJR1sXxTf4ct9yFS9UrHxiOJI7dxEJUUp7/L4Iw1vByWw75oR8MvpDz
         MktYIA2T4bPqejSwQ0WpPLlMUAWlnxAwwhLBqEIKEEWeMuoyz0uthqI8r9yChfaSNKAM
         NohA9OvNVzLTLi2SAeyBXhkIRG8A4q8+FychAsjw/WNkMJKXWxsFSHGuj8tmn02VDZCp
         ecXQ==
X-Gm-Message-State: AOUpUlGv2HmzI9oT3FnkRhXOFoFwdDs70+85kgCYVk/mlANYM7kcA3hi
        +dsdJTvm4KI8E4H3sXOUrrs=
X-Google-Smtp-Source: AAOMgpcadw/fffgXFWoh46UWKtAnragf8fKEqOnVS6vDNdeB5AUsoMroAmPBD/aIvTX8PU/AK8vU1A==
X-Received: by 2002:adf:93a3:: with SMTP id 32-v6mr1146803wrp.140.1531828676551;
        Tue, 17 Jul 2018 04:57:56 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id o13-v6sm765058wmc.8.2018.07.17.04.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 04:57:55 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 4BD2512401C; Tue, 17 Jul 2018 13:57:55 +0200 (CEST)
Date:   Tue, 17 Jul 2018 13:57:55 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, dan.j.williams@intel.com, jack@suse.cz,
        jglisse@redhat.com, jrdr.linux@gmail.com, bhe@redhat.com,
        gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, abdhalee@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH v6 2/5] mm/sparse: use the new sparse buffer functions in
 non-vmemmap
Message-ID: <20180717115755.GC24361@techadventures.net>
References: <20180716174447.14529-1-pasha.tatashin@oracle.com>
 <20180716174447.14529-3-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716174447.14529-3-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 01:44:44PM -0400, Pavel Tatashin wrote:
> non-vmemmap sparse also allocated large contiguous chunk of memory, and if
> fails falls back to smaller allocations.  Use the same functions to
> allocate buffer as the vmemmap-sparse
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks
-- 
Oscar Salvador
SUSE L3
