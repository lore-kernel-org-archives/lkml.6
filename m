Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0178DECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67572088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67572088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbeIQUKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:10:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:11217 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728735AbeIQUKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:10:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2018 07:42:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,385,1531810800"; 
   d="scan'208";a="70657071"
Received: from yisun1-ubuntu.bj.intel.com (HELO localhost) ([10.238.156.104])
  by fmsmga007.fm.intel.com with ESMTP; 17 Sep 2018 07:40:27 -0700
Date:   Mon, 17 Sep 2018 22:37:54 +0800
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "chao.p.peng@intel.com" <chao.p.peng@intel.com>,
        "chao.gao@intel.com" <chao.gao@intel.com>,
        "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
        "michael.h.kelly@microsoft.com" <michael.h.kelly@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 0/3] Enable PV qspinlock for Hyper-V
Message-ID: <20180917143754.GD11769@yi.y.sun>
References: <1536830005-37260-1-git-send-email-yi.y.sun@linux.intel.com>
 <CY4PR21MB07735BAA5C00C933C4E00C9FDC180@CY4PR21MB0773.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY4PR21MB07735BAA5C00C933C4E00C9FDC180@CY4PR21MB0773.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-09-15 23:43:12, Michael Kelley (EOSG) wrote:
> >From Yi Sun   Sent: Thursday, September 13, 2018 2:13 AM
> 
> > This patch adds the necessary Hyper-V specific code to allow
> > PV qspinlock work on Hyper-V.
> > 
> 
> Have you done any performance measurements with this
> new code, so that we know whether there is any improvement,
> or even potentially any degradation in some circumstances?
> 
> Michael
>  
I executed reaim in Guest (20 vcpus, 30G memory). Reaim is one of
the performance test methods used by qspinlock patch set. Results
are below. With hv_spinlock enabled, performance is better.

hv_spinlock disabled:
$ src/reaim -c data/reaim.config -f data/workfile.compute -i 16 -e 256
Num     Parent   Child   Child  Jobs per   Jobs/min/  Std_dev  Std_dev   JTI
Forked  Time     SysTime UTime   Minute     Child      Time     Percent
1       1.16     0.05    1.08    5224.14    5224.14    0.00     0.00     100
17      1.40     0.75    19.22   73585.71   4328.57    0.05     4.03     95
33      2.17     1.29    36.71   92156.68   2792.63    0.12     6.13     93
49      2.84     1.59    50.50   104556.34  2133.80    0.17     6.68     93
65      3.71     2.17    68.11   106172.51  1633.42    0.24     7.14     92
81      4.63     2.87    84.00   106017.28  1308.86    0.35     8.31     91
97      5.55     3.40    101.11  105913.51  1091.89    0.32     6.27     93
113     6.28     3.90    117.70  109041.40  964.97     0.38     6.51     93
129     7.20     4.44    134.00  108575.00  841.67     0.62     9.31     90
145     8.02     4.98    150.90  109563.59  755.61     0.61     8.18     91
178     9.75     6.46    184.96  110633.85  621.54     0.62     6.78     93
211     11.91    7.65    226.10  107360.20  508.82     0.88     7.96     92
244     13.30    8.28    253.82  111175.94  455.64     0.80     6.44     93
Max Jobs per Minute 111175.94

hv_spinlock enabled:
Num     Parent   Child   Child  Jobs per   Jobs/min/  Std_dev  Std_dev   JTI
Forked  Time     SysTime UTime   Minute     Child      Time     Percent
1       1.07     0.04    1.00    5663.55    5663.55    0.00     0.00     100
17      1.21     0.58    17.63   85140.50   5008.26    0.03     3.05     96
33      1.88     1.18    34.22   106372.34  3223.40    0.09     5.27     94
49      3.04     1.83    56.27   97677.63   1993.42    0.20     7.35     92
65      3.66     2.26    68.64   107622.95  1655.74    0.26     7.86     92
81      4.50     2.85    84.45   109080.00  1346.67    0.25     6.03     93
97      5.33     3.29    100.55  110285.18  1136.96    0.36     7.43     92
113     6.20     3.87    117.76  110448.39  977.42     0.39     6.87     93
129     6.96     4.42    132.93  112318.97  870.69     0.45     6.92     93
145     7.86     5.01    151.02  111793.89  770.99     0.50     6.76     93
179     9.71     6.16    185.62  111713.70  624.10     0.72     7.92     92
213     11.70    7.43    224.77  110323.08  517.95     0.73     6.69     93
247     13.45    8.48    259.19  111287.73  450.56     0.73     5.78     94
Max Jobs per Minute 112318.97
