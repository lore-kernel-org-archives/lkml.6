Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51974C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F522082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F522082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeJaDeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:34:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:53880 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbeJaDeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:34:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 11:39:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,445,1534834800"; 
   d="scan'208";a="276958912"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga006.fm.intel.com with ESMTP; 30 Oct 2018 11:39:31 -0700
Date:   Tue, 30 Oct 2018 11:35:45 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Babu Moger <babu.moger@amd.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: [PATCH v2 2/8] selftests/resctrl: Add basic resctrl file
 system operations and data
Message-ID: <20181030183544.GA173608@romley-ivt3.sc.intel.com>
References: <1540508826-144502-1-git-send-email-fenghua.yu@intel.com>
 <1540508826-144502-3-git-send-email-fenghua.yu@intel.com>
 <DM5PR12MB2471679DD21D00A33D092A1795F30@DM5PR12MB2471.namprd12.prod.outlook.com>
 <CALBSrqDRKbth2NAUFM+emBHVv7eZPX=O9Ki-=vUxi-QQc1wVnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALBSrqDRKbth2NAUFM+emBHVv7eZPX=O9Ki-=vUxi-QQc1wVnQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Moger, Babu <Babu.Moger@amd.com>
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> >
> > The basic resctrl file system operations and data are added for future
> > usage by resctrl selftest tool.
> >
> > +     return 0;
> > +}
> > +
> > +char get_sock_num(int cpu_no)
> > +{
> > +     char sock_num, phys_pkg_path[1024];
> > +     FILE *fp;
> > +
> > +     sprintf(phys_pkg_path, "%s%d/topology/physical_package_id",
> > +             PHYS_ID_PATH, cpu_no);
> > +     fp = fopen(phys_pkg_path, "r");
> 
> There should corresponding fclose for this. In general, I would check all the
> fopens in this series. I found few of the files not closed while returning.
> More comments below.
> 
> > +     if (!fp || fscanf(fp, "%c", &sock_num) <= 0 || fclose(fp) == EOF) {

fclose is here.

> > +             perror("Could not get socket number");
> > +
> > +             return -1;
> > +     }
> > +
> > +      */
> > +     if (!freopen("/dev/null", "w", stdout))
> > +             PARENT_EXIT("Unable to direct BM op to /dev/null");
> 
> Do you need fclose for this before returning from this function?

This fclose is missing. I will add it.

> > +     /* Write child pid to con_mon grp */
> > +     fp = fopen(controlgroup, "w");
> 
> I don't see corresponding fclose.
> 
> > +     if (!fp || fprintf(fp, "%d\n", bm_pid) <= 0 || fclose(fp) == EOF) {

fclose is here:)

> > +             perror("Failed to write child to con_mon grp");
> > +
> > +             return errno;
> > +     }
> > +
> > +     /* Write child pid to mon grp, only for "mbm" */
> > +     if ((strcmp(resctrl_val, "mbm") == 0)) {
> > +             if (mongrp) {
> > +                     fp = fopen(monitorgroup, "w");
> > +                     if (!fp || fprintf(fp, "%d\n", bm_pid) <= 0 ||
> > +                         fclose(fp) == EOF) {
> 
> 
> I feel too many checks at one place.  If fprintf fails,  will it fclose the
> file? I suggest to separate these checks.

You are right. I will separate the checks in multiple lines.

> 
> > +
> > +             fp = fopen(controlgroup, "w");
> > +             if (!fp || fprintf(fp, "%s\n", schema) <= 0 ||
> > +                 fclose(fp) == EOF) {
> 
> Same comment as above.. If fprintf fails,  will it fclose the file? I suggest
> to separate these checks.

Sure.

I will change code based on your comments.

Thanks.

-Fenghua
