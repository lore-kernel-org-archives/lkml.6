Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F858C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C850320882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C850320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeILTdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:33:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726672AbeILTdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:33:49 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CEOHPP136829
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 10:29:03 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mf3fu3nw9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 10:29:03 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
        Wed, 12 Sep 2018 15:29:01 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Sep 2018 15:28:59 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8CESwFX55509200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Sep 2018 14:28:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BEFD5204F;
        Wed, 12 Sep 2018 17:28:47 +0100 (BST)
Received: from thinkpad (unknown [9.152.212.168])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C52875204E;
        Wed, 12 Sep 2018 17:28:46 +0100 (BST)
Date:   Wed, 12 Sep 2018 16:28:56 +0200
From:   Gerald Schaefer <gerald.schaefer@de.ibm.com>
To:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        "zaslonko@linux.ibm.com" <zaslonko@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "osalvador@suse.de" <osalvador@suse.de>
Subject: Re: [PATCH] memory_hotplug: fix the panic when memory end is not on
 the section boundary
In-Reply-To: <abf84f61-82f3-e3d5-2e6e-82a11cb5dcf5@microsoft.com>
References: <20180910123527.71209-1-zaslonko@linux.ibm.com>
        <20180910131754.GG10951@dhcp22.suse.cz>
        <e8d75768-9122-332b-3b16-cad032aeb27f@microsoft.com>
        <20180910135959.GI10951@dhcp22.suse.cz>
        <CAGM2reZuGAPmfO8x0TnHnqHci_Hsga3-CfM9+udJs=gUQCw-1g@mail.gmail.com>
        <20180910141946.GJ10951@dhcp22.suse.cz>
        <CAGM2reZ5OD9SRW8j9iaQAk9jpr86pF2NqpBjv-dxH+1vJZs0=g@mail.gmail.com>
        <20180910144152.GL10951@dhcp22.suse.cz>
        <abf84f61-82f3-e3d5-2e6e-82a11cb5dcf5@microsoft.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18091214-0012-0000-0000-000002A7C2EC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091214-0013-0000-0000-000020DC0532
Message-Id: <20180912162856.697038a8@thinkpad>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=752 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809120149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018 15:26:55 +0000
Pasha Tatashin <Pavel.Tatashin@microsoft.com> wrote:

> 
> I agree memoryblock is a hack, it fails to do both things it was
> designed to do:
> 
> 1. On bare metal you cannot free a physical dimm of memory using
> memoryblock granularity because memory devices do not equal to physical
> dimms. Thus, if for some reason a particular dimm must be
> remove/replaced, memoryblock does not help us.
> 
> 2. On machines with hypervisors it fails to provide an adequate
> granularity to add/remove memory.
> 
> We should define a new user interface where memory can be added/removed
> at a finer granularity: sparse section size, but without a memory
> devices for each section. We should also provide an optional access to
> legacy interface where memory devices are exported but each is of
> section size.
> 
> So, when legacy interface is enabled, current way would work:
> 
> echo offline > /sys/devices/system/memory/memoryXXX/state
> 
> And new interface would allow us to do something like this:
> 
> echo offline 256M > /sys/devices/system/node/nodeXXX/memory
> 
> With optional start address for offline memory.
> echo offline [start_pa] size > /sys/devices/system/node/nodeXXX/memory
> start_pa and size must be section size aligned (128M).
> 
> It would probably be a good discussion for the next MM Summit how to
> solve the current memory hotplug interface limitations.

Please keep lsmem/chmem from util-linux in mind, when changing the
memory hotplug user interface.

