Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CD9C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC8B20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC8B20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeKASYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:24:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:49342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726520AbeKASYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:24:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A472EAF62;
        Thu,  1 Nov 2018 09:22:13 +0000 (UTC)
Date:   Thu, 1 Nov 2018 10:22:12 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: Memory hotplug failed to offline on bare metal system of
 multiple nodes
Message-ID: <20181101092212.GB23921@dhcp22.suse.cz>
References: <20181101091055.GA15166@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101091055.GA15166@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-11-18 17:10:55, Baoquan He wrote:
> Hi,
> 
> A hot removal failure was met on one bare metal system with 8 nodes, and
> node1~7 are all hotpluggable and 'movable_node' is set. When try to check
> value of  /sys/devices/system/node/node1/memory*/removable, found some of
> them are 0, namely un-removable. And a back trace will always be seen. After
> bisecting, it points at criminal commit:
> 
>   15c30bc09085  ("mm, memory_hotplug: make has_unmovable_pages more robust")
> 
> Reverting it fix the failure, and node1~7 can be hot removed and hot
> added again. From the log of commit 15c30bc09085, it's to fix a
> movable_core setting issue which we allocated node_data firstly in
> initmem_init(), then try to mark it as movable in mm_init(). We may need
> think about it further to fix it, meanwhile not breaking bare metal
> system.
> 
> I haven't figured out why the above commit caused those memmory
> block in MOVABL zone being not removable. Still checking. Attach the
> tested reverting patch in this mail.

Could you check which of the test inside has_unmovable_pages claimed the
failure? Going back to marking movable_zone as guaranteed to offline is
just too fragile.
-- 
Michal Hocko
SUSE Labs
