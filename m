Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770FBC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394F32436C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394F32436C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeGBOEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:04:44 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33794 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbeGBOEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:04:43 -0400
Received: by mail-wr0-f194.google.com with SMTP id a12-v6so15702073wro.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=917w/9gKbd1HWE1ie0Oaeh8MPaLpujVElp2JokhZBQY=;
        b=BGsAJQ9T8s2ZrMcIgsosGnbO4b85+4VC2osifHmuNyT2ZGMlOHNW35SUXSkxrmQCWg
         SEzCx1SqYPew4Vxep93TSvKpvqhtWfEjLiXUpSdCp8YHlEDiUavvSCKCS1/i+gMudx+R
         gKzdaDdBu5Bx6jJD6U6Hg+Ts93nsdEeO4LDY688qc5dm34Gy8cM6S0SuUP2YQqI6ITIU
         3sVmbMZb8P4Z+2Ur0SekxN4J7sDsnK8+HIdSQtfAvzSk+5ITkRsreCp8LWW8QqFC4fJK
         K+fsXPNBLGbggUfrETFhHRLnb6njWSZX+NNvjS3iO8j9ZnbEJkRlPF8Hv0t42l33LD2E
         xn/Q==
X-Gm-Message-State: APt69E2eHoSuhgw85PQWoCHvHeeLSUeyYyHsmU+baKirUJYh7nT0fV2F
        sTf9SdqGY324W75Dy2jlQlY=
X-Google-Smtp-Source: AAOMgpc7Dkpx/BDeDztXqqyLcau1If9EZJTP4ucRYJFRaQcwvka6oxjyRagz9jlPldSVlnR1CXR96g==
X-Received: by 2002:adf:a285:: with SMTP id s5-v6mr19104934wra.114.1530540281885;
        Mon, 02 Jul 2018 07:04:41 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id f133-v6sm8387617wme.42.2018.07.02.07.04.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 07:04:40 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 2CFA6123A5F; Mon,  2 Jul 2018 16:04:40 +0200 (CEST)
Date:   Mon, 2 Jul 2018 16:04:40 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, dan.j.williams@intel.com, jack@suse.cz,
        jglisse@redhat.com, jrdr.linux@gmail.com, bhe@redhat.com,
        gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org
Subject: Re: [PATCH v3 2/2] mm/sparse: start using sparse_init_nid(), and
 remove old code
Message-ID: <20180702140440.GA10207@techadventures.net>
References: <20180702020417.21281-1-pasha.tatashin@oracle.com>
 <20180702020417.21281-3-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702020417.21281-3-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 10:04:17PM -0400, Pavel Tatashin wrote:
> Change sprase_init() to only find the pnum ranges that belong to a specific
> node and call sprase_init_nid() for that range from sparse_init().
> 
> Delete all the code that became obsolete with this change.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
 
This looks like an improvement to me.
It also makes the code much easier to follow and to understand.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
