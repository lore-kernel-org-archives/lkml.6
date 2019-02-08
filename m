Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECBAC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BD821907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfBHB1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:27:22 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:40436 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726850AbfBHB1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 20:27:22 -0500
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x181Qgv7030262;
        Fri, 8 Feb 2019 01:27:00 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 2qgw0tsvvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Feb 2019 01:27:00 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 6BB6811B;
        Fri,  8 Feb 2019 01:26:59 +0000 (UTC)
Received: from anatevka (anatevka.americas.hpqcorp.net [10.34.81.61])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id BCBD936;
        Fri,  8 Feb 2019 01:26:58 +0000 (UTC)
Date:   Thu, 7 Feb 2019 18:26:58 -0700
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Ivan Mironov <mironov.ivan@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 1/4] watchdog: hpwdt: Don't disable watchdog on NMI
Message-ID: <20190208012658.GF28168@anatevka>
Reply-To: Jerry.Hoemann@hpe.com
References: <20190114023617.10656-1-mironov.ivan@gmail.com>
 <20190114023617.10656-2-mironov.ivan@gmail.com>
 <20190116022731.GD18342@anatevka>
 <84950aa0d194f28389f3bb209154ddc26e96c6de.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84950aa0d194f28389f3bb209154ddc26e96c6de.camel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-07_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=941 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 09:55:29AM +0500, Ivan Mironov wrote:
> On Tue, 2019-01-15 at 19:27 -0700, Jerry Hoemann wrote:
> > On Mon, Jan 14, 2019 at 07:36:14AM +0500, Ivan Mironov wrote:
> 
> Somehow I missed the whole pretimout thing when reading about the
> watchdog API. Thanks for clarification, now code makes much more sense
> =).
> 
> Still, I do not really understand the point of enabling of kdump
> support in hpwdt driver by default while kdump is not enabled by
> default.

Kdump is enabled by default by our Distro partners.

HPE works with distro partners to deliver a validated system which we support.

The ability to generate crash dumps is one of the means we use to
support our customers.  Even if kdump isn't configured, panic will
at least print stack trace to indicate system activity.


> 
> Also, existing code may call hpwdt_stop() (and thus break watchdog)
> even if pretimout is disabled.
> 
> Also, "panic=N" option is not providing a way to *not* panic on NMI
> unrelated with iLO. This could be circumvented by blacklisting the
> hpwdt module entirely, but normal watchdog functionality would be lost
> then.

panic=N provides for reset upon receipt of NMI if user wants timeout
to reset system but not a crash dump.

The panic is for error containment.  On the legacy systems within
the context of hpwdt_pretimeout we cannot determine if the error
is recoverable or not.  So, we have little choice but to panic.


> 
> It is possible to rebuild kernel without HPWDT_NMI_DECODING (which is
> enabled in Fedora, for example). But it is nearly impossible to come to
> this solution without examining the source code, because description of
> this option does not mention that it is really about pretimout support
> and panics and not about something else...

The name is not the best given its current use, but I'm not sure a
name change would be allowed.

However, I will send a patch to update the documentation in Kconfig.


-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
