Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346D2C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAE321473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfA2OIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:08:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbfA2OIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:08:16 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0TE4qBf010482
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 09:08:15 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qaqsya5v0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 09:08:15 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
        Tue, 29 Jan 2019 14:08:13 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Jan 2019 14:08:10 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0TE89WO9044292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Jan 2019 14:08:09 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9D14A4054;
        Tue, 29 Jan 2019 14:08:09 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77D93A405C;
        Tue, 29 Jan 2019 14:08:09 +0000 (GMT)
Received: from thinkpad (unknown [9.152.99.81])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Jan 2019 14:08:09 +0000 (GMT)
Date:   Tue, 29 Jan 2019 15:08:08 +0100
From:   Gerald Schaefer <gerald.schaefer@de.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] mm, memory_hotplug: fix uninitialized pages
 fallouts.
In-Reply-To: <20190129134920.GM18811@dhcp22.suse.cz>
References: <20190128144506.15603-1-mhocko@kernel.org>
        <20190129141447.34aa9d0c@thinkpad>
        <20190129134920.GM18811@dhcp22.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19012914-0028-0000-0000-000003405403
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012914-0029-0000-0000-000023FD56DF
Message-Id: <20190129150808.685d7d39@thinkpad>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 14:49:20 +0100
Michal Hocko <mhocko@kernel.org> wrote:

> On Tue 29-01-19 14:14:47, Gerald Schaefer wrote:
> > On Mon, 28 Jan 2019 15:45:04 +0100
> > Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > > Hi,
> > > Mikhail has posted fixes for the two bugs quite some time ago [1]. I
> > > have pushed back on those fixes because I believed that it is much
> > > better to plug the problem at the initialization time rather than play
> > > whack-a-mole all over the hotplug code and find all the places which
> > > expect the full memory section to be initialized. We have ended up with
> > > 2830bf6f05fb ("mm, memory_hotplug: initialize struct pages for the full
> > > memory section") merged and cause a regression [2][3]. The reason is
> > > that there might be memory layouts when two NUMA nodes share the same
> > > memory section so the merged fix is simply incorrect.
> > > 
> > > In order to plug this hole we really have to be zone range aware in
> > > those handlers. I have split up the original patch into two. One is
> > > unchanged (patch 2) and I took a different approach for `removable'
> > > crash. It would be great if Mikhail could test it still works for his
> > > memory layout.
> > > 
> > > [1] http://lkml.kernel.org/r/20181105150401.97287-2-zaslonko@linux.ibm.com
> > > [2] https://bugzilla.redhat.com/show_bug.cgi?id=1666948
> > > [3] http://lkml.kernel.org/r/20190125163938.GA20411@dhcp22.suse.cz
> > 
> > I verified that both patches fix the issues we had with valid_zones
> > (with mem=2050M) and removable (with mem=3075M).
> > 
> > However, the call trace in the description of your patch 1 is wrong.
> > You basically have the same call trace for test_pages_in_a_zone in
> > both patches. The "removable" patch should have the call trace for
> > is_mem_section_removable from Mikhails original patches:
> 
> Thanks for testing. Can I use you Tested-by?

Sure, forgot to add this:
Tested-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>

> 
> >  CONFIG_DEBUG_VM_PGFLAGS=y
> >  kernel parameter mem=3075M
> >  --------------------------
> >  page:000003d08300c000 is uninitialized and poisoned
> >  page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> >  Call Trace:
> >  ([<000000000038596c>] is_mem_section_removable+0xb4/0x190)
> >   [<00000000008f12fa>] show_mem_removable+0x9a/0xd8
> >   [<00000000008cf9c4>] dev_attr_show+0x34/0x70
> >   [<0000000000463ad0>] sysfs_kf_seq_show+0xc8/0x148
> >   [<00000000003e4194>] seq_read+0x204/0x480
> >   [<00000000003b53ea>] __vfs_read+0x32/0x178
> >   [<00000000003b55b2>] vfs_read+0x82/0x138
> >   [<00000000003b5be2>] ksys_read+0x5a/0xb0
> >   [<0000000000b86ba0>] system_call+0xdc/0x2d8
> >  Last Breaking-Event-Address:
> >   [<000000000038596c>] is_mem_section_removable+0xb4/0x190
> >  Kernel panic - not syncing: Fatal exception: panic_on_oops
> 
> Yeah, this is c&p mistake on my end. I will use this trace instead.
> Thanks for spotting.

