Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36706C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018A621470
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018A621470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeJEOM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:12:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37466 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbeJEOMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:12:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id 185-v6so865927wmt.2;
        Fri, 05 Oct 2018 00:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rLF/fUrswzwTf1w0onr3v+ax23k7hk6LQODldba/KpQ=;
        b=byJHU8HzCfuyJBV2w0JG+ivJ28KVk/hs0wso0+tbIGVCOmMuDyIyHpRrdLCoerke6i
         o/KxQ35ksXKP//aVl6MMkNZWd9mu6n9mkxExYVL6kyeUkjpY2wTpoBLifKUlEi36GbXx
         zvrI3ubwepGVb0M/Cfvn85JkKW+ke0wdL+JPgPKpABpBrSwIHvkrVelQvzSt6yX1A4QG
         BEXRXjNREg4RJv80dF6UQnoxcdvCRsLQyjicAggHaJlcanV53fbpmpP1dgKnModDlk0d
         VaXUvgZvT6uVRP8eiQzdqhRHtULnWceygZIgLoVMr+k1iq1GuBkA+EeuR/vo1JGV11qY
         ttQQ==
X-Gm-Message-State: ABuFfoiEFe3Y5JG6RQKvZ0RUTd1Wbc9ZHrmlOZss6AdxebSZEZNuriWn
        rOH5TgnA+EhOgJFWL9+BENo=
X-Google-Smtp-Source: ACcGV62xTS7MoAnvgjRB5eo6esfIUGlYCP2yq8jFJz1NJEE76Gthgl8cHLOAdd7f71xBAils/qV+ow==
X-Received: by 2002:a1c:2846:: with SMTP id o67-v6mr6740461wmo.60.1538723730904;
        Fri, 05 Oct 2018 00:15:30 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id s24-v6sm809132wmc.7.2018.10.05.00.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 00:15:30 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 95CFE125826; Fri,  5 Oct 2018 09:15:29 +0200 (CEST)
Date:   Fri, 5 Oct 2018 09:15:29 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
        devel@linuxdriverproject.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        John Allen <jallen@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH v3 1/6] mm/memory_hotplug: make remove_memory() take the
 device_hotplug_lock
Message-ID: <20181005071529.GC27754@techadventures.net>
References: <20180927092554.13567-1-david@redhat.com>
 <20180927092554.13567-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927092554.13567-2-david@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:25:49AM +0200, David Hildenbrand wrote:
> Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
 
Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
