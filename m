Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3544C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C048B20869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C048B20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbeKLHOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 02:14:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46563 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbeKLHOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 02:14:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so3089808pgp.13;
        Sun, 11 Nov 2018 13:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mM2BePLAFEvzXsIAXLTmovB5tnuRc7E0/5hm98PsytQ=;
        b=o+OVcmml6kx2+jowf6pbqtuxi2jb8npLe95YaoPD/lcGtmfZnQvirRbUH6mcU85/Sj
         SiDYnD52lg7gXzyc30dk8Uz4sycBxeuR3r34jUQUDUzp6HK6MfC8XPA42N93VJoa/u9z
         aV205iE0pC0hk25CxzrG3b48+zus0zU/LdC/JL6bTAFnkfI8Pl/NajKDwlhJuBR7GuIR
         +AldbsmdU+TQiTZaeV62iMsXyprQkDIywXY31wekDk84W8Ok5zrA/7D3D0g68FGML7St
         oUbrt4pua33mm/qfDl707jMaYPKsVlbD2yiz9A+kIawf9rOu2T3kzW9dh0Aq/b5zRUUX
         MBFQ==
X-Gm-Message-State: AGRZ1gJklVoAQdJb6R3POZ+vWKBoiOhj/9cVcgtgcJh67Byg/W5rseDB
        5AqxOQQY8mi9fS1uRb7JsrQ=
X-Google-Smtp-Source: AJdET5e3QQ0aDvsBcKhL0n3eVD8KGk4KQJttZ2nIJuclXo99pKaNMdeuYddShEenIy7pwVfs7NuXiA==
X-Received: by 2002:a63:588:: with SMTP id 130mr15003146pgf.273.1541971463314;
        Sun, 11 Nov 2018 13:24:23 -0800 (PST)
Received: from asus.site ([2601:647:4601:5d98:fb3c:91c5:1423:24cd])
        by smtp.gmail.com with ESMTPSA id k68-v6sm17529063pfj.13.2018.11.11.13.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 13:24:22 -0800 (PST)
Subject: Re: [driver-core PATCH v6 2/9] async: Add support for queueing on
 specific NUMA node
To:     Greg KH <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        tj@kernel.org, akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        zwisler@kernel.org, dan.j.williams@intel.com, dave.jiang@intel.com
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170041079.12967.13132220574997822111.stgit@ahduyck-desk1.jf.intel.com>
 <20181111193208.GB8332@kroah.com> <20181111195903.GA9726@amd>
 <20181111203304.GA16871@kroah.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7373f722-f498-f0fa-2eaf-8ac9200fb9e1@acm.org>
Date:   Sun, 11 Nov 2018 13:24:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181111203304.GA16871@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/18 12:33 PM, Greg KH wrote:
> When I see new major patches show up from an Intel developer without
> _any_ other review from anyone else, directed at me, I get suspicious it
> is happening again.

Hi Greg,

Please note that I reviewed this patch four days ago. See also
https://lore.kernel.org/lkml/1541720197.196084.231.camel@acm.org/.

Thanks,

Bart.
