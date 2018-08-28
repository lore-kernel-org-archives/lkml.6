Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338B9C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22EA20878
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22EA20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeH1KXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 06:23:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726567AbeH1KXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 06:23:12 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7S6UXFK008585
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 02:33:03 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m4ywq2t04-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 02:33:02 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Tue, 28 Aug 2018 07:33:00 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 Aug 2018 07:32:54 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7S6WrvD41615384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Aug 2018 06:32:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8054011C04C;
        Tue, 28 Aug 2018 09:32:50 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAF0A11C05B;
        Tue, 28 Aug 2018 09:32:48 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.97])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 28 Aug 2018 09:32:48 +0100 (BST)
Date:   Tue, 28 Aug 2018 09:32:50 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <guro@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] devres: provide devm_kstrdup_const()
References: <20180827082101.5036-1-brgl@bgdev.pl>
 <20180827103353.GB13848@rapoport-lnx>
 <CAMRc=MdZ_1Vk2c19L-spzOm=7UaDpaACriq4gzMxAvQz=noNgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdZ_1Vk2c19L-spzOm=7UaDpaACriq4gzMxAvQz=noNgQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18082806-4275-0000-0000-000002B127F2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082806-4276-0000-0000-000037BA2905
Message-Id: <20180828063250.GB25317@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-28_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808280067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 04:28:55PM +0200, Bartosz Golaszewski wrote:
> 2018-08-27 12:33 GMT+02:00 Mike Rapoport <rppt@linux.vnet.ibm.com>:
> > On Mon, Aug 27, 2018 at 10:21:00AM +0200, Bartosz Golaszewski wrote:
> >> Provide a resource managed version of kstrdup_const(). This variant
> >> internally calls devm_kstrdup() on pointers that are outside of
> >> .rodata section. Also provide a corresponding version of devm_kfree().
> >>
> >> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> >> ---
> >>  include/linux/device.h |  2 ++
> >>  mm/util.c              | 35 +++++++++++++++++++++++++++++++++++
> >>  2 files changed, 37 insertions(+)
> >>
> >> diff --git a/include/linux/device.h b/include/linux/device.h
> >> index 8f882549edee..f8f5982d26b2 100644
> >> --- a/include/linux/device.h
> >> +++ b/include/linux/device.h
> >> @@ -693,7 +693,9 @@ static inline void *devm_kcalloc(struct device *dev,
> >>       return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
> >>  }
> >>  extern void devm_kfree(struct device *dev, void *p);
> >> +extern void devm_kfree_const(struct device *dev, void *p);
> >>  extern char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
> >> +extern char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp);
> >>  extern void *devm_kmemdup(struct device *dev, const void *src, size_t len,
> >>                         gfp_t gfp);
> >>
> >> diff --git a/mm/util.c b/mm/util.c
> >> index d2890a407332..6d1f41b5775e 100644
> >> --- a/mm/util.c
> >> +++ b/mm/util.c

[ ... ]

> >> + * Strings allocated by devm_kstrdup_const will be automatically freed when
> >> + * the associated device is detached.
> >> + */
> >> +char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp)
> >> +{
> >> +     if (is_kernel_rodata((unsigned long)s))
> >> +             return s;
> >> +
> >> +     return devm_kstrdup(dev, s, gfp);
> >> +}
> >> +EXPORT_SYMBOL(devm_kstrdup_const);
> >> +
> >
> > The devm_ variants seem to belong to drivers/base/devres.c rather than
> > mm/util.c
> >
> 
> Not all devm_ variants live in drivers/base/devres.c, many subsystems
> implement them locally. In this case we need to choose between
> exporting is_kernel_rodata() and putting devm_kstrdup_const() in
> mm/util.c. I chose the latter, since it's cleaner.

I rather think that moving is_kernel_rodata() to
include/asm-generic/sections.h and having devm_kstrdup_const() next to
devm_kstrdup() would be cleaner.
 
> Bart
> 

-- 
Sincerely yours,
Mike.

