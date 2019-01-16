Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4170CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ABE820657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390880AbfAPOFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:05:08 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:49680 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730952AbfAPOFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:05:07 -0500
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0G2Qbc5018936;
        Wed, 16 Jan 2019 02:27:33 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 2q1qyd9cfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jan 2019 02:27:32 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 4F431A2;
        Wed, 16 Jan 2019 02:27:32 +0000 (UTC)
Received: from anatevka (anatevka.americas.hpqcorp.net [10.34.81.61])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id EF87B3A;
        Wed, 16 Jan 2019 02:27:31 +0000 (UTC)
Date:   Tue, 15 Jan 2019 19:27:31 -0700
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Ivan Mironov <mironov.ivan@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 1/4] watchdog: hpwdt: Don't disable watchdog on NMI
Message-ID: <20190116022731.GD18342@anatevka>
Reply-To: Jerry.Hoemann@hpe.com
References: <20190114023617.10656-1-mironov.ivan@gmail.com>
 <20190114023617.10656-2-mironov.ivan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114023617.10656-2-mironov.ivan@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 07:36:14AM +0500, Ivan Mironov wrote:
> Existing code disables watchdog on NMI right before completely hanging
> the system.
> 
> There are two problems here:
> 
>  * First, watchdog is expected to reset the system in a case of such
>    failure, no matter what.

Documentation/watchdog/watchdog-api.txt

explicitly allows for pretimeout NMI and generation of kernel crash dumps.

By removing hpwdt_stop the system will likely fail to crash dump
as there is only 9 seconds between receipt of a NMI and the iLO
resetting the system.

Unfortunately, kdump is not without issues and can also be difficult
to properly configure either of which can result in failure to dump
and reset.

Customers who value availability over kdump collection, the pretimeout
NMI can be disabled and hardware will not issue the pretimeout NMI
and will only do reset.

A middle ground for those who want tombstones but not kdump, would
be to leave the pretimeout NMI enabled and add "panic=N" to the
Linux command line.  That way after the panic, the tombstone is
printed and the system resets after N seconds.



>  * Second, this code has no effect if there are more than one watchdog.

That is correct.  Hpwdt will not turn off any other WDT.

I don't see a current method of notifying other watchdogs
that a given watchdog is going to take the system down.

The closest I hook see is watchdog_notify_pretimeout, but I don't
see that notifying other WDT.  Its not clear to me that it should.
(e.g. the second WDT could be of longer duration and protect against
kdump hanging. This would need to be thought through.)



> 
> Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
> ---
>  drivers/watchdog/hpwdt.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index ef30c7e9728d..2467e6bc25c2 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -170,8 +170,6 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>  	if (ilo5 && !pretimeout && !mynmi)
>  		return NMI_DONE;
>  
> -	hpwdt_stop();
> -
>  	hex_byte_pack(panic_msg, mynmi);
>  	nmi_panic(regs, panic_msg);
>  
> -- 
> 2.20.1

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
