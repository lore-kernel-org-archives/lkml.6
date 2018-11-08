Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB8AC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E3A20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VwzmpFs2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L3OW6tm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E3A20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbeKHUGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:06:00 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51890 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKHUGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:06:00 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5C0EC60B26; Thu,  8 Nov 2018 10:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541673071;
        bh=nNR8psVAb4JV1kRVLgNPe5iFq7l9HGWlpM4X9CznbeY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VwzmpFs2YTBPP9SF0as1Vo67tmY2BC+o4RKADSodsRMVJlosDp3uKQR7vn/KsdEs/
         9J0aLo4nXicT94GtHszJHZNPaUHi930r0TtsfUCqvkeRDzkaEBaRWaZYwgHLQWkxCO
         YVc1D6GwT8fE+XTv+SA31hJ7ibbbobSGdzNrfgwg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3644F601D7;
        Thu,  8 Nov 2018 10:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541673070;
        bh=nNR8psVAb4JV1kRVLgNPe5iFq7l9HGWlpM4X9CznbeY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L3OW6tm9Z7PvsYH2kGi//rdS2rCKL3OUkd7iASYWNex4mbTJrH/MWfSVsHqvR7jjM
         poaD1I+/D1s4HDouL+Z/zaokn1tt4uAkzfgmfS5D5opOAHLAHxbeWI14YP5Z3ln2FJ
         xEphsXkuCfpU0VbT46hTOtYXc23CqMRDF8TV4t48=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 08 Nov 2018 16:01:10 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        khlebnikov@yandex-team.ru, minchan@kernel.org, vbabka@suse.cz,
        osalvador@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, getarunks@gmail.com
Subject: Re: [PATCH v3 4/4] mm: Remove managed_page_count spinlock
In-Reply-To: <20181108101400.GU27423@dhcp22.suse.cz>
References: <1541665398-29925-1-git-send-email-arunks@codeaurora.org>
 <1541665398-29925-5-git-send-email-arunks@codeaurora.org>
 <20181108083400.GQ27423@dhcp22.suse.cz>
 <4e5e2923a424ab2e2c50e56b2e538a3c@codeaurora.org>
 <20181108101400.GU27423@dhcp22.suse.cz>
Message-ID: <e3ca027726d9683a9fbf3694a96afd17@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-08 15:44, Michal Hocko wrote:
> On Thu 08-11-18 15:33:06, Arun KS wrote:
>> On 2018-11-08 14:04, Michal Hocko wrote:
>> > On Thu 08-11-18 13:53:18, Arun KS wrote:
>> > > Now totalram_pages and managed_pages are atomic varibles. No need
>> > > of managed_page_count spinlock.
>> >
>> > As explained earlier. Please add a motivation here. Feel free to reuse
>> > wording from
>> > http://lkml.kernel.org/r/20181107103630.GF2453@dhcp22.suse.cz
>> 
>> Sure. Will add in next spin.
> 
> Andrew usually updates changelogs if you give him the full wording.
> I would wait few days before resubmitting, if that is needed at all.

mm: Remove managed_page_count spinlock

Now that totalram_pages and managed_pages are atomic varibles, no need
of managed_page_count spinlock. The lock had really a weak consistency
guarantee. It hasn't been used for anything but the update but no reader
actually cares about all the values being updated to be in sync.

Signed-off-by: Arun KS <arunks@codeaurora.org>
Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>


> 0day will throw a lot of random configs which can reveal some 
> leftovers.

Yea. Fixed few of them during v3.

Regards,
Arun
