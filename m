Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85DAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 04:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7742086A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 04:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfBVEfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 23:35:14 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:42782 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbfBVEfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 23:35:13 -0500
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1M4VRJ7018269;
        Fri, 22 Feb 2019 04:35:08 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0a-002e3701.pphosted.com with ESMTP id 2qt7s8h0yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Feb 2019 04:35:08 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 9B5DD8D;
        Fri, 22 Feb 2019 04:35:07 +0000 (UTC)
Received: from anatevka (anatevka.americas.hpqcorp.net [10.34.81.61])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 3A7CA4A;
        Fri, 22 Feb 2019 04:35:07 +0000 (UTC)
Date:   Thu, 21 Feb 2019 21:35:07 -0700
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Matt Hsiao <matt.hsiao@hpe.com>, linux-kernel@vger.kernel.org,
        arnd@arndb.de, david.altobelli@hpe.com, mark.rusk@hpe.com
Subject: Re: [PATCH 2/4] misc: hpilo: Exclude unsupported device via blacklist
Message-ID: <20190222043506.GC31132@anatevka>
Reply-To: Jerry.Hoemann@hpe.com
References: <1550736282-25416-1-git-send-email-matt.hsiao@hpe.com>
 <1550736282-25416-3-git-send-email-matt.hsiao@hpe.com>
 <20190221083355.GB6397@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221083355.GB6397@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 09:33:55AM +0100, Greg KH wrote:
> On Thu, Feb 21, 2019 at 04:04:40PM +0800, Matt Hsiao wrote:

> > +static const struct pci_device_id ilo_blacklist[] = {
> > +	/* auxiliary iLO */
> > +	{PCI_DEVICE_SUB(PCI_VENDOR_ID_HP, 0x3307, PCI_VENDOR_ID_HP, 0x1979)},
> > +	{}
> > +};
> >  

...

> 
> And why do some devices need to be blacklisted, shouldn't there only be
> a whitelist in the first place?  Do you need to tighten up your original
> device ids?

Hi Greg,

I related the underlying reason for the black listing on another message
of this thread.  I can fill you in on why we've taken this approach to
white/black listing.

HPE hardware/firmware teams will put out minor updates to the iLO using
the same device info except for the subsystem device id.

The approach we've taken in both the hpilo and hpwdt drivers is
to claim based upon {Vendor, PC DevID, SubVendor}.

This allows old software to work on new hardware without patching.

As our primary way to support our customers is via distros, this patching
when it does happen requires us to not just submit a patch upstream, but
to then to have the patches back ported to multiple releases of multiple
distros.  This process takes many many months.

So far, the approach we've taken has worked fairly well as this is only
the second time in 10+ years that we've needed to blacklist an instance.

Hope this helps.

Jerry

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
